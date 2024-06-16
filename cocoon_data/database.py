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


def get_database_name(con):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return "DuckDB"
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        return "Snowflake"
    else:
        return "Unknown"
    
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
        
    else:
        return {}
def get_table_schema(conn, table_name):
    if isinstance(conn, duckdb.DuckDBPyConnection):
        query = f'''
        SELECT "column_name", "data_type"
        FROM "information_schema"."columns"
        WHERE "table_name" = '{table_name}'
        ORDER BY "ordinal_position";
        '''
        
        result = conn.execute(query).fetchall()
        
        schema = {}
        for row in result:
            schema[row[0]] = row[1]
        
        return schema

    elif isinstance(conn, snowflake.connector.connection.SnowflakeConnection):
        query = f'SHOW COLUMNS IN TABLE "{table_name}"'

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

    else:
        return []
    


def generate_count_distinct_query(table_name, attributes):
    select_clauses = []
    
    for attribute in attributes:
        select_clause = f'COUNT(DISTINCT "{attribute}")/COUNT(*) AS "{attribute}"'
        select_clauses.append(select_clause)
    
    query = f'SELECT {", ".join(select_clauses)} \nFROM "{table_name}"'
    
    return query




def generate_group_ratio_query(table_name, group_by, attributes):
    subquery_select_clauses = []
    main_select_clauses = []

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
        FROM "{table_name}"
        GROUP BY "{group_by}"
        HAVING "COCOON_COUNT" > 5
    ) AS subquery;
    """

    return query



def generate_queries_for_overlap(table1, attributes1, table2, attributes2, con):
    select_clause1 = ", ".join(f"\"{table1}\".\"{attr}\"" for attr in attributes1)
    select_clause2 = ", ".join(f"\"{table2}\".\"{attr}\"" for attr in attributes2)

    query1 = f"""
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT {select_clause1}
            FROM "{table1}"
            LEFT JOIN (
                SELECT DISTINCT {select_clause2}
                FROM "{table2}"
                WHERE {' OR '.join(f'"{table2}"."{attr2}" IS NOT NULL' for attr2 in attributes2)}
            ) T2 ON {' AND '.join(f'"{table1}"."{attr1}" = T2."{attr2}"' for attr1, attr2 in zip(attributes1, attributes2))}
            WHERE {' AND '.join(f'T2."{attr2}" IS NULL' for attr2 in attributes2)}
                AND {' OR '.join(f'"{table1}"."{attr1}" IS NOT NULL' for attr1 in attributes1)}
        )
    """
    only1 = run_sql_return_df(con, query1).iloc[0, 0]

    query2 = f"""
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT {select_clause2}
            FROM "{table2}"
            LEFT JOIN (
                SELECT DISTINCT {select_clause1}
                FROM "{table1}"
                WHERE {' OR '.join(f'"{table1}"."{attr1}" IS NOT NULL' for attr1 in attributes1)}
            ) T1 ON {' AND '.join(f'"{table2}"."{attr2}" = T1."{attr1}"' for attr1, attr2 in zip(attributes1, attributes2))}
            WHERE {' AND '.join(f'T1."{attr1}" IS NULL' for attr1 in attributes1)}
                AND {' OR '.join(f'"{table2}"."{attr2}" IS NOT NULL' for attr2 in attributes2)}
        )
    """
    only2 = run_sql_return_df(con, query2).iloc[0, 0]

    query3 = f"""
        SELECT COUNT(*)
        FROM (
            SELECT DISTINCT {select_clause1}
            FROM "{table1}"
            INNER JOIN (
                SELECT DISTINCT {select_clause2}
                FROM "{table2}"
                WHERE {' OR '.join(f'"{table2}"."{attr2}" IS NOT NULL' for attr2 in attributes2)}
            ) T3 ON {' AND '.join(f'"{table1}"."{attr1}" = T3."{attr2}"' for attr1, attr2 in zip(attributes1, attributes2))}
            WHERE {' OR '.join(f'"{table1}"."{attr1}" IS NOT NULL' for attr1 in attributes1)}
        )
    """
    overlap = run_sql_return_df(con, query3).iloc[0, 0]

    return int(only1), int(only2), int(overlap)



def create_sample_distinct_query(table_name, column_name, sample_size=None):
    query =  f'SELECT "{column_name}" \nFROM "{table_name}" \nWHERE "{column_name}" IS NOT NULL \nGROUP BY "{column_name}" \nORDER BY COUNT(*) DESC, "{column_name}"\n'
    if sample_size is not None:
        query += f" LIMIT {sample_size}"
    return query

def create_sample_distinct(con, table_name, column_name, sample_size):

    query = create_sample_distinct_query(table_name, column_name, sample_size)
    sample_values = run_sql_return_df(con,query)

    return sample_values

def create_sample_distinct_query_regex(con, table_name, column_name, sample_size=None, regex_except_list=None, regex_list=None):
    if regex_list is None:
        regex_list = []
        
    if regex_except_list is None:
        regex_except_list = []
        
    query =  f'SELECT "{column_name}" \nFROM "{table_name}" \nWHERE "{column_name}" IS NOT NULL \n'
    
    for regex in regex_list:
        regex_match_clause = create_regex_match_clause(con, column_name, regex)
        query += f"AND {regex_match_clause} \n"
    
    for regex in regex_except_list:
        regex_match_clause = create_regex_match_clause(con, column_name, regex)
        query += f"AND NOT {regex_match_clause} \n"
    
    query += f'GROUP BY "{column_name}" \nORDER BY COUNT(*) DESC, "{column_name}"\n'
    
    if sample_size is not None:
        query += f" LIMIT {sample_size}"
    
    sample_values = run_sql_return_df(con, query)
    return sample_values

def create_regex_match_clause(con, column_name, regex):
    if isinstance(con, duckdb.DuckDBPyConnection):
        return f'regexp_full_match("{column_name}", \'{regex}\')'
    elif isinstance(con, snowflake.connector.connection.SnowflakeConnection):
        regex = regex.replace('\\', '\\\\')
        return f'REGEXP_LIKE("{column_name}", \'{regex}\')'
    else:
        raise ValueError(f"Connection type {type(con)} not supported")

def find_duplicate_rows(con, table_name, sample_size=0):
    sql_query = f'''
SELECT *, COUNT(*) as cocoon_count
FROM "{table_name}"
GROUP BY ALL
HAVING COUNT(*) > 1'''
    duplicate_count_sql = f'SELECT COUNT(*) from ({sql_query});'
    duplicate_count = run_sql_return_df(con, duplicate_count_sql).iloc[0, 0]

    sample_sql = sql_query
    if sample_size > 0:
        sample_sql += f" LIMIT {sample_size}"

    sample_duplicate_rows = run_sql_return_df(con, sample_sql)
    return duplicate_count, sample_duplicate_rows

def where_clause_for_space(column_name):
    return f'"{column_name}" <> TRIM("{column_name}")'


def count_total_distinct(con, table_name, column_name):
    total_distinct_count = run_sql_return_df(con,f'SELECT COUNT(DISTINCT "{column_name}") FROM "{table_name}" WHERE "{column_name}" IS NOT NULL').iloc[0, 0]
    return total_distinct_count

def compute_unique_ratio(con, table_name, column_name, allow_null=False):
    if not allow_null:
        query = f"""
        SELECT COUNT(DISTINCT "{column_name}") AS DISTINCT_COUNT,
               COUNT(*) AS TOTAL_COUNT
        FROM "{table_name}"
        """
    else:
        query = f"""
        SELECT COUNT(DISTINCT "{column_name}") AS DISTINCT_COUNT,
               COUNT("{column_name}") AS NON_NULL_COUNT
        FROM "{table_name}"
        """

    result = run_sql_return_df(con, query)
    distinct_count = result.iloc[0]['DISTINCT_COUNT']
    
    total_count = result.iloc[0]['TOTAL_COUNT'] if not allow_null else result.iloc[0]['NON_NULL_COUNT']
    return distinct_count, total_count