import sys
import traceback
import re

def get_detailed_error_info():
    """
    Retrieve detailed information about the most recent exception caught by an except clause.
    Specifically, it fetches the exact line and explanation of the error within the exec block.
    """
    exc_type, exc_value, exc_traceback = sys.exc_info()

    tb_list = traceback.format_exception(exc_type, exc_value, exc_traceback)

    for i, line in enumerate(tb_list):
        if "exec(" in line:
            tb_list = tb_list[i+1:]
            break
        if "con.execute(" in line:
            tb_list = tb_list[i+1:]
            break

    detailed_error_info = ''.join(tb_list)

    return detailed_error_info

def replace_newline(input_string):
    parts = input_string.split('"')

    for i in range(len(parts)):
        if i % 2 == 1:
            parts[i] = parts[i].replace("\n", "\\n")
            characters = ["d", "t", "b", "r", "f", "D", "w", "W", "s", "S", "B", ".", "(", ")", "[", "]", "{", "}", "|", "?", "*", "+", "^", "$"]
            for character in characters:
                parts[i] = parts[i].replace(f"\\\\{character}", f"\\{character}").replace(f"\\{character}", f"\\\\{character}")

    modified_string = '"'.join(parts)

    return modified_string

def write_log(message: str):
    log_file = open('data_log.txt', 'a')
    log_file.write(message + '\n')
    log_file.close()
    
def sql_cleaner(sql):
    sql = sql.replace('`', '"')
    return sql

def sanitize_table_name(table_name):
    return re.sub(r'[^a-zA-Z0-9_]', '_', table_name)

def clean_table_name(table_name):
    if not table_name[0].isalpha() and table_name[0] != "_":
        table_name = "_" + table_name

    return sanitize_table_name(table_name)

def clean_column_name(column_name):
    reserved_words = {
        "ADD", "ALL", "ALTER", "AND", "ANY", "AS", "ASC", "AUTHORIZATION", "BACKUP",
        "BEGIN", "BETWEEN", "BREAK", "BROWSE", "BULK", "BY", "CASCADE", "CASE",
        "CHECK", "CHECKPOINT", "CLOSE", "CLUSTERED", "COALESCE", "COLLATE",
        "COLUMN", "COMMIT", "COMPUTE", "CONSTRAINT", "CONTAINS", "CONTINUE",
        "CONVERT", "CREATE", "CROSS", "CURRENT", "CURRENT_DATE", "CURRENT_TIME",
        "CURRENT_TIMESTAMP", "CURRENT_USER", "CURSOR", "DATABASE", "DBCC",
        "DEALLOCATE", "DECLARE", "DEFAULT", "DELETE", "DENY", "DESC", "DISK",
        "DISTINCT", "DISTRIBUTED", "DOUBLE", "DROP", "DUMP", "ELSE", "END", "ERRLVL",
        "ESCAPE", "EXCEPT", "EXEC", "EXECUTE", "EXISTS", "EXIT", "EXTERNAL", "FETCH",
        "FILE", "FILLFACTOR", "FOR", "FOREIGN", "FREETEXT", "FROM", "FULL", "FUNCTION",
        "GOTO", "GRANT", "GROUP", "HAVING", "HOLDLOCK", "IDENTITY", "IDENTITY_INSERT",
        "IDENTITYCOL", "IF", "IN", "INDEX", "INNER", "INSERT", "INTERSECT", "INTO",
        "IS", "JOIN", "KEY", "KILL", "LEFT", "LIKE", "LINENO", "LOAD", "MERGE", "NATIONAL",
        "NOCHECK", "NONCLUSTERED", "NOT", "NULL", "NULLIF", "OF", "OFF", "OFFSETS", "ON",
        "OPEN", "OPENDATASOURCE", "OPENQUERY", "OPENROWSET", "OPENXML", "OPTION", "OR",
        "ORDER", "OUTER", "OVER", "PERCENT", "PIVOT", "PLAN", "PRECISION", "PRIMARY",
        "PRINT", "PROC", "PROCEDURE", "PUBLIC", "RAISERROR", "READ", "READTEXT", "RECONFIGURE",
        "REFERENCES", "REPLICATION", "RESTORE", "RESTRICT", "RETURN", "REVERT", "REVOKE",
        "RIGHT", "ROLLBACK", "ROWCOUNT", "ROWGUIDCOL", "RULE", "SAVE", "SCHEMA", "SECURITYAUDIT",
        "SELECT", "SEMANTICKEYPHRASETABLE", "SEMANTICSIMILARITYDETAILSTABLE", "SEMANTICSIMILARITYTABLE",
        "SESSION_USER", "SET", "SETUSER", "SHUTDOWN", "SOME", "STATISTICS", "SYSTEM_USER", "TABLE",
        "TABLESAMPLE", "TEXTSIZE", "THEN", "TO", "TOP", "TRAN", "TRANSACTION", "TRIGGER", "TRUNCATE",
        "TRY_CONVERT", "TSEQUAL", "UNION", "UNIQUE", "UNPIVOT", "UPDATE", "UPDATETEXT", "USE",
        "USER", "VALUES", "VARYING", "VIEW", "WAITFOR", "WHEN", "WHERE", "WHILE", "WITH", "WITHIN GROUP",
        "WRITETEXT"
    }
    
    if column_name.upper() in reserved_words:
        column_name += "_"
    
    return clean_table_name(column_name)

def robust_create_to_replace(input_sql):
    pattern = re.compile(r'create\s+table', re.IGNORECASE)
    
    return pattern.sub('CREATE OR REPLACE TABLE', input_sql)


def print_history(history):
    for chat in history:
        print(chat['content'])
        print("---------------------")