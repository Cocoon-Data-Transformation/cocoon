try:
    import duckdb
except ImportError:
    pass

try:
    import snowflake.connector
except ImportError:
    pass

import pandas as pd
import json

def run_sql_return_df(con, sql_query):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return con.execute(sql_query).df()
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return pd.read_sql(sql_query, con)
    else:
        raise ValueError(f"Connection type {type(con)} not supported")
    

def get_schema_snowflake(con):
    cursor = con.cursor()
    schema_tables = {}
    
    try:
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()
        
        for table_info in tables:
            table_name = table_info[1]
            cursor.execute(f"SHOW COLUMNS IN TABLE {table_name}")
            columns = cursor.fetchall()
            
            schema_tables[table_name] = [col_info[2] for col_info in columns]
            
    finally:
        cursor.close()
        
    return schema_tables

def get_schema(con):
    if isinstance(con, duckdb.DuckDBPyConnection):
        schema_df = run_sql_return_df(con, "DESCRIBE;")

        tables = {}
        for _, row in schema_df.iterrows():
            table_name = row['name']
            column_name = row['column_names']
            tables[table_name] = column_name
        
        return tables
    
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        tables = get_schema_snowflake(con)
        return tables
        
    else:
        raise ValueError(f"Connection type {type(con)} not supported")
   
def get_table_schema(conn, table_name):

    if isinstance(conn, duckdb.DuckDBPyConnection):

        query = f"""
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = '{table_name}'
        ORDER BY ordinal_position;
        """
        
        result = conn.execute(query).fetchall()
        
        schema = {}
        for row in result:
            schema[row[0]] = row[1]
        
        return schema

    elif isinstance(conn, snowflake.connector.connection.SnowflakeConnection):
        query = f"SHOW COLUMNS IN TABLE {table_name}"

        df = run_sql_return_df(conn, query)
        df = df[["table_name", "column_name", "data_type"]]
        df['simple_data_type'] = df['data_type'].apply(lambda x: json.loads(x)['type'])

        schema = {}
        for _, row in df.iterrows():
            schema[row['column_name']] = row['simple_data_type']

        return schema

