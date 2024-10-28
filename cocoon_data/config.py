try:
    import openai
except ImportError as e:
    raise ImportError("Failed to import openai. Please verify if the openai package is installed correctly.") from e

import os

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
    'api_type': getattr(openai, 'api_type', os.getenv('OPENAI_API_TYPE', 'openai')),
    'api_base': getattr(openai, 'api_base', os.getenv('OPENAI_API_BASE')),
    'api_version': getattr(openai, 'api_version', os.getenv('OPENAI_API_VERSION')),
    'api_key': getattr(openai, 'api_key', os.getenv('OPENAI_API_KEY')),
    'aws_access_key': os.environ.get("AWS_ACCESS_KEY_ID", None),
    'aws_secret_key': os.environ.get("AWS_SECRET_ACCESS_KEY", None),
    'aws_region': os.environ.get("AWS_REGION", None),
    's3_bucket': os.environ.get("S3_BUCKET", None),
    'aws_model': os.environ.get("AWS_MODEL", "anthropic.claude-3-5-sonnet-20240620-v1:0"),
    'claude_model': os.environ.get("CLAUDE_MODEL", "claude-3-5-sonnet-20240620"),
    'vertex_model': os.environ.get("VERTEX_MODEL", "claude-3-5-sonnet@20240620"),
    'vertex_region': os.environ.get("AnthropicVertex_region", None),
    'vertex_project_id': os.environ.get("AnthropicVertex_project_id", None),
    'openai_model': os.environ.get("OPENAI_MODEL", "gpt-4-turbo"),
    'azure_engine': os.environ.get("AZURE_ENGINE", None),
}

cocoon_main_setting = {
    'DEBUG_MODE': False,
    'LOG_MESSAGE_HISTORY': False,
    'MAX_TRIALS': 3,
    'icon_import': False,
    'file_system': 'local',
    "allow_cache": True,
}

