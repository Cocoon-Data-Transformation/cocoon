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


reverse_data_types = {}
for key, value in data_types.items():
    for val in value:
        reverse_data_types[val] = key