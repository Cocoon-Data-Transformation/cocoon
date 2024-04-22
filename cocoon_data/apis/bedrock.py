import json
import os

import boto3
from botocore.exceptions import ClientError

BEDROCK_MODEL_ID = os.environ.get(
    "BEDROCK_MODEL_ID", "anthropic.claude-3-sonnet-20240229-v1:0"
)
BEDROCK_ANTHROPIC_VERSION = os.environ.get(
    "BEDROCK_ANTHROPIC_VERSION", "bedrock-2023-05-31"
)
BEDROCK_MAX_TOKENS = os.environ.get("BEDROCK_MAX_TOKENS", 1054)


class Client:
    def __init__(self, aws_region: str = "us-east-1") -> None:
        self.client = boto3.client(
            service_name="bedrock-runtime", region_name=aws_region
        )

    def create(self, messages, *args, **kwargs):
        message = self.parse_input(messages)
        response = self.invoke_model(message, *args, **kwargs)
        return self.parse_output(response)

    def parse_input(self, messages):
        return [
            {"role": "user", "content": [{"type": "text", "text": message["content"]}]}
            for message in messages
        ]

    def parse_output(self, response):
        message_text = response["content"][0].get("text")
        return {
            "choices": [{"message": {"role": "assistant", "content": message_text}}]
        }

    def invoke_model(self, message, *args, **kwargs):
        try:
            response = self.client.invoke_model(
                modelId=BEDROCK_MODEL_ID,
                body=json.dumps(
                    {
                        "anthropic_version": BEDROCK_ANTHROPIC_VERSION,
                        "max_tokens": BEDROCK_MAX_TOKENS,
                        "messages": message,
                    }
                ),
            )

            result = json.loads(response.get("body").read())
            if len(result.get("content", [])) == 0:
                return None

            return result
        except ClientError as err:
            # logger.error(
            #     "Couldn't invoke Claude 3 Sonnet. Here's why: %s: %s",
            #     err.response["Error"]["Code"],
            #     err.response["Error"]["Message"],
            # )
            raise


if __name__ == "__main__":
    client = Client()
    client.invoke_model("Hello, how are you?")
