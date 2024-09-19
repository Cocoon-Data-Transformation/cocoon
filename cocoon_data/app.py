import os
import json
import streamlit.components.v1 as components
from cocoon_data import *

st.set_page_config(page_title="RAG for Large Data + Pipelines", layout="wide")

def save_settings_to_yaml():
    settings = {
        'cocoon_llm_setting': cocoon_llm_setting,
        'loaded_catalogs': [catalog.get_directory() for catalog in st.session_state.catalogs.values()]
    }
    with open('cocoon_settings.yml', 'w') as file:
        yaml.dump(settings, file)

def load_settings_from_yaml():
    try:
        with open('cocoon_settings.yml', 'r') as file:
            settings = yaml.safe_load(file)
            for key in settings['cocoon_llm_setting']:
                cocoon_llm_setting[key] = settings['cocoon_llm_setting'][key]
            for directory in settings.get('loaded_catalogs', []):
                catalog_obj = load_catalog(directory)
                if catalog_obj:
                    st.session_state.catalogs[catalog_obj.get_name()] = catalog_obj
    except FileNotFoundError:
        pass
    
def test_llm_connection():
    try:
        test_message = "hello"
        messages = [{"role": "user", "content": test_message}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=False)
        st.session_state.llm_connection_successful = True
        st.session_state.selected_llm = "VertexAI Claude"
    except Exception as e:
        st.session_state.llm_connection_successful = False
        st.error(f"Default LLM connection failed: {str(e)}")

    
def load_pipelines(directory):
    pipelines = []
    for filename in os.listdir(directory):
        if filename.endswith(".json"):
            with open(os.path.join(directory, filename), "r") as f:
                pipeline = json.load(f)
                pipelines.append(pipeline)
    return pipelines

def load_catalog(directory):
    catalog_obj = validate_catalog_and_generate_object(directory)
    return catalog_obj

@st.dialog("Load Catalog")
def upload_catalog():
    st.markdown("Enter the project directory of the compiled dbt project:")
    directory = st.text_input(
        label="Project Directory",
        value="",
        placeholder="e.g., /path/to/your/dbt/project",
    )
    st.markdown("Make sure `{your_directory}/target/manifest.json` is available")
    if st.button("Submit"):
        if directory and os.path.isdir(directory):
            manifest_path = os.path.join(directory, "target", "manifest.json")
            if os.path.exists(manifest_path):
                with st.spinner("Loading catalog... This may take a moment."):
                    catalog_obj = load_catalog(directory)
                if catalog_obj:
                    if 'catalogs' not in st.session_state:
                        st.session_state.catalogs = {}
                    catalog_name = catalog_obj.get_name()
                    st.session_state.catalogs[catalog_name] = catalog_obj
                    save_settings_to_yaml()
                    st.session_state.page = f"catalog_{catalog_name}"
                    st.success("Catalog loaded successfully!")
                    st.rerun()
                else:
                    st.error("Failed to load catalog. Please check the directory and try again.")
            else:
                st.error("manifest.json not found in the target subdirectory. Please make sure it exists.")
        elif directory:
            st.error("Invalid directory path. Please try again.")

@st.dialog("Select LLM")
def select_llm():
    global cocoon_llm_setting
    st.subheader("Select LLM")
    
    llm_options = {
        'openai': 'OpenAI GPT-4',
        'azure': 'Azure GPT-4',
        'Anthropic': 'Anthropic Claude',
        'AnthropicBedrock': 'Bedrock Claude ',
        'Llama3Bedrock': 'Bedrock Llama3',
        'AnthropicVertex': 'VertexAI Claude',
        'Llama3Vertex': 'VertexAI Llama3',
        'gemini': 'VertexAI Gemini'
    }
    
    default_api_type = cocoon_llm_setting.get('api_type', openai.api_type)
    default_index = list(llm_options.keys()).index(default_api_type) if default_api_type in llm_options else 0
    
    selected_llm = st.selectbox("Choose an LLM:", 
                                options=list(llm_options.values()),
                                index=default_index)
    
    selected_api_type = list(llm_options.keys())[list(llm_options.values()).index(selected_llm)]
    
    st.subheader("API Configuration")
    
    if selected_api_type == 'openai':
        cocoon_llm_setting['api_type'] = 'openai'
        cocoon_llm_setting['api_key'] = st.text_input("API Key:", value=cocoon_llm_setting.get('api_key', ''))
        cocoon_llm_setting['openai_model'] = st.text_input("Model:", value=cocoon_llm_setting.get('openai_model', 'gpt-4-turbo'))
    
    elif selected_api_type == 'azure':
        cocoon_llm_setting['api_type'] = 'azure'
        cocoon_llm_setting['api_key'] = st.text_input("API Key:", value=cocoon_llm_setting.get('api_key', ''))
        cocoon_llm_setting['api_base'] = st.text_input("API Base URL:", value=cocoon_llm_setting.get('api_base', ''))
        cocoon_llm_setting['azure_engine'] = st.text_input("Azure Deployment Name:", value=cocoon_llm_setting.get('azure_engine', ''))
        cocoon_llm_setting['api_version'] = st.text_input("API Version:", value=cocoon_llm_setting.get('api_version', ''))
    
    if selected_api_type == 'Anthropic':
        cocoon_llm_setting['api_type'] = 'Anthropic'
        anthropic_api_key = st.text_input("Anthropic API Key:", 
                                          value=os.environ.get("ANTHROPIC_API_KEY", ""),
                                          type="password")
        cocoon_llm_setting['claude_model'] = st.text_input("Claude Model:", 
                                                           value=cocoon_llm_setting.get('claude_model', 'claude-3-sonnet-20240229'))
    
    elif selected_api_type == 'AnthropicBedrock':
        cocoon_llm_setting['api_type'] = 'AnthropicBedrock'
        cocoon_llm_setting['aws_access_key'] = st.text_input("AWS Access Key:", value=cocoon_llm_setting.get('aws_access_key', ''))
        cocoon_llm_setting['aws_secret_key'] = st.text_input("AWS Secret Key:", value=cocoon_llm_setting.get('aws_secret_key', ''))
        cocoon_llm_setting['aws_region'] = st.text_input("AWS Region:", value=cocoon_llm_setting.get('aws_region', 'us-east-1'))
        cocoon_llm_setting['aws_model'] = st.text_input("AWS Model:", value=cocoon_llm_setting.get('aws_model', ''))
    
    elif selected_api_type == 'Llama3Bedrock':
        cocoon_llm_setting['api_type'] = 'Llama3Bedrock'
        cocoon_llm_setting['aws_access_key'] = st.text_input("AWS Access Key:", value=cocoon_llm_setting.get('aws_access_key', ''))
        cocoon_llm_setting['aws_secret_key'] = st.text_input("AWS Secret Key:", value=cocoon_llm_setting.get('aws_secret_key', ''))
        cocoon_llm_setting['aws_region'] = st.text_input("AWS Region:", value=cocoon_llm_setting.get('aws_region', 'us-west-2'))
    
    elif selected_api_type == 'AnthropicVertex':
        cocoon_llm_setting['api_type'] = 'AnthropicVertex'
        cocoon_llm_setting['vertex_region'] = st.text_input("Vertex Region:", value=cocoon_llm_setting.get('vertex_region', ''))
        cocoon_llm_setting['vertex_project_id'] = st.text_input("Vertex Project ID:", value=cocoon_llm_setting.get('vertex_project_id', ''))
        cocoon_llm_setting['vertex_model'] = st.text_input("Vertex Model:", value=cocoon_llm_setting.get('vertex_model', ''))
    
    elif selected_api_type == 'Llama3Vertex':
        cocoon_llm_setting['api_type'] = 'Llama3Vertex'
        cocoon_llm_setting['vertex_project_id'] = st.text_input("Vertex Project ID:", value=cocoon_llm_setting.get('vertex_project_id', ''))
    
    elif selected_api_type == 'gemini':
        cocoon_llm_setting['api_type'] = 'gemini'

    if st.button("Test Connection"):
        cocoon_llm_setting['api_type'] = selected_api_type
        if selected_api_type == 'Anthropic':
            os.environ["ANTHROPIC_API_KEY"] = anthropic_api_key
        
        try:
            test_message = "hello"
            messages = [{"role": "user", "content": test_message}]
            response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=False)
            
            st.session_state.selected_llm = selected_llm
            st.session_state.llm_connection_successful = True
            save_settings_to_yaml()
            st.success(f"Connection successful for {selected_llm}")
            st.rerun()
        except Exception as e:
            st.error(f"Connection failed: {str(e)}")
            st.session_state.llm_connection_successful = False


def home_page():
    st.title("Cocoon: RAG for Large Data + Pipelines")

    st.markdown("""
    Cocoon offers a [RAG + cursor-style general-purpose chatbot](https://cocoon-data-transformation.github.io/page/pipeline) for large data pipelines (starting with dbt).

    **Use cases include:**
    - **Models discovery**: "I have a question about customer behavior. Which tables should I use?"
    - **Safe model edits**: "I want to modify the 'customer_segmentation' model. What other models might be affected?"
    - **Model debugging**: "The 'total_revenue' column looks incorrect. How is it computed upstream?"
    - **New pipelines prototyping**: "I want to add a new 'customer_lifetime_value' metric. How are similar metrics computed?"
    - **Natural language querying**: "I want to understand our customers better. Can you recommend some insightful queries?"
    - **Pipelines testing and optimizations**: "Suggest columns to partition based on downstream filtering patterns."

    Cocoon is very reliable and scalable: It's tested on dbt projects with 1000+ models. The secret source is a novel RAG structure tailored for dbt pipelines (going much further beyond vector embedding).
    """)

    st.markdown("### Step 1: Configure your LLMs")
    if st.button("Configure LLM"):
        select_llm()
        
    display_llm_status()

    st.markdown("### Step 2: Provide a compiled dbt project as catalog")
    if st.button("Load Catalog"):
        upload_catalog()

    st.markdown("### Step 3: Chat with catalog")
    if 'catalogs' in st.session_state and st.session_state.catalogs:
        st.success("Catalogs loaded:")
        for catalog_name in st.session_state.catalogs:
            if st.button(f"Go to {catalog_name}", key=f"{catalog_name}"):
                st.session_state.page = f"catalog_{catalog_name}"
                st.rerun()
    else:
        st.warning("No catalog provided yet. Please load a catalog in Step 2.")


def chat_with_catalog_page(catalog_obj, input_question=""):
    st.title(f"Chat with {catalog_obj.get_name()}")
    
    col1, col2, col3 = st.columns(3)
    col1.button("Return to Home", on_click=lambda: setattr(st.session_state, 'page', 'home'), use_container_width=True)
    col2.button("Return to Catalog", on_click=lambda: setattr(st.session_state, 'page', f'catalog_{catalog_obj.get_name()}'), use_container_width=True)
    col3.button("New Conversation", type="primary", on_click=reset_agent, args=(catalog_obj,), use_container_width=True)

    catalog_key = catalog_obj.get_name()

    if 'agents' not in st.session_state:
        st.session_state.agents = {}
    if catalog_key not in st.session_state.agents:
        st.session_state.agents[catalog_key] = DBTLLMAgentStreamlit(catalog_obj, track_cost=st.session_state.track_cost)

    agent = st.session_state.agents[catalog_key]

    def display_temp_user_message(message):
        container = st.empty()
        with container.container():
            st.chat_message("user").markdown(message, unsafe_allow_html=True)
        return container

    if input_question:
        temp_container = display_temp_user_message(input_question)
        with st.spinner("Processing your question..."):
            result = agent.process_user_question(input_question)
        temp_container.empty()

    agent.display_chat_history()

    prompt = st.chat_input("Ask a follow-up question")
    if prompt:
        temp_container = display_temp_user_message(prompt)
        with st.spinner("Processing your question..."):
            result = agent.process_user_question(prompt)
        temp_container.empty()
        st.rerun()

def reset_agent(catalog_obj):
    catalog_key = catalog_obj.get_name()
    if catalog_key in st.session_state.agents:
        st.session_state.agents[catalog_key] = DBTLLMAgentStreamlit(catalog_obj)

def catalog_details_page(catalog_obj):
    st.title(catalog_obj.get_name())
    
    col1, col2, col3 = st.columns(3)
    col1.button("Return to Home", on_click=lambda: setattr(st.session_state, 'page', 'home'), use_container_width=True)
    col2.button("View Chat History", on_click=lambda: setattr(st.session_state, 'page', f'chat_{catalog_obj.get_name()}'), use_container_width=True)
    col3.button("Delete Catalog", type="primary", on_click=delete_catalog, args=(catalog_obj.get_name(),), use_container_width=True)

    catalog_obj.create_dbt_lineage_selectbox()

    user_input = st.chat_input("Ask a question about the catalog...", key="catalog_chat_input")

    if user_input:
        if user_input.strip():
            st.session_state.chat_input = user_input
            catalog_name = catalog_obj.get_name()
            
            if 'agents' in st.session_state and catalog_name in st.session_state.agents:
                st.session_state.agents[catalog_name] = DBTLLMAgentStreamlit(catalog_obj, track_cost=st.session_state.track_cost)
            
            st.session_state.page = f'chat_{catalog_name}'
            st.rerun()
        else:
            st.error("Please enter a question before submitting.")

def delete_catalog(catalog_name):
    if catalog_name in st.session_state.catalogs:
        del st.session_state.catalogs[catalog_name]
        save_settings_to_yaml()
        st.session_state.delete_success = True
        st.session_state.page = "home"
    else:
        st.session_state.delete_error = True
    
def display_llm_status():
    if 'selected_llm' in st.session_state and 'llm_connection_successful' in st.session_state:
        status_color = "green" if st.session_state.llm_connection_successful else "red"
        status_icon = "✅" if st.session_state.llm_connection_successful else "❌"
        status_text = "Connected" if st.session_state.llm_connection_successful else "Failed"
        st.markdown(
            f"<p style='color: {status_color};'>{status_icon} {status_text}: {st.session_state.selected_llm}</p>",
            unsafe_allow_html=True
        )
    else:
        st.markdown(
            "<p style='color: red;'>❌ Not Connected</p>",
            unsafe_allow_html=True
        )
        
def main():
    if "catalogs" not in st.session_state:
        st.session_state.catalogs = {}
        load_settings_from_yaml()

    if 'llm_connection_successful' not in st.session_state:
        test_llm_connection()

    if "page" not in st.session_state:
        st.session_state.page = "home"

    with st.sidebar:        
        if st.button("Home"):
            st.session_state.page = "home"
            st.rerun()

        st.sidebar.markdown("---")
        st.header("LLM connection")
        if st.sidebar.button("Select LLM"):
            select_llm()
        display_llm_status()
        st.session_state.track_cost = st.sidebar.checkbox("Track chat cost", value=st.session_state.get('track_cost', False))
        
        st.sidebar.markdown("---")
        st.header("Data Pipeline Catalogs")
        
        if st.session_state.catalogs:
            for catalog_name, catalog_obj in st.session_state.catalogs.items():
                if st.button(catalog_obj.get_name()):
                    st.session_state.page = f"catalog_{catalog_name}"
                    st.rerun()
        else:
            st.markdown("❌ <span style='color: red;'>No catalogs loaded yet.</span>", unsafe_allow_html=True)

    if st.session_state.page == "home":
        if st.session_state.get('delete_success'):
            st.success("Catalog has been deleted.")
            del st.session_state.delete_success
        elif st.session_state.get('delete_error'):
            st.error("Catalog not found in session state.")
            del st.session_state.delete_error
        home_page()

    elif st.session_state.page.startswith("catalog_"):
        catalog_name = st.session_state.page[8:]
        catalog_obj = st.session_state.catalogs[catalog_name]
        catalog_details_page(catalog_obj)
    
    elif st.session_state.page.startswith("chat_"):
        catalog_name = st.session_state.page[5:]
        if catalog_name in st.session_state.catalogs:
            catalog_obj = st.session_state.catalogs[catalog_name]
            input_question = st.session_state.get('chat_input', '')
            chat_with_catalog_page(catalog_obj, input_question)
            st.session_state.chat_input = ''
        else:
            st.error(f"Catalog '{catalog_name}' not found. Returning to home page.")
            st.session_state.page = "home"
            st.rerun()

    if st.session_state.get('delete_success') or st.session_state.get('delete_error'):
        st.rerun()

if __name__ == "__main__":
    main()