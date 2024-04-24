data_types ={
    "INT": ["INT", "INTEGER", "BIGINT", "SMALLINT", "TINYINT"],
    "DECIMAL": ["DECIMAL", "NUMERIC", "DOUBLE", "FLOAT", "FIXED"],
    "BOOLEAN": ["BOOLEAN"],
    "DATE": ["DATE"],
    "TIME": ["TIME"],
    "TIMESTAMP": ["TIMESTAMP"],
    "INTERVAL": ["INTERVAL"],
    "VARCHAR": ["VARCHAR", "CHAR", "TEXT", "STRING", "CHARACTER"],
    "UUID": ["UUID"],
    "BLOB": ["BLOB"],
    "JSON": ["JSON"],
    "ARRAY": ["ARRAY"]
}

reverse_data_types = {}
for key, value in data_types.items():
    for val in value:
        reverse_data_types[val] = key