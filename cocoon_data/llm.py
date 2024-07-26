import openai
import os
import json
import hashlib
from collections import OrderedDict

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



if 'OPENAI_API_TYPE' in os.environ:
    openai.api_type = os.environ['OPENAI_API_TYPE']

if 'OPENAI_API_BASE' in os.environ:
    openai.api_base = os.environ['OPENAI_API_BASE']

if 'OPENAI_API_KEY' in os.environ:
    openai.api_key = os.environ['OPENAI_API_KEY']

if 'OPENAI_API_VERSION' in os.environ:
    openai.api_version = os.environ['OPENAI_API_VERSION']

if 'OPENAI_GPT4_ENGINE' in os.environ:
    openai.gpt4_engine = os.environ['OPENAI_GPT4_ENGINE']

if 'OPENAI_EMBED_ENGINE' in os.environ:
    openai.embed_engine = os.environ['OPENAI_EMBED_ENGINE']
    
cocoon_llm_setting = {
    'aws_access_key': os.environ.get("AWS_ACCESS_KEY_ID", None),
    'aws_secret_key': os.environ.get("AWS_SECRET_ACCESS_KEY", None),
    'aws_region': os.environ.get("AWS_REGION", None),
    'aws_model': os.environ.get("AWS_MODEL", "anthropic.claude-3-5-sonnet-20240620-v1:0"),
    'claude_model': os.environ.get("CLAUDE_MODEL", "claude-3-5-sonnet-20240620"),
    'vertex_model': os.environ.get("VERTEX_MODEL", "claude-3-5-sonnet@20240620"),
    'vertex_region': os.environ.get("AnthropicVertex_region", None),
    'vertex_project_id': os.environ.get("AnthropicVertex_project_id", None),
    'openai_model': os.environ.get("OPENAI_MODEL", "gpt-4-turbo"),
}
    

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

lru_cache = LRUCache(5000)







if os.path.exists("./cached_messages.json"):
    lru_cache.load_from_disk("./cached_messages.json")

def call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=True):

    message_hash = hash_messages(messages)

    if use_cache:
        response = lru_cache.get(message_hash)
        if response is not None:
            lru_cache.save_to_disk()
            return response

    if openai.api_type == 'Anthropic':
        messages = convert_openai_to_claude(messages)

        client = anthropic.Anthropic()
        responses = client.messages.create(
            model=cocoon_llm_setting['claude_model'] or os.environ.get("CLAUDE_MODEL"),
            max_tokens=4000,
            messages=messages
        )

        response = convert_claude_to_openai(responses)
        
    elif openai.api_type == 'AnthropicBedrock':
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
        
    elif openai.api_type == 'AnthropicVertex':
        messages = convert_openai_to_claude(messages)

        client = AnthropicVertex(region=cocoon_llm_setting['vertex_region'] or os.environ.get("AnthropicVertex_region"),
                                 project_id=cocoon_llm_setting['vertex_project_id'] or os.environ.get("AnthropicVertex_project_id"))
        
        responses = client.messages.create(
            max_tokens=4000,
            messages=messages,
            model=cocoon_llm_setting['vertex_model'] or os.environ.get("VERTEX_MODEL"),
            )

        response = convert_anthropicvertex_to_openai(responses)
        
    elif openai.api_type == 'gemini':
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

    elif openai.api_type == 'azure':
        response = openai.ChatCompletion.create(
            engine = openai.gpt4_engine,
            temperature=temperature,
            top_p=top_p,
            messages=messages
        )
        
    elif openai.api_type == 'open_ai':
        
        response = openai.ChatCompletion.create(
            model="gpt-4-turbo",
            temperature=temperature,
            top_p=top_p,
            messages=messages
        )
        
    
    else:
        raise ValueError(f"openai.api_type is {openai.api_type}, but it should be 'azure' or 'openai'.")

    lru_cache.put(message_hash, response)
    lru_cache.save_to_disk()
    return response








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




def convert_claude_to_openai(claude_response):
    message_text = claude_response.content[0].text

    openai_response = {
        "choices": [
            {"message": {"role": "assistant", "content": message_text}}
        ]
    }

    return openai_response