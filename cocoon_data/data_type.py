from .config import *

data_types ={
    "INT": ["INT", "INTEGER", "BIGINT", "SMALLINT", "TINYINT", "BYTEINT"],
    "DECIMAL": ["DECIMAL", "NUMERIC", "DOUBLE", "FLOAT", "FIXED", "REAL", "DOUBLE PRECISION"],
    "BOOLEAN": ["BOOLEAN"],
    "DATE": ["DATE", "DATETIME"],
    "TIME": ["TIME"],
    "TIMESTAMP": ["TIMESTAMP", "TIMESTAMPT_TZ", "TIMESTAMP_LTZ", "TIMESTAMP_NTZ", "TIMESTAMP_TZ"],
    "INTERVAL": ["INTERVAL"],
    "VARCHAR": ["VARCHAR", "CHAR", "TEXT", "STRING", "CHARACTER"],
    "UUID": ["UUID"],
    "BLOB": ["BLOB", "BINARY", "VARBINARY"],
    "JSON": ["JSON", "VARIANT", "OBJECT"],
    "ARRAY": ["ARRAY"],
    "GEOGRAPHY": ["GEOGRAPHY"],
    "GEOMETRY": ["GEOMETRY"]
}


data_types_database = {
    "Snowflake": {
        "INT": ["INT", "INTEGER", "BIGINT", "SMALLINT", "TINYINT", "BYTEINT"],
        "FLOAT": ["DECIMAL", "NUMBER", "NUMERIC", "DOUBLE", "DOUBLE PRECISION", "FLOAT", "FLOAT4", "FLOAT8", "REAL", "FIXED"],
        "VARCHAR": ["VARCHAR", "CHAR", "TEXT", "STRING", "CHARACTER"],
        "BINARY": ["BLOB", "BINARY", "VARBINARY"],
        "BOOLEAN": ["BOOLEAN"],
        "DATE": ["DATE", "DATETIME"],
        "TIME": ["TIME"],
        "TIMESTAMP": ["TIMESTAMP", "TIMESTAMPT_TZ", "TIMESTAMP_LTZ", "TIMESTAMP_NTZ", "TIMESTAMP_TZ"],
        "VARIANT": ["VARIANT", "OBJECT", "ARRAY"],
        "GEOGRAPHY": ["GEOGRAPHY"],
        "GEOMETRY": ["GEOMETRY"]
    },
    "DuckDB": {
        "INT": ["UBIGINT", "UHUGEINT", "UINTEGER", "BIGINT", "USMALLINT", "UTINYINT", "INTEGER", "SMALLINT", "TINYINT", "HUGEINT", "INT8", "LONG", "INT4", "INT", "SIGNED", "INT2", "SHORT", "INT1"],
        "BIT": ["BIT", "BITSTRING"],
        "BLOB": ["BLOB", "BYTEA", "BINARY", "VARBINARY"],
        "BOOLEAN": ["BOOL", "BOOLEAN", "LOGICAL"],
        "DATE": ["DATE"],
        "DECIMAL": ["DECIMAL", "NUMERIC", "FLOAT4", "FLOAT", "REAL", "DOUBLE","FLOAT8"],
        "TIME": ["TIME"],
        "TIMESTAMP": ["DATETIME", "TIMESTAMP", "TIMESTAMPTZ", "TIMESTAMP WITH TIME ZONE", "TIMESTAMPWITHTIMEZONE"],
        "VARCHAR": ["CHAR", "BPCHAR", "TEXT", "STRING", "VARCHAR"],
        "ARRAY": ["ARRAY"],
        "JSON": ["JSON"],
        "INTERVAL": ["INTERVAL"],
        "UUID": ["UUID"],
    },
    "SQL Server": {
        "INT": ["BIGINT", "INT", "SMALLINT", "TINYINT"],
        "DECIMAL": ["DECIMAL", "NUMERIC", "MONEY", "SMALLMONEY"],
        "FLOAT": ["FLOAT", "REAL"],
        "BOOLEAN": ["BIT", "BOOLEAN"],
        "VARCHAR": ["CHAR", "VARCHAR", "TEXT", "NCHAR", "NVARCHAR", "NTEXT"],
        "BINARY": ["BINARY", "VARBINARY", "IMAGE"],
        "TIME": ["TIME"],
        "DATE": ["DATE"],
        "DATETIME": ["DATETIME", "DATETIME2", "SMALLDATETIME", "DATETIMEOFFSET", "TIMESTAMP", "ROWVERSION"],
        "UNIQUEIDENTIFIER": ["UNIQUEIDENTIFIER"],
        "XML": ["XML"],
        "GEOGRAPHY": ["GEOGRAPHY"],
        "GEOMETRY": ["GEOMETRY"],
        "JSON": ["JSON", "TABLE"],
        "HIERARCHYID": ["HIERARCHYID"],
        "SQL_VARIANT": ["SQL_VARIANT"]
    },
    "BigQuery": {
        "INT": ["INT", "INT64", "INTEGER", "BIGINT", "SMALLINT", "TINYINT", "BYTEINT"],
        "FLOAT": ["FLOAT", "FLOAT64", "NUMERIC", "DECIMAL", "BIGDECIMAL","BIGNUMERIC"],
        "BOOLEAN": ["BOOL", "BOOLEAN"],
        "STRING": ["STRING"],
        "BYTES": ["BYTES"],
        "DATE": ["DATE"],
        "TIME": ["TIME"],
        "DATETIME": ["DATETIME"],
        "TIMESTAMP": ["TIMESTAMP"],
        "STRUCT": ["STRUCT", "RECORD"],
        "ARRAY": ["ARRAY"],
        "GEOGRAPHY": ["GEOGRAPHY"],
        "JSON": ["JSON"],
        "RANGE": ["RANGE"],
    }
}

database_general_hint = {
    "DuckDB": "",
    "Snowflake": "Double quote table and column names, if they are not all uppercase", 
}

def is_type_time(data_type):
    return data_type in ["TIME", "DATE", "TIMESTAMP", "DATETIME"]

def is_type_boolean(data_type):
    return data_type in ["BOOLEAN"]

def is_type_string(data_type):
    return data_type in ["VARCHAR", "STRING"]

def is_type_numeric(data_type):
    return data_type in ["INT", "DECIMAL", "FLOAT"]
    
def is_type_id(data_type):
    return data_type in ["UUID", "UNIQUEIDENTIFIER"]

def is_type_comparable(data_type):
    return is_type_time(data_type) or is_type_string(data_type) or \
        is_type_numeric(data_type) or is_type_id(data_type) or is_type_boolean(data_type)

duckdb_cocoon_hint = """
- Extract last name from full name: list_extract(string_split("full_name", ' '), -1)
- Extract year from a date string: EXTRACT(YEAR FROM CAST(strptime('02/03/1992', '%d/%m/%Y') AS DATE))
- Calculate age from birthdate: EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM CAST("birthdate" AS DATE))
- Convert 'yes'/'no' to boolean: CASE WHEN col = 'no' THEN false ELSE true END
- Extract number from string: CAST(REGEXP_EXTRACT('35.2 KG', '(\d+(\.\d+)?)') AS DECIMAL)
- Convert string to date: CAST(strptime('02/03/1992', '%d/%m/%Y') AS DATE)
- Convert string to time: CAST(strptime('14:30:45', '%H:%M:%S') AS TIME)
- Concatenate strings: CONCAT("first_name", ' ', "last_name")
- Get the first 3 digits for number: SUBSTRING(REGEXP_REPLACE(CAST("number" AS VARCHAR), '[^0-9]', ''), 1, 3)
- Convert number to string with leading zeros: LPAD(CAST(123 AS VARCHAR), 5, '0')
- Convert string with commas to decimal: CAST(REGEXP_REPLACE('1,234,567.89', ',', '', 'g') AS DECIMAL)
- Round number to 2 decimal places: ROUND(123.4567, 2)
- Convert UNIX timestamp to datetime: TO_TIMESTAMP(1634319300)
- Convert string to uppercase: UPPER('hello world')
- Trim whitespace from both ends of a string: TRIM('   padded string   ')
- Extract hour from timestamp: EXTRACT(HOUR FROM CAST('2023-10-15 14:30:45' AS TIMESTAMP))
- Extract date from timestamp: CAST(CAST("my_time" AS TIMESTAMP) AS DATE)
"""

transform_hints = {
    'VARCHAR':{
        'DATE': {
            "DuckDB": """Example Clause: 
CAST(strptime('02/03/1992', '%d/%m/%Y') AS DATE)
CAST(strptime(replace('Mon, 2 March 1992', 'Mon', 'Monday'), '%A, %-d %B %Y') AS DATE)""",
            "Snowflake": """Example Clause: 
TO_DATE('02/03/1992', 'DD/MM/YYYY')
TO_DATE('Mon, 2 March 1992', 'DY, DD MON YYYY')""",
            "SQL Server": """Example Clause:
CAST('02/03/1992' AS DATE)
CONVERT(DATE, '2 March 1992', 106)""",
            "BigQuery": """Example Clause:
PARSE_DATE('%d/%m/%Y', '02/03/1992')
PARSE_DATE('%a, %d %B %Y', 'Mon, 2 March 1992')""",
        },
        'TIME': {
            "DuckDB": """Example Clause: 
CAST(strptime('14:30:45', '%H:%M:%S') AS TIME)
CAST(strptime(REPLACE(REPLACE('08:32:45 p.m.', 'a.m.', 'AM'), 'p.m.', 'PM'), '%I:%M:%S %p') AS TIME)""",
            "Snowflake": """Example Clause: 
TO_TIME('14:30:45', 'HH24:MI:SS')
TO_TIME(REPLACE(REPLACE('08:32:45 p.m.', 'a.m.', 'AM'), 'p.m.', 'PM'), 'HH12:MI:SS AM')""",
            "SQL Server": """Example Clause:
CAST('14:30:45' AS TIME)
CONVERT(TIME, '20:32:45', 108)""",
            "BigQuery": """Example Clause:
PARSE_TIME('%H:%M:%S', '14:30:45')
PARSE_TIME('%I:%M:%S %p', REPLACE(REPLACE('08:32:45 p.m.', 'a.m.', 'am'), 'p.m.', 'pm'))""",
        },
        'TIMESTAMP': {
            "DuckDB": """Example Clause: 
strptime('02/03/1992', '%d/%m/%Y')
strptime('Monday, 2 March 1992 - 08:32:45 PM', '%A, %-d %B %Y - %I:%M:%S %p')""",
            "Snowflake": """Example Clause: 
TO_DATE('02/03/1992', 'DD/MM/YYYY')
TO_TIMESTAMP('Monday, 2 March 1992 - 08:32:45 PM', 'DY, D MONTH YYYY - HH12:MI:SS AM')""",
            "BigQuery": """Example Clause:
PARSE_TIMESTAMP('%d/%m/%Y', '02/03/1992')
PARSE_TIMESTAMP('%A, %d %B %Y - %I:%M:%S %p', 'Monday, 2 March 1992 - 08:32:45 PM')""",
        },
        'DATETIME': {
            "SQL Server": """Example Clause:
CAST('02/03/1992' AS DATETIME)
CONVERT(DATETIME, 'Mar 2 1992 08:32:45:123PM', 109)""",
            "BigQuery": """Example Clause:
PARSE_DATETIME('%d/%m/%Y', '02/03/1992')
PARSE_DATETIME('%b %e %Y %r', 'Mar 2 1992 08:32:45 PM')"""
        },
        'BOOLEAN': {
            "DuckDB": """Example Clause:
CASE WHEN col = 'no' THEN false ELSE true END""",
            "Snowflake": """Example Clause:
CASE WHEN col = 'no' THEN false ELSE true END""",
            "SQL Server": """Example Clause:
CASE WHEN col = 'no' THEN 0 ELSE 1 END""",
            "BigQuery": """Example Clause:
CASE WHEN col = 'no' THEN FALSE ELSE TRUE END"""
        },
        'VARIANT': {
            "Snowflake": """Example Clause:
PARSE_JSON('["Apple", "Pear","Chicken"]')
SPLIT('127.0.0.1', '.')""",
        },
        'ARRAY': {
            "DuckDB": """Example Clause:
from_json(json('[1,2,3]'),'["INT"]')
SPLIT('127.0.0.1', '.')""",
            "Snowflake": """Example Clause:
PARSE_JSON('["Apple", "Pear","Chicken"]')
SPLIT('127.0.0.1', '.')""",
            "BigQuery": """Example Clause:
JSON_QUERY_ARRAY('["Apple", "Pear","Chicken"]')
SPLIT('127.0.0.1', '.')"""
        },
        'JSON': {
            "DuckDB": """Example Clause:
from_json(json('[1,2,3]'),'["INT"]')
SPLIT('127.0.0.1', '.')""",
            "SQL Server": """Example Clause:
JSON_QUERY('["Apple", "Pear","Chicken"]')""",
            "BigQuery": """Example Clause:
JSON_QUERY('{"fruits": ["Apple", "Pear", "Chicken"]}', '$.fruits')"""
        },
        'MAP': {
            "Snowflake": """Example Clause:
PARSE_JSON('["Apple", "Pear","Chicken"]')
SPLIT('127.0.0.1', '.')""",
        },
        "INT": {
            "DuckDB": """Example Clause:
CAST(REGEXP_EXTRACT('35 KG', '(\d+(\.\d+)?)') AS INT)""",
            "Snowflake": """Example Clause:
CAST(REGEXP_SUBSTR('35 KG', '\\\\d+(\\\\.\\\\d+)?') AS INT)""",
            "SQL Server": """Example Clause:
CAST(LEFT('35 KG', PATINDEX('%[^0-9]%', '35 KG' + 'a') - 1) AS INT)""",
            "BigQuery": """Example Clause:
CAST(REGEXP_EXTRACT('35 KG', r'\d+') AS INT)"""
        },
        "DECIMAL": {
            "DuckDB": """Example Clause:
CAST(REGEXP_EXTRACT('35.2 KG', '(\d+(\.\d+)?)') AS DECIMAL)""",
            "Snowflake": """Example Clause:
CAST(REGEXP_SUBSTR('35.2 KG', '\\\\d+(\\\\.\\\\d+)?') AS FLOAT)""",
            "SQL Server": """Example Clause:
CAST(LEFT('35.2 KG', CHARINDEX(' ', '35.2 KG' + ' ') - 1) AS DECIMAL(10,2))""",
        },
        "FLOAT": {
            "BigQuery": """Example Clause:
CAST(REGEXP_EXTRACT('35.2 KG', r'(\d+\.?\d*)') AS FLOAT64)"""
        },
        "RANGE": {
            "BigQuery": """Example Clause:
CAST('[2020-01-01, 2020-01-02)' AS RANGE<DATE>)"""
        }
    },
    
    'INT':{
        'DATE': {
            "DuckDB": """Example Clause:
strptime(CAST(19920302 AS VARCHAR), '%Y%m%d')""",
            "Snowflake": """Example Clause:
TO_DATE(TO_CHAR(19920302), 'YYYYMMDD')""",
            "SQL Server": """Example Clause:
CONVERT(DATE, CAST(19920302 AS VARCHAR(8)), 112)""",
            "BigQuery": """Example Clause:
DATE(PARSE_DATE('%Y%m%d', CAST(19920302 AS STRING)))"""
        },
        'TIME': {
            "DuckDB": """Example Clause:
strptime(CAST(13245 AS VARCHAR), '%H%M%S')""",
            "Snowflake": """Example Clause:
TO_TIME(TO_CHAR(13245), 'HHMISS')""",
            "SQL Server": """Example Clause:
CONVERT(TIME, STUFF(STUFF(RIGHT('000000' + CAST(132445 AS VARCHAR(6)), 6), 3, 0, ':'), 6, 0, ':'),108)""",
            "BigQuery": """Example Clause:
TIME(CAST(CAST(132445 AS STRING FORMAT '%06d') AS STRING FORMAT '%H%M%S'))"""
        },
        'TIMESTAMP': {
            "DuckDB": """Example Clause:
strptime(CAST(199203020832 AS VARCHAR), '%Y%m%d%H%M')""",
            "Snowflake": """Example Clause:
TO_TIMESTAMP(TO_CHAR(19920302083200), 'YYYYMMDDHH24MISS')""",
            "BigQuery": """Example Clause:
TIMESTAMP(PARSE_DATETIME('%Y%m%d%H%M%S', FORMAT('%014d', 19920302083200)))"""
        },
        'DATETIME': {
            "SQL Server": """Example Clause:
CONVERT(DATETIME, STUFF(STUFF(CAST(199203020832 AS VARCHAR(12)), 9, 0, ' '), 12, 0, ':') + ':00', 120)""",
            "BigQuery": """Example Clause:
DATETIME(PARSE_DATETIME('%Y%m%d%H%M%S', FORMAT('%014d', 19920302083200)))"""
        },
    },
    'DECIMAL':{
        'DATE': {
            "DuckDB": """Example Clause:
strptime(CAST(19920302 AS VARCHAR), '%Y%m%d')""",
            "Snowflake": """Example Clause:
TO_DATE(TO_CHAR(19920302), 'YYYYMMDD')""",
            "SQL Server": """Example Clause:
CONVERT(DATE, CAST(19920302 AS VARCHAR(8)), 112)""",
            "BigQuery": """Example Clause:
PARSE_DATE('%Y%m%d', CAST(19920302 AS STRING))"""
        },
        'TIME': {
            "DuckDB": """Example Clause:
strptime(CAST(13245 AS VARCHAR), '%H%M%S')""",
            "Snowflake": """Example Clause:
TO_TIME(TO_CHAR(13245), 'HHMISS')""",
"SQL Server": """Example Clause:
CONVERT(TIME, STUFF(STUFF(RIGHT('000000' + CAST(132445 AS VARCHAR(6)), 6), 3, 0, ':'), 6, 0, ':'),108)""",
            "BigQuery": """Example Clause:
PARSE_TIME('%H%M%S', FORMAT('%06d', 132445))"""
        },
        'TIMESTAMP': {
            "DuckDB": """Example Clause:
strptime(CAST(199203020832 AS VARCHAR), '%Y%m%d%H%M')""",
            "Snowflake": """Example Clause:
TO_TIMESTAMP(TO_CHAR(19920302083200), 'YYYYMMDDHH24MISS')""",
            "BigQuery": """Example Clause:
PARSE_TIMESTAMP('%Y%m%d%H%M', CAST(199203020832 AS STRING))"""
        },
        'DATETIME': {
            "SQL Server": """Example Clause:
CONVERT(DATETIME, STUFF(STUFF(CAST(199203020832 AS VARCHAR(12)), 9, 0, ' '), 12, 0, ':') + ':00', 120)""",
            "BigQuery": """Example Clause:
PARSE_DATETIME('%Y%m%d%H%M', CAST(199203020832 AS STRING))"""
        },
    },
}


    
def get_reverse_type(data_type, database):
    data_type = data_type.upper().replace(" ", "")

    if database == "Snowflake":
        if data_type.startswith("NUMBER"):
            if data_type.endswith(",0)") or data_type.endswith(",0"):
                return "INT"
            else:
                return "DECIMAL"
            
    if database == "DuckDB":
        if data_type.endswith("[]"):
            return "ARRAY"
    
    data_type = data_type.split('(')[0].upper().strip()
    
    if database not in data_types_database:
        if cocoon_main_setting['DEBUG_MODE']:
            raise ValueError(f"Database '{database}' not found in data_types_database")
        return data_type

    for key, value in data_types_database[database].items():
        if data_type.upper() in value:
            return key
        
    if cocoon_main_setting['DEBUG_MODE']:
            raise ValueError(f"Data type '{data_type}' not found in database '{database}'")
    
    return data_type


reverse_data_types = {}
for key, value in data_types.items():
    for val in value:
        reverse_data_types[val] = key