import json

from cocoon_data.extract import extract_json_code_safe
from cocoon_data.llm import call_llm_chat
from cocoon_data.utils import get_detailed_error_info, replace_newline, write_log


class Testing:
    def __init__(self, name=None, explanation="", codes="", sample_df=None):
        if name is None:
            self.name = "Testing Task"
        else:
            self.name = name

        self.codes = codes
        self.explanation = explanation
        self.sample_df = sample_df

    def run_codes(self, dfs, codes=None):

        if codes is None:
            codes = self.codes

        if isinstance(dfs, list):
            df = dfs[0]
        else:
            df = dfs

        input_df = df.copy()
        try:
            if "transform" in globals():
                del globals()["transform"]
            exec(codes, globals())
            result = test(input_df)
            return result

        except Exception:
            detailed_error_info = get_detailed_error_info()
            return detailed_error_info

    def generate_codes(self, explanation=None):
        if explanation is None:
            explanation = self.explanation
        template = f"""Testing task: Given input df, write python codes that test df and output True/False
===
Input Df:
{self.sample_df.to_csv()}
===
Testing Requirement
{explanation}

Do the following:
1. First reason about how to test
2. Then fill in the python function, with detailed comments.
DONT change the function name and the return clause.

{{
    "reason": "To transform, we need to ...",
    "codes": "def test(input_df):\\n   ...\\n    return True/False"
}}
"""
        messages = [{"role": "user", "content": template}]

        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        write_log(template)
        write_log("-----------------------------------")
        write_log(response["choices"][0]["message"]["content"])

        json_code = extract_json_code_safe(response["choices"][0]["message"]["content"])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)

        self.reason = json_code["reason"]
        self.codes = json_code["codes"]

    def display(self):
        raise NotImplementedError


class TestColumnUnique(Testing):
    def __init__(self, col_name, name=None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name

        if name is None:
            self.name = f"Test if {col_name} is unique"

    def generate_test_unique_codes(self):
        self.codes = """# Concatenate all dataframes horizontally
def test(input_df):
    return input_df["{col_name}"].is_unique"""


class TestColumnNotNull(Testing):
    def __init__(self, col_name, name=None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name

        if name is None:
            self.name = f"Test if {col_name} has no null"

    def generate_test_not_null_codes(self):
        self.codes = f"""def test(input_df):
    return not input_df["{self.col_name}"].isnull().any()"""


class TestColumnAcceptedValues(Testing):
    def __init__(
        self,
        col_name,
        accepted_values,
        name=None,
        explanation="",
        codes="",
        sample_df=None,
    ):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        if not isinstance(accepted_values, list):
            raise ValueError("Accepted values must be a list.")
        self.accepted_values = accepted_values

        if name is None:
            self.name = f"Test {col_name} domain"

    def generate_test_accepted_values_codes(self):
        self.codes = f"""def test(input_df):
    return input_df["{self.col_name}"].isin({self.accepted_values}).all()"""


class TestColumnType(Testing):
    def __init__(
        self,
        col_name,
        expected_type,
        name=None,
        explanation="",
        codes="",
        sample_df=None,
    ):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        self.expected_type = expected_type

        if name is None:
            self.name = f"Test {col_name} type"

    def generate_test_column_type_codes(self):
        self.codes = f"""def test(input_df):
    return input_df["{self.col_name}"].dtype == "{self.expected_type}"""


class TestColumnRange(Testing):
    def __init__(
        self,
        col_name,
        min_value,
        max_value,
        name=None,
        explanation="",
        codes="",
        sample_df=None,
    ):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        self.min_value = min_value
        self.max_value = max_value

        if name is None:
            self.name = f"Test {col_name} range"

    def generate_test_range_codes(self):
        self.codes = f"""def test(input_df):
    if not pd.api.types.is_numeric_dtype(input_df["{self.col_name}"]):
        return False
    return input_df["{self.col_name}"].between({self.min_value}, {self.max_value}).all()"""


class TestColumnRegex(Testing):
    def __init__(
        self,
        col_name,
        regex_pattern,
        name=None,
        explanation="",
        codes="",
        sample_df=None,
    ):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        self.regex_pattern = regex_pattern

        if name is None:
            self.name = f"Test {col_name} regex pattern"

    def generate_test_regex_codes(self):
        self.codes = f"""def test(input_df):
    return input_df["{self.col_name}"].str.match("{self.regex_pattern}").all()"""
