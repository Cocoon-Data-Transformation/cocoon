try:
    import duckdb
except ImportError:
    pass

try:
    import snowflake.connector
    from snowflake.connector.pandas_tools import write_pandas
except ImportError:
    pass

try:
    import pyodbc
except ImportError:
    pass

import pandas as pd
import json
import sqlglot
import re

def get_database_name(con):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return "DuckDB"
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return "Snowflake"
    elif isinstance(con, pyodbc.Connection):
        return "SQL Server"
    else:
        return "Unknown"

cocoon_query_logs = []

def run_sql_return_df(con, sql_query, database=None, schema=None, transpile=True, log=False):
    if log:
        cocoon_query_logs.append(sql_query)
    if isinstance(con, duckdb.DuckDBPyConnection):
        context_queries = []
        if database:
            context_queries.append(f"SET CURRENT_CATALOG = '{database}';")
        if schema:
            context_queries.append(f"SET CURRENT_SCHEMA = '{schema}';")
        
        full_query = "\n".join(context_queries + [sql_query])
        try:
            return con.execute(full_query).df()
        except Exception as e:
            raise type(e)(f"Error executing query:\n{full_query}\n\nOriginal error: {str(e)}") from e

    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        cursor = con.cursor()
        try:
            if database:
                cursor.execute(f'USE DATABASE "{database}"')
            if schema:
                cursor.execute(f'USE SCHEMA "{schema}"')
            
            try:
                cursor.execute(sql_query)
                if cursor.description:
                    columns = [desc[0] for desc in cursor.description]
                    data = cursor.fetchall()
                    return pd.DataFrame(data, columns=columns)
                else:
                    return pd.DataFrame()
            except Exception as e:
                raise type(e)(f"Error executing query:\n{sql_query}\n\nOriginal error: {str(e)}") from e
        finally:
            cursor.close()
            
    elif isinstance(con, pyodbc.Connection):
        cursor = con.cursor()
        try:
            if database:
                cursor.execute(f'USE {database}')
            if schema:
                cursor.execute(f'SET SCHEMA {schema}')
            
            if transpile:
                try:
                    sql_query = sqlglot.transpile(sql_query, read="tsql", write="tsql", comments=False)[0]
                except Exception as e:
                    print(f"Error transpiling query:\n{sql_query}\n\nOriginal error: {str(e)}") 
            try:
                cursor.execute(sql_query)
                if cursor.description:
                    columns = [column[0] for column in cursor.description]
                    data = cursor.fetchall()
                    return pd.DataFrame.from_records(data, columns=columns)
                else:
                    con.commit()
                    return pd.DataFrame()
            except Exception as e:
                con.rollback()
                raise type(e)(f"Error executing query:\n{sql_query}\n\nOriginal error: {str(e)}") from e
        finally:
            cursor.close()
    else:
        raise ValueError(f"Connection type {type(con)} not supported")

def enclose_table_name(table_name):
    table_name = f"{table_name}"
    if not table_name.startswith('"'):
        table_name = '"' + table_name
    if not table_name.endswith('"'):
        table_name = table_name + '"'
    return table_name

def get_schema_sqlserver(con):
    cursor = con.cursor()
    schema_tables = {}
    
    try:
        cursor.execute("SELECT DB_NAME()")
        db_name = cursor.fetchone()[0]
        
        cursor.execute(f"""
            SELECT TABLE_NAME
            FROM {db_name}.INFORMATION_SCHEMA.TABLES
            WHERE TABLE_TYPE = 'BASE TABLE'
        """)
        tables = cursor.fetchall()
        
        for table_info in tables:
            table_name = table_info[0]
            cursor.execute(f"""
                SELECT COLUMN_NAME
                FROM {db_name}.INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = ?
                ORDER BY ORDINAL_POSITION
            """, table_name)
            columns = cursor.fetchall()
            
            schema_tables[table_name] = [col[0] for col in columns]
            
    finally:
        cursor.close()
        
    return schema_tables
    
def get_schema_snowflake(con):
    cursor = con.cursor()
    schema_tables = {}
    
    try:
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()
        
        for table_info in tables:
            table_name = table_info[1]
            cursor.execute(f"SHOW COLUMNS IN TABLE \"{table_name}\"")
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

    elif isinstance(con, pyodbc.Connection):
        tables = get_schema_sqlserver(con)
        return tables
    
    else:
        return {}
    
def get_query_schema(con, query, transpile=True):

    if isinstance(con, duckdb.DuckDBPyConnection):
        describe_query = f"DESCRIBE ({query})"
        schema_df = run_sql_return_df(con, describe_query)
        return dict(zip(schema_df['column_name'], schema_df['column_type']))
    
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        cur = con.cursor()

        try:
            cur.execute(query)
        except Exception as e:
            raise type(e)(f"Error executing query:\n{query}\n\nOriginal error: {str(e)}") from e

        query_id = cur.sfqid

        df = run_sql_return_df(con, f"DESCRIBE RESULT '{query_id}'; ")

        cur.close()

        return dict(zip(df['name'], df['type']))
    
    elif isinstance(con, pyodbc.Connection):
        if transpile:
            try:
                query = sqlglot.transpile(query, read="tsql", write="tsql", comments=False)[0]
            except Exception as e:
                print(f"Error transpiling query:\n{query}\n\nOriginal error: {str(e)}") 

        escaped_query = query.replace("'", "''")

        describe_query = f"EXEC sp_describe_first_result_set N'{escaped_query}'"

        try:
            df = pd.read_sql(describe_query, con)
            df = df[df['is_hidden'] == False][['name', 'system_type_name']]

            return dict(zip(df['name'], df['system_type_name']))
        
        except pyodbc.Error as e:
            raise ValueError(f"Error executing query:\n{query}\n\nOriginal error: {str(e)}")
    
    else:
        return {}


def get_table_schema(conn, table_name, schema=None, database=None):
    raw_table_name = table_name
    if schema and database:
        table_name = f'{enclose_table_name(database)}.{enclose_table_name(schema)}.{enclose_table_name(table_name)}'
    else:
        table_name = enclose_table_name(table_name)
    if isinstance(conn, duckdb.DuckDBPyConnection):
        describe_query = f"DESCRIBE {table_name}"
        schema_df = run_sql_return_df(conn, describe_query)
        return dict(zip(schema_df['column_name'], schema_df['column_type']))

    elif isinstance(conn, snowflake.connector.connection.SnowflakeConnection):
        query = f'SHOW COLUMNS IN TABLE {table_name}'

        df = run_sql_return_df(conn, query)
        df = df[["table_name", "column_name", "data_type"]]
        def determine_data_type(x):
            data = json.loads(x)
            if data['type'] == 'FIXED':
                if data.get('scale', 1) == 0:
                    return 'INT'
            return data['type']

        df['simple_data_type'] = df['data_type'].apply(determine_data_type)
        
        schema = {}
        for _, row in df.iterrows():
            schema[row['column_name']] = row['simple_data_type']

        return schema

    elif isinstance(conn, pyodbc.Connection):
        query = f"""
        SELECT COLUMN_NAME, DATA_TYPE
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = '{raw_table_name.replace("'", "''")}'
        """
        
        if schema:
            query += f""" AND TABLE_SCHEMA = '{schema.replace("'", "''")}'"""
        
        if database:
            query += f""" AND TABLE_CATALOG = '{database.replace("'", "''")}'"""

        cursor = conn.cursor()
        cursor.execute(query)
        
        schema = {}
        for row in cursor.fetchall():
            column_name, data_type = row
            schema[column_name] = data_type

        cursor.close()
        return schema

def get_table_names(conn):
    if isinstance(conn, duckdb.DuckDBPyConnection):
        query = "SHOW TABLES"
        df = run_sql_return_df(conn, query)
        df = df[['name']]
        table_names = df['name'].tolist()
        return table_names

    elif isinstance(conn, snowflake.connector.connection.SnowflakeConnection):
        query = "SHOW TABLES"
        df = run_sql_return_df(conn, query)
        df = df[['name']]
        table_names = df['name'].tolist()
        
        return table_names
    
    elif isinstance(conn, pyodbc.Connection):
        query = """
        SELECT TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE'
        """
        cursor = conn.cursor()
        cursor.execute(query)
        
        results = cursor.fetchall()
        
        table_names = [row.TABLE_NAME for row in results]
        
        cursor.close()
        return table_names
        
    else:
        return []
    


def generate_count_distinct_query(table_name, attributes, ratio=True):
    select_clauses = []
    table_name = enclose_table_name(table_name)
    
    for attribute in attributes:
        if ratio:
            select_clause = f'COUNT(DISTINCT "{attribute}")/COUNT(*) AS "{attribute}"'
        else:
            select_clause = f'COUNT(DISTINCT "{attribute}") AS "{attribute}"'
        select_clauses.append(select_clause)
    
    query = f'SELECT {", ".join(select_clauses)} \nFROM {table_name}'
    
    return query




def generate_group_ratio_query(table_name, group_by, attributes):
    subquery_select_clauses = []
    main_select_clauses = []
    table_name = enclose_table_name(table_name)
    
    for attribute in attributes:
        subquery_select_clause = f'ENTROPY("{attribute}") AS "{attribute}"'
        subquery_select_clauses.append(subquery_select_clause)

        main_select_clause = f'AVG("{attribute}") AS "{attribute}"'
        main_select_clauses.append(main_select_clause)

    subquery_select = ", ".join(subquery_select_clauses)
    main_select = ", ".join(main_select_clauses)

    query = f"""
    SELECT {main_select}
    FROM (
        SELECT "{group_by}", {subquery_select}, COUNT(*) AS "COCOON_COUNT"
        FROM {table_name}
        GROUP BY "{group_by}"
        HAVING "COCOON_COUNT" > 5
    ) AS subquery;
    """

    return query



def generate_queries_for_overlap(table1, attributes1, table2, attributes2, con):
    table1 = enclose_table_name(table1)
    table2 = enclose_table_name(table2)
    
    select_clause1 = ", ".join(f"{table1}.\"{attr}\"" for attr in attributes1)
    select_clause2 = ", ".join(f"{table2}.\"{attr}\"" for attr in attributes2)

    query1 = f"""
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT {select_clause1}
            FROM {table1}
            LEFT JOIN (
                SELECT DISTINCT {select_clause2}
                FROM {table2}
                WHERE {' OR '.join(f'{table2}."{attr2}" IS NOT NULL' for attr2 in attributes2)}
            ) T2 ON {' AND '.join(f'{table1}."{attr1}" = T2."{attr2}"' for attr1, attr2 in zip(attributes1, attributes2))}
            WHERE {' AND '.join(f'T2."{attr2}" IS NULL' for attr2 in attributes2)}
                AND {' OR '.join(f'{table1}."{attr1}" IS NOT NULL' for attr1 in attributes1)}
        )
    """
    only1 = run_sql_return_df(con, query1).iloc[0, 0]

    query2 = f"""
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT {select_clause2}
            FROM {table2}
            LEFT JOIN (
                SELECT DISTINCT {select_clause1}
                FROM {table1}
                WHERE {' OR '.join(f'{table1}."{attr1}" IS NOT NULL' for attr1 in attributes1)}
            ) T1 ON {' AND '.join(f'{table2}."{attr2}" = T1."{attr1}"' for attr1, attr2 in zip(attributes1, attributes2))}
            WHERE {' AND '.join(f'T1."{attr1}" IS NULL' for attr1 in attributes1)}
                AND {' OR '.join(f'{table2}."{attr2}" IS NOT NULL' for attr2 in attributes2)}
        )
    """
    only2 = run_sql_return_df(con, query2).iloc[0, 0]

    query3 = f"""
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT {select_clause1}
            FROM {table1}
            INNER JOIN (
                SELECT DISTINCT {select_clause2}
                FROM {table2}
                WHERE {' OR '.join(f'{table2}."{attr2}" IS NOT NULL' for attr2 in attributes2)}
            ) T3 ON {' AND '.join(f'{table1}."{attr1}" = T3."{attr2}"' for attr1, attr2 in zip(attributes1, attributes2))}
            WHERE {' OR '.join(f'{table1}."{attr1}" IS NOT NULL' for attr1 in attributes1)}
        )
    """
    overlap = run_sql_return_df(con, query3).iloc[0, 0]

    return int(only1), int(only2), int(overlap)



def create_sample_distinct_query(table_name, column_name, sample_size=None):
    table_name = enclose_table_name(table_name)
    query =  f'SELECT "{column_name}" \nFROM {table_name} \nWHERE "{column_name}" IS NOT NULL \nGROUP BY "{column_name}" \nORDER BY COUNT(*) DESC, "{column_name}"\n'
    if sample_size is not None:
        query += f" LIMIT {sample_size}"
    return query

def create_sample_distinct(con, table_name, column_name, sample_size):

    query = create_sample_distinct_query(table_name, column_name, sample_size)
    sample_values = run_sql_return_df(con,query)

    return sample_values

def create_sample_distinct_query_regex(con, table_name, column_name, sample_size=None, regex_except_list=None, regex_list=None, with_context=""):
    if regex_list is None:
        regex_list = []
        
    if regex_except_list is None:
        regex_except_list = []
        
    table_name = enclose_table_name(table_name)
        
    query =  f'SELECT "{column_name}" \nFROM {table_name} \nWHERE "{column_name}" IS NOT NULL \n'
    
    for regex in regex_list:
        regex_match_clause = create_regex_match_clause(con, column_name, regex)
        query += f"AND {regex_match_clause} \n"
    
    for regex in regex_except_list:
        regex_match_clause = create_regex_match_clause(con, column_name, regex)
        query += f"AND NOT {regex_match_clause} \n"
    
    query += f'GROUP BY "{column_name}" \nORDER BY COUNT(*) DESC, "{column_name}"\n'
    
    if sample_size is not None:
        query += f" LIMIT {sample_size}"

    query = with_context + "\n" + query
    
    sample_values = run_sql_return_df(con, query)
    return sample_values

def create_regex_match_clause(con, column_name, regex):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return f'regexp_full_match("{column_name}", \'{regex}\')'
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        regex = regex.replace('\\', '\\\\')
        return f'REGEXP_LIKE("{column_name}", \'{regex}\')'
    elif isinstance(con, pyodbc.Connection):
        like_pattern = regex_to_like_pattern(regex)
        return f'"{column_name}" LIKE \'{like_pattern}\''
    else:
        raise ValueError(f"Connection type {type(con)} not supported")

def regex_to_like_pattern(regex):
    pattern = regex.replace('%', '[%]').replace('_', '[_]')
    
    pattern = pattern.replace('.*', '%')
    pattern = pattern.replace('.', '_')
    pattern = pattern.replace('?', '_')
    pattern = pattern.replace('+', '%')
    pattern = pattern.replace('^', '')
    pattern = pattern.replace('$', '')
    
    pattern = re.sub(r'\\d', '_', pattern)
    pattern = re.sub(r'\\w', '_', pattern)
    pattern = re.sub(r'\\s', '_', pattern)
    
    pattern = re.sub(r'\{(\d+)\}', lambda m: '_' * int(m.group(1)), pattern)
    pattern = re.sub(r'\{(\d+),\}', r'%', pattern)
    pattern = re.sub(r'\{(\d+),(\d+)\}', r'%', pattern)
    
    pattern = re.sub(r'\\[bB]', '', pattern)
    pattern = re.sub(r'\(\?[=!:].*?\)', '', pattern)
    pattern = re.sub(r'\(\?<[=!].*?\)', '', pattern)
    
    return pattern


def find_duplicate_rows_result(con, table_name, sample_size=0, with_context = "", columns=None):
    
    table_name = enclose_table_name(table_name)

    group_by_clause = "ALL"
    if columns is not None:
        group_by_clause = ", ".join(f'{enclose_table_name(column)}' for column in columns)
    
    sql_query = f'''
SELECT *, COUNT(*) as cocoon_count
FROM {table_name}
GROUP BY {group_by_clause}
HAVING COUNT(*) > 1'''
        
    duplicate_count_sql = f'SELECT COUNT(*) FROM ({sql_query}) AS DUPLICATES'
    duplicate_count_sql = with_context + "\n" + duplicate_count_sql
        
    duplicate_count = run_sql_return_df(con, duplicate_count_sql).iloc[0, 0]

    sample_sql = sql_query
    if sample_size > 0:
        sample_sql += f" LIMIT {sample_size}"
    
    sample_sql = with_context + "\n" + sample_sql
    sample_duplicate_rows = run_sql_return_df(con, sample_sql)
    return duplicate_count, sample_duplicate_rows

def where_clause_for_space(column_name):
    return f'"{column_name}" <> TRIM("{column_name}")'

def construct_distinct_count_query(table_name, column_name):
    
    table_name = enclose_table_name(table_name)
    
    query = f'SELECT COUNT(DISTINCT "{column_name}") FROM {table_name} WHERE "{column_name}" IS NOT NULL'
    return query

def count_total_distinct(con, table_name, column_name):
    query = construct_distinct_count_query(table_name, column_name)
    result_df = run_sql_return_df(con, query)
    total_distinct_count = result_df.iloc[0, 0]
    return total_distinct_count

def compute_unique_ratio(con, table_name, column_name, allow_null=False, with_context=""):
    table_name = enclose_table_name(table_name)
    
    if not allow_null:
        query = f"""
        SELECT COUNT(DISTINCT "{column_name}") AS DISTINCT_COUNT,
               COUNT(*) AS TOTAL_COUNT
        FROM {table_name}
        """
    else:
        query = f"""
        SELECT COUNT(DISTINCT "{column_name}") AS DISTINCT_COUNT,
               COUNT("{column_name}") AS NON_NULL_COUNT
        FROM {table_name}
        """

    query = with_context + "\n" + query
    result = run_sql_return_df(con, query)
    distinct_count = result.iloc[0]['DISTINCT_COUNT']
    
    total_count = result.iloc[0]['TOTAL_COUNT'] if not allow_null else result.iloc[0]['NON_NULL_COUNT']
    return distinct_count, total_count



def list_duckdb_databases(con):
    query = "SELECT DISTINCT catalog_name FROM information_schema.schemata"
    df = run_sql_return_df(con, query)
    return df['catalog_name'].tolist()

def list_duckdb_schemas(con, database):
    query = f"SELECT schema_name FROM information_schema.schemata WHERE catalog_name = '{database}'"
    df = run_sql_return_df(con, query)
    return df['schema_name'].tolist()

def list_duckdb_objects(con, schema, database, object_type='BASE TABLE'):
    query = f"""
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = '{schema}' 
    AND table_catalog = '{database}' 
    AND table_type = '{object_type}'
    """
    df = run_sql_return_df(con, query)
    return df['table_name'].tolist()

def list_duckdb_tables(con, schema, database):
    return list_duckdb_objects(con, schema, database, 'BASE TABLE')

def list_duckdb_views(con, schema, database):
    return list_duckdb_objects(con, schema, database, 'VIEW')

def get_default_duckdb_database_and_schema(con):
    catalog_query = "SELECT CURRENT_CATALOG()"
    schema_query = "SELECT CURRENT_SCHEMA()"
    
    catalog_df = run_sql_return_df(con, catalog_query)
    schema_df = run_sql_return_df(con, schema_query)
    
    if catalog_df.empty or schema_df.empty:
        return None, None
    
    default_catalog = catalog_df.iloc[0, 0]
    default_schema = schema_df.iloc[0, 0]
    
    return default_catalog, default_schema

def list_snowflake_databases(con):
    df = run_sql_return_df(con, "SHOW DATABASES")
    return df['name'].tolist()


def list_snowflake_schemas(con, database_name):
    query = f'SHOW SCHEMAS IN DATABASE "{database_name}"'
    df = run_sql_return_df(con, query)
    return df['name'].tolist()

def list_snowflake_tables(con, database_name, schema):
    query = f'SHOW TABLES IN "{database_name}"."{schema}"'
    df = run_sql_return_df(con, query)
    return df['name'].tolist()

def list_snowflake_views(con, database_name, schema):
    query = f'SHOW VIEWS IN "{database_name}"."{schema}"'
    df = run_sql_return_df(con, query)
    return df['name'].tolist()

def get_default_snowflake_database_and_schema(con):
    query = "SELECT CURRENT_DATABASE(), CURRENT_SCHEMA()"
    df = run_sql_return_df(con, query)
    
    if df.empty:
        return None, None
    
    default_database = df.iloc[0, 0]
    default_schema = df.iloc[0, 1]
    
    return default_database, default_schema

def list_sqlserver_databases(con):
    query = "SELECT name FROM sys.databases"
    df = run_sql_return_df(con, query)
    return df['name'].tolist()

def list_sqlserver_schemas(con, database):
    con.execute(f"USE {database}")
    query = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA"
    df = run_sql_return_df(con, query)
    return df['SCHEMA_NAME'].tolist()

def list_sqlserver_objects(con, schema, database, object_type='BASE TABLE'):
    con.execute(f"USE {database}")
    query = f"""
    SELECT TABLE_NAME 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = '{schema}' 
    AND TABLE_TYPE = '{object_type}'
    """
    df = run_sql_return_df(con, query)
    return df['TABLE_NAME'].tolist()

def list_sqlserver_tables(con, schema, database):
    return list_sqlserver_objects(con, schema, database, 'BASE TABLE')

def list_sqlserver_views(con, schema, database):
    return list_sqlserver_objects(con, schema, database, 'VIEW')

def get_default_sqlserver_database_and_schema(con):
    database_query = "SELECT DB_NAME()"
    schema_query = "SELECT SCHEMA_NAME()"
    
    database_df = run_sql_return_df(con, database_query)
    schema_df = run_sql_return_df(con, schema_query)
    
    if database_df.empty or schema_df.empty:
        return None, None
    
    default_database = database_df.iloc[0, 0]
    default_schema = schema_df.iloc[0, 0]
    
    return default_database, default_schema
    
def list_databases(con):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return list_duckdb_databases(con)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return list_snowflake_databases(con)
    elif isinstance(con, pyodbc.Connection):
        return list_sqlserver_databases(con)
    else:
        return []

def list_schemas(con, database):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return list_duckdb_schemas(con, database)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return list_snowflake_schemas(con, database)
    elif isinstance(con, pyodbc.Connection):
        return list_sqlserver_schemas(con, database)
    else:
        return []

def list_tables(con, schema, database):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return list_duckdb_tables(con, schema, database)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return list_snowflake_tables(con, database, schema)
    elif isinstance(con, pyodbc.Connection):
        return list_sqlserver_tables(con, schema, database)
    else:
        return []
        
def list_views(con, schema, database):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return list_duckdb_views(con, schema, database)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return list_snowflake_views(con, database, schema)
    elif isinstance(con, pyodbc.Connection):
        return list_sqlserver_views(con, schema, database)
    else:
        return []

def get_default_database_and_schema(con):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return get_default_duckdb_database_and_schema(con)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return get_default_snowflake_database_and_schema(con)
    elif isinstance(con, pyodbc.Connection):
        return get_default_sqlserver_database_and_schema(con)
    else:
        return None, None
        
def create_database(con, database_name):
    if isinstance(con, duckdb.DuckDBPyConnection):
        raise NotImplementedError("DuckDB does not support creating separate databases")
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        query = f'CREATE DATABASE IF NOT EXISTS "{database_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        query = f"IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'{database_name}') CREATE DATABASE [{database_name}]"
        run_sql_return_df(con, query)

def remove_database(con, database_name):
    if isinstance(con, duckdb.DuckDBPyConnection):
        raise NotImplementedError("DuckDB does not support removing separate databases")
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        query = f'DROP DATABASE IF EXISTS "{database_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        query = f"""
        IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'{database_name}')
        BEGIN
            ALTER DATABASE [{database_name}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
            DROP DATABASE [{database_name}];
        END
        """
        run_sql_return_df(con, query)

def create_schema(con, schema_name, database_name=None):
    if isinstance(con, duckdb.DuckDBPyConnection):
        query = f'CREATE SCHEMA IF NOT EXISTS "{schema_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        if database_name:
            query = f'CREATE SCHEMA IF NOT EXISTS "{database_name}"."{schema_name}"'
        else:
            query = f'CREATE SCHEMA IF NOT EXISTS "{schema_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        if database_name:
            query = f"USE {database_name}; IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = '{schema_name}') EXEC('CREATE SCHEMA {schema_name}')"
        else:
            query = f"IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = '{schema_name}') EXEC('CREATE SCHEMA {schema_name}')"
        run_sql_return_df(con, query, transpile=False)

def remove_schema(con, schema_name, database_name=None):
    if isinstance(con, duckdb.DuckDBPyConnection):
        query = f'DROP SCHEMA IF EXISTS "{schema_name}" CASCADE'
        run_sql_return_df(con, query)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        if database_name:
            query = f'DROP SCHEMA IF EXISTS "{database_name}"."{schema_name}"'
        else:
            query = f'DROP SCHEMA IF EXISTS "{schema_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        if database_name:
            query = f"USE [{database_name}]; IF EXISTS (SELECT * FROM sys.schemas WHERE name = '{schema_name}') DROP SCHEMA [{schema_name}]"
        else:
            query = f"IF EXISTS (SELECT * FROM sys.schemas WHERE name = '{schema_name}') DROP SCHEMA [{schema_name}]"
        run_sql_return_df(con, query)

def remove_table(con, table_name, schema_name=None, database_name=None):
    if isinstance(con, duckdb.DuckDBPyConnection):
        if schema_name:
            query = f'DROP TABLE IF EXISTS "{schema_name}"."{table_name}"'
        else:
            query = f'DROP TABLE IF EXISTS "{table_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        if database_name and schema_name:
            query = f'DROP TABLE IF EXISTS "{database_name}"."{schema_name}"."{table_name}"'
        elif schema_name:
            query = f'DROP TABLE IF EXISTS "{schema_name}"."{table_name}"'
        else:
            query = f'DROP TABLE IF EXISTS "{table_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        if database_name and schema_name:
            query = f"USE [{database_name}]; IF OBJECT_ID('{schema_name}.{table_name}', 'U') IS NOT NULL DROP TABLE [{schema_name}].[{table_name}]"
        elif schema_name:
            query = f"IF OBJECT_ID('{schema_name}.{table_name}', 'U') IS NOT NULL DROP TABLE [{schema_name}].[{table_name}]"
        else:
            query = f"IF OBJECT_ID('{table_name}', 'U') IS NOT NULL DROP TABLE [{table_name}]"
        run_sql_return_df(con, query, transpile=False)

def remove_view(con, view_name, schema_name=None, database_name=None):
    if isinstance(con, duckdb.DuckDBPyConnection):
        if schema_name:
            query = f'DROP VIEW IF EXISTS "{schema_name}"."{view_name}"'
        else:
            query = f'DROP VIEW IF EXISTS "{view_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        if database_name and schema_name:
            query = f'DROP VIEW IF EXISTS "{database_name}"."{schema_name}"."{view_name}"'
        elif schema_name:
            query = f'DROP VIEW IF EXISTS "{schema_name}"."{view_name}"'
        else:
            query = f'DROP VIEW IF EXISTS "{view_name}"'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        if database_name and schema_name:
            query = f"USE [{database_name}]; IF OBJECT_ID('{schema_name}.{view_name}', 'V') IS NOT NULL DROP VIEW [{schema_name}].[{view_name}]"
        elif schema_name:
            query = f"IF OBJECT_ID('{schema_name}.{view_name}', 'V') IS NOT NULL DROP VIEW [{schema_name}].[{view_name}]"
        else:
            query = f"IF OBJECT_ID('{view_name}', 'V') IS NOT NULL DROP VIEW [{view_name}]"
        run_sql_return_df(con, query, transpile=False)


def create_table(con, table_name, columns, schema_name=None, database_name=None):
    if isinstance(con, duckdb.DuckDBPyConnection):
        columns_str = ", ".join([f"{col['name']} {col['type']}" for col in columns])
        query = f'CREATE TABLE IF NOT EXISTS {schema_name+"." if schema_name else ""}{table_name} ({columns_str})'
        run_sql_return_df(con, query)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        columns_str = ", ".join([f'"{col["name"]}" {col["type"]}' for col in columns])
        full_name = ''
        if database_name:
            full_name += f'"{database_name}".'
        if schema_name:
            full_name += f'"{schema_name}".'
        full_name += f'"{table_name}"'
        query = f'CREATE TABLE IF NOT EXISTS {full_name} ({columns_str})'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        columns_str = ", ".join([f"[{col['name']}] {col['type']}" for col in columns])
        full_name = f"{database_name+'.' if database_name else ''}{schema_name+'.' if schema_name else ''}{table_name}"
        query = f"IF OBJECT_ID('{full_name}', 'U') IS NULL CREATE TABLE {full_name} ({columns_str})"
        run_sql_return_df(con, query, transpile=False)


def create_view(con, view_name, select_statement, schema_name=None, database_name=None):
    if isinstance(con, duckdb.DuckDBPyConnection):
        query = f'CREATE OR REPLACE VIEW {schema_name+"." if schema_name else ""}{view_name} AS {select_statement}'
        run_sql_return_df(con, query)
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        full_name = ''
        if database_name:
            full_name += f'"{database_name}".'
        if schema_name:
            full_name += f'"{schema_name}".'
        full_name += f'"{view_name}"'
        query = f'CREATE OR REPLACE VIEW {full_name} AS {select_statement}'
        run_sql_return_df(con, query)
    elif isinstance(con, pyodbc.Connection):
        full_name = f"{schema_name+'.' if schema_name else ''}{view_name}"
        
        use_stmt = f"USE {database_name};" if database_name else ""
        
        create_stmt = f"CREATE VIEW {full_name} AS {select_statement}"
        
        query = f"""
        {use_stmt}
        GO
        {create_stmt}
        """
        with con.cursor() as cursor:
            if use_stmt:
                cursor.execute(use_stmt)
            
            cursor.execute(create_stmt)
        
        con.commit()



def create_schema_and_objects(con, database_name, schema_name):
    try:
        schemas = list_schemas(con, database_name)
        schema_exists = schema_name in schemas
    except Exception as e:
        error_message = f"Failed to list schemas in database {database_name}. Error: {str(e)}"
        return f"<div style='color: red;'>{error_message}<br>⚠️ Do you have <code>USAGE</code> privilege on this database?</div>"

    if not schema_exists:
        try:
            create_schema(con, schema_name, database_name)
        except Exception as e:
            error_message = f"Failed to create schema {schema_name}. Error: {str(e)}"
            return f"<div style='color: red;'>{error_message}<br>⚠️ Do you have <code>CREATE SCHEMA</code> privilege in this database?</div>"

    try:
        remove_table(con, table_name="cocoon_test_new_table", schema_name=schema_name, database_name=database_name)
        columns = [
            {"name": "dummy_column", "type": "INTEGER"}
        ]
        create_table(con, "cocoon_test_new_table", columns, schema_name=schema_name, database_name=database_name)
        
    except Exception as e:
        error_message = f"Failed to create or replace table cocoon_test_new_table. Error: {str(e)}"
        return f"<div style='color: red;'>{error_message}<br>⚠️ Do you have <code>CREATE TABLE</code> privilege in this schema?</div>"


    try:
        remove_view(con, view_name="cocoon_test_new_view", schema_name=schema_name, database_name=database_name)
        view_query = "SELECT 1 AS test"
        create_view(con, "cocoon_test_new_view", view_query, schema_name=schema_name, database_name=database_name)
    except Exception as e:
        error_message = f"Failed to create or replace view cocoon_test_new_view. Error: {str(e)}"
        return f"<div style='color: red;'>{error_message}<br>⚠️ Do you have <code>CREATE VIEW</code> privilege in this schema?</div>"

    return "<div style='color: green;'>🎉 Cocoon have the right access to this schema!</div>"


def get_sql_type(dtype):
    if pd.api.types.is_integer_dtype(dtype):
        return 'BIGINT'
    elif pd.api.types.is_float_dtype(dtype):
        return 'FLOAT'
    elif pd.api.types.is_datetime64_any_dtype(dtype):
        return 'DATETIME'
    else:
        return 'NVARCHAR(MAX)'

def create_table_from_df_sql_server(con, table_name, df):
    cursor = con.cursor()
    columns = []
    for column, dtype in df.dtypes.items():
        sql_type = get_sql_type(dtype)
        columns.append(f"[{column}] {sql_type}")
    
    create_table_sql = f"CREATE TABLE {table_name} ({', '.join(columns)})"
    cursor.execute(create_table_sql)
    con.commit()


    
def insert_df_to_table(con, table_name, df):
    cursor = con.cursor()
    for _, row in df.iterrows():
        placeholders = ', '.join(['?' for _ in row])


        row = row.where(pd.notnull(row), None)
        placeholders = ', '.join(['?' for _ in row])
        insert_sql = f"INSERT INTO {table_name} VALUES ({placeholders})"
        cursor.execute(insert_sql, tuple(row))
    con.commit()

def create_table_from_df(df: pd.DataFrame, con, table_name: str, database: str = None, schema: str = None):

    if isinstance(con, duckdb.DuckDBPyConnection):
        if schema and database:
            full_table_name = f'{enclose_table_name(database)}.{enclose_table_name(schema)}.{enclose_table_name(table_name)}'
        else:
            full_table_name = enclose_table_name(table_name)
        con.execute(f"CREATE OR REPLACE TABLE {full_table_name} AS SELECT * FROM df")
    
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        write_pandas(con, df, table_name, auto_create_table=True, overwrite=True, database=database, schema=schema)
    
    elif isinstance(con, pyodbc.Connection):

        remove_table(con, table_name, schema_name=schema, database_name=database)

        
        

        full_table_name = ""
        if database:
            full_table_name += enclose_table_name(database) + "."
        if schema:
            full_table_name += enclose_table_name(schema) + "."
        full_table_name += enclose_table_name(table_name)
        

        create_table_from_df_sql_server(con, full_table_name, df)
        
        insert_df_to_table(con, full_table_name, df)

    else:
        raise ValueError("Unsupported connection type. Use either DuckDB or Snowflake connection.")
    

def sample_query(con, query, sample_size):
    sampled_query = f"SELECT * FROM ({query})  AS subquery LIMIT {sample_size}"
    return sampled_query


def format_value(value):
    if pd.isna(value):
        return 'NULL'
    elif isinstance(value, (int, float)):
        return str(value)
    else:
        return f"""N'{value.replace("'", "''")}'"""