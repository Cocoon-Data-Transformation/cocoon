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
        "TIMESTAMP": ["DATETIME", "TIMESTAMP", "TIMESTAMPTZ", "TIMESTAMP WITH TIME ZONE"],
        "VARCHAR": ["CHAR", "BPCHAR", "TEXT", "STRING", "VARCHAR"],
        "ARRAY": ["ARRAY"],
        "JSON": ["JSON"],
        "INTERVAL": ["INTERVAL"],
        "UUID": ["UUID"],
    }
}

database_general_hint = {
    "DuckDB": "",
    "Snowflake": "Double quote table and column names, if they are not all uppercase", 
}

transform_hints = {
    'VARCHAR':{
        'DATE': {
            "DuckDB": """Example Clause: 
CAST(strptime('02/03/1992', '%d/%m/%Y') AS DATE)
CAST(strptime(replace('Mon, 2 March 1992', 'Mon', 'Monday'), '%A, %-d %B %Y') AS DATE)""",
            "Snowflake": """Example Clause: 
TO_DATE('02/03/1992', 'DD/MM/YYYY')
TO_DATE('Mon, 2 March 1992', 'DY, DD MON YYYY')""",
        },
        'TIME': {
            "DuckDB": """Example Clause: 
CAST(strptime('14:30:45', '%H:%M:%S') AS TIME)
CAST(strptime(REPLACE(REPLACE('08:32:45 p.m.', 'a.m.', 'AM'), 'p.m.', 'PM'), '%I:%M:%S %p') AS TIME)""",
            "Snowflake": """Example Clause: 
TO_TIME('14:30:45', 'HH24:MI:SS')
TO_TIME(REPLACE(REPLACE('08:32:45 p.m.', 'a.m.', 'AM'), 'p.m.', 'PM'), 'HH12:MI:SS AM')""",
        },
        'TIMESTAMP': {
            "DuckDB": """Example Clause: 
strptime('02/03/1992', '%d/%m/%Y')
strptime('Monday, 2 March 1992 - 08:32:45 PM', '%A, %-d %B %Y - %I:%M:%S %p')""",
            "Snowflake": """Example Clause: 
TO_DATE('02/03/1992', 'DD/MM/YYYY')
TO_TIMESTAMP('Monday, 2 March 1992 - 08:32:45 PM', 'DY, D MONTH YYYY - HH12:MI:SS AM')""",
        },
        'BOOL': {
            "DuckDB": """Example Clause:
CASE WHEN col = 'no' THEN false ELSE true END""",
            "Snowflake": """Example Clause:
CASE WHEN col = 'no' THEN false ELSE true END""",
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
        },
        'JSON': {
            "DuckDB": """Example Clause:
from_json(json('[1,2,3]'),'["INT"]')
SPLIT('127.0.0.1', '.')""",
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
        },
        "DECIMAL": {
            "DuckDB": """Example Clause:
CAST(REGEXP_EXTRACT('35.2 KG', '(\d+(\.\d+)?)') AS DECIMAL)""",
            "Snowflake": """Example Clause:
CAST(REGEXP_SUBSTR('35.2 KG', '\\\\d+(\\\\.\\\\d+)?') AS FLOAT)""",
        },
    },
    
    'INT':{
        'DATE': {
            "DuckDB": """Example Clause:
strptime(CAST(19920302 AS VARCHAR), '%Y%m%d')""",
            "Snowflake": """Example Clause:
TO_DATE(TO_CHAR(19920302), 'YYYYMMDD')""",
        },
        'TIME': {
            "DuckDB": """Example Clause:
strptime(CAST(13245 AS VARCHAR), '%H%M%S')""",
            "Snowflake": """Example Clause:
TO_TIME(TO_CHAR(13245), 'HHMISS')""",
        },
        'TIMESTAMP': {
            "DuckDB": """Example Clause:
strptime(CAST(199203020832 AS VARCHAR), '%Y%m%d%H%M')""",
            "Snowflake": """Example Clause:
TO_TIMESTAMP(TO_CHAR(19920302083200), 'YYYYMMDDHH24MISS')""",
        },
    },
    'DECIMAL':{
        'DATE': {
            "DuckDB": """Example Clause:
strptime(CAST(19920302 AS VARCHAR), '%Y%m%d')""",
            "Snowflake": """Example Clause:
TO_DATE(TO_CHAR(19920302), 'YYYYMMDD')""",
        },
        'TIME': {
            "DuckDB": """Example Clause:
strptime(CAST(13245 AS VARCHAR), '%H%M%S')""",
            "Snowflake": """Example Clause:
TO_TIME(TO_CHAR(13245), 'HHMISS')""",
        },
        'TIMESTAMP': {
            "DuckDB": """Example Clause:
strptime(CAST(199203020832 AS VARCHAR), '%Y%m%d%H%M')""",
            "Snowflake": """Example Clause:
TO_TIMESTAMP(TO_CHAR(19920302083200), 'YYYYMMDDHH24MISS')""",
        },
    },
}


def is_type_numeric(data_type):
    return data_type in ["INT", "DECIMAL"]
    
    
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
        raise ValueError(f"Database '{database}' not found in data_types_database")

    for key, value in data_types_database[database].items():
        if data_type.upper() in value:
            return key

    raise ValueError(f"Data type '{data_type}' not found in database '{database}'")

reverse_data_types = {}
for key, value in data_types.items():
    for val in value:
        reverse_data_types[val] = key