import re


def extract_json_code_safe(s):
    s_stripped = s.strip()
    if (s_stripped.startswith("{") and s_stripped.endswith("}")) or (
        s_stripped.startswith("[") and s_stripped.endswith("]")
    ):
        return s_stripped
    return extract_json_code(s_stripped)


def extract_json_code(s):
    pattern = r"```json(.*?)```"
    match = re.search(pattern, s, re.DOTALL)
    return match.group(1).strip() if match else None


def extract_python_code(s):
    pattern = r"```python(.*?)```"
    match = re.search(pattern, s, re.DOTALL)
    return match.group(1).strip() if match else None
