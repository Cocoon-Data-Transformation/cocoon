from abc import abstractmethod

import openai


class Client:
    @abstractmethod
    def create(messages, *args, **kwargs):
        return openai.ChatCompletion.create(
            engine=kwargs.get("engine"),
            temperature=kwargs.get("temperature"),
            top_p=kwargs.get("top_p"),
            messages=messages,
        )
