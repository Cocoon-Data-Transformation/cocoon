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
        "JSON": ["JSON"],
        "VARIANT": ["VARIANT"],
        "OBJECT": ["OBJECT"],
        "ARRAY": ["ARRAY"],
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
        "INTERVAL": ["INTERVAL"],
        "UUID": ["UUID"],
        "LIST": ["LIST"],
        "MAP": ["MAP"],
        "STRUCT": ["STRUCT"],
        "UNION": ["UNION"]
    }
}

transform_hints = {
    'VARCHAR':{
        'DATE': {
            "DuckDB": """Example Clause: 
strptime('02/03/1992', '%d/%m/%Y')
strptime('Monday, 2 March 1992 - 08:32:45 PM', '%A, %-d %B %Y - %I:%M:%S %p')""",
            "Snowflake": """Example Clause: 
TO_DATE('02/03/1992', 'DD/MM/YYYY')
TO_TIMESTAMP('Monday, 2 March 1992 - 08:32:45 PM', 'DY, D MONTH YYYY - HH12:MI:SS AM')""",
        },
        'TIME': {
            "DuckDB": """Example Clause: 
strptime('02/03/1992', '%d/%m/%Y')
strptime('Monday, 2 March 1992 - 08:32:45 PM', '%A, %-d %B %Y - %I:%M:%S %p')""",
            "Snowflake": """Example Clause: 
TO_DATE('02/03/1992', 'DD/MM/YYYY')
TO_TIMESTAMP('Monday, 2 March 1992 - 08:32:45 PM', 'DY, D MONTH YYYY - HH12:MI:SS AM')""",
        },
        'TIMESTAMP': {
            "DuckDB": """Example Clause: 
strptime('02/03/1992', '%d/%m/%Y')
strptime('Monday, 2 March 1992 - 08:32:45 PM', '%A, %-d %B %Y - %I:%M:%S %p')""",
            "Snowflake": """Example Clause: 
TO_DATE('02/03/1992', 'DD/MM/YYYY')
TO_TIMESTAMP('Monday, 2 March 1992 - 08:32:45 PM', 'DY, D MONTH YYYY - HH12:MI:SS AM')""",
        },
    }
}

def get_reverse_type(data_type, database):
    if database == "Snowflake":
        if data_type.upper().startswith("NUMBER"):
            if data_type.upper().endswith(", 0)"):
                return "INT"
            else:
                return "DECIMAL"
    
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