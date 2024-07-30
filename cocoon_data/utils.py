import sys
import traceback
import re
from jinja2 import Template
import ast

def get_detailed_error_info():

    exc_type, exc_value, exc_traceback = sys.exc_info()

    tb_list = traceback.format_exception(exc_type, exc_value, exc_traceback)
    
    tb_list = [line for tb in tb_list for line in tb.split('\n') if line]

    for i, line in enumerate(tb_list):
        if line.startswith("Original error"):
            tb_list = tb_list[i:]
            break
        
    for i, line in enumerate(tb_list):
        if "exec(" in line:
            tb_list = tb_list[i+1:]
            break
        if "con.execute(" in line:
            tb_list = tb_list[i+1:]
            break
        if "pandas.io.sql.DatabaseError:" in line:
            tb_list = tb_list[i:]
            break

    detailed_error_info = '\n'.join(tb_list)

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


def unescape_regex(string):
    characters = [
        "d", "t", "b", "r", "f", "D", "w", "W", "s", "S", "B", ".",
        "(", ")", "[", "]", "{", "}", "|", "?", "*", "+", "^", "$"
    ]
    
    for char in characters:
        escaped_char = "\\\\" + char
        if escaped_char in string:
            string = string.replace(escaped_char, "\\" + char)
    
    return string


def write_log(message: str):
    log_file = open('error_log.txt', 'a')
    log_file.write(message + '\n')
    log_file.close()
    
def sql_cleaner(sql):
    sql = sql.replace('`', '"')
    return sql

def sanitize_table_name(table_name):
    return re.sub(r'[^a-zA-Z0-9_]', '_', table_name)

def remove_newline(string):
    return re.sub(r'[\r\n\v\f\x1c-\x1e\x85\u2028\u2029]', '', string)

def clean_table_name(table_name):
    if not table_name[0].isalpha() and table_name[0] != "_":
        table_name = "_" + table_name

    return sanitize_table_name(table_name)

def clean_column_name(column_name):
    reserved_words = {
        "ABSOLUTE", "ACTION", "ADA", "ADD", "ALL", "ALLOCATE", "ALTER", "AND", "ANY", "ARE", "AS", "ASC",
        "ASSERTION", "AT", "AUTHORIZATION", "AVG", "BACKUP", "BEGIN", "BETWEEN", "BIT", "BIT_LENGTH", "BOTH",
        "BREAK", "BROWSE", "BULK", "BY", "CASCADE", "CASCADED", "CASE", "CAST", "CATALOG", "CHAR", "CHAR_LENGTH",
        "CHARACTER", "CHARACTER_LENGTH", "CHECK", "CHECKPOINT", "CLOSE", "CLUSTERED", "COALESCE", "COLLATE",
        "COLLATION", "COLUMN", "COMMIT", "COMPUTE", "CONNECT", "CONNECTION", "CONSTRAINT", "CONSTRAINTS",
        "CONTAINS", "CONTAINSTABLE", "CONTINUE", "CONVERT", "CORRESPONDING", "COUNT", "CREATE", "CROSS",
        "CURRENT", "CURRENT_DATE", "CURRENT_TIME", "CURRENT_TIMESTAMP", "CURRENT_USER", "CURSOR", "DATABASE",
        "DATE", "DAY", "DBCC", "DEALLOCATE", "DEC", "DECIMAL", "DECLARE", "DEFAULT", "DEFERRABLE", "DEFERRED",
        "DELETE", "DENY", "DESC", "DESCRIBE", "DESCRIPTOR", "DIAGNOSTICS", "DISCONNECT", "DISK", "DISTINCT",
        "DISTINCTROW", "DISTRIBUTED", "DOMAIN", "DOUBLE", "DROP", "DUMP", "ELSE", "END", "END-EXEC", "ERRLVL",
        "ESCAPE", "EXCEPT", "EXCEPTION", "EXEC", "EXECUTE", "EXISTS", "EXIT", "EXTERNAL", "EXTRACT", "FALSE",
        "FETCH", "FILE", "FILLFACTOR", "FIRST", "FLOAT", "FOR", "FOREIGN", "FORTRAN", "FOUND", "FREETEXT",
        "FREETEXTTABLE", "FROM", "FULL", "FUNCTION", "GENERAL", "GET", "GLOBAL", "GO", "GOTO", "GRANT", "GROUP",
        "HAVING", "HOLDLOCK", "HOUR", "IDENTITY", "IDENTITY_INSERT", "IDENTITYCOL", "IF", "IMMEDIATE", "IN",
        "INCLUDE", "INDEX", "INDICATOR", "INITIALLY", "INNER", "INPUT", "INSENSITIVE", "INSERT", "INT",
        "INTEGER", "INTERSECT", "INTERVAL", "INTO", "IS", "ISOLATION", "JOIN", "KEY", "KILL", "LANGUAGE",
        "LAST", "LEADING", "LEFT", "LEVEL", "LIKE", "LIMIT", "LINENO", "LOAD", "LOCAL", "LOWER", "MATCH",
        "MAX", "MIN", "MINUTE", "MIRROREXIT", "MODIFIES", "MODULE", "MONTH", "NAMES", "NATIONAL", "NATURAL",
        "NCHAR", "NEXT", "NO", "NOCHECK", "NONCLUSTERED", "NONE", "NOT", "NULL", "NULLIF", "NUMERIC", "OCTET_LENGTH",
        "OF", "OFF", "OFFSETS", "ON", "ONLY", "OPEN", "OPENDATASOURCE", "OPENQUERY", "OPENROWSET", "OPENXML",
        "OPTION", "OR", "ORDER", "OUTER", "OUTPUT", "OVER", "OVERLAPS", "PAD", "PARTIAL", "PASCAL", "PERCENT",
        "PIVOT", "PLAN", "POSITION", "PRECISION", "PREPARE", "PRESERVE", "PRIMARY", "PRINT", "PRIOR", "PRIVILEGES",
        "PROC", "PROCEDURE", "PUBLIC", "RAISERROR", "READ", "READTEXT", "REAL", "RECONFIGURE", "REFERENCES",
        "RELATIVE", "REPLICATION", "RESTORE", "RESTRICT", "RETURN", "REVOKE", "RIGHT", "ROLLBACK", "ROWCOUNT",
        "ROWGUIDCOL", "ROWS", "RULE", "SAVE", "SCHEMA", "SCROLL", "SECOND", "SECTION", "SELECT", "SEQUENCE",
        "SESSION", "SESSION_USER", "SET", "SETUSER", "SIZE", "SMALLINT", "SOME", "SPACE", "SQL", "SQLCA", "SQLCODE",
        "SQLERROR", "SQLSTATE", "SQLWARNING", "STATISTICS", "SYSTEM_USER", "TABLE", "TEMPORARY", "THEN", "TIME",
        "TIMESTAMP", "TIMEZONE_HOUR", "TIMEZONE_MINUTE", "TO", "TOP", "TRAILING", "TRAN", "TRANSACTION", "TRANSLATE",
        "TRANSLATION", "TRIGGER", "TRIM", "TRUE", "TRUNCATE", "TSEQUAL", "UNION", "UNIQUE", "UNKNOWN", "UNNEST",
        "UPDATE", "UPDATETEXT", "UPPER", "USAGE", "USE", "USER", "USING", "VALUE", "VALUES", "VARCHAR", "VARIABLE",
        "VARYING", "VIEW", "WAITFOR", "WHEN", "WHENEVER", "WHERE", "WHILE", "WITH", "WORK", "WRITE", "WRITETEXT",
        "YEAR", "ZONE"
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
        
def evaluate_jinja(template_string):
    
    template = Template(template_string)

    rendered_template = template.render()
    rendered_template = escape_single_quotes(rendered_template)
    result = ast.literal_eval(rendered_template)

    return result



def escape_single_quotes(input_string):
    input_string = input_string.strip("[\n]")
    
    items = re.split(r",\s*\n?", input_string)
    
    escaped_items = []
    for item in items:
        item = item.strip("' ")
        
        escaped_item = item.replace("'", "\\'")
        
        escaped_items.append(f"'{escaped_item}'")
    
    output_string = "[" + ", ".join(escaped_items) + "]"
    
    return output_string




def clean_summary(summary):
    summary = summary.strip()
    summary = summary.strip("'")
    return summary

def indent_paragraph(paragraph, spaces=4):
    indent = ' ' * spaces
    return '\n'.join(indent + line for line in paragraph.split('\n'))
