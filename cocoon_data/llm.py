
import os
import json
import hashlib
from collections import OrderedDict

from .config import *

try:
    import vertexai
    from vertexai.preview.generative_models import GenerativeModel, Part, HarmCategory, HarmBlockThreshold
except:
    pass

try:
    from anthropic import AnthropicBedrock
except:
    pass

try:
    import anthropic
except:
    pass

try:
    from anthropic import AnthropicVertex
except:
    pass

import tiktoken

def calculate_claude_cost(messages, response):
    encoder = tiktoken.encoding_for_model("gpt-3.5-turbo")
    
    INPUT_PRICE_PER_1M_TOKENS = 3.0
    OUTPUT_PRICE_PER_1M_TOKENS = 15.0
    
    input_tokens = 0
    output_tokens = 0
    
    for message in messages:
        tokens = encoder.encode(message['content'])
        input_tokens += len(tokens)
    
    output_tokens = len(encoder.encode(response['choices'][0]['message']['content']))
    
    input_cost = (input_tokens / 1_000_000) * INPUT_PRICE_PER_1M_TOKENS
    output_cost = (output_tokens / 1_000_000) * OUTPUT_PRICE_PER_1M_TOKENS
    total_cost = input_cost + output_cost
    
    return total_cost

def call_embed(input_string):

    if openai.api_type == 'azure':
        response = openai.Embedding.create(input=input_string, 
            engine=openai.embed_engine)
        return response
    
    elif openai.api_type == 'open_ai':
        response = openai.Embedding.create(
            model="text-embedding-ada-002",
            input=input_string
        )
        return response

def hash_messages(messages):
    serialized_input = json.dumps(messages, sort_keys=True)
    return hashlib.sha256(serialized_input.encode('utf-8')).hexdigest()

class LRUCache:
    def __init__(self, capacity: int = 100):
        self.cache = OrderedDict()
        self.capacity = capacity

    def get(self, key: str):
        if key not in self.cache:
            return None
        else:
            self.cache.move_to_end(key)
            return self.cache[key]

    def put(self, key: str, value):
        if key in self.cache:
            self.cache.move_to_end(key)
        else:
            if len(self.cache) >= self.capacity:
                self.cache.popitem(last=False)
        self.cache[key] = value

    def pop(self):
        self.cache.popitem()

    def save_to_disk(self, file_path = "./cached_messages.json"):
        with open(file_path, 'w') as file:
            json.dump(dict(self.cache), file)

    def load_from_disk(self, file_path= "./cached_messages.json"):
        with open(file_path, 'r') as file:
            loaded_cache = json.load(file)
            self.cache = OrderedDict(loaded_cache)

lru_cache = LRUCache(20000)







if os.path.exists("./cached_messages.json"):
    lru_cache.load_from_disk("./cached_messages.json")

def call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=True, api_type=None, return_cost=False):
    global openai
    message_hash = hash_messages(messages)

    if use_cache and cocoon_main_setting.get('allow_cache', True):
        cached_response = lru_cache.get(message_hash)
        if cached_response is not None:
            lru_cache.save_to_disk()
            if return_cost:
                return cached_response, 0
            else:
                return cached_response
        
    if api_type is None:
        api_type = cocoon_llm_setting.get('api_type', openai.api_type)
    
    if api_type == 'Anthropic':
        messages = convert_openai_to_claude(messages)

        client = anthropic.Anthropic()
        responses = client.messages.create(
            model=cocoon_llm_setting['claude_model'] or os.environ.get("CLAUDE_MODEL"),
            max_tokens=4000,
            messages=messages
        )

        response = convert_claude_to_openai(responses)
        
    elif api_type == 'AnthropicBedrock':
        messages = convert_openai_to_claude(messages)

        client = AnthropicBedrock(
            aws_access_key=cocoon_llm_setting['aws_access_key'] or os.environ.get("AWS_ACCESS_KEY_ID"),
            aws_secret_key=cocoon_llm_setting['aws_secret_key'] or os.environ.get("AWS_SECRET_ACCESS_KEY"),
            aws_region=cocoon_llm_setting['aws_region'] or os.environ.get("AWS_REGION") or "us-east-1",
        )

        message = client.messages.create(
            model=cocoon_llm_setting['aws_model'] or os.environ.get("AWS_MODEL"),
            max_tokens=4000,
            messages=messages
        )

        response = convert_anthropicvertex_to_openai(message)
    
    elif api_type == 'Llama3Bedrock':
        import boto3
        
        conversation = convert_openai_to_bedrock_llama(messages)

        client = boto3.client("bedrock-runtime", 
            region_name=cocoon_llm_setting['aws_region'] or os.environ.get("AWS_REGION") or "us-west-2",
            aws_access_key_id=cocoon_llm_setting['aws_access_key'] or os.environ.get("AWS_ACCESS_KEY_ID"),
            aws_secret_access_key=cocoon_llm_setting['aws_secret_key'] or os.environ.get("AWS_SECRET_ACCESS_KEY"),
        )

        response = client.converse(
            modelId="meta.llama3-1-405b-instruct-v1:0",
            messages=conversation,
            inferenceConfig={"maxTokens": 512, "temperature": temperature, "topP": top_p},
        )

        response_text = response["output"]["message"]["content"][0]["text"]

        response = convert_bedrockllama_to_openai(response)
        
    elif api_type == 'AnthropicVertex':
        messages = convert_openai_to_claude(messages)

        client = AnthropicVertex(region=cocoon_llm_setting['vertex_region'] or os.environ.get("AnthropicVertex_region"),
                                 project_id=cocoon_llm_setting['vertex_project_id'] or os.environ.get("AnthropicVertex_project_id"))
        
        responses = client.messages.create(
            max_tokens=4000,
            messages=messages,
            model=cocoon_llm_setting['vertex_model'] or os.environ.get("VERTEX_MODEL"),
            )

        response = convert_anthropicvertex_to_openai(responses)
    
            
    elif api_type == 'Llama3Vertex':
        
        import openai
        from google.auth import default
        from google.auth.transport import requests

        credentials, _ = default()
        auth_request = requests.Request()
        credentials.refresh(auth_request)

        MODEL_LOCATION = "us-central1"
        PROJECT_ID=cocoon_llm_setting['vertex_project_id'] or os.environ.get("AnthropicVertex_project_id")
        client = openai.OpenAI(
            base_url=f"https://{MODEL_LOCATION}-aiplatform.googleapis.com/v1beta1/projects/{PROJECT_ID}/locations/{MODEL_LOCATION}/endpoints/openapi/chat/completions?",
            api_key=credentials.token,
        )
        
        MODEL_ID = "meta/llama3-405b-instruct-maas" 
        response = client.chat.completions.create(
            model=MODEL_ID, messages=messages
        )
        
        response = convert_new_to_old_openai(response)
                
    elif api_type == 'gemini':
        messages = convert_openai_to_gemini(messages)

        model = GenerativeModel("gemini-pro-vision")

        safety_settings={
            HarmCategory.HARM_CATEGORY_HARASSMENT: HarmBlockThreshold.BLOCK_NONE,
            HarmCategory.HARM_CATEGORY_HATE_SPEECH: HarmBlockThreshold.BLOCK_NONE,
            HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: HarmBlockThreshold.BLOCK_NONE,
            HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: HarmBlockThreshold.BLOCK_NONE,
        }
                
        responses = model.generate_content(
            messages,
            generation_config={
                "max_output_tokens": 2048,
                "temperature": 0.4,
                "top_p": 1,
                "top_k": 32
            },
            safety_settings=safety_settings
        )

        response = convert_gemini_to_openai(responses)

        
    elif api_type == 'azure':
        engine_name = cocoon_llm_setting['azure_engine'] or os.environ.get("AZURE_ENGINE") or openai.gpt4_engine
        if engine_name is None:
            raise ValueError("Please provide the deployment name of your GPT-4 model: cocoon_llm_setting['azure_engine'] = 'your_deployment_name'")
        try:
            from openai import AzureOpenAI
            client = AzureOpenAI(
                api_key=cocoon_llm_setting['api_key'] or getattr(openai, 'api_key', os.environ.get("OPENAI_API_KEY")),
                azure_endpoint=cocoon_llm_setting['api_base'] or getattr(openai, 'api_base', os.environ.get("OPENAI_API_BASE")),
                api_version=cocoon_llm_setting['api_version'] or getattr(openai, 'api_version', os.environ.get("OPENAI_API_VERSION")),
            )
            response = client.chat.completions.create(
                model=engine_name,
                temperature=temperature,
                top_p=top_p,
                messages=messages
            )
            response = convert_new_to_old_openai(response)
            
        except ImportError:
            openai.api_type = "azure"
            openai.api_key = cocoon_llm_setting['api_key'] or os.getenv('OPENAI_API_KEY')
            openai.api_base = cocoon_llm_setting['api_base'] or os.getenv('OPENAI_API_BASE')
            openai.api_version = cocoon_llm_setting['api_version'] or os.getenv('OPENAI_API_VERSION')
                                                                                
            response = openai.ChatCompletion.create(
                engine=engine_name,
                temperature=temperature,
                top_p=top_p,
                messages=messages
            )
        
    elif api_type == 'openai':
        try:
            from openai import OpenAI
            client = OpenAI(
                api_key=cocoon_llm_setting['api_key'] or getattr(openai, 'api_key', os.getenv('OPENAI_API_KEY'))
            )
            
            response = client.chat.completions.create(
                model=cocoon_llm_setting['openai_model'] or os.environ.get("OPENAI_MODEL") or 'gpt-4-turbo',
                temperature=temperature,
                top_p=top_p,
                messages=messages
            )
            response = convert_new_to_old_openai(response)
            
        except ImportError:
            import openai
            if not openai.api_key:
                openai.api_key = cocoon_llm_setting['api_key'] or os.getenv('OPENAI_API_KEY')
            
            response = openai.ChatCompletion.create(
                model=cocoon_llm_setting['openai_model'] or os.environ.get("OPENAI_MODEL") or 'gpt-4-turbo',
                temperature=temperature,
                top_p=top_p,
                messages=messages
            )
    
    else:
        raise ValueError(f"openai.api_type is {api_type}, but it should be 'azure' or 'openai'.")

    lru_cache.put(message_hash, response)
    lru_cache.save_to_disk()
    
    if return_cost:
        cost = calculate_claude_cost(messages, response)
        return response, cost
    
    return response




def convert_new_to_old_openai(new_response):
    
    return {
        'choices': [{
            'message': {
                'role': new_response.choices[0].message.role,
                'content': new_response.choices[0].message.content
            }
        }]
    }






def convert_openai_to_gemini(openai_messages):
    gemini_messages = []

    for message in openai_messages:
        role = "USER" if message["role"] == "user" else "model"

        gemini_message = {
            "role": role.upper(),
            "parts": [{"text": message["content"]}]
        }

        gemini_messages.append(gemini_message)

    return gemini_messages




def convert_gemini_to_openai(gemini_response):
    message_text = gemini_response.candidates[0].content.parts[0].text

    message_content = {"role": "assistant", "content": message_text}

    openai_response = {
        "choices": [
            {"message": message_content}
        ]
    }

    return openai_response




def convert_bedrockllama_to_openai(bedrockllama_response):
    openai_format = {
        "choices": [
            {
                "message": {
                    "content": bedrockllama_response["output"]["message"]["content"][0]["text"]
                }
            }
        ]
    }
    return openai_format




def convert_anthropicvertex_to_openai(anthropicvertex_response):
    message_text = anthropicvertex_response.content[0].text

    message_content = {"role": "assistant", "content": message_text}

    openai_response = {
        "choices": [
            {"message": message_content}
        ]
    }

    return openai_response


def convert_openai_to_claude(openai_messages):
    return openai_messages



def convert_openai_to_bedrock_llama(openai_messages):
    bedrock_llama_messages = []
    
    for message in openai_messages:
        role = message["role"]
        content = message["content"]
        
        bedrock_message = {
            "role": role,
            "content": [{"text": content}]
        }
        
        bedrock_llama_messages.append(bedrock_message)
    
    return bedrock_llama_messages





def convert_claude_to_openai(claude_response):
    message_text = claude_response.content[0].text

    openai_response = {
        "choices": [
            {"message": {"role": "assistant", "content": message_text}}
        ]
    }

    return openai_response