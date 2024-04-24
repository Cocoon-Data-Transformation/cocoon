import sys
import traceback

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