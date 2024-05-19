import os
import io
import pandas as pd
import json
import re
import uuid
import numpy as np
import networkx as nx
import matplotlib.patches as patches
from ipywidgets import *
import ipywidgets as widgets
from IPython.display import *
from graphviz import Digraph
from pygments import highlight
from pygments.lexers import PythonLexer, SqlLexer, YamlLexer
from pygments.formatters import Terminal256Formatter, HtmlFormatter
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import seaborn as sns
import plotly.graph_objects as go
import ast
import faiss
from tqdm import tqdm
import base64
from io import BytesIO
import heapq
import chardet
import datetime
from functools import partial
from contextlib import contextmanager
import yaml
import rasterio
from rasterio.warp import calculate_default_transform, reproject, Resampling
from datasketch import MinHash, MinHashLSH
from bs4 import BeautifulSoup

from .database import *
from .llm import *
from .utils import *
from .extract import *
from .viz import *
from .constant import *
from .data_type import *
from .widgets import *


try:
    import openpyxl
    import xlrd
    from pyproj import Transformer, CRS
    from rasterio.windows import from_bounds
    from rasterio.features import rasterize
    from rasterio.transform import from_origin, Affine
    from rasterio.enums import Resampling as ResamplingMethods
    import geopandas as gpd
    from shapely.geometry import Polygon
    from shapely.ops import transform
    from rasterio.transform import array_bounds
    import scipy
except:
    pass


icon_import = False
MAX_TRIALS = 3
LOG_MESSAGE_HISTORY = False

cocoon_comment_start = "-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK IF YOU WANT TO LET COCOON MAINTAIN THE CODES\n"
cocoon_comment_end = "-- COCOON BLOCK END\n"

def yml_from_name(table_name):

    yaml_dict = {
        "version": 2,
        "models": [{
            "name": table_name
        }]
    }

    return yaml_dict


class QueryWidget:
    def __init__(self, con):
        self.con = con
        self.label = widgets.Label(value='Enter your SQL query:')
        self.sql_input = widgets.Textarea(value='SELECT * FROM my_table\n\n\n\n', 
                                          placeholder='Type something', 
                                          description='', 
                                          disabled=False, 
                                          layout={'width': '100%', 'height': '100px'})
        self.error_msg = widgets.HTML(value='')
        self.result_display = widgets.HTML()
        self.submit_button = widgets.Button(description="Submit Query", button_style='success')
        self.vbox = widgets.VBox([self.label, self.sql_input, self.submit_button, self.error_msg, self.result_display])
        
        self.submit_button.on_click(self.run_query_from_button)
    
    def run_query(self, sql_query):
        sample_size = 100
        self.sql_input.value = sql_query
        modified_query = f"SELECT * FROM ({sql_query}) LIMIT {sample_size}"
        try:
            result = run_sql_return_df(self.con, modified_query)
            self.error_msg.value = f'The query was successful. We only show the first {sample_size} rows.'
            self.result_display.value = wrap_in_scrollable_div(result.to_html(), height="400px")
        except Exception as e:
            self.error_msg.value = f"<div style='color: red;'>{str(e)}</div>"
            self.result_display.value = ''
    
    def run_query_from_button(self, b):
        self.run_query(self.sql_input.value)
    
    def display(self):
        display(self.vbox)


        


def create_data_type_grid(df, all_data_types = None):
    
    if all_data_types is None:
        type_domain = list(data_types.keys())
    else:
        type_domain = all_data_types

    def update_match_status(change, match_status_label, current_type):
        match_status_label.value = "✔️ Yes" if change['new'] == current_type else "❌ No"

    grid = widgets.GridspecLayout(len(df) + 1, 4)

    grid[0, 0] = widgets.Label('Column')
    grid[0, 1] = widgets.Label('Current Type')
    grid[0, 2] = widgets.Label('Target Type')
    grid[0, 3] = widgets.Label('Matched?')

    for i, row in df.iterrows():
        column_name_label = widgets.Label(row['column_name'])
        current_type_label = widgets.Label(row['current_type'])
        target_type_dropdown = widgets.Dropdown(options=type_domain, value=row['target_type'], description='')
        match_status_label = widgets.Label(value="✔️ Yes" if row['current_type'] == row['target_type'] else "❌ No")

        target_type_dropdown.observe(
            lambda change, current_type=row['current_type'], match_status_label=match_status_label: update_match_status(change, match_status_label, current_type), 
            names='value'
        )
        grid[i + 1, 0] = column_name_label
        grid[i + 1, 1] = current_type_label
        grid[i + 1, 2] = target_type_dropdown
        grid[i + 1, 3] = match_status_label

    return grid

def extract_grid_data_type(grid):

    data = []
    for i in range(1, grid.n_rows):
        column_name = grid[i, 0].value
        current_type = grid[i, 1].value
        target_type = grid[i, 2].value  
        matched = grid[i, 3].value
        
        data.append([column_name, current_type, target_type, matched])
        
    df = pd.DataFrame(data, columns=["Column", "Current Type", "Target Type", "Matched?"])
    return df






def generate_draggable_graph_html_dynamically(graph_data):
    number_nodes = len(graph_data["nodes"])
    svg_width = min(800, 300 + 50 * number_nodes)
    svg_height = 100 + number_nodes * 30
    return svg_width, svg_height, generate_draggable_graph_html(graph_data, svg_height, svg_width)


def display_draggable_graph_html(graph_data):
    _, svg_height, html_content = generate_draggable_graph_html_dynamically(graph_data)
    display_html_iframe(html_content, width="100%", height=f"{svg_height+50}px")

def cluster_tables(tables, threshold=0.5, num_perm=128):

    lsh = MinHashLSH(threshold=threshold, num_perm=num_perm)

    minhashes = {}
    for table_name, attributes in tables.items():
        minhash = MinHash(num_perm=128)
        for attribute in attributes:
            minhash.update(attribute.encode('utf8'))
        lsh.insert(table_name, minhash)
        minhashes[table_name] = minhash

    clusters = []
    seen = set()

    for table_name, minhash in minhashes.items():
        if table_name in seen:
            continue
        
        similar_tables = lsh.query(minhash)
        
        new_cluster = {table for table in similar_tables if table not in seen}
        
        new_cluster.add(table_name)
        
        if new_cluster:
            clusters.append(new_cluster)
            seen.update(new_cluster)

            
    return clusters



def group_tables_exclude_single(tables):
    attribute_to_table = {}
    
    for table, attributes in tables.items():
        attributes_sorted = tuple(sorted(attributes))
        
        if attributes_sorted not in attribute_to_table:
            attribute_to_table[attributes_sorted] = [table]
        else:
            attribute_to_table[attributes_sorted].append(table)
    
    grouped_tables = [tables for tables in attribute_to_table.values() if len(tables) > 1]
    
    return grouped_tables



def replace_keys_and_values_with_index(nodes, edges):
    node_index = {node: index for index, node in enumerate(nodes)}
    updated_edges = {node_index[node]: [node_index[edge] for edge in edges[node]] for node in edges}
    return updated_edges






def create_html_content_project(title, descriptions, page_no):
    nodes = []
    edges = []
    edge_labels = []

    list_of_descriptions = "<ol>"

    for i in range(page_no):
        description, ers = descriptions[i]
        list_of_descriptions += f"<li>{description}</li>"

        for er in ers:
            node_1, edge, node2 = er

            if node_1 not in nodes:
                nodes.append(node_1)

            if node2 not in nodes:
                nodes.append(node2)

            node_1_idx = nodes.index(node_1)
            node_2_idx = nodes.index(node2)

            edges.append((node_1_idx, node_2_idx))
            edge_labels.append(edge)
    
    description, ers = descriptions[page_no]
    list_of_descriptions += f"<li><b>{description}</b></li>"
    list_of_descriptions += "</ol>"

    highlight_nodes_indices = []
    highlight_edges_indices = []

    for er in ers:
        node_1, edge, node2 = er

        if node_1 not in nodes:
            nodes.append(node_1)

        if node2 not in nodes:
            nodes.append(node2)

        node_1_idx = nodes.index(node_1)
        node_2_idx = nodes.index(node2)

        highlight_nodes_indices.append(node_1_idx)
        highlight_nodes_indices.append(node_2_idx)

        edges.append((node_1_idx, node_2_idx))
        edge_labels.append(edge)
        highlight_edges_indices.append(len(edges) - 1)


    html_content = f"""
    <h3>{title}</h3>
    {list_of_descriptions}
    {generate_workflow_html_multiple(nodes, edges, edge_labels, highlight_nodes_indices, highlight_edges_indices)}
    """
    return html_content

def generate_html_for_sanity_check(document):
    html_output = ""

    duplicate_rows = document.get("duplicate_rows", {})
    index_columns = document.get("index_columns", {})
    missing_columns = document.get("missing_columns", {})
    duplicate_columns = document.get("duplicate_columns", {})
    x_y_columns = document.get("x_y_columns", {})
    data_type = document.get("data_type", {})

    num_duplicated_rows = duplicate_rows.get("num_duplicated_rows", 0)
    if num_duplicated_rows > 0:
        html_output += "<h3>Duplicated Rows</h3>"
        html_output += f"There are <b>{num_duplicated_rows}</b> duplicated rows in the data.<br>"
        remove_duplicates = duplicate_rows.get("remove_duplicates", False)
        html_output += f"The duplicated rows <b>{'have' if remove_duplicates else 'have not'} been removed</b>.<br>"
        html_output += f"<hr>"

    index_column_names = index_columns.get("index_column_names", [])
    if index_column_names:
        html_output += "<h3>Index Columns</h3>"
        html_output += f"There are <b>{len(index_column_names)}</b> columns that look like indices: <i>{', '.join(index_column_names)}</i><br>"
        remove_index_columns = index_columns.get("remove_columns", [])
        html_output += f"{len(remove_index_columns)} index columns <b>{'have' if remove_index_columns else 'have not'} been removed</b>.<br>"
        html_output += f"<hr>"

    missing_column_names = missing_columns.get("missing_column_names", [])
    if missing_column_names:
        html_output += "<h3>Missing Columns</h3>"
        html_output += f"There are <b>{len(missing_column_names)}</b> columns whose values are all missing: <i>{', '.join(missing_column_names)}</i><br>"
        remove_missing_columns = missing_columns.get("remove_columns", [])
        html_output += f"{len(remove_missing_columns)} missing columns <b>{'have' if remove_missing_columns else 'have not'} been removed</b>.<br>"
        html_output += f"<hr>"

    duplicated_column_names = duplicate_columns.get("duplicated_column_names", [])
    if duplicated_column_names:
        html_output += "<h3>Duplicate Columns</h3>"
        html_output += f"There are <b>{len(duplicated_column_names)}</b> groups of columns that have the same names:<br>"
        html_output += "<ol>"
        for duplicate_column in duplicated_column_names:
            html_output += f"<li>{len(duplicate_column)} columns named <i>{duplicate_column[0]}</i><br></li>"
        html_output += "</ol>"
        remove_duplicate_columns = duplicate_columns.get("remove_columns", [])
        html_output += f"{len(remove_duplicate_columns)} duplicate columns <b>{'have' if remove_duplicate_columns else 'have not'} been removed</b>.<br>"
        html_output += f"<hr>"

    x_y_column_names = x_y_columns.get("x_y_column_names", [])
    if x_y_column_names:
        html_output += "<h3>X-Y Columns</h3>"
        html_output += f"There are <b>{len(x_y_column_names)}</b> pairs of columns that look like the result of a merge:<br>"
        html_output += "<ol>"
        for x_y_column in x_y_column_names:
            html_output += f"<li><i>{', '.join(x_y_column)}</i><br></li>"
        html_output += "</ol>"
        remove_x_y_columns = x_y_columns.get("remove_columns", [])
        html_output += f"{len(remove_x_y_columns)} x-y columns <b>{'have' if remove_x_y_columns else 'have not'} been removed</b>.<br>"
        html_output += f"<hr>"

    invalid_data_examples = {}
    for column_name, column_data in data_type.items():
        invalid_rows = column_data.get("invalid_rows", [])
        if invalid_rows:
            invalid_data_examples[column_name] = {"data_type": column_data.get("data_type", "unknown"),
                                                  "invalid_rows": invalid_rows}

    if invalid_data_examples:
        html_output += "<h3>Invalid Data Type</h3>"
        html_output += f"There are <b>{len(invalid_data_examples)}</b> columns contains values of invalid data type:<br>"
        html_output += "<ol>"
        for column_name, example_data in invalid_data_examples.items():
            html_output += f"<li> <i>{column_name}</i> is of type <i>{example_data['data_type']}</i><br>"
            html_output += f"        Examples of invalid data: <i>{example_data['invalid_rows']}</i><br></li>"
        html_output += "</ol>"
        html_output += f"Rows with invalid data <b>have been removed</b>."
        html_output += f"<hr>"
    
    return html_output

def select_invalid_data_type(df, column, data_type):
    data_type = data_type.upper()

    
    def is_uuid(val):
        try:
            uuid.UUID(str(val))
            return True
        except ValueError:
            return False
    
    if data_type == 'NULL':
        mask = ~df[column].isnull()
    elif data_type in ['INTEGER', 'SMALLINT', 'TINYINT', 'BIGINT', 'HUGEINT']:
        numeric_mask = pd.to_numeric(df[column], errors='coerce').notnull()
        integer_mask = df[column].astype(str).str.isdigit()
        mask = ~(numeric_mask & integer_mask)
    elif data_type in ['DOUBLE', 'REAL', 'DECIMAL']:
        numeric_mask = pd.to_numeric(df[column], errors='coerce').notnull()
        null_mask = df[column].isnull()
        mask = ~(numeric_mask | null_mask)
    elif data_type == 'BOOLEAN':
        mask = ~df[column].isin([True, False, 1, 0, 'True', 'False', 'true', 'false'])
    elif data_type in data_types['VARCHAR']:
        mask = df[column].astype(str).isnull()
    elif data_type == 'DATE':
        mask = ~df[column].apply(lambda x: isinstance(x, (datetime.date, datetime.datetime, datetime.time)))
    elif data_type in ['TIME', 'TIMESTAMP', 'TIMESTAMP WITH TIME ZONE']:
        mask = ~df[column].apply(lambda x: isinstance(x, (datetime.date, datetime.datetime, datetime.time)))
    elif data_type == 'BLOB':
        mask = df[column].apply(lambda x: not isinstance(x, (bytes, bytearray)))
    elif data_type == 'UUID':
        mask = ~df[column].apply(is_uuid)
    else:
        raise ValueError(f"Data type {data_type} is not supported.")

    return mask





def identify_longitude_latitude(source_table_description):

    template = f"""Below are summary of the table. The attributes are highlighted in **bold**.
Table: {source_table_description}.

Task: Identify the pairs of longitude/latitude attribute names.
Respond in JSON format:
```json
[  
{{
    "longitude_name": "attribute_1" (case sensitive),
    "latitude_name": "attribute_2
}},
...
]
```"""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    summary = response['choices'][0]['message']['content']
    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
            write_log(message['content'])
            write_log("---------------------")


    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_code = replace_newline(json_code)
    json_code = json.loads(json_code)

    def verify_json_result(json_code):
        if not isinstance(json_code, list):
            raise ValueError("JSON code should be a list")

        for item in json_code:
            if not isinstance(item, dict):
                raise ValueError("Each item in the list should be a dictionary")

            required_keys = ["longitude_name", "latitude_name"]
            for key in required_keys:
                if key not in item:
                    raise ValueError(f"Key '{key}' is missing in one of the items")

                if not isinstance(item[key], str):
                    raise ValueError(f"Value for '{key}' should be a string")

    verify_json_result(json_code)
    return json_code


def display_longitude_latitude(json_code, full_list, call_back):
    print(f"🤓 We have identified attributes for longitude/latitude. Please select one:")

    radio_options = [f"Longitude: \"{pair['longitude_name']}\", Latitude: \"{pair['latitude_name']}\"" for pair in json_code]

    if len(radio_options) == 0:
        print(f"🙁 There doesn't seem to be a pair of attributes for longitude/latitude")
        print(f"🤓 You can try to first extract these attributes")
        print(f"😊 GeoEncoding is under development. Please send a feature request! ")


    radio_options.append('Manual Selection:')


    selection_radio_buttons = widgets.RadioButtons(
        options=radio_options,
        disabled=False,
        layout=widgets.Layout(width='600px')
    )

    longitude_label = widgets.HTML(value='<strong>Longitude:</strong>')
    latitude_label = widgets.HTML(value='<strong>Latitude:</strong>')


    custom_longitude_dropdown = widgets.Dropdown(
        options=full_list,
        layout=widgets.Layout(width='15%')
    )
    custom_latitude_dropdown = widgets.Dropdown(
        options=full_list,
        layout=widgets.Layout(width='15%')
    )

    hbox_longitude = widgets.HBox([longitude_label, custom_longitude_dropdown,latitude_label, custom_latitude_dropdown])

    submit_button = widgets.Button(description="Submit")

    def on_submit_button_clicked(b):
        clear_output(wait=True)
        
        selected_index = selection_radio_buttons.index
        if selected_index < len(json_code):
            selected_pair = json_code[selected_index]
            call_back(selected_pair['longitude_name'], selected_pair['latitude_name'])
        else:  
            call_back(custom_longitude_dropdown.value, custom_latitude_dropdown.value)

    submit_button.on_click(on_submit_button_clicked)

    display(selection_radio_buttons, hbox_longitude, submit_button)

    def on_selection_change(change):
        if change['new'] == 'Manual Selection:':
            hbox_longitude.layout.display = 'flex'
        else:
            hbox_longitude.layout.display = 'none'

    selection_radio_buttons.observe(on_selection_change, names='value')
    on_selection_change({'new': selection_radio_buttons.value})






def recommend_testing(basic_description, table_name):
    template = f"""{basic_description}
Propose domain specific testing for table columns.
E.g., If the table has "volume 1", "volume 2" and "total volume", then the domain specific testing should be "volume 1 + volume 2 = total volume".
If the table has "start date" and "end date", then the domain specific testing should be "start date < end date" when these columns are not null.
Don't write tests that checks the column range/domains, as they are already given.

Now respond in the following format:
```json
[
{{
    "name": "Total Volume Check",
    "reasoning": "The total volume should be the sum of volume 1 and volume 2",
    "sql" (select rows that violate the rule, to be executed by duckdb): "select * from {table_name} where volume_1 + volume_2 != total_volume",
}},
...
]
```"""

    messages = [{"role": "user", "content": template}]
    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    write_log(template)
    write_log("-----------------------------------")
    write_log(response['choices'][0]['message']['content'])

    processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_code = json.loads(processed_string)

    def test_json_code(code):
        if not isinstance(code, list):
            raise ValueError("The provided JSON is not a list.")

        required_keys = {"name", "reasoning", "sql"}
        for item in code:
            if not isinstance(item, dict):
                raise ValueError("An item in the list is not a dictionary.")

            if not required_keys.issubset(item.keys()):
                missing_keys = required_keys - item.keys()
                raise ValueError(f"Missing keys in an item: {missing_keys}")

    test_json_code(json_code)
    return json_code



def recommend_join_keys(source_table_description, target_table_description):
    template = f"""Below are summary of tables. The attributes are highlighted in **bold**.
Table 1: {source_table_description}.

Table 2 : {target_table_description}.

Task: Recommend a list of join keys between the two tables.
Respond in JSON format:
```json
[  
{{
    "reason": "Both tables contain the same concept of ...",
    "table_1_join_keys": [attribute_1, attribute_2, ...] (case sensitive),
    "table_2_join_keys": [...]
}},
...
]
```"""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    summary = response['choices'][0]['message']['content']
    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
            write_log(message['content'])
            write_log("---------------------")


    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_code = replace_newline(json_code)
    json_code = json.loads(json_code)

    def verify_json_result(json_code):
        if not isinstance(json_code, list):
            raise ValueError("JSON code should be a list")

        for item in json_code:
            if not isinstance(item, dict):
                raise ValueError("Each item in the list should be a dictionary")

            required_keys = ["reason", "table_1_join_keys", "table_2_join_keys"]
            for key in required_keys:
                if key not in item:
                    raise ValueError(f"Key '{key}' is missing in one of the items")

            if not isinstance(item["table_1_join_keys"], list) or not isinstance(item["table_2_join_keys"], list):
                raise ValueError("table_1_join_keys and table_2_join_keys should be lists")

    verify_json_result(json_code)
    return json_code


def find_duplicate_indices(df):
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Input must be a pandas DataFrame")

    df_temp = df.fillna("NaN_placeholder")

    duplicates = df_temp[df_temp.duplicated(keep=False)]

    if duplicates.empty:
        return []

    grouped = duplicates.groupby(list(duplicates.columns)).apply(lambda x: x.index.tolist())

    return grouped.values.tolist()




def display_duplicated_rows_html(df, duplicated_indices):
    html_output = f"<p>🤨 There are {len(duplicated_indices)} groups of duplicated rows.</p>"
    for i, group in enumerate(duplicated_indices[:5]):
        html_output += f"Group {i+1} appear {len(group)} times:"
        for idx in group[:1]:
            html_output += df.iloc[[idx]].to_html()
    if len(duplicated_indices) > 5:
        html_output += "<p>...</p>"
    html_output += "<p>🧐 Do you want to remove the duplicated rows?</p>"
    display(HTML(html_output))




def color_columns(df, color, column_indices):
    return color_columns_multiple(df, [color], [column_indices])



def columns_with_all_missing_values(df):
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Input must be a pandas DataFrame")

    missing_column_indices = [i for i, col in enumerate(df.columns) if df.iloc[:, i].isna().all()]

    return missing_column_indices

def display_and_ask_removal(df, missing_column_indices):
    html_output = f"<p>🤔 There are {len(missing_column_indices)} columns <b>with all missing values</b>:</p>"
    display(HTML(html_output))

    df_sample = color_columns(df.head(), 'lightgreen', missing_column_indices)
    display(HTML(wrap_in_scrollable_div(truncate_html_td(df_sample.to_html()))))
    display(HTML("<p>🧐 Select the columns you want to remove:</p>"))



def display_duplicated_columns_html(df, duplicate_column_indices):
    html_output = f"<p>🤔 There are {len(duplicate_column_indices)} groups of duplicated column names.</p>"


    for group in duplicate_column_indices:

        col_name = df.columns[group[0]]
        
        new_column_names = df.columns.tolist()

        for i, idx in enumerate(group):
            new_column_names[idx] = f"{df.columns[idx]} ({i+1})"
        
        df.columns = new_column_names

    colors = generate_seaborn_palette(len(duplicate_column_indices))

    styled_df = color_columns_multiple(df.head(), colors, duplicate_column_indices)

    display(HTML(html_output))
    display(HTML(wrap_in_scrollable_div(truncate_html_td(styled_df.to_html()))))

    display(HTML("<p>🧐 Select the columns you want to remove:</p>"))


def find_duplicate_column_indices(df):
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Input must be a pandas DataFrame")

    columns_dict = {}
    for index, col in enumerate(df.columns):
        columns_dict.setdefault(col, []).append(index)

    duplicate_columns = [indices for indices in columns_dict.values() if len(indices) > 1]

    return duplicate_columns




def find_default_index_column(df):
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Input must be a pandas DataFrame")

    sample_df = df[:1000].copy()

    default_index_indices = []

    for col in sample_df.columns:
        if sample_df[col].equals(pd.Series(range(len(sample_df)))):
            default_index_indices.append(df.columns.get_loc(col))

    return default_index_indices






def find_columns_with_xy_suffix_indices(df):
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Input must be a pandas DataFrame")

    base_names = set(df.columns.str.replace('(_x$|_y$|\.x$|\.y$)', '', regex=True))

    matched_column_indices = []

    for base in base_names:
        if f'{base}_x' in df.columns and f'{base}_y' in df.columns:
            index_x = df.columns.get_loc(f'{base}_x')
            index_y = df.columns.get_loc(f'{base}_y')
            matched_column_indices.append([index_x, index_y])

        if f'{base}.x' in df.columns and f'{base}.y' in df.columns:
            index_x_dot = df.columns.get_loc(f'{base}.x')
            index_y_dot = df.columns.get_loc(f'{base}.y')
            matched_column_indices.append([index_x_dot, index_y_dot])

    return matched_column_indices


def display_xy_duplicated_columns_html(df, duplicate_column_indices):
    html_output = f"<p>🤔 There are {len(duplicate_column_indices)} groups of column names, duplicated likely by merge.</p>"


    for group in duplicate_column_indices:

        col_name = df.columns[group[0]]
        
        new_column_names = df.columns.tolist()

        for i, idx in enumerate(group):
            new_column_names[idx] = f"{df.columns[idx]}"
        
        df.columns = new_column_names

    colors = generate_seaborn_palette(len(duplicate_column_indices))

    styled_df = color_columns_multiple(df.head(), colors, duplicate_column_indices)

    display(HTML(html_output))
    display(HTML(wrap_in_scrollable_div(truncate_html_td(styled_df.to_html()))))

    display(HTML("<p>🧐 Select the columns you want to remove:</p>"))




def find_default_index_column(df):
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Input must be a pandas DataFrame")

    sample_df = df[:1000].copy()

    default_index_indices = []

    for col in sample_df.columns:
        if sample_df[col].equals(pd.Series(range(len(sample_df)))):
            default_index_indices.append(df.columns.get_loc(col))

    return default_index_indices

    
def display_index_and_ask_removal(df, missing_column_indices):
    html_output = f"<p>🤔 There are {len(missing_column_indices)} columns <b>for row id</b>:</p>"

    df_sample = color_columns(df.head(), 'lightgreen', missing_column_indices)

    display(HTML(html_output))
    display(HTML(wrap_in_scrollable_div(truncate_html_td(df_sample.to_html()))))

    display(HTML("<p>🧐 Select the columns you want to remove:</p>"))





doc_steps = ["Sanity", "Table", "Missing", "Unusual"]
geo_integration_steps = ["Process", "CRS", "Integration"] 




def create_tabs_with_notifications(tab_data):
    def tab_title_with_emoji_notification(title, notification_count):
        no_break_space = '\u00A0'
        return f"{title}{no_break_space}⚠️{notification_count}"

    tab_children = []
    for title, notifications, content in tab_data:
        tab_content = widgets.HTML(value=content)
        tab_children.append(tab_content)

    tab = widgets.Tab(children=tab_children)

    for index, (title, notifications, _) in enumerate(tab_data):
        if notifications > 0:
            tab.set_title(index, tab_title_with_emoji_notification(title, notifications))
        else:
            tab.set_title(index, title)

    return tab




def create_dropdown_with_content(tab_data):
    dropdown = Dropdown(
        options=[(title, index) for index, (title, _) in enumerate(tab_data)],
    )

    display_area = widgets.HTML(value=tab_data[0][1])

    def on_dropdown_change(change):
        if change['type'] == 'change' and change['name'] == 'value':
            display_area.value = tab_data[change['new']][1]

    dropdown.observe(on_dropdown_change, names='value')

    return VBox([dropdown, display_area])


def transform_string(s):
    """Transforms a string to lowercase and removes special characters."""
    return ''.join(c for c in s if c.isalnum()).lower()

def process_lists(list1, list2):
    transformed_list1 = {s: transform_string(s) for s in list1}

    transformed_list2 = {}
    for s in list2:
        new_string = transform_string(s)
        if new_string in transformed_list2:
            raise ValueError(f"Duplicate transformation: '{transformed_list2[new_string]}' and '{s}' both transform to '{new_string}'")
        transformed_list2[s] = new_string

    for old_string, new_string in transformed_list2.items():
        if new_string not in transformed_list1.values():
            raise ValueError(f"No corresponding string in list1 for '{old_string}'")

    mapping_dict = {}
    for old1, new1 in transformed_list1.items():
        for old2, new2 in transformed_list2.items():
            if new1 == new2:
                mapping_dict[old1] = old2
                break

    return mapping_dict



def image_json_to_base64(json_var, df):
    histogram_imgs = []
    map_imgs = []

    if not isinstance(json_var, list):
        raise ValueError("json_var is not a list")

    for json_entry in json_var:
        if json_entry['name'] == 'Histogram':
            att = json_entry['params']
            histogram_imgs.append(plot_distribution(df, att))
        elif json_entry['name'] == 'Map':
            lon, lat = json_entry['params']
            map_imgs.append(plot_geospatial_data(df, lon, lat))
        else:
            raise ValueError(f"Visualization name {json_entry['name']} is not supported")

    return histogram_imgs, map_imgs
    

def generate_visualization_recommendation(table_summary):    
    template =  f"""Below are table summary, where attributes are in **bold**:
{table_summary}

Help me choose some interesting attributes to generate visualizations for.

Below are visualization APIs:

1. "Histogram"
params: "att" (**atts** are highlighted)
This shows att's distribution. Suitable for categorical attributes.

2. "Map"
params: ["lon_att", "lat_att"] (doesn't suppport address yet)
This shows the geo distribution.

Respond in the following format without reasonings:
```json
[
    {{"name": "Histogram", "params": "age"}},
    {{"name": "Map", "params": ["longitude", "latitude"]}},
    ...
]
```"""
    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    assistant_message = response['choices'][0]['message']

    json_code = extract_json_code_safe(assistant_message['content'])
    json_code = json_code.replace('\'', '\"')
    json_var = json.loads(json_code)

    messages.append(assistant_message)

    return json_var, messages



def get_source_nodes_ids(edges, node):
    source_nodes = []

    for source, targets in edges.items():
        if node in targets:
            source_nodes.append(source)

    return source_nodes



def wrap_in_scrollable_div(html_code, width='100%', height='200px'):
    scrollable_div = f'<div style="width: {width}; overflow: auto; max-height: {height};">{html_code}</div>'

    return scrollable_div

def json_to_html(json_code):

    json_str = json.dumps(json_code, indent=2)
    
    html_content = f"<pre>{json_str}</pre>"
    
    return html_content




def wrap_in_iframe(html_code, width=800, height=400):

    escaped_html = html_code.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#039;")

    iframe_code = f"<iframe srcdoc=\"{escaped_html}\" width=\"{width}\" height=\"{height}\" frameborder=\"0\"></iframe>"

    return iframe_code

def plot_missing_values_html(df):
    missing_percent = df.isnull().mean() * 100
    missing_percent = missing_percent[missing_percent > 0]

    if len(missing_percent) == 0:
        return

    plot_width = max(4, len(missing_percent) * 0.5)
    sns.set(style="whitegrid")

    plt.figure(figsize=(plot_width, 3), dpi=100)
    bar_plot = sns.barplot(x=missing_percent.index, y=missing_percent, color="lightgreen")

    for index, value in enumerate(missing_percent):
        bar_plot.text(index, value, f'{value:.2f}%', color='black', ha="center", fontsize=8)

    plt.title('Missing % (for Columns with Missing Values)', fontsize=8)
    plt.ylabel('%', fontsize=10)
    plt.xticks(rotation=45, fontsize=6)
    plt.yticks(fontsize=8)
    plt.tight_layout()

    buffer = BytesIO()
    plt.savefig(buffer, format='png')
    plt.close()
    buffer.seek(0)
    image_png = buffer.getvalue()

    image_base64 = base64.b64encode(image_png).decode('utf-8')
    html_str = f'<img src="data:image/png;base64,{image_base64}"/>'

    return html_str


def get_tree_javascript(data):
    def process_data(data):
        keys = list(data.keys())
        if len(keys) == 0:
            return {}

        key = keys[0]
        main_data = data[key]

        children = []
        for sub_key, sub_value in main_data.items():
            if isinstance(sub_value, list):
                items_str = ','.join(map(str, sub_value))

                final_str = '[' + items_str + ']'

                leaf_node = [{"name": final_str}]
                children.append({"name": sub_key, "children": leaf_node})
            else:
                children.append(process_data({sub_key: sub_value}))

        return {"name": key, "children": children}



    def count_leaf_nodes(node):
        """
        Count the number of leaf nodes in a tree represented by nested dictionaries.

        Args:
        node (dict): The tree node, which could be the root of the tree or any sub-node within the tree.

        Returns:
        int: The total number of leaf nodes in the tree from the given node down.
        """
        if not isinstance(node, dict) or 'children' not in node or not node['children']:
            return 1

        leaf_count = 0
        for child in node['children']:
            leaf_count += count_leaf_nodes(child)

        return leaf_count

    def max_path_length(data, ch_size, gap_size):
        def calculate_length(path):
            return sum(len(step) for step in path) * ch_size + (len(path) - 1) * gap_size

        def traverse(node, path=[]):
            if isinstance(node, dict):
                for key, value in node.items():
                    yield from traverse(value, path + [key])
            elif isinstance(node, list):
                for item in node:
                    yield calculate_length(path + [item])

        return max(traverse(data))

    processed_data = process_data(data)

    number_of_leaves = count_leaf_nodes(processed_data)
    
    javascript = """
    const structuredData = {{data}};

    const treeLayout = d3.tree().size([{{height1}}, {{width1}}]);

    const root = d3.hierarchy(structuredData);
    root.x0 = 0;
    root.y0 = 0;

    const svg = d3.select('#tree').append('svg')
        .attr('width',  {{width2}})
        .attr('height', {{height2}});

    const g = svg.append('g')
        .attr('transform', 'translate(50,50)');

    update(root);

    function update(source) {
        const duration = 750;

        // Re-compute the tree layout
        treeLayout(root);

        // Determine the leftmost node's y-position to adjust the tree positioning
        let leftmostNode = root;
        root.each(d => {
            if (d.y < leftmostNode.y) {
                leftmostNode = d;
            }
        });
        const shiftX = -leftmostNode.y + 50;

        const nodes = root.descendants();
        const links = root.links();

        const node = g.selectAll('.node')
            .data(nodes, d => d.id || (d.id = Math.random()));

        const nodeEnter = node.enter().append('g')
            .attr('class', 'node')
            .attr('transform', d => `translate(${source.y0 + shiftX},${source.x0})`)
            .on('click', click);

        nodeEnter.append('circle')
            .attr('r', 1e-6)
            .style('fill', d => d._children ? 'lightgreen' : '#fff');

        nodeEnter.append('text')
            .attr('dy', '0.35em')
            .attr('x', d => d.children || d._children ? -13 : 13)
            .style('text-anchor', d => d.children || d._children ? 'end' : 'start')
            .text(d => d.data.name);

        const nodeUpdate = nodeEnter.merge(node);

        nodeUpdate.transition()
            .duration(duration)
            .attr('transform', d => `translate(${d.y + shiftX},${d.x})`);

        nodeUpdate.select('circle')
            .attr('r', 5)
            .style('fill', d => d._children ? 'lightgreen' : '#fff');

        const nodeExit = node.exit().transition()
            .duration(duration)
            .attr('transform', d => `translate(${source.y + shiftX},${source.x})`)
            .remove();

        nodeExit.select('circle')
            .attr('r', 1e-6);

        nodeExit.select('text')
            .style('fill-opacity', 1e-6);

        const link = g.selectAll('.link')
            .data(links, d => d.target.id);

        const linkEnter = link.enter().insert('path', 'g')
            .attr('class', 'link')
            .attr('d', d => {
                const o = { x: source.x0, y: source.y0 };
                return diagonal(o, o);
            });

        const linkUpdate = linkEnter.merge(link);

        linkUpdate.transition()
            .duration(duration)
            .attr('d', d => diagonal(d.source, d.target));

        link.exit().transition()
            .duration(duration)
            .attr('d', d => {
                const o = { x: source.x, y: source.y };
                return diagonal(o, o);
            })
            .remove();


        // Update the positional attributes of each node for the next transition.
        nodes.forEach(d => {
            d.x0 = d.x;
            d.y0 = d.y;
        });

        function diagonal(s, d) {
            const path = `M ${s.y + shiftX} ${s.x}
                C ${(s.y + d.y) / 2 + shiftX} ${s.x},
                ${(s.y + d.y) / 2 + shiftX} ${d.x},
                ${d.y + shiftX} ${d.x}`;

            return path;
        }

    }

    function click(event, d) {
        if (d.children) {
            d._children = d.children;
            d.children = null;
        } else {
            d.children = d._children;
            d._children = null;
        }
        update(d);
    }"""
    
    processed_data_str = json.dumps(processed_data, indent=4)

    height1 = number_of_leaves * 30
    height2 = number_of_leaves * 35 + 50

    width1 = max_path_length(data, 5, 20)
    width2 = max_path_length(data, 10, 50) + 150
    
    html_content_updated = javascript.replace('{{data}}', processed_data_str)
    html_content_updated = html_content_updated.replace('{{height1}}', str(height1))
    html_content_updated = html_content_updated.replace('{{height2}}', str(height2))
    html_content_updated = html_content_updated.replace('{{width1}}', str(width1))
    html_content_updated = html_content_updated.replace('{{width2}}', str(width2))
    
    return html_content_updated, width2, height2
    

def get_tree_html(data):
    javascript_content, width2, height2 = get_tree_javascript(data)

    html_content = f"""<div id="tree" style="overflow: scroll;"></div>
<script src="https://d3js.org/d3.v6.min.js"></script>
<style>
    .link {{
        fill: none;
        stroke: #555;
        stroke-opacity: 0.4;
        stroke-width: 1.5px;
    }}

    .node {{
        cursor: pointer;
    }}

    .node circle {{
        fill: #999;
        stroke: forestgreen;
        stroke-width: 1.5px;
    }}

    .node text {{
        font: 12px sans-serif;
        fill: #555;
    }}
</style>
<script>
{javascript_content}
</script>"""  

    return html_content, width2, height2




def get_rename(meanings):

    column_meanings = '\n'.join([f"  \"{m['column']}\": {m['meaning']}" for m in meanings])

    template = f"""{column_meanings}

    Analyze the column names. The final result as a json file:

    ```json
    [{{
    "column": "column_name" (case sensitive),
    "ambiguous": Given the meaning, is the column name ambiguous? Note that it's fine for the name to be domain specific.
    "rename": "" (empty string if not ambiguous)
    }},...]```"""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
        write_log(message['content'])
        write_log("---------------------")

    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_code = replace_newline(json_code)
    json_code = json.loads(json_code)
            
    def verify_rename(meanings, json_code):

        meanings_columns = set([m['column'] for m in meanings])
        json_code_columns = set([j['column'] for j in json_code])
        if meanings_columns != json_code_columns:
            raise ValueError(f"The set of column names in the meanings and json_code are different: {meanings_columns} vs {json_code_columns}") 

    verify_rename(meanings, json_code)

    return json_code, messages


def topological_sort(nodes, edges):
    in_degree = {i: 0 for i in range(len(nodes))}
    for targets in edges.values():
        for target in targets:
            in_degree[target] += 1

    queue = [i for i in range(len(nodes)) if in_degree[i] == 0]

    order = []

    while queue:
        node_idx = queue.pop(0)
        order.append(node_idx)

        for target_idx in edges.get(node_idx, []):
            in_degree[target_idx] -= 1
            if in_degree[target_idx] == 0:
                queue.append(target_idx)

    if len(order) != len(nodes):
        return "Cycle detected in the graph, topological sort not possible."

    return order



def show_progress(max_value=1, value=1):
    progress = widgets.IntProgress(
        value=value,
        min=0,
        max=max_value+1,  
        step=1,
        description='',
        bar_style='',
        orientation='horizontal'
    )
    
    display(progress)
    return progress


def give_title(task):
    template = f"""Rename the below task into a title that's as short as possible:
{task}"""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    title = response['choices'][0]['message']['content']
    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)
    
    for message in messages:
        write_log(message['content'])
        write_log("---------------------")

    return title, messages


def classify_unusual_values(col, unique_values, reason):

    template = f"""Issue: In the '{col}' column, some values are unusual.
Data Values: {unique_values}
Reason: {reason}
Goal: Classify unusual and normal values.

Return the results in json format:
```json
{{
    "reasoning": "The unusual values are ...",
    "unusual_values": ["unusual value",...], (could be empty)
    "normal_values": ["normal value",...] (could be empty)
}}```"""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
        write_log(message['content'])
        write_log("---------------------")


    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_code = replace_newline(json_code)
    json_code = json.loads(json_code)


    def verify_result(json_code, unique_values):

        unique_values = [str(v) for v in unique_values]

        assert json_code['reasoning'] is not None
        assert json_code['unusual_values'] is not None
        assert json_code['normal_values'] is not None

        assert isinstance(json_code['reasoning'], str)
        assert isinstance(json_code['unusual_values'], list)
        assert isinstance(json_code['normal_values'], list)

        assert len(set(json_code['unusual_values']).intersection(set(json_code['normal_values']))) == 0

        json_codes_all = json_code['unusual_values'] + json_code['normal_values']
        json_codes_all = [str(v) for v in json_codes_all]

        assert len(set(unique_values).difference(set(json_codes_all))) == 0 

    verify_result(json_code, unique_values)

    return json_code

def find_regex_pattern(col, result):

    template = f"""Issue: In the '{col}' column, some values are unusual.
Unusual Values: {result['unusual_values']}
Normal Values: {result['normal_values']}

Goal: Identify if there is regular expression that
(1) matches all the normal values, and
(2) does not match any of the unusual values.

There could be multiple regex patterns that satisfy the goal. 
Please understand the meaning of the column, and find one general regex pattern.

Return the results in json format:
```json
{{
"reasoning": "The patterns in the normal values are ...",
"exists_regex": true/false,
"regex": "..."
}}```"""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)


    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
        write_log(message['content'])
        write_log("---------------------")

    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_code = replace_newline(json_code)
    json_code = json.loads(json_code)



    def verify_json(json_code):
        fields = ['reasoning', 'exists_regex', 'regex']
        for field in fields:
            if field not in json_code:
                raise ValueError(f"Missing field '{field}' in json code.")

        if not isinstance(json_code['reasoning'], str):
            raise ValueError(f"Field 'reasoning' should be string.")
        if not isinstance(json_code['exists_regex'], bool):
            raise ValueError(f"Field 'exists_regex' should be boolean.")
        if not isinstance(json_code['regex'], str):
            raise ValueError(f"Field 'regex' should be string.")

    verify_json(json_code)
    
    if json_code['exists_regex']:

        def verify_regex(regex, normal_values, unusual_values):
            regex = re.compile(regex)
            for value in normal_values:
                if not regex.match(value):
                    raise ValueError(f"Regex does not match normal value: {value}")
            for value in unusual_values:
                if regex.match(value):
                    raise ValueError(f"Regex matches unusual value: {value}")
                
        verify_regex(json_code["regex"], result['normal_values'], result['unusual_values'])

    return json_code






def generate_workflow_html(nodes, edges, edge_labels=None, highlight_nodes=None, highlight_edges=None, height=400):
    dot = Digraph(format='png')

    if edge_labels is None:
        edge_labels = {}
    if highlight_nodes is None:
        highlight_nodes = []
    if highlight_edges is None:
        highlight_edges = []

    node_style = {
        'style': 'filled',
        'fillcolor': '#DAE8FC',
        'color': '#6C8EBF',
        'shape': 'box',
        'fontname': 'Helvetica',
        'fontsize': '8',
        'fontcolor': '#2E4057',
        'margin': '0.1,0.02',
        'height': '0.3',
        'width': '0.5'
    }

    highlighted_node_style = {
        'fillcolor': '#FFD580',
        'color': '#FFA500'
    }

    edge_style = {
        'color': '#6C8EBF',
        'arrowsize': '0.5',
        'penwidth': '0.6',
        'fontname': 'Helvetica',
        'fontsize': '8',
        'fontcolor': '#2E4057',
    }

    highlighted_edge_style = {
        'color': '#FFA500',
        'penwidth': '2.0'
    }

    for node in nodes:
        if node in highlight_nodes:
            dot.node(node, node, **{**node_style, **highlighted_node_style})
        else:
            dot.node(node, node, **node_style)

    for tail, heads in edges.items():
        for head in heads:
            label = edge_labels.get((tail, head), '')
            if (tail, head) in highlight_edges:
                dot.edge(nodes[tail], nodes[head], label=label, **{**edge_style, **highlighted_edge_style})
            else:
                dot.edge(nodes[tail], nodes[head], label=label, **edge_style)

    png_image = dot.pipe()

    encoded_image = base64.b64encode(png_image).decode()
    return encoded_image

def display_workflow(nodes, edges, edge_labels=None, highlight_nodes=None, highlight_edges=None, height=400):
    encoded_image = generate_workflow_html(nodes, edges, edge_labels, highlight_nodes, highlight_edges, height)
    scrollable_html = f"""
    <div style="max-height: {height}px; overflow: auto; border: 1px solid #cccccc;">
        <img src="data:image/png;base64,{encoded_image}" alt="Workflow Diagram" style="display: block; max-width: none; height: auto;">
    </div>
    """
    display(HTML(scrollable_html))








def visualize_graph(tables, edges):
    G = nx.Graph()
    G.add_nodes_from(tables)
    G.add_edges_from(edges)

    pos = nx.spring_layout(G)

    nx.draw_networkx_nodes(G, pos, node_color='lightgreen',node_size=1200, edgecolors='forestgreen', linewidths=1)

    nx.draw_networkx_edges(G, pos, edge_color='forestgreen', width=1)

    node_labels = {node:node for node in G.nodes()}
    nx.draw_networkx_labels(G, pos, node_labels, font_size=6)

    edge_labels = nx.get_edge_attributes(G, 'label')
    nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels, font_color='forestgreen')

    plt.axis('off')
    plt.gca().set_facecolor('lightgrey')
    plt.gca().grid(which='major', color='white', linestyle='-', linewidth=0.5)
    plt.show()






def plot_geospatial_data(df, longitude_col, latitude_col):

    if len(df) > 10000:
        df = df.sample(10000)

    fig, ax = plt.subplots(figsize=(4, 2))

    world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))

    gdf = gpd.GeoDataFrame(
        df, geometry=gpd.points_from_xy(df[longitude_col], df[latitude_col]))

    world.plot(ax=ax, color='white', edgecolor='black', linewidth=0.5)

    gdf.plot(ax=ax, color='forestgreen', marker='o', markersize=10, alpha=0.1)

    ax.set_xlabel(longitude_col)
    ax.set_ylabel(latitude_col)

    ax.tick_params(left=False, bottom=False, labelleft=False, labelbottom=False)

    ax.set_aspect('equal')

    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close(fig)
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')
    return image_base64

def plot_distribution(df, column_name):
    """
    This function takes a pandas DataFrame and a column name as input.
    It plots a suitable visualization and returns it as a base64-encoded PNG string.
    """
    if column_name not in df.columns:
        raise ValueError(f"Column '{column_name}' not found in the DataFrame.")
        return

    if df[column_name].isnull().all():
        return

    if pd.api.types.is_numeric_dtype(df[column_name]):
        plt.figure(figsize=(4, 2))

        hist_plot = sns.histplot(df[column_name], bins=min(10, len(df[column_name].dropna().unique())), 
                                 kde=False, color="lightgreen")

        hist_plot.xaxis.set_major_formatter(ticker.EngFormatter())

        for p in hist_plot.patches:
            height = p.get_height()
            plt.text(p.get_x() + p.get_width() / 2., height, f'{int(height)}', ha='center', va='bottom', fontsize=8)

        plt.ylabel('Frequency')
        plt.xlabel(column_name)
    else:
        top_categories = df[column_name].value_counts().head(10)
        others_count = df[column_name].value_counts()[10:].sum()

        if others_count > 0:
            other_values_series = pd.Series([others_count], index=['Other Values'])
            top_categories = pd.concat([top_categories, other_values_series])

        plt.figure(figsize=(4, 2))
        
        top_category_str = top_categories.index.astype(str)

        bar_plot = sns.barplot(y=top_category_str, x=top_categories, color="lightgreen", edgecolor="black")

        if 'Other Values' in top_categories:
            bar_plot.patches[-1].set_facecolor('orange')

        for index, value in enumerate(top_categories):
            bar_plot.text(value, index, f'{value}', color='black', va='center', fontsize=8)

        plt.xlabel('Frequency')
        plt.ylabel(column_name)

    plt.tight_layout()
    
    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')

    return image_base64





        
            


        



def display_html_iframe(html_content, width="100%", height=None):

    encoded_html = base64.b64encode(html_content.encode()).decode()

    data_uri = f"data:text/html;base64,{encoded_html}"
    
    display(IFrame(src=data_uri, width=width, height=height))

def render_json_in_iframe_with_max_height(json_data, max_height=200):
    def default_serializer(obj):
        if isinstance(obj, np.integer):
            return int(obj)
        raise TypeError(f"Object of type {obj.__class__.__name__} is not JSON serializable")


    json_str = json.dumps(json_data, default=default_serializer, indent=2)
        
    html_template = f"""
    <html>
    <head>
        <script src="https://rawgit.com/caldwell/renderjson/master/renderjson.js"></script>
        <script>
            window.onload = function() {{
                document.body.appendChild(renderjson.set_show_to_level(1)({json_str}));
            }};
        </script>
    </head>
    <body style="margin:0; padding:0;"></body>
    </html>
    """
    
    encoded_html = base64.b64encode(html_template.encode('utf-8')).decode('utf-8')
    
    iframe_html = f'''
    <div style="overflow-y:auto; border-left: 4px solid #ccc; padding-left: 10px;">
        <iframe src="data:text/html;base64,{encoded_html}" style="width:100%; height:{max_height}px; border:none;"></iframe>
    </div>
    '''

    return iframe_html    



def collect_df_statistics_(df, document=None, sample_distinct=20):

    stats = {}

    for col in df.columns:
        df_col = df[col]
        if isinstance(df_col, pd.DataFrame):
            df_col = df_col.iloc[:, 0]

        dtype = df_col.dtype
        null_percentage = round(df_col.isnull().mean() * 100, 2)

        if np.issubdtype(dtype, np.number):
            unique_values = df_col.nunique()

            hist, bin_edges = np.histogram(df_col.dropna(), bins=sample_distinct)
            histogram = {
                f"[{bin_edges[i]:.2f} - {bin_edges[i + 1]:.2f}]": hist[i] for i in range(sample_distinct)
            }

            stats[col] = {
                "dtype": str(dtype),
                "null_percentage": null_percentage,
                "unique_values": unique_values,
                "histogram": histogram
            }

        else:
            top_values = df_col.value_counts().head(sample_distinct).to_dict()
            other_count = df_col.nunique() - len(top_values)
            if other_count > 0:
                top_values["other"] = other_count

            stats[col] = {
                "dtype": str(dtype),
                "null_percentage": null_percentage,
                "histogram": top_values,
                "unique_values": df_col.nunique()
            }

    if document is not None:
        if "data_type" in document:
            
            for col in df.columns:
                if col in document["data_type"]:
                    data_type = document["data_type"][col]['data_type']
                    stats[col]['data_type'] = data_type

    return stats

def collect_df_statistics(documentdf, sample_distinct=20):
    return collect_df_statistics_(df=documentdf.df, document=documentdf.document, sample_distinct=sample_distinct)


def describe_column(stats, col_name, mention_missing=False, k=10):
    if not col_name in stats:
        raise ValueError(f"Column {col_name} not found in stats.")

    column_stats = stats[col_name]
    description = []

    if pd.api.types.is_numeric_dtype(column_stats["dtype"]) and not pd.api.types.is_bool_dtype(column_stats["dtype"]):
        if "data_type" in column_stats:
            description.append(f"'{col_name}': {column_stats['data_type']}")
        else:
            description.append(f"'{col_name}': numerical")

        min_val = min([float(i.split(' - ')[0][1:]) for i in column_stats["histogram"].keys()])
        max_val = max([float(i.split(' - ')[1][:-1]) for i in column_stats["histogram"].keys()])
        
        description.append(f" with range [{min_val}, {max_val}]")
        

    else:
        if "data_type" in column_stats:
            description.append(f"'{col_name}': {column_stats['data_type']} ")
        else:
            description.append(f"'{col_name}': categorical ")
        num_unique = column_stats['unique_values']
        description.append(f"with {num_unique} unique value{'s' if num_unique > 1 else ''}")
        
        histogram = column_stats["histogram"]
        top_k = 	sorted(histogram.items(), key=lambda x: x[1], reverse=True)[:k]
        top_k_values = ["'" + str(k[0]) + "'" for k in top_k if k[0] != "other"]
        
        if k >= column_stats['unique_values']:
            description.append(f" {', '.join(top_k_values)}.")
        else:
            description.append(f". E.g., {', '.join(top_k_values)}...")

    if mention_missing:
        null_percentage = column_stats['null_percentage']
        if null_percentage > 0:
            description.append(f"% Missing: {null_percentage}%")
            description.append(f"Contains missing values.")
        else:
            description.append(f"No missing values.")
    
    return "".join(description)

def describe_missing_values(stats, df, threshold=50):
    description = ""
    for col_name in df.columns:
        if stats[col_name]['null_percentage'] > threshold:
            description +=  f"{col_name}: {stats[col_name]['null_percentage']}% missing values\n"
    return description



def describe_df_in_natural_language(df, table_name, num_rows_to_show, num_cols_to_show=None):
    num_rows = len(df)
    num_columns = len(df.columns)
    if table_name != "" and table_name is not None:
        description = f"The table '{table_name}' has {num_rows} rows and {num_columns} columns.\n"
    else:
        description = f"The table has {num_rows} rows and {num_columns} columns.\n"

    pd.set_option('display.max_columns', None)
    pd.set_option('display.width', None)

    if num_cols_to_show is None:
        num_cols_to_show = num_columns

    if num_rows_to_show > 0:
        first_rows_not_null = df[df.notnull().any(axis=1)]

        first_rows = first_rows_not_null.iloc[:num_rows_to_show, :num_cols_to_show]

        first_rows_str = first_rows.to_csv(index=False, quoting=2) 
        description += f"Here are the first {num_rows_to_show} rows:\n{first_rows_str}"
    else:
        description += f"Here are the columns:\n{df.columns.to_list()}"
    
    return description

def replace_asterisks_with_tags(text):
    """
    Replaces all occurrences of words enclosed in double asterisks with the same words enclosed in <u></u> tags.
    """
    import re

    pattern = r'\*\*(.*?)\*\*'
    replaced_text = re.sub(pattern, r'<u>\1</u>', text)

    return replaced_text


def get_table_summary(main_entity, table_sample):
    """
    Generates a summary of the table.
    """
    template = f"""The table is about {main_entity}.
{table_sample} 

- Task: Concisely summarize the table.
-  Highlight: Include and highlight ALL attributes as **Attribute**. 
-  Structure: Start with the big picture, then explain how attributes are related to the big picture.
-  Requirement: ALL attributes must be mentioned and **highlighted**. The attribute name should be exactly the same (case sensitive and no extra space or _).

Example: The table is about ... at **Time**, in **Location**..."""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    summary = response['choices'][0]['message']['content']
    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    return summary, messages

def find_target_table(source_table_description, target_database_description="""The database primarily focuses on healthcare data, structured around several interconnected entities. The central entity is the **PATIENT** table, which contains details about individuals receiving medical care. Their healthcare journey is tracked through the **VISIT_OCCURRENCE** table, which records each visit to a healthcare facility. The **CONDITION_OCCURRENCE** table details any diagnosed conditions during these visits, while the **DRUG_EXPOSURE** table captures information on medications prescribed to the patients.
Procedures performed are logged in the **PROCEDURE_OCCURRENCE** table, and any medical devices used are listed in the **DEVICE** table. The **MEASUREMENT** table records various clinical measurements taken, and the **OBSERVATION** table notes any other relevant clinical observations.
In cases where a patient passes away, the **DEATH** table provides information on the mortality. The **SPECIMEN** table tracks biological samples collected for analysis, and the **COST** table details the financial aspects of the healthcare services.
The **LOCATION**, **CARE_SITE**, and **PROVIDER** tables offer contextual data, respectively detailing the geographical locations, healthcare facilities, and medical professionals involved in patient care. Lastly, the **PAYER_PLAN_PERIOD** table provides information on the patients' insurance coverage details and durations.
"""):
    template = f"""You have a source table. All its attributes are highlighted in **bold**.
{source_table_description}

You have a target database, with tables highlighted in **bold**.
{target_database_description}
Goal: transform source table to target tables.
First repeat source table attributes and reason if they can be mapped to target tables
Then, concisely summarize the targt tables (case sensitive) that can be directly mapped to, and high level reasons (not detailed attributes) in json:
```json
{{  "target table": "xxx concepts in the source matches ...",
...
}}
```"""
    messages = [{"role": "user", "content": template}]
    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    summry = json.loads(json_code)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    return summry, messages

def decide_one_one(source_table_description, source_table_sample, target_table_description, target_table_sample, transform_reason):
    template = f"""Source table:
{source_table_description}
{source_table_sample}
Target table:
{target_table_description}
{target_table_sample}
The source can be transformed to the target table:
{transform_reason}

Task: Understand the Row Mapping. Is it 1:1 or not?
Example of NOT 1:1: 
a. Source row is about student and teacher relationship. Target row in target table is Person. So one row in source table is mapped to two rows in target table.
b. Source row is about one person info (e.g., height, weight, age). Target row in target table is person's all info. So multiple rows in source table is mapped to one row in target table.
Steps:
1. repeat what each row in the source and target table is about.
2. conclude whether the mapping is 1:1 or not in json:
```json
{{  "1:1": true/false,
    "reason": "why 1:1 or not 1:1"
}}
```"""
    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.95)

    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    summry = json.loads(json_code)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    return summry, messages

def get_concept_mapping(source_table_description, source_table_sample, target_table_description, target_table_sample, transform_reason):
    template = f"""Source table:
{source_table_description}
{source_table_sample}
Target table:
{target_table_description}
{target_table_sample}
The source can be transformed to the target table:
{transform_reason}

Task: Plan for Column Mapping
First repeat each column meaning and find all columns they can be mapped to in target tables.
Then group the similar mapping, and how to map in json:
```json
[  {{"source_columns": ["day", "month", "year"] (case sensitive), 
     "target_columns": ["date"],
     "reason": "Concatenate day, month, year to date"
     }},
]
```"""
    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.95)

    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    summry = json.loads(json_code)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    return summry, messages

def write_code_and_debug(key, source_attributes, source_table_description, target_attributes, df, target_table):

    target_attributes = "\n".join(f"{idx + 1}. {target_attribute}: {attributes_description[target_table][target_attribute]}" for idx, target_attribute in enumerate(target_attributes))

    template =  f"""Transform task: Given Source Table, tansform it to Target Table. 

Source table:
{source_table_description}

Target table needs columns:
{target_attributes}

Do the following:
1. First reason about which target columns are transformable, and how to transform. 
2. Then fill in the python function, with detailed comments. Don't change the function name, first line and the return clause.
If no column is transformable, return an empty dataframe.
```python
def transform(input_df):
    output_df = pd.DataFrame()
    ...
    return output_df
```"""
    messages = [{"role": "user", "content": template}]
    
    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)
    
    python_code = extract_python_code(response['choices'][0]['message']['content'])

    messages = messages + [response['choices'][0]['message']]

    detailed_error_info = None

    max_tries = 2

    while max_tries > 0:
        max_tries -= 1

        detailed_error_info = None

        try:
            if 'transform' in globals():
                del globals()['transform']
            exec(python_code, globals())
            temp_target_df = transform(df)
        except Exception: 
            detailed_error_info = get_detailed_error_info()

        if detailed_error_info is None:
            return python_code, messages


        error_message = f"""There is a bug in the code: {detailed_error_info}.
First, study the error message and point out the problem.
Then, fix the bug and return the codes in the following format:
```python
def transform(input_df):
    output_df = pd.DataFrame()
    ...
    return output_df
```"""
        messages.append({"role": "user", "content": error_message})

        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        python_code = extract_python_code(response['choices'][0]['message']['content'])
        messages.append(response['choices'][0]['message'])
    
    for message in messages:
        print(message['content'])
        print("---------------------")

    raise Exception("The code is not correct. Please try again.")


def escape_json_string(s):
    s = s.replace("\\", "\\\\")

    s = s.replace("\\\\n", "\\n")
    s = s.replace("\\\\\"", "\\\"")

    return s

def load_template(filename, use_template=True, **kwargs):
    with open(filename, 'r') as file:
        template = file.read()
        if use_template:
            return eval(template, {}, kwargs)
        else:
            return template

def process_dataframe(df, instruction_name, **kwargs):
    message = {
        "role": "user",
        "content": load_template(instruction_name, **kwargs) + 
                   load_template('python_template.txt', use_template=False)
    }
    write_log(message['content'])
    write_log("-----------------------------------")
    
    messages_history = [message]

    max_turns = 10

    while len(messages_history) < max_turns:
        
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)


        assistant_message = response['choices'][0]['message']
        messages_history.append(assistant_message)
        write_log(assistant_message['content'])
        write_log("-----------------------------------")

        processed_string = escape_json_string(assistant_message["content"])
        action_content = json.loads(processed_string)
        action_name = action_content["Action"]["Name"]
        
        if action_name == "Code":
            eda_code = action_content["Action"]["Content"]
            
            exec(eda_code, globals())
            eda_result = code(df)
            
            eda_message = {
                "role": "user",
                "content": f"The EDA codes run successfully:\n\n{eda_result}\n\nPlease keep respond in the required format"
            }
            messages_history.append(eda_message)
            write_log(eda_message['content'])
            write_log("-----------------------------------")

        elif action_name == "Decide":
            continue

        elif action_name == "Conclude":
            return messages_history
        
        else:
            raise Exception("Unknown action")


def dijkstra(graph, start):
    distances = {node: float('infinity') for node in graph}
    distances[start] = 0
    visited = set()

    priority_queue = [(0, start)]

    while priority_queue:
        current_distance, current_node = heapq.heappop(priority_queue)

        if current_node in visited:
            continue

        visited.add(current_node)

        for neighbor, weight in graph[current_node].items():
            distance = current_distance + weight

            if distance < distances[neighbor]:
                distances[neighbor] = distance
                heapq.heappush(priority_queue, (distance, neighbor))

    return distances

def prim(graph):
    min_spanning_tree = []
    visited = set()

    start_node = next(iter(graph))
    visited.add(start_node)

    edge_heap = [(weight, start_node, neighbor) for neighbor, weight in graph[start_node].items()]
    heapq.heapify(edge_heap)

    while edge_heap:
        weight, current_node, neighbor = heapq.heappop(edge_heap)

        if neighbor in visited:
            continue

        min_spanning_tree.append((current_node, neighbor, weight))

        visited.add(neighbor)

        for next_neighbor, next_weight in graph[neighbor].items():
            if next_neighbor not in visited:
                heapq.heappush(edge_heap, (next_weight, neighbor, next_neighbor))

    return min_spanning_tree

def build_kmp_table(pattern):
    m = len(pattern)
    kmp_table = [0] * m
    j = 0

    for i in range(1, m):
        while j > 0 and pattern[i] != pattern[j]:
            j = kmp_table[j - 1]

        if pattern[i] == pattern[j]:
            j += 1

        kmp_table[i] = j

    return kmp_table

def kmp_search(text, pattern):
    n = len(text)
    m = len(pattern)
    kmp_table = build_kmp_table(pattern)
    matches = []

    i, j = 0, 0
    while i < n:
        if pattern[j] == text[i]:
            i += 1
            j += 1

            if j == m:
                matches.append(i - j)
                j = kmp_table[j - 1]
        else:
            if j != 0:
                j = kmp_table[j - 1]
            else:
                i += 1

    return matches


def read_csv_with_common_encodings(file_path, sep = ","):
    common_encodings = ['utf-8', 'ISO-8859-1', 'cp1252', 'latin1', 'ascii', 'utf-16']

    for encoding in common_encodings:
        try:
            return encoding, pd.read_csv(file_path, encoding=encoding, sep=sep)
        except UnicodeDecodeError:
            continue

    with open(file_path, 'rb') as file:
        sample = file.read()
    detected_encoding = chardet.detect(sample)['encoding']

    try:
        return detected_encoding, pd.read_csv(file_path, encoding=detected_encoding, sep=sep)
    except Exception as e:
        raise e

def detect_separator(filename, potential_separators=[',', '\t', ';', '|', ' '], max_lines=100):
    separator_scores = {sep: 0 for sep in potential_separators}

    with open(filename, 'r') as file:
        for _ in range(max_lines):
            line = file.readline()
            if not line:
                break

            for sep in potential_separators:
                fields = re.split(r'(?<!")' + re.escape(sep) + r'(?!")', line)
                
                if len(fields) > 1:
                    separator_scores[sep] += len(fields) - 1

    likely_separator = max(separator_scores, key=separator_scores.get)
    return likely_separator if separator_scores[likely_separator] > 0 else None


def read_csv_file_advanced(file_path, default_sep=',', default_encoding='utf-8'):

    try:
        df = pd.read_csv(file_path, sep=default_sep, encoding=default_encoding)
        return default_sep, default_encoding, df

    except pd.errors.ParserError:
        sep = detect_separator(file_path)
        try:
            df = pd.read_csv(file_path, sep=sep, encoding=default_encoding)
            return sep, default_encoding, df
        except UnicodeDecodeError:
            encoding, df = read_csv_with_common_encodings(file_path, sep)
            return sep, encoding, df

    except UnicodeDecodeError:
        sep = default_sep
        encoding, df = read_csv_with_common_encodings(file_path, sep)
        return sep, encoding, df

def read_data(data, document_path=None, viewer=None):

    if isinstance(data, gpd.GeoDataFrame):
        document_data = ShapeData(gdf=data)
        return document_data

    if isinstance(data, pd.DataFrame):
        document_data = DocumentedData(df=data)
        if document_path is not None:
            document_data.read_document_from_disk(document_path, viewer = viewer)
        else:
            document_data.start(viewer = viewer)
        return document_data
    
    
    if isinstance(data, str) and data.endswith('.csv'):
        document_data = DocumentedData(file_path=data)
        if document_path is not None:
            document_data.read_document_from_disk(document_path, viewer = viewer)
        else:
            document_data.start(viewer = viewer)
        return document_data

    if isinstance(data, str) and data.endswith('.tif'):
        document_data = ShapeData(raster_path=data)
        return document_data

    if isinstance(data, str) and (data.endswith('.xlsx') or data.endswith('.xls')):
        xlsx = pd.ExcelFile(data)

        sheet_names = xlsx.sheet_names

        if len(sheet_names) > 1:
            print(f"⚠️ Excel file {data} has more than 1 sheet. Please select one:")

            def display_sheet(sheet_name):
                print(f"Selected sheet: {sheet_name}")

            sheet_dropdown = widgets.Dropdown(
                options=sheet_names,
                description='Sheet:',
                disabled=False,
            )

            document_data = DocumentedData(dummy=True)

            button = widgets.Button(description="Next")

            def on_button_clicked(b):
                clear_output(wait=True)
                sheet_name = sheet_dropdown.value

                print("Selected sheet: " + sheet_name)
                print("Reading the sheet... Please wait...")

                document_data.__init__(file_path=data, sheet_name=sheet_name)
                if document_path is not None:
                    document_data.read_document_from_disk(document_path, viewer = viewer)
                else:
                    document_data.start()
                return document_data
                
            button.on_click(on_button_clicked)

            display(sheet_dropdown, button)

            return document_data

        else:
            sheet_name = sheet_names[0]
            document_data = DocumentedData(file_path=data, sheet_name=sheet_name)
            if document_path is not None:
                document_data.read_document_from_disk(document_path, viewer = viewer)
            else:
                document_data.start()
            return document_data

    


class DocumentedData:
    def __init__(self, file_path=None, df=None, table_name = None,
                 log_file_path='data_log.txt', display_html=True,
                 sheet_name=None, dummy=False):

        if dummy:
            return

        if file_path is not None and isinstance(file_path, pd.DataFrame):
            df = file_path
            file_path = None

        if file_path is not None:

            if file_path.endswith('.csv'):
            
                sep, encoding, df = read_csv_file_advanced(file_path)

                self.sep = sep
                self.encoding = encoding
                self.file_path = file_path

                if table_name is None:
                    self.table_name = os.path.basename(file_path).split('.')[0]
                else:
                    self.table_name = table_name
                self.original_df = lightweight_copy(df)
                self.df = df
            
            elif file_path.endswith('.xlsx') or file_path.endswith('.xls'):
                xlsx = pd.ExcelFile(file_path)

                sheet_names = xlsx.sheet_names

                if len(sheet_names) > 1 and sheet_name is None:

                    raise ValueError(f"Excel file {file_path} has more than 1 sheet. Please pass in the sheet_name from {sheet_names}.")


                if sheet_name is not None and sheet_name not in sheet_names:
                    raise ValueError(f"Sheet name {sheet_name} is not in the sheet names {sheet_names}.")

                if sheet_name is None and len(sheet_names) == 1:
                    sheet_name = sheet_names[0]

                self.file_path = file_path
                self.sheet_name = sheet_name

                if table_name is None:
                    self.table_name = os.path.basename(file_path).split('.')[0]
                else:
                    self.table_name = table_name
                
                self.table_name += f"-{sheet_name}"

                df = pd.read_excel(file_path, sheet_name=sheet_name)
                self.original_df = lightweight_copy(df)
                self.df = df

            else:
                raise ValueError(f"Only csv and excel files are supported. {file_path} is not supported.")

        elif df is not None:
            if not isinstance(df, pd.DataFrame):
                raise ValueError("Input must be a pandas DataFrame.")
            
            self.table_name = table_name
            self.original_df = df.copy()
            self.df = df
        
        else:
            raise ValueError("Either path or df must be provided.")

        self.document = {}
        self.stats = collect_df_statistics(self)

        idx = 1
        column_desc = ""
        for col in df.columns:
            column_desc += f"{idx}. " + describe_column(self.stats, col) + "\n"
            idx += 1

        self.column_description = column_desc

        self.log_file_path = log_file_path

        self.display_html = display_html
        self.viewer = None

        source = SourceStep(self)
        
        self.pipeline = TransformationPipeline(steps = [source], edges=[])

        self.rename_step_finished = False
        self.drop_duplicated_row_step_finished = False
        self.drop_duplicated_colulmn_step_finished = False
        self.drop_all_missing_columns_step_finished = False
        self.drop_x_y_columns_step_finished = False
        self.drop_index_column_step_finished = False
        self.project_step_finished = False
        self.remove_data_type_step_finished = False

        self.rename_table = True

    def get_summary(self):
        return self.document["table_summary"]["summary"]

    def transform(self):
        if not hasattr(self, 'cleaner'):
            self.cleaner = DataCleaning(self)
        self.cleaner.display()
    
    def get_cleaner(self):
        if not hasattr(self, 'cleaner'):
            self.cleaner = GeoDataCleaning(self)
        return self.cleaner

    def get_df(self):
        if hasattr(self, 'cleaner'):
            return self.cleaner.run_codes()
        
        return self.pipeline.run_codes()

    def describe_missing_values(self,threshold=50):
        description = ""
        first = True
        for col_name in self.df.columns:
            if self.stats[col_name]['null_percentage'] > threshold:
                if first:
                    description += "Percentage of missing values:\n"
                    first = False
                description +=  f"{col_name}: {self.stats[col_name]['null_percentage']}%\n"
        if first:
            description += "None of the columns have missing values."
        return description

    def complete(self):
        clear_output(wait=True)
        print(f"""Congratulation! The document is complete. 🎉

{BOLD}What's next?{END}
1. Use Cleaner 🧹 to clean the data.
2. Use Standardizer 📏 to standardize the data.
3. Use Transformer 🔌 to transform the data.      
...

And more to come! 🚀""")
        self.save_file()

    def write_log(self, message: str):
        self.log_file = open(self.log_file_path, 'a')
        self.log_file.write(message + '\n')
        self.log_file.close()

    def start(self, viewer=None):
        self.viewer = viewer
        self.check_document_exists()

    def check_document_exists(self):

        next_step = self.start_document

        if self.table_name is not None:
            data_name = self.table_name

            file_name = f"{data_name}_cocoon_data.json".replace(" ", "_")

            if os.path.exists(file_name):
                print(f"🤔 There is a document file ./{file_name} Do you want to load it?")


                yes_button = widgets.Button(description="Yes")
                no_button = widgets.Button(description="No")

                def on_yes(b):
                    clear_output(wait=True)
                    self.read_document_from_disk(file_name, viewer = None)

                def on_no(b):
                    clear_output(wait=True)
                    next_step()

                yes_button.on_click(on_yes)
                no_button.on_click(on_no)

                display(HBox([yes_button, no_button]))

                if self.viewer:
                    on_yes(yes_button)

            
            else:
                next_step()

        else:
            next_step()

    


    def start_document(self, viewer=None):
        next_step = self.decide_project
        
        if viewer is not None:
            self.viewer = viewer
        
        if self.viewer is  None:
            mode_selector = widgets.RadioButtons(
                options=[
                    ('Table Viewer 👀: I’m not familiar with the table. Please provide your best guess.', 'Table Viewer'),
                    ('Table Provider 🧐: I am ready to provide detailed information about the table.', 'Table Provider')
                ],
                description='Documentation Mode:',
                layout={'width': 'max-content'},
                style={'description_width': 'initial'}
            )


            submit_button = widgets.Button(description="Submit")

            def on_submit(b):
                selected_mode = mode_selector.value
                if selected_mode == 'Table Viewer':
                    self.viewer = True
                else:
                    self.viewer = False

                clear_output(wait=True)

                if selected_mode == 'Table Viewer':
                    print("We got it. Sit back and grab a coffee. It will be done in 10-20 minutes. ☕")
                next_step()


            submit_button.on_click(on_submit)

            display(mode_selector, submit_button)

        else:
            next_step()

    def save_as_html(self, file_path=None):
        if file_path is None:
            if self.table_name is not None:
                data_name = self.table_name
            else:
                data_name = self.document['main_entity']['summary']
            file_path = f"{data_name}_cocoon_doc.html".replace(" ", "_")

        html_content = self.generate_html()
        with open(file_path, 'w') as file:
            file.write(html_content)

    def generate_visualizations_html(self):

        json_var = self.document["visualization"]["summary"] 

        histogram_imgs, map_imgs = image_json_to_base64(json_var, self.df)

        html = "" 

        for img in histogram_imgs:
            if img is not None:
                html += f"""<img src="data:image/png;base64,{img}" width="300" height="150">"""

        html += "<br>"

        for img in map_imgs:
            if img is not None:
                html += f"""<img src="data:image/png;base64,{img}" width="400" height="200">"""

        return html

    def generate_html(self):
        middle_html = self.generate_html_source()
        full_html = f"""<!DOCTYPE html>
<html>
<head>
    <title>Cocoon Documentation</title>
    <style>
    /* CSS for the overall appearance: fonts, spacing, etc. */
    body {{
        font-family: "Arial";
        margin: 40px;
        background-color: #d9ead3;  /* Matching the light green background of the icon */
    }}

    .container {{
        max-width: 900px;  /* Setting a maximum width for the content */
        margin: 0 auto;   /* Centering the container */
        background-color: #ffffff; /* White background for the main content */
        padding: 20px;
        border-radius: 5px; /* Rounded corners */
        box-shadow: 0 0 10px rgba(0,0,0,0.1); /* A subtle shadow to lift the container */
    }}

    h1 {{
        font-size: 24px;
        color: #274e13; /* Dark green color matching the icon */
        padding-bottom: 10px;
        margin-bottom: 20px;
    }}

    h2 {{
        font-size: 20px;
        margin-top: 20px;
        margin-bottom: 15px;
    }}

    ul, ol {{
        padding-left: 20px;
    }}

    li {{
        margin-bottom: 10px;    }}

    p {{        margin-bottom: 20px;
        text-align: justify; /* To align the text on both sides */
    }}

    /* CSS specific to the table elements */
    table {{
        font-family: Arial, sans-serif;
        border-collapse: collapse; /* Ensures there are no double borders */
        width: 100%;
        table-layout: auto;
    }}

    th, td {{
        border: 1px solid #dddddd; /* Light grey borders */
        text-align: left;
        padding: 8px; /* Make text not touch the borders */
    }}

    th {{
        background-color: #b6d7a8; /* Light green background matching the icon */
    }}

    tr:nth-child(even) {{
        background-color: #d9ead3; /* Light green background matching the icon */
    }}

    tr:hover {{
        background-color: #c9d9b3; /* A slightly darker green for hover effect */
    }}
    </style>
</head>
<body>
    <div class="container">
        {middle_html}
    </div>
</body>
</html>"""
        return full_html

    def generate_html_source(self):
        html_content_updated = f'<div style="display: flex; align-items: center;">' \
                    f'<img src="data:image/png;base64,{cocoon_icon_64}" alt="cocoon icon" width=50 style="margin-right: 10px;">' \
                    f'<div style="margin: 0; padding: 0;">' \
                    f'<h1 style="margin: 0; padding: 0;">Table Documentation</h1>' \
                    f'<p style="margin: 0; padding: 0;">Powered by cocoon</p>' \
                    f'</div>' \
                    f'</div><hr>'

        html_content_updated += '<h2>🤓 Table Sample (first 5 rows):</h2>'
        html_content_updated += wrap_in_scrollable_div(self.df[:5].to_html(), width='800')
        html_content_updated += '<hr>'

        sanity_html = generate_html_for_sanity_check(self.document)
        if sanity_html != "":
            html_content_updated += f'<h2>🔍 Sanity Check</h2>'
            html_content_updated += sanity_html


        if "main_entity" in self.document and "column_grouping" in self.document:
            main_entity = self.document['main_entity']['summary']
            reason = self.document['table_summary']['summary']
            reason = replace_asterisks_with_tags(reason)
            html_content_updated += '<h2>📝 Table Summary:</h2>'
            html_content_updated += f'<b>💡 The table is mainly about: </b>{main_entity}<br><br>'
            html_content_updated += f'<b>Details</b>: {reason}<br>'
            html_content_updated += '<br><b>🌳 Attribute Hierarchy</b><br>'

            group_data = self.document['column_grouping']['summary']
            tree_html, _, = get_tree_html(group_data) 
            html_content_updated += wrap_in_iframe(tree_html)
            html_content_updated += '<hr>'

        if "visualization" in self.document:
            html_content_updated += '<h2>📊 Visualizations</h2>'
            html_content_updated += self.generate_visualizations_html()
            html_content_updated += '<hr>'

        if "missing_value" in self.document:
            if any(self.df.isnull().mean() > 0):
                html_content_updated += f'<h2>❓ Missing Values </h2>'
                html_content_updated += plot_missing_values_html(self.df)
                html_content_updated += '<br>'
                html_content_updated += self.generate_missing_values_report()
                html_content_updated += '<hr>'

        if "unusual" in self.document:
            exist_unusual = False

            for key in self.document['unusual']:
                value = self.document['unusual'][key]['summary']['Unusualness']
                if value:
                    exist_unusual = True
                    break
            
            if exist_unusual:
                html_content_updated +=f'<h2>🤔 Unusual Values </h2>'
                html_content_updated += self.generate_unusual_values_report()
                html_content_updated += '<hr>'

        if "recommend_testing" in self.document:
            html_content_updated += f'<h2>🧪 Testing</h2>'
            json_code = self.document["recommend_testing"]
            error_count = 0
            table_name = self.get_table_name()

            duckdb_conn = duckdb.connect()
            duckdb_conn.register(table_name, self.df)

            for test in json_code:
                html_content_updated += "<h3>Test: " + test['name'] + "</h3>"
                html_content_updated += "<p>" + test['reasoning'] + "</p>"
                
                highlighted_html = highlight(test['sql'], SqlLexer(), HtmlFormatter())
                html_content_updated += highlighted_html

                try:
                    sql = sql_cleaner(test['sql'])
                    result_df = duckdb_conn.execute(sql).df()
                    if len(result_df) == 0:
                        html_content_updated += "<span style='color: green;'>✅ The test passed.</span>"
                    else:
                        html_content_updated += "<span style='color: red;'>❌ The test failed. Below are the sample 4 rows that failed the test.</span>"
                        html_content_updated += wrap_in_scrollable_div(truncate_html_td(result_df[:4].to_html()))
                        error_count += 1

                except Exception as e:
                    html_content_updated += "<span style='color: red;'>❌ The test failed. Below is the error message.</span>"
                    html_content_updated += "<p>" + str(e) + "</p>"
                    error_count += 1

                html_content_updated += "<hr>"

        return html_content_updated

    def display_document(self):
        currnet_seq = 1

        html_content_updated = f'<div style="display: flex; align-items: center;">' \
                    f'<img src="data:image/png;base64,{cocoon_icon_64}" alt="cocoon icon" width=50 style="margin-right: 10px;">' \
                    f'<div style="margin: 0; padding: 0;">' \
                    f'<h1 style="margin: 0; padding: 0;">Table Documentation</h1>' \
                    f'<p style="margin: 0; padding: 0;">Powered by cocoon</p>' \
                    f'</div>' \
                    f'</div><hr>'

        html_content_updated += '<h2>🤓 Table Sample (first 5 rows):</h2>'
        display(HTML(html_content_updated))
        display(self.df.head())
        display(HTML('<hr>'))
        
        tab_data = []


        sanity_html = generate_html_for_sanity_check(self.document)
        if sanity_html != "":
            tab_data.append(("🔍 Sanity", 0, sanity_html))

        if "main_entity" in self.document and "table_summary" in self.document and "column_grouping" in self.document:
            main_entity = self.document['main_entity']['summary']
            reason = self.document['table_summary']['summary']
            reason = replace_asterisks_with_tags(reason)
            html_content_updated = f'<b>💡 The table is mainly about: </b>{main_entity}<br><br>'
            html_content_updated += f'<b>Details</b>: {reason}<br>'
            html_content_updated += '<br><b>🌳 Attribute Hierarchy</b><br>'

            group_data = self.document['column_grouping']['summary']
            tree_html, _, = get_tree_html(group_data) 
            html_content_updated += wrap_in_iframe(tree_html)

            tab_data.append(("📝 Summary", 0, html_content_updated))

        if "visualization" in self.document:
            html_content_updated = self.generate_visualizations_html()
            tab_data.append(("📊 Viz", 0, html_content_updated))

        if "missing_value" in self.document:

            num_cols_with_missing = sum(self.df.isnull().mean() > 0)

            if num_cols_with_missing > 0:
                html_content_updated = plot_missing_values_html(self.df)
                html_content_updated += '<br>'
                html_content_updated += self.generate_missing_values_report()

                tab_data.append(("❓ Missing", num_cols_with_missing, html_content_updated))

        if "unusual" in self.document:
            number_of_unusual_columns = 0

            for key in self.document['unusual']:
                value = self.document['unusual'][key]['summary']['Unusualness']
                if value:
                    number_of_unusual_columns += 1
            
            if number_of_unusual_columns > 0:
                html_content_updated = self.generate_unusual_values_report()
                html_content_updated += '<hr>'
                tab_data.append(("🤔 Unusual", number_of_unusual_columns, html_content_updated))
        
        if "recommend_testing" in self.document:
            json_code = self.document["recommend_testing"]
            html_output = ""
            error_count = 0
            table_name = self.get_table_name()

            duckdb_conn = duckdb.connect()
            duckdb_conn.register(table_name, self.df)

            for test in json_code:
                html_output += "<h3>Test: " + test['name'] + "</h3>"
                html_output += "<p>" + test['reasoning'] + "</p>"
                
                highlighted_html = highlight(test['sql'], SqlLexer(), HtmlFormatter())
                html_output += highlighted_html

                try:
                    sql = sql_cleaner(test['sql'])
                    result_df = duckdb_conn.execute(sql).df()
                    if len(result_df) == 0:
                        html_output += "<span style='color: green;'>✅ The test passed.</span>"
                    else:
                        html_output += "<span style='color: red;'>❌ The test failed. Below are the sample 4 rows that failed the test.</span>"
                        html_output += result_df[:4].to_html()
                        error_count += 1

                except Exception as e:
                    html_output += "<span style='color: red;'>❌ The test failed. Below is the error message.</span>"
                    html_output += "<p>" + str(e) + "</p>"
                    error_count += 1

                html_output += "<hr>"
            
            tab_data.append(("🧪 Test", error_count, html_output))


        tabs = create_tabs_with_notifications(tab_data)
        display(tabs)

    def generate_html_missing_values_report(self):

        html_output = self.generate_missing_values_report()

        display(HTML(html_output))

    def generate_missing_values_report(self):
        html_output = "<b>Reasons for Missing Values 🤓</b> <br><ul>"
        missing_values_dict = self.document['missing_value']
        for column, details in missing_values_dict.items():
            
            if 'summary' in details:
                html_output += f"<li><strong>{column}</strong>: "
                html_output += str(details['summary'])
                html_output += "</li>"

        html_output += "</ul>"
        return html_output

    def generate_unusual_values_report(self):
        unusual_values_dict = self.document['unusual']
        html_output = ""
        for column, details in unusual_values_dict.items():
            
            if details['summary']['Unusualness']:
                html_output += f"<li><strong>{column}</strong>: "
                html_output += str(details['summary']['Examples'])
                html_output += f" <strong>Explanation</strong>: "
                html_output += str(details['summary']['Explanation'])
                html_output += "</li>"

        html_output += "</ul>"
        return html_output


    def generate_html_unusual_values_report(self):
        
        html_output = self.generate_unusual_values_report()
        display(HTML(html_output))

    def plot_missing_values_compact(self):
        """
        This function takes a pandas DataFrame as input and plots a compact bar chart showing
        the percentage of missing values for each column that has missing values.
        """
        df = self.df

        missing_percent = df.isnull().mean() * 100

        missing_percent = missing_percent[missing_percent > 0]
        
        if len(missing_percent) == 0:
            return

        plot_width = max(4, len(missing_percent) * 0.5)

        sns.set(style="whitegrid")    

        plt.figure(figsize=(plot_width, 3), dpi=100)
        bar_plot = sns.barplot(x=missing_percent.index, y=missing_percent, color="lightgreen")

        for index, value in enumerate(missing_percent):
            bar_plot.text(index, value, f'{value:.2f}%', color='black', ha="center", fontsize=8)

        plt.title('Missing Values %', fontsize=8)
        plt.ylabel('%', fontsize=10)
        plt.xticks(rotation=45, fontsize=6)
        plt.yticks(fontsize=8)
        plt.tight_layout()
        plt.show()

    def get_column_warnings(self, col):
        warnings = []
        if "consistency" in self.document:
            if col in self.document["consistency"]:
                summary = self.document["consistency"][col]["summary"]
                if summary["Inconsitencies"] :
                    warnings.append({"type": "Value Consistency", 
                                    "explanation": "There are inconsistent values: " + summary["Examples"],
                                    "solution": ["Proceed with the transformation as is",
                                                "(not implemented) Clean the inconsistent values",]})
        
        if "missing_value" in self.document:
            if col in self.document["missing_value"]:
                if self.document["missing_value"][col]:
                    warnings.append({"type": "Missing Value", 
                                    "explanation": "There are missing values: " + self.document["missing_value"][col]["summary"][0],
                                    "solution": ["Proceed with the transformation as is",
                                                "Remove the rows with missing values",
                                                "(not implemented) Clean the inconsistent values",]})    
        
        if "unusual" in self.document:
            if col in self.document["unusual"]:
                summary  = self.document["unusual"][col]["summary"]
                if summary["Unusualness"]:
                    warnings.append({"type": "Unusual Value",
                                        "explanation": "There are unusual values: " + summary["Examples"],
                                        "solution": ["Proceed with the transformation as is",
                                                    "(not implemented) Clean the unusual values",]})

        return warnings


    def get_table_name(self):
        if self.table_name is None:
            return "table"
        else:
            if not self.table_name[0].isalpha() and self.table_name[0] != "_":
                table_name = "_" + self.table_name
            else:
                table_name = self.table_name

            return sanitize_table_name(table_name)
    
    def get_sample_text(self, sample_cols=None, sample_size=2, col_size=None):
        if sample_cols is None:
            sample_cols = self.df.columns
        table_name = self.get_table_name()
        return describe_df_in_natural_language(self.df[sample_cols], table_name, sample_size, num_cols_to_show=col_size)   

    def get_basic_description(self, sample_size=2, cols = None, sample_cols=None):

        if cols is None:
            cols = self.df.columns

        table_sample = self.get_sample_text(sample_cols=sample_cols, sample_size=sample_size)
        
        column_desc = ""

        idx=1
        for col in cols:
            column_desc += f"{idx}. " + describe_column(self.stats, col) + "\n"
            idx += 1

        result = table_sample
        if len(cols) > 0:
            result += "\n\nColumn details:\n" + column_desc

        return result

    def show_progress(self, max_value):
        progress = widgets.IntProgress(
            value=1,
            min=0,
            max=max_value+1,  
            step=1,
            description='',
            bar_style='',
            orientation='horizontal'
        )
        
        display(progress)
        return progress

    def display_tree(self, data):

        if self.display_html:
            html_content_updated, _, height = get_tree_html(data)

            display_html_iframe(html_content_updated, height=f"{height}px")
        else:

            import plotly.graph_objects as go

            def extract_hierarchy(data, parent_name='', hierarchy=None):
                if hierarchy is None:
                    hierarchy = {'names': [], 'parents': []}
                
                for name, children in data.items():
                    hierarchy['names'].append(name)
                    hierarchy['parents'].append(parent_name)
                    if isinstance(children, dict):
                        extract_hierarchy(children, parent_name=name, hierarchy=hierarchy)
                    elif isinstance(children, list):
                        for child in children:
                            hierarchy['names'].append(child)
                            hierarchy['parents'].append(name)
                return hierarchy

            hierarchy = extract_hierarchy(data)

            ids = list(range(1, len(hierarchy['names']) + 1))
            name_to_id = {name: id for id, name in zip(ids, hierarchy['names'])}
            parent_ids = [name_to_id[parent] if parent in name_to_id else '' for parent in hierarchy['parents']]

            fig = go.Figure(go.Treemap(
                ids=ids,
                labels=hierarchy['names'],
                parents=parent_ids
            ))

            fig.update_layout(width=600, height=400, margin = dict(t=0, l=0, r=0, b=0))

            fig.show()

    def get_table_summary(self, overwrite=False, once=False):
        next_step = self.get_column_grouping
        if "table_summary" not in self.document:
            self.document["table_summary"] = {}
        else:
            if self.document["table_summary"] and not overwrite:
                write_log("Warning: table_summary already exists in the document.")
                if not once:
                    next_step()
                return
        print("📝 Generating table summary based on renamed attributes...")

        progress = self.show_progress(1)

        main_entity = self.document["main_entity"]["summary"]
        table_sample = self.get_sample_text()

        max_trials = 3

        while max_trials > 0:
            try:
                summary, messages = get_table_summary(main_entity, table_sample)
                progress.value += 1

                for message in messages:
                    write_log(message['content'])
                    write_log("-----------------------------------")

                table_columns = self.df.columns.to_list()



                def extract_words_in_asterisks(text):
                    import re

                    pattern = r'\*\*(.*?)\*\*'

                    matches = re.findall(pattern, text)

                    return matches

                def check_sets_equality(list1, list2):
                    if not set(list1) == set(list2):
                        raise ValueError(f"""The two lists do not have the same set of elements.
                List 1: {sorted(list1)} 
                List 2: {sorted(list2)}""")

                def find_extra_columns(text_columns, table_columns):
                    text_columns_set = set(text_columns)
                    table_columns_set = set(table_columns)

                    if text_columns_set.issuperset(table_columns_set):
                        extra_columns = text_columns_set - table_columns_set
                        return list(extra_columns)
                    else:
                        raise ValueError(f"text_columns is not a superset of table_columns. text_columns: {text_columns}, table_columns: {table_columns}")

                def update_summary(summary, extra_columns):
                    for column in extra_columns:
                        summary = summary.replace(f"**{column}**", column)

                    return summary

                text_columns = extract_words_in_asterisks(summary)
                extra_columns = find_extra_columns(text_columns, table_columns)

                if len(extra_columns) > 0:
                    updated_summary = update_summary(summary, extra_columns)
                    write_log(f"Warning: The following columns are not in the table: {extra_columns}")
                    write_log(f"Updated summary: {updated_summary}")
                    write_log("-----------------------------------")
                    summary = updated_summary

                

                break

            except Exception as e:
                write_log(f"Error: {e}")
                write_log("-----------------------------------")
                max_trials -= 1
                if max_trials == 0:
                    raise e
                break
                

        self.document["table_summary"]["summary"] = summary
        if LOG_MESSAGE_HISTORY:
            self.document["table_summary"]["history"] = messages


        html = f"<b>Table Summary</b><br>{replace_asterisks_with_tags(summary)}"
        display(HTML(html))

        def on_button_clicked(b):
            clear_output(wait=True)
            print("Submission received.")
            next_step()

        submit_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='',
            tooltip='Click to submit',
            icon='check'
        )

        submit_button.on_click(on_button_clicked)

        display(submit_button)
        
        if self.viewer:
            on_button_clicked(submit_button)


    def get_visualization(self, overwrite=False, once=False):
        next_step = self.check_missing_all
        if "visualization" not in self.document:
            self.document["visualization"] = {}
        else:
            if self.document["visualization"] and not overwrite:
                write_log("Warning: visualization already exists in the document.")
                if not once:
                    next_step()
                return
        create_progress_bar_with_numbers(1, doc_steps)
        print("📊 Generating visualization...")

        progress = self.show_progress(1)

        table_summary = self.document["table_summary"]["summary"]

        max_trials = 3

        while max_trials > 0:
            try:
                json_var, messages = generate_visualization_recommendation(table_summary)
                
                for message in messages:
                    write_log(message['content'])
                    write_log("-----------------------------------")

                def verify_json(json_var, columns):
                    to_remove_indices = []

                    for index, item in enumerate(json_var):
                        if item["name"] not in ["Histogram", "Map"]:
                            to_remove_indices.append(index)
                            continue

                        if item["name"] == "Histogram":
                            if item["params"] not in columns:
                                to_remove_indices.append(index)
                        elif item["name"] == "Map":
                            if any(param not in columns for param in item["params"]):
                                to_remove_indices.append(index)

                    for index in reversed(to_remove_indices):
                        del json_var[index]

                    return json_var

                json_var = verify_json(json_var, self.df.columns)

                break
            
            except Exception as e:
                write_log(f"Error: {e}")
                write_log("-----------------------------------")
                max_trials -= 1
                if max_trials == 0:
                    raise e
                continue

        progress.value += 1

        self.document["visualization"]["summary"] = json_var
        if LOG_MESSAGE_HISTORY:
            self.document["visualization"]["history"] = messages

        html = self.generate_visualizations_html()

        display(HTML(html))

        def on_button_clicked(b):
            clear_output(wait=True)
            print("Submission received.")
            next_step()

        submit_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='',
            tooltip='Click to submit',
            icon='check'
        )

        submit_button.on_click(on_button_clicked)

        display(submit_button)

        if self.viewer:
            on_button_clicked(submit_button)


    def get_column_grouping(self, overwrite=False, once=False):
        next_step = self.get_visualization
        if "column_grouping" not in self.document:
            self.document["column_grouping"] = {}
        else:
            if self.document["column_grouping"] and not overwrite:
                write_log("Warning: column_grouping already exists in the document.")
                if not once:
                    next_step()
                return
        create_progress_bar_with_numbers(1, doc_steps)
        print("🌳 Building concept map...")

        progress = self.show_progress(1)

        meanings = self.document["column_meaning"]["summary"]

        column_meanings = '\n'.join([f"- {m['column']}: {m['meaning']}" for m in meanings])

        main_entity = self.document["main_entity"]["summary"]

        sample = self.get_sample_text()





        template = f"""{sample}

{column_meanings}

This table is about {main_entity}. The goal is to build a mind map. 

Recursively group the attributes based on inherent entity association, not conceptual similarity.
    E.g., for [student name, student grade, teacher grade], group by student and teacher, not by name.
Avoid groups with too many/few subgroups. 

Conclude with the final result as a multi-level JSON. Make sure all attributes are included.

```json
{{
    "{main_entity}":
        {{
        "Sub group": {{
        "sub-sub group": ["attribute1", "attribute2", ...],
        }},
    }}
}}
```"""
        
        def extract_attributes(json_var):
            attributes = []
            
            def traverse(element):
                if isinstance(element, dict):
                    for value in element.values():
                        traverse(value)
                        
                elif isinstance(element, list):
                    for item in element:
                        if isinstance(item, str):
                            attributes.append(item)
                        
                        else:
                            traverse(item)
                            

            traverse(json_var)
            
            return attributes

        def validate_attributes(attributes, reference_attributes):
            error_messages = []

            seen_attributes = set()
            duplicates = set()
            for attribute in attributes:
                if attribute in seen_attributes:
                    duplicates.add(attribute)
                seen_attributes.add(attribute)
            
            if duplicates:
                error_messages.append("Duplicate attributes: " + ', '.join(duplicates))

            attributes_set = set(attributes)
            reference_set = set(reference_attributes)

            extra_attributes = attributes_set - reference_set
            if extra_attributes:
                error_messages.append("Extra attributes: " + ', '.join(extra_attributes))

            missing_attributes = reference_set - attributes_set
            if missing_attributes:
                error_messages.append("Missing attributes: " + ', '.join(missing_attributes) + "\n Are attributes in the leaf as an array [att1, att2]?")

            return '\n'.join(error_messages)

        

        def build_concept_map_and_verify(messages):
            
            number_of_trials = 3

            for messgae in messages:
                write_log(messgae['content'])
                write_log("-----------------------------------")

            while number_of_trials > 0:
                response = call_llm_chat(messages, temperature=0.1, top_p=0.1)
                
                write_log(response['choices'][0]['message']['content'])
                write_log("-----------------------------------")

                assistant_message = response['choices'][0]['message']
                json_code = extract_json_code_safe(assistant_message['content'])
                json_code = json_code.replace('\'', '\"')
                json_var = json.loads(json_code)
                attributes = extract_attributes(json_var)

                messages.append(assistant_message)

                error = validate_attributes(attributes, self.df.columns)

                if error!= '':
                    error_message = {
                        "role": "user",
                        "content": f"{error}\nPlease correct your answer and return the json in the required format."
                    }
                    messages.append(error_message)
                    write_log(error_message['content'])
                    write_log("-----------------------------------")

                    number_of_trials -= 1

                    if number_of_trials == 0:
                        raise Exception(error)
                
                else:
                    self.document["column_grouping"]["summary"] = json_var
                    if LOG_MESSAGE_HISTORY:
                        if "history" not in self.document["column_grouping"]:
                            self.document["column_grouping"]["history"] = messages
                        else:
                            self.document["column_grouping"]["history"] += messages
                    break


        messages =[ {"role": "user", "content": template}]
        build_concept_map_and_verify(messages)
        data = self.document["column_grouping"]["summary"]
        
        

        progress.value += 1
        
        clear_output(wait=True)
        
        self.display_tree(data)

        def create_widgets_for_column_grouping():
            def on_value_change(change):
                if change['new'] == 'No':
                    feedback_container.layout.display = ''
                    text_area.disabled = False
                else:
                    feedback_container.layout.display = 'none'
                    text_area.disabled = True

            accuracy_question_label = widgets.Label(value='Is the mind map accurate?')

            accuracy_check = widgets.RadioButtons(
                options=['Yes', 'No'],
                description='',
                disabled=False
            )

            label = widgets.Label(value='If not accurate, how to fix it?')

            text_area = widgets.Textarea(
                value='',
                placeholder='Type here',
                description='',
                disabled=True
            )

            feedback_container = widgets.VBox([label, text_area], layout=Layout(display='none'))

            submit_button = widgets.Button(
                description='Submit',
                disabled=False,
                button_style='',
                tooltip='Click to submit',
                icon='check'
            )

            accuracy_check.observe(on_value_change, names='value')

            def on_button_clicked(b):
                if accuracy_check.value == 'No':
                    if text_area.value == '':
                        print("\033[91mPlease enter the information\033[0m.")
                        return
                    feedback = text_area.value

                    print("🌳 Refining concept map...")
                    progress = self.show_progress(1)

                    data = self.document["column_grouping"]["summary"]

                    messages =[ {"role": "user", "content": template}]
                    messages.append({"role": "system", "content": "```json\n"+str(data)+"\n```"})
                    messages.append({"role": "user", 
                                    "content": f"""{feedback} Please refine the json and return the result within ```json``` block."""})
                    
                    build_concept_map_and_verify(messages)
                    clear_output(wait=True)
                    data = self.document["column_grouping"]["summary"]
                    self.display_tree(data)
                    accuracy_question = create_widgets_for_column_grouping()
                    display(accuracy_question)
                    
                else:
                    clear_output(wait=True)
                    print("Submission received.")
                    next_step()

            submit_button.on_click(on_button_clicked)

            accuracy_question = widgets.VBox([accuracy_question_label, accuracy_check, feedback_container, submit_button])

            return accuracy_question, on_button_clicked

        accuracy_question, on_button_clicked = create_widgets_for_column_grouping()

        display(accuracy_question)

        if self.viewer:
            on_button_clicked(None)

        
    
    def execute_project(self):
        next_step = self.check_duplicated_rows

        if self.project_step_finished:
            next_step()
            return

        keep_column_indices = self.document["project"]
        remove_column_indices = [i for i in range(len(self.df.columns)) if i not in keep_column_indices]

        if len(remove_column_indices) > 0:
            remove_columns_step = RemoveColumnsStep(sample_df = self.df[:2], col_indices = remove_column_indices, name="Project Columns")
            self.pipeline.add_step_to_final(remove_columns_step)
            self.df = self.pipeline.run_codes()
        
        self.project_step_finished = True
        next_step()

    def execute_drop_x_y_columns(self):
        next_step = self.check_index_columns

        if self.drop_x_y_columns_step_finished:
            next_step()
            return

        remove_column_indices = self.document["x_y_columns"]["remove_columns"]

        if len(remove_column_indices) > 0:
            remove_columns_step = RemoveColumnsStep(sample_df = self.df[:2], col_indices = remove_column_indices, name="Remove _x _y Columns")
            self.pipeline.add_step_to_final(remove_columns_step)
            self.df = self.pipeline.run_codes()
        
        self.drop_x_y_columns_step_finished = True
        next_step()

    def execute_drop_duplicated_columns(self):
        next_step = self.check_x_y_columns

        if self.drop_duplicated_colulmn_step_finished:
            next_step()
            return
        
        remove_column_indices = self.document["duplicate_columns"]["remove_columns"]

        if len(remove_column_indices) > 0:
            remove_columns_step = RemoveColumnsStep(sample_df = self.df[:2], col_indices = remove_column_indices, name="Remove Duplicated Columns") 
            self.pipeline.add_step_to_final(remove_columns_step)
            self.df = self.pipeline.run_codes()
        
        self.drop_duplicated_colulmn_step_finished = True
        next_step()

    def execute_index_columns(self):
        next_step = self.check_data_type

        if self.drop_index_column_step_finished:
            next_step()
            return
        
        index_column_indices = self.document["index_columns"]["remove_columns"]

        if len(index_column_indices) > 0:
            remove_columns_step = RemoveColumnsStep(sample_df = self.df[:2], col_indices = index_column_indices, name="Remove Index Columns")
            self.pipeline.add_step_to_final(remove_columns_step)
            self.df = self.pipeline.run_codes()
        
        self.drop_index_column_step_finished = True
        next_step()

    def execute_drop_all_missing_columns(self):
        next_step = self.check_duplicated_columns

        if self.drop_all_missing_columns_step_finished:
            next_step()
            return

        remove_column_indices = self.document["missing_columns"]["remove_columns"]

        if len(remove_column_indices) > 0:
            remove_columns_step = RemoveColumnsStep(sample_df = self.df[:2], col_indices = remove_column_indices, name="Remove All Missing Columns")
            self.pipeline.add_step_to_final(remove_columns_step)
            self.df = self.pipeline.run_codes()
        
        self.drop_all_missing_columns_step_finished = True
        next_step()

    def execute_deduplicated_rows(self):
        next_step = self.check_all_missing_columns

        if self.drop_duplicated_row_step_finished:
            next_step()
            return
        
        if self.document["duplicate_rows"]["remove_duplicates"]:
            deduplicate_step = RemoveDuplicatesStep(sample_df = self.df[:2])
            self.pipeline.add_step_to_final(deduplicate_step)
            self.df = self.pipeline.run_codes()
        
        self.drop_duplicated_row_step_finished = True
        next_step()

    def execute_remove_data_type(self):
        next_step = self.get_main_entity

        if self.remove_data_type_step_finished:
            next_step()
            return

        column_data_type_dict = {}

        for column_name in self.document["data_type"]:
            data_type = self.document["data_type"][column_name]["data_type"]
            if "invalid_rows" in self.document["data_type"][column_name]:
                column_data_type_dict[column_name] = data_type

        if column_data_type_dict != {}:
            clean_data_type_step = CleanDataType(sample_df = self.df[:2], column_data_type_dict = column_data_type_dict)
            self.pipeline.add_step_to_final(clean_data_type_step)
            self.df = self.pipeline.run_codes()
        
        self.remove_data_type_step_finished = True
        next_step()

        
    def execute_rename_column(self):

        next_step = self.get_table_summary

        if self.rename_step_finished:
            self.stats = collect_df_statistics(self)
            next_step()
            return

        rename_summary = self.document["rename_column"]["summary"]

        self.name_mapping = {}

        if self.rename_table:
            for item in rename_summary:
                if item['rename'] != '':
                    print(f"Renaming column {item['column']} to {item['rename']}")
                    self.name_mapping[item['column']] = item['rename']

        if not self.name_mapping == {}:
            rename_step = ColumnRename(sample_df = self.df[:2], rename_map = self.name_mapping)
            self.pipeline.add_step_to_final(rename_step)
            self.df = self.pipeline.run_codes()

        self.rename_step_finished = True
        




        self.stats = collect_df_statistics(self)


        next_step()

    def generate_pipeline(self):
        return self.pipeline

    def decide_project(self, overwrite=False, once=False):
        
        next_step = self.execute_project

        if "project" not in self.document:
            pass
        else:
            if not overwrite:
                write_log("Warning: project already exists in the document.")
                if not once:
                    next_step()
                return
        
        create_progress_bar_with_numbers(0, doc_steps)

        df = self.df

        df_sample = df[:100]
        display(HTML(wrap_in_scrollable_div(truncate_html_td(df_sample.to_html()))))

        num_cols = len(df.columns)

        display(HTML(f"<p>🧐 There are <b>{num_cols}</b> columns. Please select the columns that you want to keep.</p>"))

        column_names = self.df.columns.to_list()

        def callback_next(selected_indices):
            clear_output(wait=True)
            self.document["project"] = selected_indices
            next_step()

        create_column_selector(column_names, callback_next, default=True)

        if self.viewer:
            callback_next(list(range(num_cols)))
            

    def check_duplicated_rows(self, overwrite=False, once=False):

        next_step = self.execute_deduplicated_rows

        if "duplicate_rows" not in self.document or \
           "duplicated_indices" not in self.document["duplicate_rows"] or\
            "remove_duplicates" not in self.document["duplicate_rows"]:
            self.document["duplicate_rows"] = {}
        else:
            if self.document["duplicate_rows"] and not overwrite:
                write_log("Warning: duplicate_rows already exists in the document.")
                if not once:
                    next_step()
                return
        
        create_progress_bar_with_numbers(0, doc_steps)
        print("🔍 Checking duplicated rows...")
        
        duplicated_indices = find_duplicate_indices(self.df)
        self.document["duplicate_rows"]["duplicated_indices"] = duplicated_indices
        self.document["duplicate_rows"]["num_duplicated_rows"] = len(duplicated_indices)

        if len(duplicated_indices) > 0:
            display_duplicated_rows_html(self.df, duplicated_indices)

            def on_button_clicked(b):
                clear_output(wait=True)
                if b.description == 'Yes':
                    self.document["duplicate_rows"]["remove_duplicates"] = True
                else:
                    self.document["duplicate_rows"]["remove_duplicates"] = False
                next_step()

            yes_button = widgets.Button(
                description='Yes',
                disabled=False,
                button_style='',
                tooltip='Click to submit Yes',
                icon='check'
            )

            no_button = widgets.Button(
                description='No',
                disabled=False,
                button_style='',
                tooltip='Click to submit No',
                icon='times'
            )

            yes_button.on_click(on_button_clicked)
            no_button.on_click(on_button_clicked)

            display(HBox([yes_button, no_button]))

            if self.viewer:
                on_button_clicked(yes_button)


        else:
            self.document["duplicate_rows"]["remove_duplicates"] = False
            next_step()

    def check_index_columns(self, overwrite=False, once=False):
        next_step = self.execute_index_columns

        if "index_columns" not in self.document or\
            "index_column_indices" not in self.document["index_columns"] or \
            "remove_columns" not in self.document["index_columns"]:
            self.document["index_columns"] = {}
        else:
            if self.document["index_columns"] and not overwrite:
                write_log("Warning: index_columns already exists in the document.")
                if not once:
                    next_step()
                return
        
        clear_output(wait=True)
        create_progress_bar_with_numbers(0, doc_steps)
        print("🔍 Checking index columns...")

        index_column_indices = find_default_index_column(self.df)

        self.document["index_columns"]["index_column_indices"] = index_column_indices
        self.document["index_columns"]["index_column_names"] = [self.df.columns[i] for i in index_column_indices]

        if len(index_column_indices) > 0:
            display_index_and_ask_removal(self.df, index_column_indices)

            def callback_next(selected_indices):
                to_remove_indices = [index_column_indices[i] for i in selected_indices]

                self.document["index_columns"]["remove_columns"] = to_remove_indices
                next_step()

            create_column_selector(self.df.columns.to_list(), callback_next)

            if self.viewer:
                callback_next([])

        else:
            self.document["index_columns"]["remove_columns"] = []
            next_step()



    def check_all_missing_columns(self, overwrite=False, once=False):

        next_step = self.execute_drop_all_missing_columns

        if "missing_columns" not in self.document or\
              "missing_column_indices" not in self.document["missing_columns"] or\
              "remove_columns" not in self.document["missing_columns"]:
            self.document["missing_columns"] = {}
        else:
            if self.document["missing_columns"] and not overwrite:
                write_log("Warning: missing_columns already exists in the document.")
                if not once:
                    next_step()
                return

        clear_output(wait=True)
        create_progress_bar_with_numbers(0, doc_steps)
        print("🔍 Checking columns with all missing values...")
        
        missing_column_indices = columns_with_all_missing_values(self.df)
        self.document["missing_columns"]["missing_column_indices"] = missing_column_indices
        self.document["missing_columns"]["missing_column_names"] = [self.df.columns[i] for i in missing_column_indices]

        if len(missing_column_indices) > 0:
            display_and_ask_removal(self.df, missing_column_indices)

            column_names = self.df.columns.to_list()

            missing_columns = [column_names[i] for i in missing_column_indices]

            def callback_next(selected_indices):
                to_remove_indices = [missing_column_indices[i] for i in selected_indices]
                self.document["missing_columns"]["remove_columns"] = to_remove_indices
                next_step()

            create_column_selector(missing_columns, callback_next)

            if self.viewer:
                callback_next(list(range(len(missing_columns))))
        
        else:
            self.document["missing_columns"]["remove_columns"] = []
            next_step()

    def check_duplicated_columns(self, overwrite=False, once=False):
        next_step = self.execute_drop_duplicated_columns

        if "duplicate_columns" not in self.document or\
            "duplicated_column_indices" not in self.document["duplicate_columns"] or\
            "remove_columns" not in self.document["duplicate_columns"]:
            self.document["duplicate_columns"] = {}
        else:
            if self.document["duplicate_columns"] and not overwrite:
                write_log("Warning: duplicate_columns already exists in the document.")
                if not once:
                    next_step()
                return
                
        clear_output(wait=True)
        create_progress_bar_with_numbers(0, doc_steps)
        print("🔍 Checking duplicated columns...")

        duplicated_column_indices = find_duplicate_column_indices(self.df)

        self.document["duplicate_columns"]["duplicated_column_indices"] = duplicated_column_indices
        self.document["duplicate_columns"]["duplicated_column_names"] = [[self.df.columns[i] for i in group_indices] for group_indices in duplicated_column_indices]

        if len(duplicated_column_indices) > 0:
            display_duplicated_columns_html(self.df, duplicated_column_indices)
            
            column_names = self.df.columns.to_list()

            duplicated_columns = []
            for group_indices in duplicated_column_indices:
                duplicated_columns += [f"{column_names[i]} ({i+1})" for i in group_indices]
            
            def callback_next(selected_indices):
                
                flattened_indices = [item for sublist in duplicated_column_indices for item in sublist]

                to_remove_indices = [flattened_indices[i] for i in selected_indices]

                self.document["duplicate_columns"]["remove_columns"] = to_remove_indices
                next_step()
            
            create_column_selector(duplicated_columns, callback_next)

            if self.viewer:
                callback_next(list(range(len(duplicated_columns))))

        else:
            self.document["duplicate_columns"]["remove_columns"] = []
            next_step()

    def check_x_y_columns(self, overwrite=False, once=False):
        next_step = self.execute_drop_x_y_columns

        if "x_y_columns" not in self.document or \
            "x_y_column_indices" not in self.document["x_y_columns"] or \
            "remove_columns" not in self.document["x_y_columns"]:
            self.document["x_y_columns"] = {}
        else:
            if self.document["x_y_columns"] and not overwrite:
                write_log("Warning: x_y_columns already exists in the document.")
                if not once:
                    next_step()
                return

        clear_output(wait=True)
        create_progress_bar_with_numbers(0, doc_steps)

        print("🔍 Checking x and y columns...")

        x_y_column_indices = find_columns_with_xy_suffix_indices(self.df)

        self.document["x_y_columns"]["x_y_column_indices"] = x_y_column_indices
        self.document["x_y_columns"]["x_y_column_names"] = [[self.df.columns[i] for i in group_indices] for group_indices in x_y_column_indices]

        if len(x_y_column_indices) > 0:
            display_xy_duplicated_columns_html(self.df, x_y_column_indices)

            column_names = self.df.columns.to_list()

            x_y_columns = []

            for group_indices in x_y_column_indices:
                x_y_columns += [column_names[i] for i in group_indices]

            def callback_next(selected_indices):

                flattened_indices = [item for sublist in x_y_column_indices for item in sublist]

                to_remove_indices = [flattened_indices[i] for i in selected_indices]

                self.document["x_y_columns"]["remove_columns"] = to_remove_indices
                next_step()

            create_column_selector(x_y_columns, callback_next)

            if self.viewer:
                callback_next(list(range(len(x_y_columns))))

        else:
            self.document["x_y_columns"]["remove_columns"] = []
            next_step()

    def check_data_type(self, overwrite=False, once=False):
        next_step = self.execute_remove_data_type

        if "data_type" in self.document:
            if self.document["data_type"] and not overwrite:
                write_log("Warning: data_type already exists in the document.")
                if not once:
                    next_step()
                return


        clear_output(wait=True)
        
        clear_output(wait=True)
        create_progress_bar_with_numbers(0, doc_steps)
        print("🔍 Checking data types...")

        table_name = self.get_table_name()

        duckdb_conn = duckdb.connect()
        duckdb_conn.register(table_name, self.df)

        schema_query = f"PRAGMA table_info('{table_name}')"
        schema_info = duckdb_conn.execute(schema_query).df()

        self.document["data_type"] = {}

        has_invalid_data_type = False

        df = self.df

        for index, row in schema_info.iterrows():
            column_name = row['name']
            data_type = row['type'].upper()

            

            mask = select_invalid_data_type(df, column_name, data_type)
            
            self.document["data_type"][column_name] = {"data_type": data_type}

            if mask.any():
                print(f"{BOLD}Column '{column_name}'{END} is of type {ITALIC}{data_type}{END}.")


                example = df[mask][column_name][:5].to_list()
                self.document["data_type"][column_name]["invalid_rows"] = example

                print(f"    ⚠️ There are {mask.sum()} invalid rows that don't match the data type.")
                print(f"    ⚠️ Examples: {example}")

                has_invalid_data_type = True

        if has_invalid_data_type:
            print("⚠️ These invalid rows have to be removed.")
            print("😊 Support for more flexible cleaning is coming soon.")

            def on_button_clicked(b):
                clear_output(wait=True)
                next_step()

            next_button = widgets.Button(
                description='Next',
                disabled=False,
                button_style='',
                tooltip='Click to go to the next step',
                icon='check'
            )

            next_button.on_click(on_button_clicked)

            display(next_button)

            if self.viewer:
                on_button_clicked(next_button)
        
        else:
            next_step()


    def rename_column(self, overwrite=False, once=False):
        next_step = self.execute_rename_column
        if "rename_column" not in self.document:
            self.document["rename_column"] = {}
        else:
            if self.document["rename_column"] and not overwrite:
                write_log("Warning: rename_column already exists in the document.")
                if not once:
                    next_step()
                return
        create_progress_bar_with_numbers(1, doc_steps)
        print("🏷️ Renaming the columns...")
        progress = self.show_progress(1)

        meanings = self.document["column_meaning"]["summary"]

        max_trials = 3

        while max_trials > 0:
            try:
                json_code, messages = get_rename(meanings)
                progress.value += 1
                break
                
            except Exception as e:
                write_log(f"Error: {e}")
                write_log("-----------------------------------")
                max_trials -= 1
                if max_trials == 0:
                    raise e
                continue






        

        self.document["rename_column"]["summary"] = json_code
        if LOG_MESSAGE_HISTORY:
            self.document["rename_column"]["history"] = messages

        next_step()                                    

    def get_column_meaning(self, overwrite=False, once=False):
        next_step = self.rename_column
        if "column_meaning" not in self.document:
            self.document["column_meaning"] = {}
        else:
            if self.document["column_meaning"] and not overwrite:
                write_log("Warning: column_meaning already exists in the document.")
                if not once:
                    next_step()
                return
        create_progress_bar_with_numbers(1, doc_steps)
        print("💡 Understanding the columns...")
        progress = self.show_progress(1)

        main_entity = self.document["main_entity"]["summary"]
        basic_description = self.get_basic_description()






        template = f"""{basic_description}

This table is about {main_entity}. The goal is study the high-level column meaning.
Use short simple words to describe the most possible meanings.
Respond in JSON, for all columns:
```json
[{{
   "column": "column_name",
   "meaning": "short, simple  guess on the meaning"
}},...]
```"""
        
        max_trials = 3

        while max_trials > 0:
            try:
                messages = [{"role": "user", "content": template}]

                response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

                progress.value += 1

                write_log(template)
                write_log("-----------------------------------")
                write_log(response['choices'][0]['message']['content'])
                
                json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
                data = json.loads(json_code)

                messages.append(response['choices'][0]['message'])

                def check_column_complete(data):
                    if len(data) != len(self.df.columns):
                        raise Exception("Not all columns are covered in the column meaning.")

                    for item in data:
                        if item['column'] not in self.df.columns:
                            raise Exception(f"Column {item['column']} does not exist in the table.")
                
                check_column_complete(data)

                self.document["column_meaning"]["summary"] = data
                if LOG_MESSAGE_HISTORY:
                    self.document["column_meaning"]["history"] = messages

                break
            
            except Exception as e:
                write_log(f"Error: {e}")
                write_log("-----------------------------------")
                max_trials -= 1
                if max_trials == 0:
                    raise e
                continue

        clear_output(wait=True)

        def radio_change_handler(change):
            instance = change['owner']
            if instance.value == 'Other':
                instance.text_area.layout.display = ''
            else:
                instance.text_area.layout.display = 'none'

        container = widgets.VBox()

        column_to_radio = {}

        for item in data:
            if 'ambiguous' in item and item['ambiguous']:
                label_text = f"<b>{item['column']}</b>: <span style='color: red;'>(This column has ambiguous interpretations)</span>"
            else:
                label_text = f"<b>{item['column']}</b>:"

            label = widgets.HTML(
                value=label_text, 
                layout=widgets.Layout(margin='0 0 10px 0')
            )
            
            options = [item['meaning']] 
            if 'ambiguous' in item:
                options += item['ambiguous']
            options += ['Other']
            
            radio = widgets.RadioButtons(
                options=options,
                value=item['meaning'],
                layout=widgets.Layout(width='80%', align_items='flex-start')
            )
            
            text_area = widgets.Textarea(
                value='',
                placeholder='Please provide the meaning of the column.',
                description='',
                disabled=False,
                layout=widgets.Layout(display='none', width='100%')
            )
            
            radio.text_area = text_area
            column_to_radio[item['column']] = radio
            radio.observe(radio_change_handler, names='value')
            
            container.children += (label, radio, text_area)

        def submit_callback(btn):
            error_items = []
            
            for item in data:
                radio = column_to_radio[item['column']] 
                if radio.value == 'Other' and not radio.text_area.value.strip():
                    error_items.append(item)
            
            if error_items:
                clear_output(wait=True)
                display(container, submit_btn)
                for item in error_items:
                    print(f"\033[91m{item['column']} meaning can't be empty.\033[0m")
            else:
                clear_output(wait=True)
                feedback_data = []

                for item in data:
                    radio = column_to_radio[item['column']] 
                    
                    if radio.value == 'Other':
                        feedback_data.append({'column': item['column'], 'meaning': radio.text_area.value})
                    else:
                        feedback_data.append({'column': item['column'], 'meaning': radio.value})
                self.document["column_meaning"]["summary"] = feedback_data
                if LOG_MESSAGE_HISTORY:
                    self.document["column_meaning"]["history"].append({"role": "user",
                                                                    "content": feedback_data})
                print("Submission received.")
                next_step()
                                                                          

                        
        submit_btn = widgets.Button(
            description="Submit",
            button_style='',
            tooltip='Submit',
            icon=''
        )

        submit_btn.on_click(submit_callback)

        display(container, submit_btn)

        if self.viewer:
            submit_callback(submit_btn)

    
    def get_main_entity(self, overwrite=False, once=False):

        next_step = self.get_column_meaning
        
        if "main_entity" not in self.document:
            self.document["main_entity"] = {}
        else:
            if self.document["main_entity"] and not overwrite:
                write_log("Warning: main_entity already exists in the document.")
                if not once:
                    next_step()
                return

        create_progress_bar_with_numbers(1, doc_steps)

        print("💡 Understanding the table...")
        progress = self.show_progress(1)

        basic_description = self.get_basic_description()

        template = f"""{basic_description}

Identify the main entity this table is mainly recording. 
-   Entity is tangible or conceptual thing that can exist or be conceptualized individually.
    Example of Entity: Person, Course, Location, Time, School, Job
-   Entity is not property, or aspect. Infer the main underlying entities. 
    Example of Non-entity: Height, Weight, Information, Name, Finance
    For height, the main underlying entity is "People"
-   Entity shall be a clear single phrase. Don't use / to combine entities.

1. Start by reasoning what the table is about, and the candidate main entities.
   If there are multiple candidate main entities, discuss if there is a main relationship entity that can be used to group them.
2. Conclude by listing the main entity. 

Now respond in the following format:
```json
{{
    "reasoning": "The table is about ...",
    "main entity": "..."
}}
```"""

        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        progress.value += 1
        
        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])
        
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)
        main_entity = json_code['main entity']

        messages.append(response['choices'][0]['message'])
        self.document["main_entity"]["summary"] = main_entity
        self.document["main_entity"]["reasoning"] = json_code['reasoning']
        if LOG_MESSAGE_HISTORY:
            self.document["main_entity"]["history"] = messages

        clear_output(wait=True)
        reason = json_code['reasoning']
        print(f'\033[1mThe table is mainly talking about: \033[0m{main_entity}')
        print(f'\033[1mDetails\033[0m: {reason}')

        accuracy_question_label = widgets.Label(value='Is the above information accurate?')

        accuracy_check = widgets.RadioButtons(
            options=['Yes', 'No'],
            description='',
            disabled=False
        )

        label = widgets.Label(value='If not accurate, the table is mainly talking about:')

        text_area = widgets.Textarea(
            value='',
            placeholder='Type here',
            description='',
            disabled=True
        )

        feedback_container = widgets.VBox([label, text_area], layout=Layout(display='none'))

        submit_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='',
            tooltip='Click to submit',
            icon='check'
        )

        def on_button_clicked(b):
            clear_output(wait=True)
            if accuracy_check.value == 'No':
                if text_area.value == '':
                    display(accuracy_question)
                    print("\033[91mPlease enter the information\033[0m.")
                    return
                corrected_entity = text_area.value
                
                print(f"Corrected information received. This table is mainly about {corrected_entity}")
                self.document["main_entity"]["summary"] = corrected_entity
                if LOG_MESSAGE_HISTORY:
                    self.document["main_entity"]["history"].append({"role": "user", 
                                                                "content": template})
            else:
                print("Submission received.")
                next_step()

        def on_value_change(change):
            if change['new'] == 'No':
                feedback_container.layout.display = ''
                text_area.disabled = False
            else:
                feedback_container.layout.display = 'none'
                text_area.disabled = True

        accuracy_check.observe(on_value_change, names='value')

        submit_button.on_click(on_button_clicked)

        accuracy_question = widgets.VBox([accuracy_question_label, accuracy_check, feedback_container, submit_button])

        display(accuracy_question)

        if self.viewer:
            on_button_clicked(submit_button)


    def document_all(self):
        self.get_main_entity()
        self.get_column_grouping()
        self.check_consistency_all()
        self.check_pattern_all()
        self.check_missing_all()
        self.check_unusual_all()

    def check_missing_all(self):
        next_step = self.check_unusual_all

        create_progress_bar_with_numbers(2, doc_steps)
        print("❓ Checking the missing values...")
        progress = self.show_progress(len(self.df.columns))

        for col in self.df.columns:
            self.check_missing(col)

            progress.value += 1

        ambiguous_missing = {}
        
        for col in self.document["missing_value"]:
            if "summary" in self.document["missing_value"][col]:
                summary = self.document["missing_value"][col]["summary"]
                if isinstance(summary, list):
                    ambiguous_missing[col] = summary

        if not ambiguous_missing:
            next_step()
            return

        clear_output(wait=True)
        print("The following columns have missing values: ❓")

        def radio_change_handler(change):
            instance = change['owner']
            if instance.value == 'Other':
                instance.text_area.layout.display = ''
            else:
                instance.text_area.layout.display = 'none'

        container = widgets.VBox()


        col_to_radio = {}

        for item in ambiguous_missing:
            
            label_text = f"<b>{item}</b>"

            label = widgets.HTML(value=label_text)

            reasons = ambiguous_missing[item]
            options = [f"{reason['class']}: {reason['explanation']}" for reason in reasons] + ['Unclear','Other']

            radio = widgets.RadioButtons(
                options=options,
                value=options[0],
                layout=widgets.Layout(width='80%', align_items='flex-start')
            )
            
            text_area = widgets.Textarea(
                value='',
                placeholder='Please provide the reason for missing values.',
                description='',
                disabled=False,
                layout=widgets.Layout(display='none', width='100%')
            )
            
            radio.text_area = text_area
            col_to_radio[item] = radio
            radio.observe(radio_change_handler, names='value')
            
            item_container = widgets.VBox([label, radio, text_area])
            container.children += (item_container,)

        def submit_callback(btn):
            error_items = []
            
            for col in col_to_radio:
                radio = col_to_radio[col]
                if radio.value == 'Other' and not radio.text_area.value.strip():
                    error_items.append(col)
            
            if error_items:
                for col in error_items:
                    print(f"\033[91m{col} reason can't be empty.\033[0m")
            else:
                clear_output(wait=True)

                for col in col_to_radio:
                    radio = col_to_radio[col]
                    
                    if radio.value == 'Other':
                        self.document["missing_value"][col]["summary"] = radio.text_area.value
                        if LOG_MESSAGE_HISTORY:
                            self.document["missing_value"][col]["history"].append({"role": "user",
                                                                                            "content": radio.text_area.value})
                    else:
                        self.document["missing_value"][col]["summary"] = radio.value
                        if LOG_MESSAGE_HISTORY:
                            self.document["missing_value"][col]["history"].append({"role": "user",
                                                                                     "content": radio.value})
                
                print("Submission received.")
                next_step()
                                                                          

                        
        submit_btn = widgets.Button(
            description="Submit",
            button_style='',
            tooltip='Submit',
            icon=''
        )

        submit_btn.on_click(submit_callback)

        display(container, submit_btn)

        if self.viewer:
            submit_callback(submit_btn)

        
        

    def check_missing(self, column: str):
        if column not in self.df.columns:
            raise ValueError(f"Column {column} does not exist in the DataFrame.")
        
        if "missing_value" not in self.document:
            self.document["missing_value"] = {}

        if column not in self.document["missing_value"]:
            self.document["missing_value"][column] = {}
        else:
            if self.document["missing_value"][column]:
                write_log(f"Warning: {column} already exists in the document.")
                return
        
        df_col = self.df[column]

        if isinstance(df_col, pd.DataFrame):
            df_col = df_col.iloc[:, 0]

        nan_rows = self.df[df_col.isna()]
        non_nan_rows = self.df.dropna(subset=[column])

        nan_sample = nan_rows.head(3)
        non_nan_sample = non_nan_rows.head(3)

        if len(nan_sample) == 0:
            write_log(f"Warning: {column} does not have missing values.")
            return

        nan_sample_str = nan_sample.to_string(index=False)
        non_nan_sample_str = ""
        if len(non_nan_sample) > 0:
            non_nan_sample_str = f"Sample of data without missing values:\n{non_nan_sample.to_string(index=False)}"
        else:
            non_nan_sample_str = "The whole column has missing values."

        main_entity = self.document["main_entity"]["summary"]

        template = f"""In a table about {main_entity}, {column} has missing value.

Sample of data with missing values:
{nan_sample_str}

{non_nan_sample_str}

There are general 5 classes of missing values:
    Not Applicable: Certain questions or fields do not apply to the individual/entity being measured. For example, a question about "spouse's occupation" wouldn't apply to someone who is unmarried.
    Censorship: for sensitive attribute, the data can be masked for privacy
    Non-Response: The subject chose not to provide information or ignored the request. This is common in surveys and certain types of observational research.
    Not Collected: Information wasn't gathered due to oversight, resource limitations (e.g., certain tests or measures could not be performed), or it was deemed unnecessary at the time of collection.
    Damaged Data: Information was originally collected but later became unavailable or corrupted due to issues in data storage, transfer, or processing.

Now, please provide the top 3 most likely reasons, order by likelihood (use your common sense to judge), in the following format: 
```json
[{{"class": "The above 5 classes, or Other",
   "explanation": "Short explanation of the reason in 5 words",}}...]
```"""


        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)
        
        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])
        
        messages.append(response['choices'][0]['message'])
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)
        self.document["missing_value"][column]["summary"] = json_code
        if LOG_MESSAGE_HISTORY:
            self.document["missing_value"][column]["history"] = messages

    
    def recommend_testing(self, overwrite=False, once=False):
        next_step = self.complete

        if "recommend_testing" in self.document:
            if self.document["recommend_testing"] and not overwrite:
                write_log("Warning: recommend_testing already exists in the document.")
                if not once:
                    next_step()
                return

        create_progress_bar_with_numbers(3, doc_steps)
        print("🔍 Recommending testing...")
        progress = self.show_progress(1)

        basic_description = self.get_basic_description()
        table_name = self.get_table_name()

        json_code = recommend_testing(basic_description, table_name)
        
        progress.value += 1

        self.document["recommend_testing"] = json_code

        clear_output(wait=True)

        next_step()

    def check_unusual_all(self):
        next_step = self.recommend_testing

        column_meanings = self.document['column_meaning']['summary']
        unusual_columns = {}
        create_progress_bar_with_numbers(3, doc_steps)
        print("🤔 Checking the unusual values...")
        progress = self.show_progress(len(self.df.columns))

        for column_meaning in column_meanings:
            col = column_meaning['column']
            if col in self.name_mapping:
                col = self.name_mapping[col]
            meaning = column_meaning['meaning']

            self.check_unusual(col, meaning)

            result = self.document['unusual'][col]['summary']

            if result['Unusualness'] and 'Explanation' not in result:
                unusual_columns[col] = result

            progress.value += 1

        if not unusual_columns:
            next_step()
            return

        clear_output(wait=True)
        print("The following columns have unusual values. Please provide the explanation as much as possible.")

        def radio_change_handler(change):
            instance = change['owner']
            if instance.value == 'Explanation:':
                instance.text_area.layout.display = ''
            else:
                instance.text_area.layout.display = 'none'

        container = widgets.VBox()


        col_to_radio = {}

        for item in unusual_columns:

            reasons = unusual_columns[item]
            
            label_text = f"<b>{item}</b>: {reasons['Examples']}"

            label = widgets.HTML(value=label_text)

            options = ['Unclear', 'Explanation:']

            radio = widgets.RadioButtons(
                options=options,
                value=options[0],
                layout=widgets.Layout(width='80%', align_items='flex-start')
            )
            
            text_area = widgets.Textarea(
                value='',
                placeholder='Please provide the reason for unusual values.',
                description='',
                disabled=False,
                layout=widgets.Layout(display='none', width='100%')
            )
            
            radio.text_area = text_area
            col_to_radio[item] = radio
            radio.observe(radio_change_handler, names='value')
            
            item_container = widgets.VBox([label, radio, text_area])
            container.children += (item_container,)

        def submit_callback(btn):
            error_items = []
            
            for col in col_to_radio:
                radio = col_to_radio[col]
                if radio.value == 'Explanation:' and not radio.text_area.value.strip():
                    error_items.append(col)
            
            if error_items:
                for col in error_items:
                    print(f"\033[91m{col} explanation can't be empty.\033[0m")
            else:
                clear_output(wait=True)

                for col in col_to_radio:
                    radio = col_to_radio[col]
                    
                    if radio.value == 'Explanation:':
                        self.document["unusual"][col]["summary"]["Explanation"] = radio.text_area.value
                        if LOG_MESSAGE_HISTORY:
                            self.document["unusual"][col]["history"].append({"role": "user",
                                                                                            "content": radio.text_area.value})
                    else:
                        self.document["unusual"][col]["summary"]["Explanation"] = "Unclear"
                
                print("Submission received.")
                next_step()
                                                                          

                        
        submit_btn = widgets.Button(
            description="Submit",
            button_style='',
            tooltip='Submit',
            icon=''
        )

        submit_btn.on_click(submit_callback)

        display(container, submit_btn)

        if self.viewer:
            submit_callback(submit_btn)



    def check_unusual(self, col, meaning):
        if col not in self.df.columns:
            raise ValueError(f"Column {col} does not exist in the DataFrame.")
        
        if "unusual" not in self.document:
            self.document["unusual"] = {}

        if col not in self.document["unusual"]:
            self.document["unusual"][col] = {}
        else:
            if self.document["unusual"][col]:
                write_log(f"Warning: {col} unusual already exists in the document.")
                return

        df_col = self.df[col]

        if isinstance(df_col, pd.DataFrame):
            df_col = df_col.iloc[:, 0]

        unique_values = df_col.dropna().unique()

        values_string = f"The actual data have {len(unique_values)} unique values: "

        def construct_string_with_limit(base_string, values, char_limit):
            final_string = base_string

            included_values = []

            at_least_one = False

            for value in values:
                str_value = f"'{str(value)}'"

                if not at_least_one or len(final_string) + len(str_value) + len(included_values) * len(", ") < char_limit:
                    included_values.append(str_value)
                    at_least_one = True
                else:
                    break

            values_part = ", ".join(included_values)

            if len(included_values) < len(values):
                values_part += "..."

            final_string += values_part

            return final_string

        char_limit = 300
        values_string = construct_string_with_limit(values_string, unique_values, char_limit)



        max_trials = 3

        while max_trials > 0:

            try:

                today = datetime.date.today()

                messages = [{"role": "user", 
                            "content": f"The column '{col}' is about: {meaning}. Guess in 10 words how the values usually look like."}]

                response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

                template = f"""{values_string}

                Review if there are any unusual values. Look out for:
                1. Values too large/small that are inconsistent with the context.
                E.g., age 999 or -5.
                Outlier is fine as long as it falls in a reasonable range, e.g., person age 120 is fine.
                2. Patterns that don't align with the nature of the data.
                E.g., age 10.22
                3. Special characters that don't fit within the real-world domain.
                E.g., age X21b 

                Be careful about date as your knowledge of date is not updated. Today is {today}.

                Follow below step by step:
                1. Summarize the values. Reason if it is unusual or also acceptable.
                2. Conclude with the following dict:

                ```json
                {{
                    "Unusualness": true/false,
                    "Examples": "xxx values are unusual because ..." (empty if not unusual) 
                }}
                ```"""

                messages.append(response['choices'][0]['message'])
                messages.append({"role": "user", 
                "content": template})

                response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

                messages.append(response['choices'][0]['message'])

                for message in messages:  
                    write_log(message['content'])
                    write_log("-----------------------------------")
                
                processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
                json_code = json.loads(processed_string)

                if "Unusualness" not in json_code:
                    raise Exception("Unusualness is not in the json_code")
                
                if json_code["Unusualness"] and "Examples" not in json_code:
                    raise Exception("Unusualness is true but Examples is not in the json_code")

                break

            except Exception as e:
                write_log(f"Error: {e}")
                write_log("-----------------------------------")
                max_trials -= 1
                if max_trials == 0:
                    raise e
                continue


        self.document["unusual"][col]["summary"] = json_code
        if LOG_MESSAGE_HISTORY:
            self.document["unusual"][col]["history"] = messages

    def check_consistency_all(self):
        for col in self.df.columns:
            self.check_consistency(col)

    def check_consistency(self, col: str):
        if col not in self.df.columns:
            raise ValueError(f"Column {col} does not exist in the DataFrame.")
        
        if "consistency" not in self.document:
            self.document["consistency"] = {}
        
        if col not in self.document["consistency"]:
            self.document["consistency"][col] = {}
        else:
            if self.document["consistency"][col]:
                write_log(f"Warning: {col} already exists in the document.")
                return
        
        result = process_dataframe(self.df, 'consistency.txt', col_name=col)

        processed_string = escape_json_string(result[-1]["content"])
        content = json.loads(processed_string)['Action']['Content'] 

        if isinstance(content, str):
            self.document["consistency"][col]["summary"] = json.loads(content)
        else:
            self.document["consistency"][col]["summary"] = content
        if LOG_MESSAGE_HISTORY:
            self.document["consistency"][col]["history"] = result

    def check_pattern_all(self):
        for col in self.df.columns:
            self.check_pattern(col)

    def check_pattern(self, col: str):
        if col not in self.df.columns:
            raise ValueError(f"Column {col} does not exist in the DataFrame.")
        
        if pd.api.types.is_numeric_dtype(self.df[col].dtype):
            write_log(f"Warning: {col} is a numeric column. Skipping...")
            return


        if "pattern" not in self.document:
            self.document["pattern"] = {}

        if col not in self.document["pattern"]:
            self.document["pattern"][col] = {}
        else:
            if self.document["pattern"][col]:
                write_log(f"Warning: {col} already exists in the document.")
                return
        
        result = process_dataframe(self.df, 'pattern.txt', col_name=col)

        processed_string = escape_json_string(result[-1]["content"])
        content = json.loads(processed_string)['Action']['Content'] 

        if isinstance(content, str):
            self.document["pattern"][col]["summary"] = json.loads(content)
        else:
            self.document["pattern"][col]["summary"] = content
        if LOG_MESSAGE_HISTORY:
            self.document["pattern"][col]["history"] = result

    def to_yml(self):
        table_name = self.table_name
        description = self.document["main_entity"]["reasoning"]
        column_meanings = self.document["column_meaning"]["summary"]

        yaml_dict = {
            "version": 2,
            "models": [{
                "name": table_name, 
                "description": description,
                "columns": []
            }]
        }

        for column_info in column_meanings:
            column_dict = {
                "name": column_info["column"],
                "description": column_info["meaning"]
            }
            yaml_dict["models"][0]["columns"].append(column_dict)
            
        return yaml_dict

    def write_yml_to_disk(self, filepath: str):
        yaml_dict = self.to_yml()
        with open(filepath, 'w') as file:
            yaml.dump(yaml_dict, file)

    def write_document_to_disk(self, filepath: str):
        with open(filepath, 'w') as file:
            json.dump(self.document, file)

    def read_document_from_disk(self, filepath: str, viewer=True):
        with open(filepath, 'r') as file:
            self.document = json.load(file)
        self.start_document(viewer=viewer)

    def __repr__(self):
        self.display_document()
        return ""

    def save_file(self):
        if self.table_name is not None:
            data_name = self.table_name
        else:
            data_name = self.document['main_entity']['summary']

        file_name = f"{data_name}_cocoon_data.json".replace(" ", "_")

        print(f"🤓 Do you want to save the file?")

        def save_file_click(b):
            updated_file_name = file_name_input.value
            allow_overwrite = overwrite_checkbox.value

            if os.path.exists(updated_file_name) and not allow_overwrite:
                print("\x1b[31m" + "Warning: Failed to save. File already exists." + "\x1b[0m")
            else:
                self.write_document_to_disk(updated_file_name)
                print(f"🎉 File saved successfully as {updated_file_name}")

        file_name_input = Text(value=file_name, description='File Name:')

        save_button = Button(description="Save File")
        save_button.on_click(save_file_click)

        overwrite_checkbox = Checkbox(value=False, description='Allow Overwrite')

        display(HBox([file_name_input, overwrite_checkbox]), save_button)

        if self.viewer:
            save_file_click(save_button)





def get_value_from_path(data, path):
    """Recursively extract value from nested dict using the given path."""
    
    if not isinstance(data, dict):
        return data

    if not path:
        return data
    return get_value_from_path(data[path[0]], path[1:])

class CDMTransformation:
    def __init__(self, doc_df, log_file_path='data_log.txt'):

        if isinstance(doc_df, DocumentedData):
            self.doc_df = doc_df
            self.pipeline = doc_df.generate_pipeline()
        elif isinstance(doc_df, DataCleaning):
            self.doc_df = doc_df.doc_df
            self.pipeline = doc_df.generate_pipeline()

        
        
        self.document = {}

        self.log_file_path = log_file_path
        database_description = """The database primarily focuses on healthcare data, structured around several interconnected entities. The central entity is the **PATIENT** table, which contains details about individuals receiving medical care. Their healthcare journey is tracked through the **VISIT_OCCURRENCE** table, which records each visit to a healthcare facility. The **CONDITION_OCCURRENCE** table details any diagnosed conditions during these visits, while the **DRUG_EXPOSURE** table captures information on medications prescribed to the patients.
Procedures performed are logged in the **PROCEDURE_OCCURRENCE** table, and any medical devices used are listed in the **DEVICE** table. The **MEASUREMENT** table records various clinical measurements taken, and the **OBSERVATION** table notes any other relevant clinical observations.
In cases where a patient passes away, the **DEATH** table provides information on the mortality. The **SPECIMEN** table tracks biological samples collected for analysis, and the **COST** table details the financial aspects of the healthcare services.
The **LOCATION**, **CARE_SITE**, and **PROVIDER** tables offer contextual data, respectively detailing the geographical locations, healthcare facilities, and medical professionals involved in patient care. Lastly, the **PAYER_PLAN_PERIOD** table provides information on the patients' insurance coverage details and durations."""
        self.database_description = database_description

        tables = [
            "PATIENT", "VISIT_OCCURRENCE", "CONDITION_OCCURRENCE", "DRUG_EXPOSURE", 
            "PROCEDURE_OCCURRENCE", "DEVICE", "MEASUREMENT", "OBSERVATION", 
            "DEATH", "SPECIMEN", "COST", "LOCATION", "CARE_SITE", "PROVIDER", 
            "PAYER_PLAN_PERIOD"
        ]
        self.tables = tables

        edges = [
            ("PATIENT", "VISIT_OCCURRENCE"),
            ("VISIT_OCCURRENCE", "CONDITION_OCCURRENCE"),
            ("VISIT_OCCURRENCE", "DRUG_EXPOSURE"),
            ("VISIT_OCCURRENCE", "PROCEDURE_OCCURRENCE"),
            ("VISIT_OCCURRENCE", "DEVICE"),
            ("VISIT_OCCURRENCE", "MEASUREMENT"),
            ("VISIT_OCCURRENCE", "OBSERVATION"),
            ("PATIENT", "DEATH"),
            ("VISIT_OCCURRENCE", "SPECIMEN"),
            ("VISIT_OCCURRENCE", "COST"),
            ("VISIT_OCCURRENCE", "LOCATION"),
            ("VISIT_OCCURRENCE", "CARE_SITE"),
            ("VISIT_OCCURRENCE", "PROVIDER"),
            ("PATIENT", "PAYER_PLAN_PERIOD")
        ]
        self.edges = edges
        

    def display_database(self):
        database_description = replace_asterisks_with_tags(self.database_description)
        display(HTML("<h1>OMOP CDM</h1>" + database_description))
        visualize_graph(self.tables, self.edges)

    def write_log(self, message: str):
        self.log_file = open(self.log_file_path, 'a')
        self.log_file.write(message + '\n')
        self.log_file.close()

    def complete(self):
        print("Congratulation! The transformation is complete. 🚀")

    def write_document_to_disk(self, filepath: str):
        with open(filepath, 'w') as file:
            json.dump(self.document, file)

    def read_document_from_disk(self, filepath: str):
        with open(filepath, 'r') as file:
            self.document = json.load(file)

    def show_progress(self, max_value):
        progress = widgets.IntProgress(
            value=1,
            min=0,
            max=max_value+1,  
            step=1,
            description='',
            bar_style='',
            orientation='horizontal'
        )
        
        display(progress)
        return progress

    def start(self):
        self.get_main_table()

    def get_main_table(self):

        next_step = self.decide_main_table

        if "main_table" not in self.document:
            self.document["main_table"] = {}
        else:
            if self.document["main_table"]:
                write_log("Warning: main_table already exists in the document.")
                next_step()
                return

        print("🤓 Identifying target tables to map to...")

        progress = self.show_progress(1)
        source_table_description = self.doc_df.document["table_summary"]["summary"]
        
        summary, messages = find_target_table(source_table_description)
        progress.value += 1

        for message in messages:
            write_log(message['content'])
            write_log("-----------------------------------")

        for table in summary:
            if table not in self.tables:
                raise ValueError(f"Table {table} does not exist in the CDM.")
        
        self.document["main_table"]["summary"] = summary
        if LOG_MESSAGE_HISTORY: 
            self.document["main_table"]["history"] = messages

        next_step()









        



    def concept_mapping(self, target_table):

        next_step = self.write_codes2

        if "concept_mapping" not in self.document:
            self.document["concept_mapping"] = {}
        
        if target_table in self.document["concept_mapping"]:
            write_log(f"Warning: {target_table} already exists in the document for concept_mapping.")
        else:
            print("🤓 Identifying the concept mapping...")

            progress = self.show_progress(1)
            source_table_description = self.doc_df.document["table_summary"]["summary"]
            source_table_sample = self.doc_df.get_sample_text()
            target_table_description = table_description[target_table]
            target_table_sample = table_samples[target_table]
            transform_reason = self.document["main_table"]["summary"][target_table]
            
            summary, messages = get_concept_mapping(source_table_description, source_table_sample, target_table_description, target_table_sample, transform_reason)
            progress.value += 1

            for message in messages:
                write_log(message['content'])
                write_log("-----------------------------------")


            self.document["concept_mapping"][target_table] = {}
            self.document["concept_mapping"][target_table]["summary"] = summary
            if LOG_MESSAGE_HISTORY:
                self.document["concept_mapping"][target_table]["history"] = messages

        summary = self.document["concept_mapping"][target_table]["summary"]

        print(f"""💡 {BOLD}Plan to map attributes from source to target table:{END}""")
        

        def display_mapping(summary):
            for mapping in summary:
                source_attributes = mapping["source_columns"]
                target_attributes = mapping["target_columns"]
                reason = mapping["reason"]
                print(f"{BOLD}{', '.join(source_attributes)}{END}")
                print(f"    🤓 Can be mapped to {BOLD}{', '.join(target_attributes)}{END}")
                print(f"    {ITALIC}{reason}{END}")

                has_warning = False
                for source_attribute in source_attributes:
                    warnings = self.doc_df.get_column_warnings(source_attribute)
                    if warnings:
                        has_warning = True
                        print(f"\n    ⚠️ {BOLD}{source_attribute}{END} has Data Quality Issues:")
                        for idx, warning in enumerate(warnings):
                            warning_type = warning["type"]
                            warning_explanation = warning["explanation"]
                            print(f"        {idx+1}. {BOLD}{warning_type}{END}: {ITALIC}{warning_explanation}{END}")
                if has_warning:
                    print(f"    ⚠️ It's recommended to first clean the data before transformation.")
                print()

        display_mapping(summary)

        submit_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='',
            tooltip='Click to submit',
        )

        def on_submit_button_clicked(b):
            clear_output(wait=True)
            next_step(target_table)
            

        submit_button.on_click(on_submit_button_clicked)

        display(submit_button)

        print(f"""\n⚠️ Some attributes are not supported:""")
        print(f"""    1. 💭 concept id: vocabulary standardization is under development""")
        print(f"""    2. 🔗 foreign key: table connection is under development""")
        print(f"""😊 Please send a feature request if you want them!""")    
    
    def write_codes2(self, target_table):

        print("💻 Writing the codes...")

        next_step = self.complete

        concept_mapping = self.document["concept_mapping"][target_table]["summary"]

        progress = self.show_progress(len(concept_mapping))

        for mapping in concept_mapping:

            target_attributes = mapping["target_columns"]
            
            potential_attributes = attributes_description[target_table]
            
            target_attributes = [attr for attr in target_attributes if attr in potential_attributes]

            if not target_attributes:
                progress.value += 1
                continue

            source_attributes = mapping["source_columns"]

            key = str(target_attributes) + str(source_attributes)

            reason = mapping["reason"]

            progress.value += 1
            
            if "code_mapping" not in self.document:
                self.document["code_mapping"] = {}
            else:
                if key in self.document["code_mapping"]:
                    write_log(f"Warning: code_mapping for {key} already exists in the document.")
                    continue

            source_table_description  = self.doc_df.get_basic_description(sample_cols=source_attributes, cols=source_attributes)
            
            codes, messages = write_code_and_debug(key=key, 
                                                source_attributes=source_attributes, 
                                                source_table_description=source_table_description, 
                                                target_attributes=target_attributes, 
                                                df=self.doc_df.df,
                                                target_table=target_table)

            for message in messages:
                write_log(message['content'])
                write_log("-----------------------------------")

            self.document["code_mapping"][key] = {}
            self.document["code_mapping"][key]["summary"] = codes
            if LOG_MESSAGE_HISTORY:
                self.document["code_mapping"][key]["history"] = messages

        final_node_idx = self.pipeline.find_final_node()

        transform_step_indices = []
        project_step_indices = []

        sample_df = self.pipeline.run_codes()[:4]

        for mapping in concept_mapping:
            target_attributes = mapping["target_columns"]

            potential_attributes = attributes_description[target_table]
            
            target_attributes = [attr for attr in target_attributes if attr in potential_attributes]

            if not target_attributes:
                continue

            source_attributes = mapping["source_columns"]

            key = str(target_attributes) + str(source_attributes)


            code = self.document["code_mapping"][key]["summary"]

            transform_step = TransformationStep(name = "Column Transformation",
                                                        explanation=f"""Map from source table {BOLD}{str(source_attributes)}{END} to target table {BOLD}{str(target_attributes)}{END}""", 
                                                        codes=code, 
                                                        sample_df=sample_df)
            
            
            step_index = self.pipeline.add_new_step(transform_step)
            transform_step_indices.append(step_index)

            project_step = ProjectionStep(name = "Column Projection",
                                          cols=target_attributes)

            step_index = self.pipeline.add_new_step(project_step)
            project_step_indices.append(step_index)


            

        concat_step = ConcatenateHorizontalStep()
        concat_step_idx = self.pipeline.add_new_step(concat_step)


        for transform_step_idx in transform_step_indices:
            self.pipeline.add_edge_by_index(final_node_idx, transform_step_idx)

        for i in range(len(transform_step_indices)):
            self.pipeline.add_edge_by_index(transform_step_indices[i], 
                                            project_step_indices[i])
        
        for project_step_idx in project_step_indices:
            self.pipeline.add_edge_by_index(project_step_idx, concat_step_idx)

        self.pipeline.display()

    def print_codes(self):
        self.pipeline.print_codes()
    
    def run_codes(self):
        return self.pipeline.run_codes()

    def decide_one_one_table(self, target_table):

        next_step = self.concept_mapping

        if "one_to_one" not in self.document:
            self.document["one_to_one"] = {}

        if target_table in self.document["one_to_one"]:
            write_log(f"Warning: {target_table} already exists in the document for one_to_one.")
        else:
            print("🤓 Identifying the row mapping...")

            progress = self.show_progress(1)


            source_table_description = self.doc_df.document["table_summary"]["summary"]
            source_table_sample = self.doc_df.get_sample_text()
            target_table_description = table_description[target_table]
            target_table_sample = table_samples[target_table]
            transform_reason = self.document["main_table"]["summary"][target_table]
            
            summary, messages = decide_one_one(source_table_description, source_table_sample, target_table_description, target_table_sample, transform_reason)
            progress.value += 1

            for message in messages:
                write_log(message['content'])
                write_log("-----------------------------------")

            if not isinstance(summary["1:1"], bool):
                raise ValueError(f"summary['1:1'] is not a boolean.")
            
            self.document["one_to_one"][target_table] = {}
            self.document["one_to_one"][target_table]["summary"] = summary
            if LOG_MESSAGE_HISTORY:
                self.document["one_to_one"][target_table]["history"] = messages

        summary = self.document["one_to_one"][target_table]["summary"]

        if summary["1:1"]:
            next_step(target_table)
        else:
            display(HTML("☹️ <b>Source doesn't have 1-1 row mapping with Target:</b> " + summary["reason"]))
            print("😊 M-N row mapping is under development. Please send a feature request!")
        


    def decide_main_table(self):

        next_step = self.decide_one_one_table


        json_code = self.document["main_table"]["summary"]


        source_table_description = self.doc_df.document["table_summary"]["summary"]
        source_table_description = replace_asterisks_with_tags(source_table_description)

        display(HTML("<b>Source table</b> " + source_table_description))
                    

        if json_code:
            print("💡 Below are potential tables to transform to.")

            for key in json_code:
                print(f'    {BOLD}{key}{END}: {json_code[key]}')

            print("🤓 Please choose one table to transform to.")

            radio_options = widgets.RadioButtons(
                options=list(json_code.keys()) + ['Manually Specify'],
                description='',
                disabled=False
            )
        else:
            print(f"🙁 It doesn't seem to be related to any table in common data model. \n🤓 Please manually specify the \033[1mmost\033[0m related table.")
            radio_options = widgets.RadioButtons(
                options=['Manually Specify'],
                description='',
                disabled=False
            )

        dropdown = widgets.Dropdown(
            options=self.tables,
            description='',
            disabled= (True if json_code else False),
            layout={'display': 'none' if json_code else ''}  
        )

        def on_radio_selection_change(change):
            if change['new'] == 'Manually Specify':
                dropdown.disabled = False
                dropdown.layout.display = ''
            else:
                dropdown.disabled = True
                dropdown.layout.display = 'none'

        radio_options.observe(on_radio_selection_change, names='value')

        submit_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='',
            tooltip='Click to submit',
        )

        def on_submit_button_clicked(b):
            if radio_options.value == 'Manually Specify':
                main_table = dropdown.value
            else:
                main_table = radio_options.value

            clear_output(wait=True)

            next_step(main_table)
            

        submit_button.on_click(on_submit_button_clicked)

        container = widgets.VBox([radio_options, dropdown, submit_button])

        display(container)

    def write_codes(self):
        
        next_step = self.complete

        print("💻 Writing the codes...")

        return

        concept_mapping = self.document["concept_mapping"]
        
        source_concepts = self.doc_df.document["column_grouping"]["summary"]

        target_to_source = {}

        for key, value in concept_mapping.items():
            source_path = key.strip("[]").replace("'", "").split(", ")
            
            if "summary" in value:
                for summary_mapping in value["summary"]:
                    target_path = str(summary_mapping)
                    if target_path not in target_to_source:
                        target_to_source[target_path] = source_path
                    else:
                        target_to_source[target_path].append(source_path)

        progress = self.show_progress(len(target_to_source))

        for key, source_path in target_to_source.items():
            target_path = key.strip("[]").replace("'", "").split(", ")
            target_attributes = get_value_from_path(target_concepts, target_path)
            source_attributes = get_value_from_path(source_concepts, source_path)

            progress.value += 1
            
            if "code_mapping" not in self.document:
                self.document["code_mapping"] = {}
            else:
                if key in self.document["code_mapping"]:
                    write_log(f"Warning: code_mapping for {key} already exists in the document.")
                    continue
            
            self.write_code_single(key, source_attributes, target_attributes)

        self.target_df = pd.DataFrame()    

        for key, source_path in target_to_source.items():
            target_path = key.strip("[]").replace("'", "").split(", ")
            target_attributes = get_value_from_path(target_concepts, target_path)
            source_attributes = get_value_from_path(source_concepts, source_path)


            print(f"""Codes that map 
# from source table {BOLD}{str(source_path)}{END} ({ITALIC}{str(source_attributes)}{END})
# to target table {BOLD}{str(target_path)}{END} ({ITALIC}{str(target_attributes)}{END})""")

            code = self.document["code_mapping"][key]
            print()
            print("-" * 80) 
            print(highlight(code, PythonLexer(), Terminal256Formatter()))
            print("-" * 80) 
            print()

            
            exec(code, globals())
            temp_target_df = etl(self.doc_df.df)
            for col in temp_target_df.columns:
                self.target_df[col] = temp_target_df[col]

        
    
    def write_code_single(self, key, source_attributes, target_attributes):

        target_attributes = "\n".join(f"{idx + 1}. {target_attribute}: {attributes_description[target_attribute]}" for idx, target_attribute in enumerate(target_attributes))

        template =  f"""ETL task: Given Source Table, tansform it into Target Table with new columns. 

Source table:
{self.doc_df.get_basic_description(sample_cols=source_attributes, cols=source_attributes)}

The target table needs columns:
{target_attributes}

Do the following:
1. First reason about how to extract the columns
2. Then fill in the python function with detailed comments.
```python
def etl(source_df):
    target_df = pd.DataFrame()
    ...
    return target_df
```"""

        messages = [{"role": "user", "content": template}]

        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])

        python_code = extract_python_code(response['choices'][0]['message']['content'])

        detailed_error_info = None

        max_tries = 2

        while max_tries > 0:
            max_tries -= 1

            try:
                exec(python_code, globals())
                temp_target_df = etl(self.doc_df.df)
            except Exception: 
                detailed_error_info = get_detailed_error_info()

            if detailed_error_info is None:
                self.document["code_mapping"][key] = python_code
                return


            error_message = f"""There is a bug in the code: {detailed_error_info}.
First, study the error message and point out the problem.
Then, fix the bug and return the codes in the following format:
```python
def etl(source_df):
    target_df = pd.DataFrame()
    ...
    return target_df
```"""
            messages = [{"role": "user", "content":template},
            {"role": "assistant", "content": python_code},
            {"role": "user", "content": error_message},]

            response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

            write_log(error_message)
            write_log("-----------------------------------")
            write_log(response['choices'][0]['message']['content'])

            python_code = extract_python_code(response['choices'][0]['message']['content'])
    
        raise Exception("The code is not correct. Please try again.")


    def map_concept(self):

        next_step = self.write_codes

        print("Mapping the concepts...")

        target_concept = {self.document["main_table"]["summary"]["concept"]:
                            target_concepts[self.document["main_table"]["summary"]["concept"]]}

        def dict_to_descriptive_list(data_dict, parent_keys=None):
            if parent_keys is None:
                parent_keys = []

            descriptive_map = {}

            for key, value in data_dict.items():
                current_keys = parent_keys + [key]

                if isinstance(value, dict):
                    descriptive_map.update(dict_to_descriptive_list(value, current_keys))
                elif isinstance(value, list):
                    keys_path = '[' + ', '.join(current_keys) + ']'
                    
                    attributes = ', '.join(value)

                    description = f"{keys_path}, with {len(value)} attributes: {attributes}"

                    descriptive_map[str(current_keys)] = description

            return descriptive_map
        
        source_concept = dict_to_descriptive_list(self.doc_df.document["column_grouping"]["summary"])

        progress = self.show_progress(len(source_concept))

        for keys_path in source_concept:
            description = source_concept[keys_path]

            if "concept_mapping" not in self.document:
                self.document["concept_mapping"] = {}
            else:
                if keys_path in self.document["concept_mapping"]:
                    write_log(f"Warning: concept_mapping for {keys_path} already exists in the document.")
                    continue

            self.map_concept_single(keys_path, description, target_concept)

            progress.value += 1

        clear_output(wait=True)

        source_concepts = self.doc_df.document["column_grouping"]["summary"]

        concept_mapping = self.document["concept_mapping"]



        def display_mapping(concept_mapping, target_concepts, source_concepts):
            results = []

            for key, value in concept_mapping.items():
                source_path = key.strip("[]").replace("'", "").split(", ")
                
                source_attributes = get_value_from_path(source_concepts, source_path)
                
                print(f"{BOLD}{'->'.join(source_path)}{END} ({ITALIC}{', '.join(source_attributes)}{END})")
                if "summary" in value:
                    for summary_mapping in value["summary"]:
                        target_path = summary_mapping
                        target_attributes = get_value_from_path(target_concepts, target_path)
                        matching_source_attributes = ", ".join(summary_mapping[-3:])
                        print(f"    Can be mapped to {BOLD}{'->'.join(target_path)}{END} ({ITALIC}{', '.join(target_attributes)}{END}) attributes.")
                else:
                    print(f"    Can't be used for any attributes.")


        display_mapping(concept_mapping, target_concepts, source_concepts)
        
        submit_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='',
            tooltip='Click to submit',
        )

        def on_submit_button_clicked(b):
            
            clear_output(wait=True)

            next_step()
            

        submit_button.on_click(on_submit_button_clicked)

        display(submit_button)

    def map_concept_single(self, keys_path, description, target_concept):

        key_path_list = keys_path.strip("[]").replace("'", "").split(", ")

        def extract_paths(data, path=None, results=None):
            if path is None:
                path = []
            if results is None:
                results = []

            for key, value in data.items():
                new_path = path + [key]
                if isinstance(value, dict):
                    extract_paths(value, new_path, results)
                elif isinstance(value, list):
                    results.append(new_path)

            return results

        paths = extract_paths(target_concept)

        paths_str = "\n".join(f"{idx + 1}. {item}" for idx, item in enumerate(paths))

        template = f"""You have list of target concepts about {list(target_concept.keys())[0]}. Each concept is a list from category to specifics:
{paths_str}

You have a source table about: {description}. 
The goal is to transform from source to target.

Enumerate the target concepts that the source table can be potentially mapped to, in the following format (empty list if no relevant):
```json
[["{list(target_concept.keys())[0]}",...,"Leaf Category"], 
  ["{list(target_concept.keys())[0]}", ...]...]
```"""
        messages = [{"role": "user", "content": template}]

        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])

        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)


        
        if len(json_code) == 0:
            self.document["concept_mapping"][keys_path] = {}
            return


        
        result = "\n".join(f'{idx + 1}. {path}: {get_value_from_path(target_concept, path)}' for idx, path in enumerate(json_code))

        template = f"""You have list of target concepts about {list(target_concept.keys())[0]}. Each concept is a list from category to specifics:
{result}

You have a source table about: {description}. 
**Assumption: {list(target_concept.keys())[0]} is semantically similar or more general to {key_path_list[0]}!!**

Exclude target concepts that are obviously semantically different.
E.g., ["Person", "birth date"] and ["Patient, "death date"]
"birth date" and "death date", despite both are about date, are obviously different.
Sometimes, the difference is not obvious. E.g., "birth date" and "birth year" are the same.

Based on the assumption, exclude the conpets that are obviously different, but keep the ones that are unsure.
Return the remaining concepts in the following format (empty list if no).
```json
[["{list(target_concept.keys())[0]}",...,"Leaf Category"], 
  ["{list(target_concept.keys())[0]}", ...]...]
```"""

        messages = [{"role": "user", "content": template}]
        
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)
        
        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])

        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)


        
        if len(json_code) == 0:
            self.document["concept_mapping"][keys_path] = {}
            return
        


        
        result = "\n".join(f'{idx + 1}. {path}: {get_value_from_path(target_concept, path)}' for idx, path in enumerate(json_code))

        template = f"""You have list of target concepts about {list(target_concept.keys())[0]}. Each concept is a list from category to specifics. The right side is its attributes:
{result}

You have a source table about: {description}. 
First, go through the attributes of target concept. Argue if any can be transformed from the source table.
E.g., "Student height" cannot be transformed from "Student weight" as they are different measurements.
E.g., "Student age" can be transformed from "Student birth date" by calculating the date difference.

Then, enumerate the target concept where there exists attributes can be transformed (empty list if no):
```json
[["{list(target_concept.keys())[0]}",...,"Leaf Category"], 
  ["{list(target_concept.keys())[0]}", ...]...]
```"""
        messages = [{"role": "user", "content": template}]
        
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1) 
        
        write_log(template)    
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])
        
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)



        self.document["concept_mapping"][keys_path] = {}

        if len(json_code) == 0:    
            return
        
        self.document["concept_mapping"][keys_path]["summary"] = json_code
    



        
def check_functional_dependency(df, determinant, dependent):
    groups = df.groupby(list(determinant))[dependent].nunique()
    is_functionally_dependent = (groups == 1).all()
    return is_functionally_dependent



def combine_pipelines(pipelines):
    new_steps = []
    new_edges = {}
    offset = 0

    for pipeline in pipelines:
        new_steps.extend(pipeline.steps)

        for source_idx, targets in pipeline.edges.items():
            new_targets = [t + offset for t in targets]
            new_edges[source_idx + offset] = new_targets
        
        offset += len(pipeline.steps)

    return TransformationPipeline(new_steps, new_edges)

def find_instance_index(instance_list, target_instance):
    for idx, instance in enumerate(instance_list):
        if instance is target_instance:
            return idx
    return -1




def find_final_node(steps, edges):

    node_set = set(range(len(steps)))

    nodes_with_no_outgoing = {node for node, targets in edges.items() if len(targets) == 0}
    
    nodes_not_in_edges = node_set - set(edges.keys())

    potential_final_nodes = nodes_with_no_outgoing.union(nodes_not_in_edges)

    if len(potential_final_nodes) != 1:
        return None

    final_node = potential_final_nodes.pop()

    for node in node_set:
        if node == final_node:
            continue
        if not find_path(edges, node, final_node):
            return None

    return final_node


def find_source_node(nodes, edges):
    if not edges and len(nodes) == 1:
        return 0

    all_nodes_with_outgoing = set(edges.keys())

    nodes_with_incoming = set()
    for targets in edges.values():
        nodes_with_incoming.update(targets)

    source_candidates = all_nodes_with_outgoing - nodes_with_incoming

    if len(source_candidates) == 1:
        return source_candidates.pop()
    else:
        return None




def find_path(edges, start, end, visited=None):
    if visited is None:
        visited = set()

    if start == end:
        return True
    if start in visited:
        return False

    visited.add(start)

    for neighbor in edges.get(start, []):
        if find_path(edges, neighbor, end, visited):
            return True

    return False





class TransformationPipeline:


    def __init__(self, steps, edges):
        if not isinstance(steps, list):
            raise ValueError("Steps must be a list")

        for step in steps:
            if not isinstance(step, TransformationStep):
                raise ValueError("Each step must be an instance of TransformationStep")

        if not isinstance(edges, dict):

            if not isinstance(edges, list):
                raise ValueError("Edges must be a list")

            for edge in edges:
                if not isinstance(edge, tuple) or len(edge) != 2:
                    raise ValueError("Each edge must be a tuple of two elements")
                if not isinstance(edge[0], int) or not isinstance(edge[1], int):
                    raise ValueError("Edge elements must be integers")
                if edge[0] < 0 or edge[0] >= len(steps) or edge[1] < 0 or edge[1] >= len(steps):
                    raise ValueError("Edge indices must be within the range of steps")

            self.edges = {}
            for source_idx, target_idx in edges:
                if source_idx not in self.edges:
                    self.edges[source_idx] = []
                self.edges[source_idx].append(target_idx)
        
        else:
            self.edges = edges

        self.steps = steps

        self.cached_results = {}



    def get_step(self, idx):
        return self.steps[idx]

    def get_step_idx(self, step):
        return find_instance_index(self.steps, step)









    def validate_graph(self):
        if self._is_cyclic():
            raise ValueError("The graph is cyclic.")

        num_steps = len(self.steps)
        for source, targets in self.edges.items():
            if source >= num_steps or any(target >= num_steps for target in targets):
                raise ValueError("Edge indices are out of range.")

    def _is_cyclic(self):
        visited = set()
        rec_stack = set()

        def _is_cyclic_util(v):
            if v not in visited:
                visited.add(v)
                rec_stack.add(v)

                for neighbour in self.edges.get(v, []):
                    if neighbour not in visited and _is_cyclic_util(neighbour):
                        return True
                    elif neighbour in rec_stack:
                        return True

            rec_stack.remove(v)
            return False

        for node in range(len(self.steps)):
            if node not in visited and _is_cyclic_util(node):
                return True

        return False

    def display_workflow(self):
        nodes = [f"{idx + 1}. {step.name}" for idx, step in enumerate(self.steps)]

        display_workflow(nodes, self.edges)

    def get_nodes(self):
        nodes = [f"{idx + 1}. {step.name}" for idx, step in enumerate(self.steps)]
        return nodes

    def display(self, call_back=None):

        if call_back is None:
            call_back = self.display
        

        def create_widget(instances):

            nodes = self.get_nodes()
            
            dropdown = widgets.Dropdown(
                options=nodes,
                disabled=False,
            )

            button1 = widgets.Button(description="View")
            button2 = widgets.Button(description="Edit")

            button3 = widgets.Button(description="Return")

            def on_button_clicked3(b):
                clear_output(wait=True)
                call_back()

            def on_button_clicked(b):
                clear_output(wait=True)

                display_workflow(nodes, self.edges)

                display(dropdown)

                buttons = widgets.HBox([button1, button2, button3])
                display(buttons)

                idx = nodes.index(dropdown.value)

                selected_instance = instances[idx]
                selected_instance.display()

            def on_button_clicked2(b):
                clear_output(wait=True)

                idx = nodes.index(dropdown.value)
                selected_instance = instances[idx]

                def call_back_display(step):
                    clear_output(wait=True)
                    call_back()

                selected_instance.edit_widget(callbackfunc=call_back_display)

            button1.on_click(on_button_clicked)
            button2.on_click(on_button_clicked2)
            button3.on_click(on_button_clicked3)

            display_workflow(nodes, self.edges)

            buttons = widgets.HBox([button1, button2])

            display(dropdown, buttons)


        create_widget(self.steps)




    def get_codes(self):
        sorted_step_idx = topological_sort(self.steps, self.edges)

        codes = "from cocoon_data import *\n\n"

        for step_idx  in sorted_step_idx:

            step = self.steps[step_idx]

            source_ids = get_source_nodes_ids(self.edges, step_idx)

            codes += step.get_codes(target_id=step_idx, source_ids=source_ids)

        return codes

    
    def run_codes(self, use_cache=True):

        sorted_step_idx = topological_sort(self.steps, self.edges)
        
        for step_idx  in sorted_step_idx:
        
            if use_cache and step_idx in self.cached_results:
                continue

            step = self.steps[step_idx]

            source_ids = get_source_nodes_ids(self.edges, step_idx)

            source_dfs = [self.cached_results[source_id] for source_id in source_ids]

            result = step.run_codes(dfs=source_dfs)

            if isinstance(result, str):
                write_log(result)
                raise ValueError(result)
            else:
                self.cached_results[step_idx] = result
        
        final_node_idx = self.find_final_node()
        if final_node_idx is None:
            raise ValueError("No final node to return")
        else:
            return self.cached_results[final_node_idx]


    def print_codes(self):
        codes = self.get_codes()
        
        print(highlight(codes, PythonLexer(), Terminal256Formatter()))

    

    def find_final_node(self):
        return find_final_node(self.steps, self.edges)

    def get_final_step(self):
        final_node = self.find_final_node()
        final_step = self.get_step(final_node)
        return final_step

    def find_source_node(self):
        return find_source_node(self.steps, self.edges)
    
    def get_source_step(self):
        source_node = self.find_source_node()
        source_step = self.get_step(source_node)
        return source_step

    def remove_final_node(self):
        if len(self.steps) <= 1:
            raise ValueError("The graph has less than or equal to 1 step. Cannot remove the final node.")


        final_node = self.find_final_node()
        if final_node is None:
            raise ValueError("No final node to remove")

        self.steps.pop(final_node)

        updated_edges = {}
        for source, targets in self.edges.items():
            adjusted_targets = [t - 1 if t > final_node else t for t in targets if t != final_node]

            adjusted_source = source - 1 if source > final_node else source

            if adjusted_targets:
                updated_edges[adjusted_source] = adjusted_targets

        self.edges = updated_edges

        new_cache = {}
        for key, value in self.cached_results.items():
            new_key = key - 1 if key > final_node else key

            if key != final_node:
                new_cache[new_key] = value

        self.cached_results = new_cache

    def add_step(self, new_step, parent_node_idx=None):

        if len(self.steps) == 0 and parent_node_idx is None:
            self.steps.append(new_step)
            return

        if parent_node_idx is not None and isinstance(parent_node_idx, TransformationStep):
            parent_node_idx = find_instance_index(self.steps, parent_node_idx)

        if parent_node_idx is not None and (parent_node_idx < 0 or parent_node_idx >= len(self.steps)):
            raise ValueError(f"Parent node index is out of range. {parent_node_idx} is not within [0, {len(self.steps) - 1}].")

        if not isinstance(new_step, TransformationStep):
            raise ValueError("The new step must be an instance of TransformationStep.")
        
        self.steps.append(new_step)

        new_step_idx = len(self.steps) - 1

        if parent_node_idx is not None:
            if parent_node_idx not in self.edges:
                self.edges[parent_node_idx] = []
            self.edges[parent_node_idx].append(new_step_idx)
        

    
    def add_step_right_after(self, new_step, parent_node_idx):

        if isinstance(parent_node_idx, TransformationStep):
            parent_node_idx = find_instance_index(self.steps, parent_node_idx)

        if parent_node_idx < 0 or parent_node_idx >= len(self.steps):
            raise ValueError(f"Parent node index is out of range. {parent_node_idx} is not within [0, {len(self.steps) - 1}].")

        if not isinstance(new_step, TransformationStep):
            raise ValueError("The new step must be an instance of TransformationStep.")
        
        self.steps.append(new_step)

        new_step_idx = len(self.steps) - 1


        children = self.edges.get(parent_node_idx, [])
        self.edges[parent_node_idx] = [new_step_idx]
        self.edges[new_step_idx] = children

        self.cached_results = {}




    def add_step_to_final(self, new_step):

        final_node = self.find_final_node()
        if final_node is None:
            raise ValueError("The graph doesn't have a final node.")

        self.add_step(new_step, final_node)




    def add_edge(self, source_step, target_step):
        source_idx = find_instance_index(self.steps, source_step)
        target_idx = find_instance_index(self.steps, target_step)

        if source_idx == -1:
            raise ValueError("The source step is not in the graph.")
        if target_idx == -1:
            raise ValueError("The target step is not in the graph.")
        
        self.add_edge_by_index(source_idx, target_idx)


    
    def add_new_step(self, new_step):
        self.steps.append(new_step)
        return len(self.steps) - 1

    def add_edge_by_index(self, source_idx, target_idx):
        if source_idx not in self.edges:
            self.edges[source_idx] = []
        self.edges[source_idx].append(target_idx)

        self.cached_results = {}


    def start(self):
        pass

    def __repr__(self):
        self.display()
        return ""

class Testing: 
    def __init__(self, name = None, explanation="", codes="", sample_df=None):
        if name is None:
            self.name = "Testing Task"
        else:
            self.name = name
        
        self.codes = codes
        self.explanation = explanation
        self.sample_df = sample_df
            

    def run_codes(self, dfs, codes = None):

        if codes is None:
            codes = self.codes
        
        if isinstance(dfs, list):
            df = dfs[0]
        else:
            df = dfs

        input_df = df.copy()
        try:
            if 'transform' in globals():
                del globals()['transform']
            exec(codes, globals())
            result = test(input_df) 
            return result

        except Exception: 
            detailed_error_info = get_detailed_error_info()
            return detailed_error_info
    
    def generate_codes(self, explanation=None):
        if explanation is None:
            explanation = self.explanation
        template = f"""Testing task: Given input df, write python codes that test df and output True/False
===
Input Df:
{self.sample_df.to_csv()}
===
Testing Requirement
{explanation}

Do the following:
1. First reason about how to test
2. Then fill in the python function, with detailed comments. 
DONT change the function name and the return clause.

{{
    "reason": "To transform, we need to ...",
    "codes": "def test(input_df):\\n   ...\\n    return True/False"
}}
"""
        messages = [{"role": "user", "content": template}]
    
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])

        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)
        
        self.reason = json_code["reason"]
        self.codes = json_code["codes"]
    
    def display(self):
        raise NotImplementedError


class TestColumnUnique(Testing):
    def __init__(self, col_name, name = None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name

        if name is None:
            self.name = f"Test if {col_name} is unique"

    def generate_test_unique_codes(self):
        self.codes = """# Concatenate all dataframes horizontally
def test(input_df):
    return input_df["{col_name}"].is_unique"""

class TestColumnNotNull(Testing):
    def __init__(self, col_name, name=None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name

        if name is None:
            self.name = f"Test if {col_name} has no null"

    def generate_test_not_null_codes(self):
        self.codes = f"""def test(input_df):
    return not input_df["{self.col_name}"].isnull().any()"""

class TestColumnAcceptedValues(Testing):
    def __init__(self, col_name, accepted_values, name=None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        if not isinstance(accepted_values, list):
            raise ValueError("Accepted values must be a list.")
        self.accepted_values = accepted_values

        if name is None:
            self.name = f"Test {col_name} domain"

    def generate_test_accepted_values_codes(self):
        self.codes = f"""def test(input_df):
    return input_df["{self.col_name}"].isin({self.accepted_values}).all()"""

class TestColumnType(Testing):
    def __init__(self, col_name, expected_type, name=None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        self.expected_type = expected_type

        if name is None:
            self.name = f"Test {col_name} type"

    def generate_test_column_type_codes(self):
        self.codes = f"""def test(input_df):
    return input_df["{self.col_name}"].dtype == "{self.expected_type}"""

class TestColumnRange(Testing):
    def __init__(self, col_name, min_value, max_value, name=None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        self.min_value = min_value
        self.max_value = max_value

        if name is None:
            self.name = f"Test {col_name} range"

    def generate_test_range_codes(self):
        self.codes = f"""def test(input_df):
    if not pd.api.types.is_numeric_dtype(input_df["{self.col_name}"]):
        return False
    return input_df["{self.col_name}"].between({self.min_value}, {self.max_value}).all()"""


class TestColumnRegex(Testing):
    def __init__(self, col_name, regex_pattern, name=None, explanation="", codes="", sample_df=None):
        super().__init__(name, explanation, codes, sample_df)
        self.col_name = col_name
        self.regex_pattern = regex_pattern

        if name is None:
            self.name = f"Test {col_name} regex pattern"

    def generate_test_regex_codes(self):
        self.codes = f"""def test(input_df):
    return input_df["{self.col_name}"].str.match("{self.regex_pattern}").all()"""



class TransformationStep:

    def __init__(self, name = None, explanation="", codes="", sample_df=None):
        if name is None:
            self.name = "Transformation Task"
        else:
            self.name = name

        self.codes = codes
        self.explanation = explanation

        if sample_df is not None:
            try:
                self.sample_df = sample_df.copy()
            except:
                self.sample_df = sample_df

        self.reason = ""
            

    def verify_infput(self, df):
        if not isinstance(df, pd.DataFrame):
            raise ValueError(f"Input is not a pandas dataframe. It is {type(df)}.")

    def verify_output(self, df):
        if not isinstance(df, pd.DataFrame):
            raise ValueError(f"Output is not a pandas dataframe. It is {type(df)}.")


    def generate_codes(self, explanation=None):
        if explanation is None:
            explanation = self.explanation
            
        template = f"""Transformation task: Given input df, write python codes that transform and ouput df.
===
Input Df:
{self.sample_df.to_csv()}
===
Transformation Requirement
{explanation}

Do the following:
1. First reason about how to transform
2. Then fill in the python function, with detailed comments. 
DONT change the function name, first line and the return clause.

{{
    "reason": "To transform, we need to ...",
    "codes": "def transform(input_df):\\n    output_df = input_df.copy()\\n    ...\\n    return output_df"
}}
"""
        messages = [{"role": "user", "content": template}]
    
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])

        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)
        
        self.reason = json_code["reason"]
        self.codes = json_code["codes"]


    def postprocessing(self, df):
        return df

    def run_codes(self, dfs, codes = None):

        if codes is None:
            codes = self.codes
        
        if isinstance(dfs, list):
            df = dfs[0]
        else:
            df = dfs

        input_df = df.copy()


        try:
            if 'transform' in globals():
                del globals()['transform']
            exec(codes, globals())
            temp_target_df = transform(input_df) 
            temp_target_df = self.postprocessing(temp_target_df)
            self.verify_output(temp_target_df)
            return temp_target_df
        except Exception: 
            detailed_error_info = get_detailed_error_info()
            return detailed_error_info




    def edit_widget(self, callbackfunc=None):

        print("\033[91mRemember to save after editing!\033[0m")

        explanation_label = widgets.Label('Task:')
        explanation_text = widgets.Textarea(
            value = self.explanation if self.explanation != "" else "Transform ... For example ...",
            layout=widgets.Layout(width='95%', height='200px')
        )
        submit_button = widgets.Button(description="Submit Task")
        submit_spinner = widgets.HTML()

        def on_submit_clicked(b):
            print("Generating codes...")
            
            submit_spinner.value = spinner_value
            self.generate_codes(explanation = explanation_text.value)

            codes_text.value = self.codes
            reason_label.value = self.reason
            submit_spinner.value = ""
            print("Done")

        submit_button.on_click(on_submit_clicked)
        submit_box = widgets.HBox([submit_button, submit_spinner])

        codes_label = widgets.Label('Codes:')
        codes_text = widgets.Textarea(
            value=self.codes,
            layout=widgets.Layout(width='95%', height='200px')
        )
        run_button = widgets.Button(description="Run Codes")
        run_spinner = widgets.HTML()

        reason_label = widgets.Label(layout=Layout(width='100%', overflow='auto', white_space='pre-wrap'))
        output_label = widgets.Label()

        def on_run_clicked(b):
            print("Running codes...")
            run_spinner.value =  spinner_value
            output = self.run_codes(dfs = self.sample_df, codes = codes_text.value)
            if isinstance(output, str):
                error_label.value = "<span style='color: red;'>" + output.replace("\n", "<br>") + "</span>"
                output_df_widget.value = ""
            else:
                error_label.value = ""
                output_df_widget.value = output.to_html(border=0)
            run_spinner.value = ""
            print("Done")
                

        run_button.on_click(on_run_clicked)
        run_box = widgets.HBox([run_button, run_spinner])


        panel_layout = Layout(width='400px')

        left_panel = widgets.VBox([explanation_label, explanation_text, submit_box], layout=panel_layout)
        right_panel = widgets.VBox([codes_label, codes_text, run_box, output_label], layout=panel_layout)
        display(widgets.HBox([left_panel, right_panel]))
        display(reason_label)

        input_df_label = widgets.Label('Input Table:')
        display(input_df_label)
        display(HTML(self.sample_df.to_html(border=0)))

        output_df_label = widgets.Label('Output Table:')
        output_df_widget = widgets.HTML(
            value='',
            placeholder='Output DataFrame will be shown here',
            description='',
        )
        
        error_label = widgets.HTML(layout=Layout(overflow='auto'))

        save_button = widgets.Button(description="Save the Step")

        def on_save_clicked(b):
            print("Saving ...")
            self.codes = codes_text.value
            self.explanation = explanation_text.value
            self.reason = reason_label.value
            callbackfunc(self)
            print("Done")

        save_button.on_click(on_save_clicked)

        display(widgets.VBox([
                                output_df_label, 
                                output_df_widget, 
                                error_label]))

        display(save_button)

        if self.codes != "":
            on_run_clicked(run_button)

    def get_sample_output(self):
        result = self.run_codes(self.sample_df)
        if isinstance(result, str):
            raise ValueError(f"The codes for step {self.name} is not correct: {result} \n Please edit the codes.")
        elif isinstance(result, pd.DataFrame):
            return result
        else:
            raise ValueError("Output is neither a string nor a pandas dataframe.")

    def display(self):
        print(f"{BOLD}{self.name}{END}: {self.explanation}")
        display(HTML(f"<hr>"))
        print(f"{BOLD}Codes{END}:")
        print(highlight(self.codes, PythonLexer(), Terminal256Formatter()))

        if hasattr(self, 'sample_df'):
            display(HTML(f"<hr><b>Example Input</b>: {self.sample_df.to_html()}"))
            
            if not hasattr(self, 'output_sample_df'):
                self.output_sample_df = self.run_codes(self.sample_df)
            
            display(HTML(f"<hr><b>Example Output</b>: {self.output_sample_df.to_html()}"))

    def __repr__(self):
        self.display()
        return ""

    def rename_based_on_explanation(self):
        title, message = give_title(self.explanation)
        self.name = title

    def get_codes(self, target_id=0, source_ids=[]):
        source_ids_str = ", ".join([f"df_{source_id}" for source_id in source_ids])
        return self.codes + "\n\n" + f"df_{target_id} = transform({source_ids_str})\n\n"



class GeoAggregationStep(TransformationStep):

    def __init__(self, shape_data, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.shape_data = shape_data
        self.agg_cols = [shape_data.x_att, shape_data.y_att]

        self.explanation = f"""Aggregate {self.agg_cols} by ..."""

        if 'name' not in kwargs:
            self.name = f"Aggregation"

    def verify_input(self, df):
        if not set(self.agg_cols).issubset(df.columns):
            raise ValueError(f"Columns {self.agg_cols} are not in the input dataframe.")

    def postprocessing(self, df):
        if not isinstance(df, pd.DataFrame):
            raise ValueError("Output is not a pandas dataframe.")

        if not set(self.agg_cols).issubset(df.columns):
            raise ValueError(f"Columns {self.agg_cols} are not in the output dataframe.")
        
        if df.index.name is not None:
            df = df.reset_index()
        return df

    def generate_codes(self, explanation=None):
        if explanation is None:
            explanation = self.explanation
            
        template = f"""Transformation task: Given input df, write python codes that aggregate and ouput df.
===
Input Df:
{self.sample_df.df[:2].to_csv()}
===
Transformation Requirement:
Aggregate {self.agg_cols}.
{explanation}

Do the following:
1. First reason about how to transform. The final output df should group by only attributes: {self.agg_cols}
2. Then fill in the python function, with detailed comments. 
DONT change the function name, first line and the return clause.

{{
    "reason": "To transform, we need to ...",
    "codes": "def transform(input_df):\\n    output_df = input_df.copy()\\n    ...\\n    return output_df"
}}
"""
        messages = [{"role": "user", "content": template}]
    
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])

        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)
        
        self.reason = json_code["reason"]
        self.codes = json_code["codes"]

    
    def run_codes(self, dfs, codes = None):

        if codes is None:
            codes = self.codes
        
        if isinstance(dfs, list):
            shape_data = dfs[0]
        else:
            shape_data = dfs

        data = shape_data.get_data()
        meta = shape_data.meta.copy()
        meta['aggregated'] = True


        try:
            if 'transform' in globals():
                del globals()['transform']
            exec(codes, globals())
            temp_output_df = transform(data)
            temp_output_df = self.postprocessing(temp_output_df)

            return shape_manufacturing(shape_data = temp_output_df, x_att=self.agg_cols[0], y_att=self.agg_cols[1], meta=meta)
        
        except Exception: 
            detailed_error_info = get_detailed_error_info()
            return detailed_error_info


class MultiDFTransformationStep(TransformationStep):
    def __init__(self, name=None, explanation="", codes="", sample_dfs=None):
        super().__init__(name, explanation, codes)
        if sample_dfs is not None:
            self.sample_dfs = [df.copy() for df in sample_dfs]
        else:
            self.sample_dfs = []

    def run_codes(self, dfs):
        input_dfs = [df.copy() for df in dfs]
        try:
            if 'transform' in globals():
                del globals()['transform']
            exec(self.codes, globals())
            temp_target_df = transform(*input_dfs)
            return temp_target_df
        except Exception:
            detailed_error_info = get_detailed_error_info()
            return detailed_error_info
        
        

    def display(self):
        display(HTML(f"<b>{self.name}</b>: {self.explanation} <hr> <b>Codes</b>:"))
        print(highlight(self.codes, PythonLexer(), Terminal256Formatter()))

        if hasattr(self, 'sample_dfs'):
            for i, df in enumerate(self.sample_dfs):
                display(HTML(f"<hr><b>Example Input {i+1}</b>: {df.to_html()}"))

            if not hasattr(self, 'output_sample_dfs'):
                self.output_sample_dfs = self.run_codes(self.sample_dfs)

            for i, df in enumerate(self.output_sample_dfs):
                display(HTML(f"<hr><b>Example Output {i+1}</b>: {df.to_html()}"))
    
    def generate_codes(self):
        raise NotImplementedError("generate_codes() is not implemented for MultiDFTransformationStep.")


class ConcatenateHorizontalStep(MultiDFTransformationStep):
    def __init__(self, name=None, explanation="", codes="", sample_dfs=None):
        super().__init__(name, explanation, codes, sample_dfs)
        self.generate_concatenate_horizontal_codes()

        self.explanation = """Concatenate all dataframes horizontally"""

        if name is None:
            self.name = "Concatenate Horizontal"

    def generate_concatenate_horizontal_codes(self):
        self.codes = """# Concatenate all dataframes horizontally
def transform(*dfs):
    return pd.concat(dfs, axis=1)"""



class SourceStep(TransformationStep):
    def __init__(self, doc_df, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.explanation = ""
        self.doc_df = doc_df
        self.name = doc_df.table_name

    def generate_codes(self):
        pass

    def run_codes(self, dfs):
        return self.doc_df.original_df

    def display(self):
        display(HTML(self.doc_df.original_df[:5].to_html()))

    def edit_widget(self, callbackfunc=None):
        self.display()
        print("\033[91mEdit Source File is under development!\033[0m")

        return_button = widgets.Button(description="Return")

        def on_return_clicked(b):
            clear_output(wait=True)
            callbackfunc(self)
        
        return_button.on_click(on_return_clicked)

        display(return_button)
    
    def get_codes(self, target_id=0, source_ids=[]):
        if self.doc_df.file_path is None:
            return f"df_{str(target_id)} = pd.read_csv(ADD_YOUR_SOURCE_FILE_PATH_HERE) \n\n"
        else:
            sep = self.doc_df.sep
            encoding = self.doc_df.encoding
            return f"df_{str(target_id)} = pd.read_csv('{self.doc_df.file_path}', sep='{sep}', encoding='{encoding}') \n\n"

class RemoveMissingValueStep(TransformationStep):

    def __init__(self, col, reason, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.col = col
        self.explanation = f"""Remove the rows with missing values in column {col}"""
        self.generate_remove_missing_value_codes()
        self.generate_missing_value_samples()

        if 'name' not in kwargs:
            self.name = f"Remove NULL for {col}"


    def generate_remove_missing_value_codes(self):
        self.codes = f"""# Remove the rows with missing values in column {self.col}
def transform(df):
    output_df = df.copy()
    output_df = output_df.dropna(subset=["{self.col}"])
    return output_df"""


    def generate_missing_value_samples(self):
        sample_df1 = self.sample_df[self.sample_df[self.col].notnull()][:2]
        sample_df2 = self.sample_df[self.sample_df[self.col].isnull()][:2]
        sample_df = pd.concat([sample_df1, sample_df2])
        self.sample_df = sample_df







    


















        

    






    






        




        









        



        













    






    






    


class GeoShapeCustomTransformStep(TransformationStep):

    def generate_codes(self, explanation=None):

        data_type = self.sample_df.get_type()

        if data_type == "raster":
            raise NotImplementedError("generate_codes() is not implemented for Raster.")
        elif data_type == "df":
            raise NotImplementedError("generate_codes() is not implemented for df.")

        if explanation is None:
            explanation = self.explanation
            
        template = f"""Transformation task: Given input {data_type}, write python codes that transform and ouput {data_type}.
===
Input {data_type}:
{self.sample_df.get_summary()}
===
Transformation Requirement
{explanation}

Do the following:
1. First reason about how to transform
2. Then fill in the python function, with detailed comments. 
DONT change the function name and the return clause.

{{
    "reason": "To transform, we need to ...",
    "codes": "def transform(input_{data_type}):\\n    ...\\n    return output_{data_type}"
}}
"""
        messages = [{"role": "user", "content": template}]
    
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        write_log(template)
        write_log("-----------------------------------")
        write_log(response['choices'][0]['message']['content'])

        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)
        
        self.reason = json_code["reason"]
        self.codes = json_code["codes"]
    
    def run_codes(self, dfs, codes = None):

        if codes is None:
            codes = self.codes
        
        if isinstance(dfs, list):
            shape_data = dfs[0]
        else:
            shape_data = dfs

        data = shape_data.get_data()
        meta = shape_data.meta


        try:
            if 'transform' in globals():
                del globals()['transform']
            exec(codes, globals())
            temp_output_df = transform(data)
            return shape_manufacturing(shape_data = temp_output_df, meta = meta)
        except Exception: 
            detailed_error_info = get_detailed_error_info()
            return detailed_error_info

class GeoShapeStep(TransformationStep):
    def generate_codes(self):
        self.codes = f"""# Reproject to {self.target_crs}
NOT IMPLEMENTED YET!"""

    def verify_input(self, shape_data):
        if not isinstance(shape_data, ShapeData):
            raise TypeError("shape_data must be of type ShapeData.")
    
    def verify_output(self, shape_data):
        if not isinstance(shape_data, ShapeData):
            raise TypeError("shape_data must be of type ShapeData.")

    def edit_widget(self, callbackfunc=None):
        print("🚧 under development")
        self.display()

        return_button = widgets.Button(description="Return")

        def on_return_clicked(b):
            clear_output(wait=True)
            callbackfunc(self)
        
        return_button.on_click(on_return_clicked)

        display(return_button)

    def get_sample_output(self):
        result = self.run_codes(self.sample_df)

    def display(self):
        if hasattr(self, 'sample_df'):
            display(HTML(f"<hr><b>Example Input</b>:"))
            self.sample_df.__repr__()
            
            if not hasattr(self, 'output_sample_df'):
                self.output_sample_df = self.run_codes(self.sample_df)
            
            display(HTML(f"<hr><b>Example Output</b>:"))
            self.output_sample_df.__repr__()


class ReprojectStep(GeoShapeStep):

    def __init__(self, target_crs=None, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.target_crs = target_crs
        
        if 'name' not in kwargs:
            self.name = f"Reproject to {target_crs}"

    def run_codes(self, dfs):
        if isinstance(dfs, list):
            shape_data = dfs[0]
        else:
            shape_data = dfs
        return shape_data.project_to_target_crs(target_crs=self.target_crs)

class ResampleStep(GeoShapeStep):
    def __init__(self, geo_transform=None, resolution=None, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.geo_transform = geo_transform
        self.resolution = resolution

        if 'name' not in kwargs:
            self.name = f"Rasample"

        if geo_transform is not None:
            self.name += f" to {geo_transform}"
        
        if resolution is not None:
            self.name += f" to resolution {resolution}"
    
    def run_codes(self, dfs):
        if isinstance(dfs, list):
            shape_data = dfs[0]
        else:
            shape_data = dfs
        return shape_data.resample_to_target_transform(geo_transform=self.geo_transform, resolution=self.resolution)

class NumpyToDfStep(GeoShapeStep):
    def __init__(self,  *args, **kwargs):
        super().__init__(*args, **kwargs)

        if 'name' not in kwargs:
            self.name = f"NumPy to Pandas DataFrame"
    
    def run_codes(self, dfs):
        if isinstance(dfs, list):
            shape_data = dfs[0]
        else:
            shape_data = dfs
        return shape_data.to_df()


class SourceShapeStep(GeoShapeStep):
    def __init__(self, shape_data, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.explanation = ""
        self.shape_data = shape_data
        
        if "table_name" in shape_data.meta:
            self.name = shape_data.meta["table_name"]
        else:
            self.name = "Source Geographical Shape"

    def generate_codes(self):
        pass

    def run_codes(self, dfs):
        return self.shape_data
    
    def display(self):
        self.shape_data.display()
    
    def edit_widget(self, callbackfunc=None):
        self.display()
        print("\033[91mEdit Source File is under development!\033[0m")

        return_button = widgets.Button(description="Return")

        def on_return_clicked(b):
            clear_output(wait=True)
            callbackfunc(self)
        
        return_button.on_click(on_return_clicked)

        display(return_button)

    def get_codes(self, target_id=0, source_ids=[]):
        if hasattr(self, 'gdf'):
            return f"df_{str(target_id)} = gpd.read_file(ADD_YOUR_SOURCE_FILE_PATH_HERE) \n\n"
        elif hasattr(self, 'raster_path'):
            return f"df_{str(target_id)} = rasterio.open('{self.raster_path}').read() \n\n"
        elif hasattr(self, 'np_array'):
            return f"df_{str(target_id)} = np.load(ADD_YOUR_SOURCE_FILE_PATH_HERE) \n\n"
        elif hasattr(self, 'df'):
            return f"df_{str(target_id)} = pd.read_csv(ADD_YOUR_SOURCE_FILE_PATH_HERE) \n\n"



class RemoveColumnsStep(TransformationStep):

    def __init__(self, col_indices, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.col_indices = col_indices

        if self.explanation == "":
            self.explanation = f"""Remove columns"""
        
        self.generate_remove_columns_codes()
        self.generate_remove_columns_samples()
        
        if 'name' not in kwargs:
            self.name = f"Remove Columns"
        
    
    def generate_remove_columns_codes(self):
        if isinstance(self.col_indices, list):
            cols_indices_str = str(self.col_indices)
        else:
            cols_indices_str = f"[{self.col_indices}]"

        self.codes = f"""# Remove columns by indices {cols_indices_str}
def transform(df):
    # Create a boolean mask for all columns
    mask = np.full(df.shape[1], False)
    # Set True for columns to be dropped
    mask[{cols_indices_str}] = True
    # Drop columns based on the mask
    output_df = df.loc[:, ~mask]
    return output_df"""

    def generate_remove_columns_samples(self):
        sample_df = self.sample_df[:4]
        self.sample_df = sample_df




class RemoveRowsStep(TransformationStep):

    def __init__(self, rows, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.rows = rows

        if self.explanation == "":
            self.explanation = f"""Remove rows {rows}"""
        
        self.generate_remove_rows_codes()
        self.generate_remove_rows_samples()

        if 'name' not in kwargs:
            self.name = f"Remove Rows"

    def generate_remove_rows_codes(self):
        if isinstance(self.rows, list):
            rows_str = str(self.rows)
        else:
            rows_str = f"[{self.rows}]"

        self.codes = f"""# Remove rows {rows_str}
def transform(df):
    output_df = df.drop(index={rows_str})
    return output_df"""

    def generate_remove_rows_samples(self):
        sample_df1 = self.sample_df[~self.sample_df.index.isin(self.rows)][:2]
        sample_df2 = self.sample_df[self.sample_df.index.isin(self.rows)][:2]
        sample_df = pd.concat([sample_df1, sample_df2])
        self.sample_df = sample_df

class RemoveDuplicatesStep(TransformationStep):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        if self.explanation == "":
            self.explanation = f"""Remove duplicate rows"""
        
        self.generate_remove_duplicates_codes()
        self.generate_remove_duplicates_samples()

        if 'name' not in kwargs:
            self.name = f"Remove Duplicates"
    
    def generate_remove_duplicates_codes(self):
        self.codes = f"""# Remove duplicate rows
def transform(df):
    output_df = df.drop_duplicates()
    return output_df"""

    def generate_remove_duplicates_samples(self):
        duplicate_mask = self.sample_df.duplicated(keep=False)
        duplicated_rows = self.sample_df[duplicate_mask]

        sample_duplicated_rows = duplicated_rows[:4]
        self.sample_df = sample_duplicated_rows

class CleanDataType(TransformationStep):

    def __init__(self, column_data_type_dict , *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.column_data_type_dict = column_data_type_dict

        if self.explanation == "":
            self.explanation = f"""Remove rows that don't match the data type"""

        self.generate_clean_data_type_codes()

        if 'name' not in kwargs:
            self.name = f"Clean Data Type"
    
    def generate_clean_data_type_codes(self):
        self.codes = f"""# Clean data type
def transform(df):
    data_type_dict = {self.column_data_type_dict}
    for column_name, data_type in data_type_dict.items():
        mask = select_invalid_data_type(df, column_name, data_type)
        df = df[~mask]
    return df"""


class ProjectionStep(TransformationStep):

    def __init__(self, cols, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.cols = cols

        all_cols = ", ".join(self.cols)

        self.explanation = f"""Keep only column {all_cols}"""
        self.generate_projection_codes()

        if hasattr(self, 'sample_df'):
            self.generate_projection_samples()

        if 'name' not in kwargs:
            self.name = f"Project {all_cols}"

    def generate_projection_codes(self):
        all_cols = ', '.join([f'"{col}"' for col in self.cols])

        self.codes = f"""# Keep only specified columns
def transform(df):
    output_df = df.copy()
    output_df = output_df[[{all_cols}]]
    return output_df"""

    def generate_projection_samples(self):
        sample_df = self.sample_df[:4]
        self.sample_df = sample_df



class RegexTransformationStep(TransformationStep):

    def __init__(self, col, unique_values, reason, *args, **kwargs):

        super().__init__(*args, **kwargs)

        if 'name' not in kwargs:
            self.name = f"Clean {col}"

        self.explanation = f"""Remove the unusual values from column {col}: {reason}"""

        self.col = col
        self.unique_values = unique_values
        self.reason = reason

    def generate_regex_codes(self, explanation=None):
        if not hasattr(self, 'labeled_result'):
            raise ValueError("Please run the edit_widget() function first.")

        unusual_values = self.labeled_result["unusual_values"]
        normal_values = self.labeled_result["normal_values"]


        self.sample_df[self.col] = self.sample_df[self.col].astype(str)

        sample_df1 = self.sample_df[self.sample_df[self.col].isin(normal_values)][:2]
        sample_df2 = self.sample_df[self.sample_df[self.col].isin(unusual_values)][:2]
        sample_df = pd.concat([sample_df1, sample_df2])
        self.sample_df = sample_df
        
        print("Generating codes...")

        progress = show_progress(1)
        try:
            regex_result = find_regex_pattern(self.col, self.labeled_result)
        except Exception as e:
            write_log(e)
            regex_result = {"exists_regex": False}

        progress.value += 1

        if regex_result["exists_regex"]:
            regex_pattern = regex_result["regex"]
            self.codes = f"""# Clean column {self.col} by removing the unusual rows that don't match the regex pattern
def transform(df):
    output_df = df.copy()

    # Transform the column to string type
    output_df["{self.col}"] = output_df["{self.col}"].astype(str)

    output_df = output_df[output_df["{self.col}"].str.match(r"{regex_pattern}")]
    return output_df"""

            self.explanation = f"""Remove the unusual values from column {self.col} by removing the rows that don't match the regex pattern: {regex_pattern}"""
        
        else:
            unusual_values = self.labeled_result["unusual_values"]
            self.codes = f"""# Clean column {self.col} by removing the unusual rows with unusual values
def transform(df):
    output_df = df.copy()

    # Transform the column to string type
    output_df["{self.col}"] = output_df["{self.col}"].astype(str)

    output_df = output_df[~output_df["{self.col}"].isin({unusual_values})]
    return output_df"""

            self.explanation = f"""Remove the unusual values from column {self.col} by removing the rows with unusual values: {unusual_values}"""

    def parent_edit_widget(self, callbackfunc=None):
        super().edit_widget(callbackfunc)


    def edit_widget(self, callbackfunc=None):

        print("Analyzing the unusual values...")

        if not hasattr(self, 'labeled_result'):
            progress = show_progress(1)
            result = classify_unusual_values(self.col, self.unique_values, self.reason)
            self.labeled_result = result
            progress.value += 1

        def create_tabular_widgets_toggle(result):
            grid_items = []

            grid_items.append(widgets.Label(value=''))
            grid_items.append(widgets.Label(value='Keep (Normal)'))
            grid_items.append(widgets.Label(value='Remove (Unusual)'))

            checkbox_widgets = {}

            for email in result['normal_values'] + result['unusual_values']:
                is_normal = email in result['normal_values']
                
                label = widgets.Label(value=email)
                grid_items.append(label)

                keep_checkbox = widgets.Checkbox(value=is_normal)
                grid_items.append(keep_checkbox)

                remove_checkbox = widgets.Checkbox(value=not is_normal)
                grid_items.append(remove_checkbox)

                checkbox_widgets[email] = (keep_checkbox, remove_checkbox)

                keep_checkbox.observe(lambda change, email=email: on_checkbox_toggle(change, email, 'keep'), names='value')
                remove_checkbox.observe(lambda change, email=email: on_checkbox_toggle(change, email, 'remove'), names='value')

            def on_checkbox_toggle(change, email, action):
                if change['new']:
                    if action == 'keep':
                        checkbox_widgets[email][1].value = False
                    else:
                        checkbox_widgets[email][0].value = False

            grid_layout = widgets.Layout(grid_template_columns="repeat(3, 33%)",
                                        align_items='center')
            grid_box = widgets.GridBox(children=grid_items, layout=grid_layout)

            submit_button = widgets.Button(description="Submit")

            def on_submit_button_clicked(b):
                clear_output(wait=True)

                updated_result = {'unusual_values': [], 'normal_values': []}
                for email, (keep_checkbox, remove_checkbox) in checkbox_widgets.items():
                    if keep_checkbox.value:
                        updated_result['normal_values'].append(email)
                    else:
                        updated_result['unusual_values'].append(email)
                
                self.labeled_result = updated_result
                
                self.generate_regex_codes()

                print("Done")

                self.parent_edit_widget(callbackfunc)


            submit_button.on_click(on_submit_button_clicked)

            display(grid_box, submit_button)

        print("Please verify the unusual values...")

        create_tabular_widgets_toggle(self.labeled_result)



class ColumnRename(TransformationStep):

    def __init__(self, rename_map, *args, **kwargs):

        super().__init__(*args, **kwargs)

        if 'name' not in kwargs:
            self.name = "Rename Columns"

        self.rename_map = rename_map
        self.explanation = f"""Rename columns in the DataFrame based on: \n"""

        valid_renaming = {}

        for old_name, new_name in self.rename_map.items():
            if old_name != new_name:
                valid_renaming[old_name] = new_name

        rename_map_str = "{\n"
        rename_map_str += "\n".join([f"    '{old}': '{new}'," for old, new in valid_renaming.items()])
        rename_map_str += "\n    }"

        self.explanation += rename_map_str
        
        self.generate_rename_codes()

    def verify_input(self, df):
        super().verify_input(df)

        if len(self.rename_map) != len(set(self.rename_map.keys())):
            raise ValueError("Some old column names are duplicated.")
        
        if len(self.rename_map) != len(set(self.rename_map.values())):
            raise ValueError("Some new column names are duplicated.")

        for old_name in self.rename_map.keys():
            if old_name not in df.columns:
                raise ValueError(f"Column {old_name} does not exist in the DataFrame.")

    def generate_rename_codes(self):

        valid_renaming = {}
        
        for old_name, new_name in self.rename_map.items():
            if old_name != new_name:
                valid_renaming[old_name] = new_name

        rename_map_str = "{\n"
        rename_map_str += "\n".join([f"        '{old}': '{new}'," for old, new in valid_renaming.items()])
        rename_map_str += "\n    }"

        self.codes = f"""# Rename columns in the DataFrame based on column indices to avoid circular issues
def transform(df):
    rename_map = {rename_map_str}
    # Create a list of the current column names
    new_column_names = list(df.columns)

    # Find the indices of the columns to be renamed and update their names
    for old_name, new_name in rename_map.items():
        if old_name in df.columns:
            index = df.columns.get_loc(old_name)
            new_column_names[index] = new_name
        else:
            raise ValueError(f'Column {{{{old_name}}}} not found in DataFrame')

    # Assign the new names to the DataFrame's columns
    df.columns = new_column_names
    return df
"""



        



class DocumentedDatabase:
    def __init__(self, doc_dfs):
        self.doc_dfs = doc_dfs
        
    def generate_pipeline(self):
        pipelines = []

        for doc_df in self.doc_dfs:
            pipelines.append(doc_df.generate_pipeline())

        final_pipeline = combine_pipelines(pipelines)
        return final_pipeline

class DataCleaning:
    def __init__(self, doc_df):
        self.doc_df = doc_df
        self.pipeline = doc_df.generate_pipeline()
    
    def __repr__(self):
        self.display()
        return ""

    def run_codes(self):
        return self.pipeline.run_codes()

    def display(self):
        

        self.pipeline.display(call_back=self.display)

        attributes = []
        issues = {}

        document = self.doc_df.document

        if "missing_value" in document:
            issues["missing_value"] = []
            for attribute in document["missing_value"]:
                item = document["missing_value"][attribute]
                if item:
                    attributes.append(attribute)
                    issues["missing_value"].append((attribute, item["summary"]))

        if "unusual" in document:
            issues["unusual"] = []
            for attribute in document["unusual"]:
                item = document["unusual"][attribute]["summary"]
                if item["Unusualness"]:
                    attributes.append(attribute)
                    issues["unusual"].append((attribute, item["Examples"]))

        self.recommends_transformation(issues)

    def recommends_transformation(self, issues):

        def on_button_clicked_missing(b):
            clear_output(wait=True)
            self.create_remove_missing_value_step(b.attribute, b.issue)

        boxes = []
        for attribute, issue in issues["missing_value"]:
            label = widgets.HTML(value=f"❓ <b>{attribute}</b> has missing values: {issue}")

            button = widgets.Button(description=f"Remove them")
            button.attribute = attribute
            button.issue = issue
            button.on_click(on_button_clicked_missing)

            box = widgets.VBox([label, button])
            boxes.append(box)

        def on_button_clicked(b):
            clear_output(wait=True)
            unique_values = self.doc_df.df[b.attribute].dropna().unique()[:20]
            self.create_regex_step(b.attribute, b.issue, unique_values)
            
        for attribute, issue in issues["unusual"]:
            label = widgets.HTML(value=f"🤔 <b>{attribute}</b> has unusual value: {issue}")

            button = widgets.Button(description=f"Remove them")
            button.attribute = attribute
            button.issue = issue
            button.on_click(on_button_clicked)

            box = widgets.VBox([label, button])
            boxes.append(box)

        def on_remove_last_clicked(b):
            clear_output(wait=True)
            self.add_remove_last_step()

        remove_last_button = widgets.Button(description="⚠️ Remove Last")
        remove_last_button.on_click(on_remove_last_clicked)
        box = widgets.VBox([remove_last_button])
        boxes.append(box)


        label = widgets.HTML(value=f"🎲 Want to perform an ad hoc transformation?")

        def on_ad_hoc_clicked(b):
            clear_output(wait=True)
            self.create_ad_hoc_step()

        adhoc_button = widgets.Button(description="Ad hoc")
        adhoc_button.on_click(on_ad_hoc_clicked)
        box = widgets.VBox([label, adhoc_button])
        boxes.append(box)


        display(widgets.VBox(boxes))

    
    def add_remove_last_step(self):
        self.pipeline.remove_final_node()
        self.final_shape = self.pipeline.run_codes()
        clear_output(wait=True)
        self.display()

    def create_remove_missing_value_step(self, col, reason):


        sample_output = self.doc_df.df

        remove_missing_value_step = RemoveMissingValueStep(col=col, reason=reason, sample_df=sample_output)

        def callback(remove_missing_value_step):
            if remove_missing_value_step.explanation != "" or remove_missing_value_step.codes != "":
                self.pipeline.add_step_to_final(remove_missing_value_step)
            clear_output(wait=True)
            self.display()

        callbackfunc = callback
        
        remove_missing_value_step.edit_widget(callbackfunc=callbackfunc)


    def create_regex_step(self, col, reason, unique_values):


        sample_output = self.doc_df.df

        regex_step = RegexTransformationStep(col=col, unique_values=unique_values, reason=reason, sample_df=sample_output)

        def callback(regex_step):
            if regex_step.explanation != "" or regex_step.codes != "":
                
                self.pipeline.add_step_to_final(regex_step)

            clear_output(wait=True)
            self.display()

        callbackfunc = callback

        regex_step.edit_widget(callbackfunc=callbackfunc)

    def create_ad_hoc_step(self):

        final_node = self.pipeline.find_final_node()
        final_step = self.pipeline.get_step(final_node)
        sample_output = final_step.get_sample_output()

        add_hoc_step = TransformationStep(name="Ad hoc", sample_df=sample_output)

        def callback(add_hoc_step):
            if add_hoc_step.explanation != "" or add_hoc_step.codes != "":
                add_hoc_step.rename_based_on_explanation()
                self.pipeline.add_step_to_final(add_hoc_step)
            clear_output(wait=True)
            self.display()

        callbackfunc = callback

        add_hoc_step.edit_widget(callbackfunc=callbackfunc)
    
    def print_codes(self):
        self.pipeline.print_codes()

    def generate_pipeline(self):
        return self.pipeline

def replace_nan(df):
    for col in df.columns:
        df[col] = df[col].fillna("")
    return df

def embed_string(string, engine=None):

    try:
        response = call_embed(string)
        embeddings = response['data'][0]['embedding']
        return embeddings
    except Exception as e:
        print(f"An error occurred while embedding: {e}")
        return None

def initialize_output_csv(df, output_csv_address, label='label'):
    try:
        df_output = pd.read_csv(output_csv_address)
    except FileNotFoundError:
        df_output = get_unique_labels_with_ids(df, label='label')
        df_output.to_csv(output_csv_address, index=False)
    return df_output

def find_first_nan_index(df, column_name):
    """
    Finds the first index in a DataFrame column that is NaN.
    
    :param df: pandas DataFrame object
    :param column_name: String name of the column to search for NaN
    :return: The index of the first NaN value, or None if no NaN found
    """
    nan_index = df[column_name].isna().idxmax()
    if pd.isna(df[column_name][nan_index]):
        return nan_index
    else:
        return None

def embed_labels(df, output_csv_address, chunk_size=1000, label='label'):
    df_output = initialize_output_csv(df, output_csv_address, label='label')

    start_index = find_first_nan_index(df_output, 'embedding')

    if start_index is None:
        print("All labels already embedded.")
        return df_output

    pbar = tqdm(total=len(df_output), desc="Embedding Labels", unit="label")

    pbar.update(start_index)

    for chunk_start in range(start_index, len(df_output), chunk_size):
        chunk_end = min(chunk_start + chunk_size, len(df_output))
        labels_chunk = df_output[label][chunk_start:chunk_end]

        for i, label_value in enumerate(labels_chunk):
            if pd.isna(df_output.at[chunk_start + i, 'embedding']):
                embeddings = embed_string(label_value)
                if embeddings is not None:
                    df_output.at[chunk_start + i, 'embedding'] = embeddings
            pbar.update(1)

        df_output.to_csv(output_csv_address, index=False)

    pbar.close()
    
    print("All labels embedded and CSV updated.")

    return df_output

def get_unique_labels(df, label='label'):
    unique_labels = df[label].dropna().unique()
    return unique_labels


def parse_json_col(df, col='embedding'):
    df[col] = df[col].apply(ast.literal_eval)
    return df


def load_embedding(df, label_embedding='embedding', dim=1536):
    
    if not isinstance(df[label_embedding].iloc[0], list):
        df = parse_json_col(df, col=label_embedding)

    embeddings_array = np.array(list(df[label_embedding]), dtype=np.float32)
    index = faiss.IndexFlatL2(dim)
    index.add(embeddings_array)
    return index

def adhoc_search(string, index, topk=10):
    adhoc_embed = embed_string(string)
    D, I = index.search(np.array([adhoc_embed], dtype=np.float32), topk) 
    return D, I

def df_search(df, index, label_embedding='embedding', topk=10):

    if not isinstance(df[label_embedding].iloc[0], list):
        df = parse_json_col(df, col=label_embedding)

    embeddings = list(df[label_embedding])
    D, I = index.search(np.array(embeddings, dtype=np.float32), topk) 
    return D, I

def flatten_append(df, std_df, D, I, topk=10):
    df = df.loc[df.index.repeat(topk)].reset_index(drop=True)
    df['D_values'] = D.flatten()
    df['I_values'] = I.flatten()
    df['rank'] = (df.index % topk) + 1

    for col in std_df.columns:
        df[col] = std_df.iloc[df['I_values'].values][col].values

    return df

def display_matches(reference_df, 
                    input_df, 
                    I, 
                    exclude_columns=['label', 'index_ids', 'embedding'],
                    label_col = 'label'):

    
    current_page = 0

    def create_html_content(page_no):
        label = input_df[label_col][page_no]
        results_indices = I[page_no]
        results = reference_df.iloc[results_indices][label_col]
        results = [result.replace('\n', '<br>') for result in results]
        results_html = "<ul>" + "".join(f"<li>{result}</li>" for result in results) + "</ul>"
        html_content = f"<b>Input Label</b>: {df_row_to_column_value(input_df, idx=page_no, exclude_columns=exclude_columns).to_html()}<br><b>Top 10 Matches</b>:{results_html}"
        return html_content

    def update_html_display(page_no):
        html_display.value = create_html_content(page_no)
        page_label.value = f'Page {page_no + 1} of {len(input_df)}'
    
    def on_prev_clicked(b):
        nonlocal current_page
        if current_page > 0:
            current_page -= 1
            update_html_display(current_page)

    def on_next_clicked(b):
        nonlocal current_page
        if current_page < len(input_df) - 1:
            current_page += 1
            update_html_display(current_page)
    
    html_display = widgets.HTML(value=create_html_content(current_page))
    
    btn_prev = widgets.Button(description='Previous Page')
    btn_next = widgets.Button(description='Next Page')
    
    btn_prev.on_click(on_prev_clicked)
    btn_next.on_click(on_next_clicked)

    page_label = widgets.Label(value=f'Page {current_page + 1} of {len(input_df)}')
    
    navigation_bar = widgets.HBox([btn_prev, page_label, btn_next])
    
    display(navigation_bar, html_display)


def check_functional_dependency(df, determinant, dependent):
    groups = df.groupby(list(determinant))[dependent].nunique()
    is_functionally_dependent = (groups == 1).all()
    return is_functionally_dependent


def get_unique_labels_with_ids(df, label = 'label'):
    df_cleaned = df.dropna(subset=['label'])

    grouped = df_cleaned.groupby('label')

    label_id_df = grouped.apply(lambda x: x.index.tolist()).reset_index(name='index_ids')

    dependent_columns = []

    for column in df_cleaned.columns:
        if column != 'label':
            if grouped[column].nunique().eq(1).all():
                dependent_columns.append(column)
    
    if dependent_columns:
        attributes_data = grouped[dependent_columns].first().reset_index()
        label_id_df = pd.merge(label_id_df, attributes_data, on='label', how='left')

    label_id_df['embedding'] = None

    return label_id_df


def df_row_to_column_value(df, idx=0, exclude_columns=[]):
    """
    Create a DataFrame of [column, value] pairs from a specified row index,
    excluding specified columns.

    Parameters:
    - df: The input DataFrame.
    - idx: The index of the row to use.
    - exclude_columns: A set or list of columns to exclude.

    Returns:
    - A new DataFrame with two columns: 'Column' and 'Value'.
    """

    df_reduced = df.drop(columns=exclude_columns, errors='ignore')

    if idx not in df_reduced.index:
        raise IndexError(f"Index {idx} is out of bounds for the DataFrame.")

    row_transposed = df_reduced.iloc[idx].transpose()

    new_df = pd.DataFrame(row_transposed)
    new_df.reset_index(inplace=True)
    new_df.columns = ['Column', 'Value']

    return new_df

def extract_json_code_safe(s):
    s_stripped = s.strip()
    if (s_stripped.startswith('{') and s_stripped.endswith('}')) or \
       (s_stripped.startswith('[') and s_stripped.endswith(']')):
        return s_stripped
    return extract_json_code(s_stripped)

def extract_json_code(s):
    import re
    pattern = r"```json(.*?)```"
    match = re.search(pattern, s, re.DOTALL)
    return match.group(1).strip() if match else None

def compute_cluster(df, match="matches"):
    clusters = {}

    for idx, row in df.iterrows():
        entry = row[match]
        if 'similar_to' not in entry:
            clusters[idx] = []

    for idx, row in df.iterrows():
        entry = row[match]
        if 'similar_to' in entry:
            similar_to_idx = entry['similar_to']
            if similar_to_idx in clusters:
                clusters[similar_to_idx].append(idx)
            elif similar_to_idx not in clusters:
                clusters[similar_to_idx] = [idx]
    return clusters

def generate_report_for_cluster(df, clusters, exclude_columns=['label', 'index_ids', 'embedding','matches'], match_col='matches'):
    middle_html = ""

    for i in clusters:

        js = clusters[i] 
        middle_html += f"""<h1>{i+1}</h1>
{generate_page_clusters(df=df, clusters=clusters, i=i, js=js, exclude_columns=exclude_columns, match_col=match_col)}"""

    title_html = f'<div style="display: flex; align-items: center;">' \
        f'<img src="data:image/png;base64,{cocoon_icon_64}" alt="cocoon icon" width=50 style="margin-right: 10px;">' \
        f'<div style="margin: 0; padding: 0;">' \
        f'<h1 style="margin: 0; padding: 0;">Table Standardization</h1>' \
        f'<p style="margin: 0; padding: 0;">Powered by cocoon</p>' \
        f'</div>' \
        f'</div><hr>'


    full_html = f"""<!DOCTYPE html>
<html>
<head>
    <title>Cocoon Standardization</title>
    <head>
        <style>
    /* CSS for the overall appearance: fonts, spacing, etc. */
    body {{
        font-family: "Arial";
        margin: 40px;
        background-color: #d9ead3;  /* Matching the light green background of the icon */
    }}

    .container {{
        max-width: 900px;  /* Setting a maximum width for the content */
        margin: 0 auto;   /* Centering the container */
        background-color: #ffffff; /* White background for the main content */
        padding: 20px;
        border-radius: 5px; /* Rounded corners */
        box-shadow: 0 0 10px rgba(0,0,0,0.1); /* A subtle shadow to lift the container */
    }}

    h1 {{
        font-size: 24px;
        color: #274e13; /* Dark green color matching the icon */
        padding-bottom: 10px;
        margin-bottom: 20px;
    }}

    h2 {{
        font-size: 20px;
        margin-top: 20px;
        margin-bottom: 15px;
    }}

    ul, ol {{
        padding-left: 20px;
    }}

    li {{
        margin-bottom: 10px;    }}

    p {{        margin-bottom: 20px;
        text-align: justify; /* To align the text on both sides */
    }}

    /* CSS specific to the table elements */
    table {{
        font-family: Arial, sans-serif;
        border-collapse: collapse; /* Ensures there are no double borders */
        width: 100%;
        table-layout: auto;
    }}

    th, td {{
        border: 1px solid #dddddd; /* Light grey borders */
        text-align: left;
        padding: 8px; /* Make text not touch the borders */
    }}

    th {{
        background-color: #b6d7a8; /* Light green background matching the icon */
    }}

    tr:nth-child(even) {{
        background-color: #d9ead3; /* Light green background matching the icon */
    }}

    tr:hover {{
        background-color: #c9d9b3; /* A slightly darker green for hover effect */
    }}
    </style>
</head>
<body>
    
    <div class="container">
        {title_html}
        {middle_html}
    </div>
</body>
</html>
"""
    return full_html

def entity_relation_match(input_df, I, refernece_df, attributes=None, label = "label", match="matches"):
    
    if match not in input_df:
        input_df[match] = None

    if attributes is None:
        attributes = input_df.columns.tolist()
        attributes.remove("label")
        attributes.remove("index_ids")
        attributes.remove("embedding")

    for idx in range(len(input_df)):
        print(f"💪 Working on the row {idx+1} ...")

        if input_df[match][idx] is not None:
            continue

        input_desc = ""
        for attribute in attributes:
            input_desc += (attribute + ": " + input_df.iloc[idx][attribute] + "\n")

        refernece_desc = ""
        for i, output in enumerate(refernece_df[label].iloc[I[idx]]): 
            refernece_desc += (str(i+1) + ". " + output + "\n")

        template = f"""Your goal is to build relations between input and reference entities.

The input entity has the following attributes:
{input_desc}
Below are reference entities:
{refernece_desc}
Do the following:
1. Read input entity attributes and guess what it is about.

2. Go through each output entity. Describe what it is and reason its relation.
For instance, given the input entity "small car":
if the same entity then EXACT_MATCH. 
    E.g., "small automobile"
else if has assumptions that is clearly wrong then CONFLICTED_ASSUMPTION
    E.g., "big car" is wrong because input entity clearly specify size as "small"
else if additional assumptions that can't be verified then ADDITIONAL_ASSUMPTION
    E.g., "electronic car" is additional battery assumption can't be verified
else if it is general super class then GENERAL 
    E.g., "small vehicle" and "car" are general category of "small car"
else it is irrelavent entity then NOT_RELATED
    E.g., "cloth" is a irrelavent

The list is prioritized. Choose the first one that applies. Provide your answer as json:
```json
{{       
        "Input Entity Guess": "...",
        "EXACT_MATCH": {{
                "reason": "The input entity is ... which matches ...",
                "entity": [...] (A list of reference entity names)

        }},
        "CONFLICTED_ASSUMPTION": {{
                "reason": "The (what specific) details are conflicted",
                "entity": [...]

        }},
        "ADDITIONAL_ASSUMPTION": {{
                "reason": "The (what specific) details are not mentioned",
                "entity": [...]

        }},
        "GENERAL": {{
                "reason": "How these entites are more general",
                "entity": [...]
        }}
        (DON'T include NOT_RELATED!)
}}
```
"""
        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_var = json.loads(json_code)
        input_df.at[idx, match] = json_var

def entity_relation_match_cluster(input_df, I, refernece_df, attributes=None, label = "label", match="matches", verbose=False):

    emdeb_searcher = EmbeddingSearcher(input_df)

    if match not in input_df:
        input_df[match] = None


    for idx in range(len(input_df)):
        if input_df[match][idx] is not None:
            emdeb_searcher.remove_rows(idx)

    if attributes is None:
        attributes = input_df.columns.tolist()
        attributes.remove("label")
        attributes.remove("index_ids")
        attributes.remove("embedding")

    while not emdeb_searcher.is_index_empty():
        print(f"👉 {emdeb_searcher.get_size()} rows remain...")
        

        idx = emdeb_searcher.get_valid_id()

        emdeb_searcher.remove_rows(idx)
            
        input_desc = ""
        for attribute in attributes:
            input_desc += (attribute + ": " + input_df.iloc[idx][attribute] + "\n")
        
        reference_entities = list(refernece_df[label].iloc[I[idx]])

        refernece_desc = ""
        for i, output in enumerate(refernece_df[label].iloc[I[idx]]): 
            refernece_desc += (str(i+1) + ". " + output + "\n")
        if verbose:
            print(f"👉 Input: {input_desc}")
            print(f"👉 Reference: {refernece_desc}")

        json_var = entity_relation_match_one(input_desc, refernece_desc)

        def replace_indices_with_entities(json_var, reference_entities):
            for category in json_var:
                if isinstance(json_var[category], dict) and "entity" in json_var[category]:
                    json_var[category]["entity"] = [reference_entities[int(idx) - 1] for idx in json_var[category]["entity"]]
            return json_var

        json_var = replace_indices_with_entities(json_var, reference_entities)

        if verbose:        
            print(f"👉 Match: {json.dumps(json_var, indent=4)}")

        all_indicies = []



        related_rows = emdeb_searcher.search_by_row_index(idx, k=30)

        if len(related_rows) > 0:





            entity_desc = json_var["Summary of Relations"]
            refernece_desc = related_rows[attributes].reset_index(drop=True).to_csv(quoting=2)

            json_var2 = find_relation_satisfy_description(entity_desc=entity_desc, 
                                                        related_rows_desc_str=refernece_desc)
            
            indicies = json_var2["indices"]

            ids = []
            for index in indicies:
                ids.append(list(related_rows.index)[index])
            
            all_indicies += ids
            emdeb_searcher.remove_rows(ids)


            json_var3 = {"similar_to": idx}
            for i, index in enumerate(all_indicies):
                input_df.at[index, match] = json_var3
        
        input_df.at[idx, match] = json_var

def generate_html_from_json_entity(json_var):
    html_output = f"<p>&#x1F913; <b>This input entity is about:</b> <i>{json_var['Input Entity Guess']}</i><p>"
    if json_var['EXACT_MATCH']['entity']:
        html_output += "<p>&#x1F600; We find <u>exactly matched</u> entities:</p>"
        html_output += "<ul>"
        for entity in json_var['EXACT_MATCH']['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if json_var['EXACT_MATCH']['reason']:
            html_output += f"<p><b>Reason:</b> <i>{json_var['EXACT_MATCH']['reason']}</i></p>"
        html_output += "</body></html>"
    else:
        html_output += "<p>&#x1F641; We can't find <u>exactly matched</u> entities.</p>"

    if json_var['GENERAL']['entity']:
        html_output += "<p>&#x1F600; We find entities that are <u>more general</u>:</p>"
        html_output += "<ul>"
        for entity in json_var['GENERAL']['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if json_var['GENERAL']['reason']:
            html_output += f"<p><b>Reason:</b> <i>{json_var['GENERAL']['reason']}</i></p>"

    if json_var['ADDITIONAL_ASSUMPTION']['entity']:
        html_output += "<p>&#x1F600; We find entities but with <u>additional details</u> that need verification:</p>"
        html_output += "<ul>"
        for entity in json_var['ADDITIONAL_ASSUMPTION']['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if json_var['ADDITIONAL_ASSUMPTION']['reason']:
            html_output += f"<p><b>Reason:</b> <i>{json_var['ADDITIONAL_ASSUMPTION']['reason']}</i></p>"

    if json_var['CONFLICTED_ASSUMPTION']['entity']:
        html_output += "<p>&#x1F600; We find entities that are <u>similar, but details are different</u>:</p>"
        html_output += "<ul>"
        for entity in json_var['CONFLICTED_ASSUMPTION']['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if json_var['CONFLICTED_ASSUMPTION']['reason']:
            html_output += f"<p><b>Reason:</b> <i>{json_var['CONFLICTED_ASSUMPTION']['reason']}</i></p>"

    return html_output


def generate_entity_page(df, i=0, exclude_columns=['label', 'index_ids', 'embedding','matches'], match_col="matches"):

    if isinstance(df[match_col].iloc[0], str):
        df = parse_json_col(df, col=match_col)
    
    input_data_html = df_row_to_column_value(df, idx=i, exclude_columns=exclude_columns).to_html(index=False)
    json_var = df[match_col][i]
    solution_output_html = generate_html_from_json_entity(json_var)

    return f"""<h1>Input Data</h1>
{input_data_html}
<h1>Match Result</h1>
{solution_output_html}"""

def display_entity_matches(df, exclude_columns=['label', 'index_ids', 'embedding','matches'], match_col="matches"):
    if isinstance(df[match_col].iloc[0], str):
        df = parse_json_col(df, col=match_col)

    current_page = 0

    def create_html_content(page_no):
        return generate_entity_page(df, page_no, exclude_columns, match_col)

    def update_html_display(page_no):
        html_display.value = create_html_content(page_no)
        page_label.value = f'Page {page_no + 1} of {len(df)}'
    
    def on_prev_clicked(b):
        nonlocal current_page
        if current_page > 0:
            current_page -= 1
            update_html_display(current_page)

    def on_next_clicked(b):
        nonlocal current_page
        if current_page < len(df) - 1:
            current_page += 1
            update_html_display(current_page)
    
    html_display = widgets.HTML(value=create_html_content(current_page))
    
    btn_prev = widgets.Button(description='Previous Page')
    btn_next = widgets.Button(description='Next Page')
    
    btn_prev.on_click(on_prev_clicked)
    btn_next.on_click(on_next_clicked)

    page_label = widgets.Label(value=f'Page {current_page + 1} of {len(df)}')
    
    navigation_bar = widgets.HBox([btn_prev, page_label, btn_next])
    
    display(navigation_bar, html_display)

def generate_html_from_json(json_var):
    
    html_output = ""
    
    if 'Input Entity Guess' in json_var:
        html_output += f"<p>&#x1F913; <b>This input entity is about:</b> <i>{json_var.get('Input Entity Guess', 'Unknown')}</i></p>"

    exact_matches = json_var.get('EXACT_MATCH', {})
    if exact_matches.get('entity'):
        html_output += "<p>&#x1F600; We find <u>exactly matched</u> entities:</p><ul>"
        for entity in exact_matches['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if exact_matches.get('reason'):
            html_output += f"<p><b>Reason:</b> <i>{exact_matches['reason']}</i></p>"
    else:
        html_output += "<p>&#x1F641; We can't find <u>exactly matched</u> entities.</p>"

    general_matches = json_var.get('GENERAL', {})
    if general_matches.get('entity'):
        html_output += "<p>&#x1F600; We find entities that are <u>more general</u>:</p><ul>"
        for entity in general_matches['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if general_matches.get('reason'):
            html_output += f"<p><b>Reason:</b> <i>{general_matches['reason']}</i></p>"

    additional_assumptions = json_var.get('ADDITIONAL_ASSUMPTION', {})
    if additional_assumptions.get('entity'):
        html_output += "<p>&#x1F600; We find entities but with <u>additional details</u> that need verification:</p><ul>"
        for entity in additional_assumptions['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if additional_assumptions.get('reason'):
            html_output += f"<p><b>Reason:</b> <i>{additional_assumptions['reason']}</i></p>"

    conflicted_assumptions = json_var.get('CONFLICTED_ASSUMPTION', {})
    if conflicted_assumptions.get('entity'):
        html_output += "<p>&#x1F600; We find entities that are <u>similar, but details are different</u>:</p><ul>"
        for entity in conflicted_assumptions['entity']:
            html_output += f"<li>{entity}</li>"
        html_output += "</ul>"
        if conflicted_assumptions.get('reason'):
            html_output += f"<p><b>Reason:</b> <i>{conflicted_assumptions['reason']}</i></p>"

    return html_output




def generate_page_clusters(df, clusters, i=0, js=[], exclude_columns=['label', 'index_ids', 'embedding', 'matches'], match_col='matches'):
    input_data_html = df_row_to_column_value(df, idx=i, exclude_columns=exclude_columns).to_html(index=False)
    similar_data_html = ""
    for j in clusters[i]:
        similar_data_html += df_row_to_column_value(df, idx=j, exclude_columns=exclude_columns).to_html(index=False)
    json_var = df[match_col][i]
    solution_output_html = generate_html_from_json(json_var)

    similar_data_section = ""
    if len(js) > 0:
        similar_data_section = f"<h1>Similar Data</h1>\n{similar_data_html}"

    return f"""<h1>Input Data</h1>
{input_data_html}
{similar_data_section}
<h1>Match Result</h1>
{solution_output_html}"""


def generate_page(df, i=0, exclude_columns=['label', 'index_ids', 'embedding','matches'], match_col='matches'):
    input_data_html = df_row_to_column_value(df, idx=i, exclude_columns=exclude_columns).to_html(index=False)
    json_var = df[match_col][i]
    solution_output_html = generate_html_from_json(json_var)

    return f"""<h1>Input Data</h1>
{input_data_html}
<h1>Match Result</h1>
{solution_output_html}"""

def write_report_to_file(df, output_html_address, exclude_columns=['label', 'index_ids', 'embedding','matches'], match_col='matches'):

    full_html = generate_report(df, exclude_columns=exclude_columns)

    with open(output_html_address, 'w') as f:
        f.write(full_html)

def print_report(df, exclude_columns=['label', 'index_ids', 'embedding','matches'], match_col='matches'):
    
    full_html = generate_report(df, exclude_columns=exclude_columns)

    display(HTML(full_html))

def generate_report(df, exclude_columns=['label', 'index_ids', 'embedding','matches'], match_col='matches'):
    middle_html = ""

    for i in range(len(df)):
        json_var = df[match_col][i]

        middle_html += f"""<h1>{i+1}</h1>
{generate_page(df=df, i=i, exclude_columns=exclude_columns, match_col=match_col)}"""

    title_html = f'<div style="display: flex; align-items: center;">' \
        f'<img src="data:image/png;base64,{cocoon_icon_64}" alt="cocoon icon" width=50 style="margin-right: 10px;">' \
        f'<div style="margin: 0; padding: 0;">' \
        f'<h1 style="margin: 0; padding: 0;">Fuzzy Join</h1>' \
        f'<p style="margin: 0; padding: 0;">Powered by cocoon</p>' \
        f'</div>' \
        f'</div><hr>'


    full_html = f"""<!DOCTYPE html>
<html>
<head>
    <title>Cocoon Standardization</title>
    <head>
        <style>
    /* CSS for the overall appearance: fonts, spacing, etc. */
    body {{
        font-family: "Arial";
        margin: 40px;
        background-color: #d9ead3;  /* Matching the light green background of the icon */
    }}

    .container {{
        max-width: 900px;  /* Setting a maximum width for the content */
        margin: 0 auto;   /* Centering the container */
        background-color: #ffffff; /* White background for the main content */
        padding: 20px;
        border-radius: 5px; /* Rounded corners */
        box-shadow: 0 0 10px rgba(0,0,0,0.1); /* A subtle shadow to lift the container */
    }}

    h1 {{
        font-size: 24px;
        color: #274e13; /* Dark green color matching the icon */
        padding-bottom: 10px;
        margin-bottom: 20px;
    }}

    h2 {{
        font-size: 20px;
        margin-top: 20px;
        margin-bottom: 15px;
    }}

    ul, ol {{
        padding-left: 20px;
    }}

    li {{
        margin-bottom: 10px;    }}

    p {{        margin-bottom: 20px;
        text-align: justify; /* To align the text on both sides */
    }}

    /* CSS specific to the table elements */
    table {{
        font-family: Arial, sans-serif;
        border-collapse: collapse; /* Ensures there are no double borders */
        width: 100%;
        table-layout: auto;
    }}

    th, td {{
        border: 1px solid #dddddd; /* Light grey borders */
        text-align: left;
        padding: 8px; /* Make text not touch the borders */
    }}

    th {{
        background-color: #b6d7a8; /* Light green background matching the icon */
    }}

    tr:nth-child(even) {{
        background-color: #d9ead3; /* Light green background matching the icon */
    }}

    tr:hover {{
        background-color: #c9d9b3; /* A slightly darker green for hover effect */
    }}
    </style>
</head>
<body>
    
    <div class="container">
        {title_html}
        {middle_html}
    </div>
</body>
</html>
"""
    return full_html


def CRS_select(callbackfunc=None):

    checkbox1 = widgets.Checkbox(description='String', value=True, indent=False)
    checkbox2 = widgets.Checkbox(description='Parameters', value=False, indent=False)

    text_input1 = widgets.Text(description='', indent=False)

    box1 = widgets.VBox([text_input1])
    
    projection_label = widgets.Label(value='Projection Parameters', style={'font_weight': 'bold'})
    projection_description = widgets.Label(value='Select the type of map projection.')

    proj_options = [
        ('Albers Equal Area', 'aea'), 
        ('Mercator', 'merc'), 
        ('Lambert Conformal Conic', 'lcc'), 
        ('Universal Transverse Mercator', 'utm'), 
        ('Longitude/Latitude', 'longlat'),
        ('Stereographic', 'stere'),
        ('Gnomonic', 'gnom'),
        ('Lambert Azimuthal Equal Area', 'laea'),
        ('Transverse Mercator', 'tmerc'),
        ('Robinson', 'robin')
    ]
    proj_dropdown = widgets.Dropdown(options=proj_options, value='aea', description='Projection:')

    def update_visibility(*args):
        projection_uses = {
            'aea': {'lat_lon': True, 'standard_parallels': True, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'merc': {'lat_lon': True, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'lcc': {'lat_lon': True, 'standard_parallels': True, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'utm': {'lat_lon': False, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'longlat': {'lat_lon': False, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': False, 'scale_factor': False},
            'stere': {'lat_lon': True, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'gnom': {'lat_lon': True, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'laea': {'lat_lon': True, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'tmerc': {'lat_lon': True, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True},
            'robin': {'lat_lon': True, 'standard_parallels': False, 'ellipsoid_datum': True, 'false_easting_northing': True, 'scale_factor': True}
        }

        uses = projection_uses[proj_dropdown.value]
        lat_0.disabled = not uses['lat_lon']
        lon_0.disabled = not uses['lat_lon']
        lat_1.disabled = not uses['standard_parallels']
        lat_2.disabled = not uses['standard_parallels']
        ellps_dropdown.disabled = not uses['ellipsoid_datum']
        datum_dropdown.disabled = not uses['ellipsoid_datum']
        false_easting.disabled = not uses['false_easting_northing']
        false_northing.disabled = not uses['false_easting_northing']
        scale_factor.disabled = not uses['scale_factor']


    proj_dropdown.observe(update_visibility, 'value')

    projection_group = widgets.VBox([projection_label, projection_description, proj_dropdown])

    central_meridian_label = widgets.Label(value='Central Meridian and Latitude of Origin', style={'font_weight': 'bold'})
    central_meridian_description = widgets.Label(value='Define the central point of the projection.')

    lat_0 = widgets.FloatText(value=0, description='lat_0:')
    lon_0 = widgets.FloatText(value=0, description='lon_0:')

    central_meridian_group = widgets.VBox([central_meridian_label, central_meridian_description, lat_0, lon_0])



    standard_parallels_label = widgets.Label(value='Standard Parallels', style={'font_weight': 'bold'})
    standard_parallels_description = widgets.Label(value='Standard parallels for accurate map scale.')

    lat_1 = widgets.FloatText(value=20, description='lat_1:')
    lat_2 = widgets.FloatText(value=60, description='lat_2:')

    standard_parallels_group = widgets.VBox([standard_parallels_label, standard_parallels_description, lat_1, lat_2])

    ellipsoid_datum_label = widgets.Label(value='Ellipsoid and Datum Parameters', style={'font_weight': 'bold'})
    ellipsoid_datum_description = widgets.Label(value='Choose the ellipsoid model and datum.')

    ellps_options = [
        'WGS84', 'GRS80', 'Airy', 'Bessel', 'Clarke1866', 'Clarke1880', 
        'International', 'Krassovsky', 'GRS67', 'Australian', 'Hayford', 
        'Helmert1906', 'IERS1989', 'IERS2003', 'SouthAmerican1969'
    ]
    ellps_dropdown = widgets.Dropdown(options=ellps_options, value='WGS84', description='Ellipsoid:')


    datum_options = [
        'WGS84', 'NAD83', 'NAD27', 'ED50', 'OSGB36', 'GDA94', 'Pulkovo1942', 
        'AGD66', 'AGD84', 'SAD69', 'Ireland1965', 'NZGD49', 'ATS77', 'JGD2000'
    ]
    datum_dropdown = widgets.Dropdown(options=datum_options, value='WGS84', description='Datum:')


    ellipsoid_datum_group = widgets.VBox([ellipsoid_datum_label, ellipsoid_datum_description, ellps_dropdown, datum_dropdown])

    false_easting_northing_label = widgets.Label(value='False Easting and Northing', style={'font_weight': 'bold'})
    false_easting_northing_description = widgets.Label(value='Shifts the origin of the map by specific units.')

    false_easting = widgets.FloatText(value=0, description='+x_0:')
    false_northing = widgets.FloatText(value=0, description='+y_0:')

    false_easting_northing_group = widgets.VBox([false_easting_northing_label, false_easting_northing_description, false_easting, false_northing])


    scale_factor_label = widgets.Label(value='Scale Factor', style={'font_weight': 'bold'})
    scale_factor_description = widgets.Label(value='Multiplier to reduce or increase the scale of the projection.')

    scale_factor = widgets.FloatText(value=1.0, description='+k:')

    scale_factor_group = widgets.VBox([scale_factor_label, scale_factor_description, scale_factor])


    submit_button = widgets.Button(description='Create CRS')

    def on_submit_clicked(b):
        crs_string = None
        if checkbox1.value and not checkbox2.value:
            crs_string = text_input1.value
        elif checkbox2.value and not checkbox1.value:
            parts = [f"+proj={proj_dropdown.value}"]

            if not lat_0.disabled:
                parts.append(f"+lat_0={lat_0.value}")
            if not lon_0.disabled:
                parts.append(f"+lon_0={lon_0.value}")
            if not lat_1.disabled:
                parts.append(f"+lat_1={lat_1.value}")
            if not lat_2.disabled:
                parts.append(f"+lat_2={lat_2.value}")
            if not ellps_dropdown.disabled:
                parts.append(f"+ellps={ellps_dropdown.value}")
            if not datum_dropdown.disabled:
                parts.append(f"+datum={datum_dropdown.value}")
            if not false_easting.disabled:
                parts.append(f"+x_0={false_easting.value}")
            if not false_northing.disabled:
                parts.append(f"+y_0={false_northing.value}")
            if not scale_factor.disabled:
                parts.append(f"+k={scale_factor.value}")

            crs_string = " ".join(parts)

        callbackfunc(crs_string)

    submit_button.on_click(on_submit_clicked)


    update_visibility()

    box2 = widgets.VBox([projection_group, 
    central_meridian_group, 
    standard_parallels_group, 
    ellipsoid_datum_group, 
    false_easting_northing_group,
    scale_factor_group
    ])

    box1.layout.display = 'flex'
    box2.layout.display = 'none'

    def update_widgets(change):
        
        if change['owner'] == checkbox1:
            checkbox2.value = not checkbox1.value
            box1.layout.display = 'none' if not checkbox1.value else 'flex'
            box2.layout.display = 'none' if checkbox1.value else 'flex'
        elif change['owner'] == checkbox2:
            checkbox1.value = not checkbox2.value
            box1.layout.display = 'none' if checkbox2.value else 'flex'
            box2.layout.display = 'none' if not checkbox2.value else 'flex'

    checkbox1.observe(update_widgets, names='value')
    checkbox2.observe(update_widgets, names='value')

    display(checkbox1, box1, checkbox2, box2, submit_button)




def lightweight_copy(df, columns_to_copy=[]):
    
    
    
    
    
    new_df = pd.DataFrame(index=df.index, columns=df.columns)
    
    for col in df.columns:
        if col in columns_to_copy:
            new_df[col] = df[col].copy()
        else:
            new_df[col] = df[col]

    return new_df



def plot_efficient_grid(df, x_col, y_col, value_col=None):

    if value_col:
        value_columns = [value_col]
    else:
        numeric_columns = df.select_dtypes(include=np.number).columns
        value_columns = [col for col in numeric_columns if col not in [x_col, y_col]]
        value_columns = value_columns[:5]

    n_rows = len(value_columns)
    fig, axs = plt.subplots(n_rows, 1, figsize=(6, 3 * n_rows))

    if n_rows == 1:
        axs = [axs]

    for i, value_col in enumerate(value_columns):
        pivot_table = df.pivot_table(index=y_col, columns=x_col, values=value_col, aggfunc='sum', fill_value=0)
        if isinstance(pivot_table.columns, pd.MultiIndex):
            pivot_table.columns = pivot_table.columns.get_level_values(1)

        pivot_table = pivot_table.where(pd.notnull(pivot_table), np.nan)

        cmap = plt.cm.viridis
        cmap.set_bad(color='white')

        im = axs[i].imshow(pivot_table.values, cmap=cmap)
        axs[i].set_title(f"Heatmap for {value_col}")

        plt.colorbar(im, ax=axs[i], fraction=0.046, pad=0.04, aspect=10)

    plt.tight_layout()
    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')
    return image_base64

def are_crs_equivalent(crs_string1, crs_string2):

    crs1 = CRS(crs_string1)
    crs2 = CRS(crs_string2)
    return crs1 == crs2

def apply_affine_transform(affine_matrix, x, y, offset='ul'):
    homogeneous_coords = np.vstack([x, y, np.ones_like(x)])

    transformed_x, transformed_y, _ = np.dot(affine_matrix, homogeneous_coords)

    if offset == 'center':
        transformed_x += affine_matrix[0, 2] / 2
        transformed_y += affine_matrix[1, 2] / 2
    elif offset == 'll':
        transformed_y += affine_matrix[1, 2]

    return transformed_x, transformed_y

def xy_to_colrow(affine_matrix, x_coords, y_coords, offset='ul'):
    if offset == 'center':
        x_coords -= affine_matrix[0, 0] / 2
        y_coords -= affine_matrix[1, 1] / 2
    elif offset == 'll':
        y_coords -= affine_matrix[1, 1]

    homogeneous_coords = np.vstack([x_coords, y_coords, np.ones_like(x_coords)])

    inverse_affine = np.linalg.inv(affine_matrix)
    col, row, _ = np.dot(inverse_affine, homogeneous_coords)

    return np.round(col).astype(int), np.round(row).astype(int)

def plot_np_array(np_array, meta, band_names=None):
    if 'nodata' in meta.keys():
        np_array = np.ma.masked_equal(np_array, meta['nodata'])

    if np_array.ndim == 2:
        plt.figure(figsize=(6,3))

        im = plt.imshow(np_array, cmap='viridis')
        plt.colorbar(im, fraction=0.046, pad=0.04, aspect=10)
        
    elif np_array.ndim == 3:
        plt.figure(figsize=(6,3* np_array.shape[0]))
        fig, axs = plt.subplots(np_array.shape[0], 1, figsize=(6, 3 * np_array.shape[0]))
        for i in range(np_array.shape[0]):
            ax = axs[i] if np_array.shape[0] > 1 else axs
            im = ax.imshow(np_array[i], cmap='viridis')
            if band_names is not None:
                ax.set_title(band_names[i])
            else:
                ax.set_title(f"Band {i+1}")
            fig.colorbar(im, ax=ax, fraction=0.046, pad=0.04, aspect=10)
            
    plt.tight_layout()
    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')

    return image_base64


def plot_coarse_raster_file(file_path):
    
    with rasterio.open(file_path) as src:
        max_dimension = max(src.width, src.height)
        downscale_factor = max(1, max_dimension // 1000)

        out_shape = (
            src.count,
            int(src.height // downscale_factor),
            int(src.width // downscale_factor)
        )

        image = src.read(out_shape=out_shape)

        if src.count == 3:
            plt.imshow(np.rollaxis(image), cmap='viridis')
        else:
            fig, axs = plt.subplots(1, src.count)
            for i in range(src.count):
                if src.count == 1:
                    ax = axs
                else:
                    ax = axs[i]
                ax.imshow(image[i], cmap='viridis')
                ax.set_title(f"Band {i+1}")
            plt.tight_layout()

    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')

    return image_base64


def plot_coarse_raster(raster):
    max_dimension = max(raster.width, raster.height)
    downscale_factor = max(1, max_dimension // 1000)

    out_shape = (
        raster.count,
        int(raster.height // downscale_factor),
        int(raster.width // downscale_factor)
    )

    image = raster.read(out_shape=out_shape)

    nodata_value = raster.nodata

    if nodata_value is not None:
        image = np.ma.masked_equal(image, nodata_value)

    if raster.count == 3:
        img_plot = plt.imshow(np.rollaxis(image, 0, 3), cmap='viridis')
        _set_original_scale_ticks(img_plot, raster.width, raster.height, downscale_factor)
    else:
        fig, axs = plt.subplots(1, raster.count)
        for i in range(raster.count):
            ax = axs if raster.count == 1 else axs[i]
            img_plot = ax.imshow(image[i], cmap='viridis')
            ax.set_title(f"Band {i+1}")
            _set_original_scale_ticks(img_plot, raster.width, raster.height, downscale_factor)
        plt.tight_layout()

    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')

    return image_base64

def _set_original_scale_ticks(img_plot, original_width, original_height, downscale_factor):
    xticks = np.linspace(0, img_plot.get_array().shape[1], num=5)
    xtick_labels = [f"{int(x * downscale_factor)}" for x in xticks]
    plt.xticks(xticks, xtick_labels)

    yticks = np.linspace(0, img_plot.get_array().shape[0], num=5)
    ytick_labels = [f"{int(y * downscale_factor)}" for y in yticks]
    plt.yticks(yticks, ytick_labels)
    plt.xlabel('x')
    plt.ylabel('y')

def plot_gdf(gdf):
    if not isinstance(gdf, gpd.GeoDataFrame):
        raise TypeError("Input must be a geopandas GeoDataFrame")

    gdf.plot(figsize=(6, 3))

    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')

    return image_base64


def create_geotransform(bounds, resolution):

    width = int((bounds[2] - bounds[0]) / resolution)
    height = int((bounds[3] - bounds[1]) / resolution)

    if width == 0 or height == 0:
        raise ValueError(f"""Resolution is too large for the given geometry. 
Current resolution: {resolution}
Geometry bounds: {bounds}                   
The width and height of the raster must be at least 1 pixel.""")
    
    transform = from_origin(bounds[0], bounds[3], resolution, resolution)
    return transform




def rasterize_gdf(gdf, transform=None, resolution=None, dtype='uint8', nodata=0):
    
    if transform is None:
        if resolution is None:
            raise ValueError("Either transform or resolution must be provided.")
        bounds = gdf.total_bounds
        width = int((bounds[2] - bounds[0]) / resolution)
        height = int((bounds[3] - bounds[1]) / resolution)
        
        transform = create_geotransform(bounds, resolution)

    else:
        if not isinstance(transform, Affine):
            raise TypeError("Transform must be of type Affine.")
        bounds = gdf.total_bounds
        width = int((bounds[2] - bounds[0]) / transform.a)
        height = int((bounds[3] - bounds[1]) / -transform.e)

        if width == 0 or height == 0:
            raise ValueError(f"""Transform is too large for the given geometry.
Current transform: {transform}
Geometry bounds: {bounds}
The width and height of the raster must be at least 1 pixel.""")

    rasterized = rasterize(
        ((geometry, 1) for geometry in gdf.geometry),
        out_shape=(height, width),
        transform=transform,
        dtype=dtype,
        fill=nodata
    )

    meta = {
        'driver': 'GTiff',
        'height': height,
        'width': width,
        'count': 1,
        'dtype': dtype,
        'crs': gdf.crs,
        'transform': transform,
        'nodata': nodata
    }

    return rasterized, meta

















def standardize_crs_bbox(target_transform, bbox):
    left, bottom, right, top = bbox

    window = from_bounds(left, bottom, right, top, target_transform)

    return window

def standardize_crs_geo_df(target_crs, gdf):
    gdf = gdf.to_crs(target_crs)
    return gdf

def read_raster_to_numpy(raster, window=None):

    all_bands = raster.read(window=window)

    return all_bands



def get_meta_from_gdf(gdf):
    meta = {
        'crs': gdf.crs.to_string(),
        'bounds': gdf.total_bounds
    }

    width = int((meta['bounds'][2] - meta['bounds'][0]) / meta['resolution'][0])
    height = int((meta['bounds'][3] - meta['bounds'][1]) / meta['resolution'][1])

    meta['width'] = width
    meta['height'] = height

    meta['transform'] = from_bounds(*meta['bounds'], width, height)

    return meta

def write_raster_to_disk(self, meta, output_path):
    with rasterio.open(output_path, 'w', **meta) as dst:
        for i in range(1, self.raster.count + 1):
            data = self.raster.read(i)
            dst.write(data, i)



def resample_raster_to_transform(raster, target_transform, resampling_method=Resampling.bilinear):

    src_meta = raster.meta.copy()
    
    scale_x = target_transform.a
    scale_y = -target_transform.e
    new_width = int(raster.width * abs(raster.transform.a / scale_x))
    new_height = int(raster.height * abs(raster.transform.e / scale_y))

    resampled_meta = src_meta.copy()
    resampled_meta.update({
        'transform': target_transform,
        'width': new_width,
        'height': new_height
    })

    resampled_raster = rasterio.open('./tmp/temp.tif', 'w+', **resampled_meta)
    for i in range(1, raster.count + 1):
        reproject(
            source=rasterio.band(raster, i),
            destination=rasterio.band(resampled_raster, i),
            src_transform=raster.transform,
            src_crs=raster.crs,
            dst_transform=target_transform,
            dst_crs=raster.crs,
            resampling=resampling_method)

    resampled_raster_data = resampled_raster.read()
    resampled_raster.close()

    return resampled_raster_data, resampled_meta


def resample_array(np_array, bounds, src_meta, target_transform=None, resolution=None, resampling_method=Resampling.bilinear):

    if target_transform is None:
        if resolution is None:
            raise ValueError("Either target_transform or resolution must be provided.")

        width = int((bounds[2] - bounds[0]) / resolution)
        height = int((bounds[3] - bounds[1]) / resolution)

        target_transform = create_geotransform(bounds, resolution)

    nodata = src_meta.get('nodata', -9999)

    np_array = np_array.astype(np.float32)

    if np_array.ndim == 2:
        return resample_2d_array(np_array, src_meta, target_transform, resampling_method, nodata)
    elif np_array.ndim == 3:
        return resample_3d_array(np_array, src_meta, target_transform, resampling_method, nodata)
    else:
        raise ValueError("Array must be either 2D or 3D")

def resample_2d_array(np_array, src_meta, target_transform, resampling_method, nodata):
    scale_x, scale_y = target_transform.a, -target_transform.e
    new_width = int(src_meta['width'] * abs(src_meta['transform'].a / scale_x))
    new_height = int(src_meta['height'] * abs(src_meta['transform'].e / scale_y))

    resampled_array = np.full((new_height, new_width), nodata, dtype=np_array.dtype)

    resampled_meta = src_meta.copy()
    resampled_meta.update({
        'transform': target_transform,
        'width': new_width,
        'height': new_height,
        'nodata': nodata
    })

    reproject(
        source=np_array,
        destination=resampled_array,
        src_transform=src_meta['transform'],
        src_crs=src_meta['crs'],
        dst_transform=target_transform,
        dst_crs=src_meta['crs'],
        resampling=resampling_method,
        src_nodata=nodata,
        dst_nodata=nodata)

    return resampled_array, resampled_meta

def resample_3d_array(np_array, src_meta, target_transform, resampling_method, nodata):
    num_bands, src_height, src_width = np_array.shape

    scale_x, scale_y = target_transform.a, -target_transform.e
    new_width = int(src_width * abs(src_meta['transform'].a / scale_x))
    new_height = int(src_height * abs(src_meta['transform'].e / scale_y))

    resampled_array = np.full((num_bands, new_height, new_width), nodata, dtype=np_array.dtype)

    resampled_meta = src_meta.copy()
    resampled_meta.update({
        'transform': target_transform,
        'width': new_width,
        'height': new_height,
        'nodata': nodata
    })

    for band in range(num_bands):
        reproject(
            source=np_array[band, :, :],
            destination=resampled_array[band, :, :],
            src_transform=src_meta['transform'],
            src_crs=src_meta['crs'],
            dst_transform=target_transform,
            dst_crs=src_meta['crs'],
            resampling=resampling_method,
            src_nodata=nodata,
            dst_nodata=nodata)

    return resampled_array, resampled_meta



def reproject_raster(raster, meta, target_crs):

    src_crs = meta['crs']
    src_width = meta['width']
    src_height = meta['height']
    src_transform = meta['transform']

    left, bottom, right, top = array_bounds(src_height, src_width, src_transform)

    new_transform, new_width, new_height = calculate_default_transform(
        src_crs, target_crs, src_width, src_height, left=left, bottom=bottom, right=right, top=top)

    new_meta = meta.copy()
    new_meta.update({
        'crs': target_crs,
        'transform': new_transform,
        'width': new_width,
        'height': new_height
    })

    new_raster = rasterio.MemoryFile().open(**new_meta)

    for band in range(1, raster.count + 1):
        reproject(
            source=rasterio.band(raster, band),
            destination=rasterio.band(new_raster, band),
            src_transform=src_transform,
            src_crs=src_crs,
            dst_transform=new_transform,
            dst_crs=target_crs,
            resampling=Resampling.nearest)
    
    return new_raster, new_meta



def reproject_array(np_array, meta, target_crs):

    src_crs = meta['crs']
    src_width = meta['width']
    src_height = meta['height']
    src_transform = meta['transform']

    left, bottom, right, top = array_bounds(src_height, src_width, src_transform)

    new_transform, new_width, new_height = calculate_default_transform(
        src_crs, target_crs, src_width, src_height, left=left, bottom=bottom, right=right, top=top)


    new_meta = meta.copy()
    new_meta.update({
        'crs': target_crs,
        'transform': new_transform,
        'width': new_width,
        'height': new_height
    })

    reprojected_array = np.empty((new_height, new_width), dtype=np_array.dtype)
    
    reproject(
        source=np_array,
        destination=reprojected_array,
        src_transform=src_transform,
        src_crs=src_crs,
        dst_transform=new_transform,
        dst_crs=target_crs,
        resampling=Resampling.nearest)

    return reprojected_array, new_meta


def get_bounding_box(raster):

    width, height = raster.width, raster.height

    transform = raster.transform

    min_x, min_y = transform * (0, height)
    max_x, max_y = transform * (width, 0)

    return min_x, min_y, max_x, max_y

def get_raster_bounding_box(meta):
    transform = meta['transform']
    width = meta['width']
    height = meta['height']

    top_left_x, top_left_y = transform * (0, 0)
    bottom_right_x, bottom_right_y = transform * (width, height)

    return (top_left_x, bottom_right_y, bottom_right_x, top_left_y)


def raster_numpy_to_df(np_array, table_name="raster", no_data=None):
    if np_array.ndim == 2:
        rows, cols = np.indices(np_array.shape)
        data = {
            'row': rows.ravel(),
            'col': cols.ravel(),
            table_name: np_array.ravel()
        }
        df = pd.DataFrame(data)
    else:
        rows, cols = np.indices(np_array[0].shape)
        data = {
            'row': rows.ravel(),
            'col': cols.ravel()
        }
        for band_num, band in enumerate(np_array, start=1):
            data[f'{table_name}_{band_num}'] = band.ravel()
        df = pd.DataFrame(data)

    if no_data is not None:
        df.replace(no_data, np.nan, inplace=True)
    
    return df

def shape_manufacturing(shape_data, x_att = None, y_att = None, meta={}):
    if isinstance(shape_data, str):
        return ShapeData(raster_path=shape_data, meta=meta)
    if isinstance(shape_data, rasterio.DatasetReader):
        return ShapeData(raster=shape_data, meta=meta)
    if isinstance(shape_data, gpd.GeoDataFrame):
        return ShapeData(gdf=shape_data, meta=meta)
    if isinstance(shape_data, np.ndarray):
        return ShapeData(np_array=shape_data, meta=meta)
    if isinstance(shape_data, pd.DataFrame):
        return ShapeData(df=shape_data, x_att=x_att, y_att=y_att, meta=meta)

class ShapeData:

    def __init__(self, raster_path=None, raster=None, gdf=None, np_array=None, df=None, x_att=None, y_att=None, meta={}):
        if raster_path is not None:
            self.load_raster(raster_path)
            self.raster_path = raster_path

        elif raster is not None:
            self.raster = raster
            self.meta = meta

        elif gdf is not None:
            self.gdf = gdf
            self.meta = meta
            if "crs" not in self.meta.keys():
                self.meta["crs"] = self.gdf.crs.to_string()

        elif np_array is not None:
            self.np_array = np_array
            self.meta = meta

        elif df is not None:
            if x_att is None or y_att is None:
                raise ValueError("x_att and y_att must be provided if df is provided")
            
            self.df = lightweight_copy(df)
            self.x_att = x_att
            self.y_att = y_att
            self.meta = meta

    def get_nodata(self):
        if "nodata" in self.meta.keys():
            return self.meta["nodata"]
        else:
            return None

    def to_df(self, xcol = "x", ycol = "y"):
        if hasattr(self, 'np_array'):
            df = create_df_from_np_array(np_array=self.np_array, 
                        column_names=self.get_band_names(),
                        nodata=self.get_nodata(),
                        x_col=xcol, y_col=ycol)
            meta = self.meta.copy()
            meta["aggregated"] = True
            return ShapeData(df=df, x_att=xcol, y_att=ycol, meta=meta)
        else:
            raise ValueError("Not implemented yet")

    def get_band_names(self):
        
        if "band_names" in self.meta.keys():
            return self.meta["band_names"]

        table_name = self.get_name()
        
        if hasattr(self, 'raster'):
            return [f"{table_name}_band_{i+1}" for i in range(self.raster.count)]
        
        if hasattr(self, 'np_array'):
            if self.np_array.ndim == 2:
                return [table_name]
            else:
                return [f"{table_name}_band_{i+1}" for i in range(self.np_array.shape[0])]

    def set_band_names(self, new_names):
        self.meta["band_names"] = new_names

    def get_name(self):

        if "table_name" in self.meta:
            return self.meta["table_name"]

        else:
            return self.get_type()

    def get_summary(self):
        if hasattr(self, 'gdf'):
            return f"""gdf has {len(self.gdf)} rows and {len(self.gdf.columns)} columns.
Below are the first 2 rows of the gdf:
{self.gdf.head(2)}"""

        elif hasattr(self, 'raster'):
            value_max
            return f"""raster is rasterio.DatasetReader. It has {self.raster.count} bands, {self.raster.width} columns, and {self.raster.height} rows.
Its nodata value is {self.raster.nodata}. Its crs is {self.raster.crs.to_string()}. Its transform is {self.raster.transform}."""

        elif hasattr(self, 'np_array'):
            nodata_summary = ""
            if "nodata" in self.meta.keys():
                nodata_summary = f"Its nodata value is {self.meta['nodata']}."
            
            np_array = self.np_array
            min_value = np.nanmin(np_array)
            max_value = np.nanmax(np_array)

            if "nodata" in self.meta.keys():
                filtered_array = np_array[np_array != self.meta['nodata']]
                min_value = np.nanmin(filtered_array)
                max_value = np.nanmax(filtered_array)

            return f"""np_array has shape {self.np_array.shape}. 
{nodata_summary}. Its normal value range is from {min_value} to {max_value}.
Its crs is {self.meta['crs']}. Its transform is {self.meta['transform']}."""

        elif hasattr(self, 'df'):
            if "crs" in self.meta.keys():
                crs_summary = f"\nIts crs is {self.meta['crs']}."
            if "transform" in self.meta.keys():
                transform_summary = f"\nIts transform is {self.meta['transform']}."

            return f"""df has {len(self.df)} rows and {len(self.df.columns)} columns.{crs_summary}{transform_summary}
The attribute for x is {self.x_att}. The attribute for y is {self.y_att}.
Below are the first 2 rows of the df:
{self.df.head(2)}"""


    def get_type(self):
        if hasattr(self, 'gdf'):
            return "gdf"
        
        elif hasattr(self, 'raster'):
            return "raster"
        
        elif hasattr(self, 'np_array'):
            return "np_array"
        
        elif hasattr(self, 'df'):
            return "df"

    def get_post_fix(self):
        if hasattr(self, 'gdf'):
            return "shp"
        elif hasattr(self, 'raster'):
            return "tif"
        elif hasattr(self, 'np_array'):
            return "tif"
        elif hasattr(self, 'df'):
            return "csv"

    def save_file(self, output_path):
        if hasattr(self, 'gdf'):
            gdf = self.gdf
            meta = self.meta
            self.gdf.to_file(output_path)

        elif hasattr(self, 'raster'):
            raster = self.raster
            meta = self.meta
            with rasterio.open(output_path, 'w', **meta) as dst:
                for i in range(1, raster.count + 1):
                    dst.write(raster.read(i), i)

        elif hasattr(self, 'np_array'):
            np_array = self.np_array
            meta = self.meta
            save_np_array_as_raster(np_array, output_path, meta)


        elif hasattr(self, 'df'):
            df = self.df
            meta = self.meta
            df.to_csv(output_path, index=False)

        


    def get_data(self):
        if hasattr(self, 'gdf'):
            return self.gdf
        elif hasattr(self, 'raster'):
            return self.raster
        elif hasattr(self, 'np_array'):
            return self.np_array
        elif hasattr(self, 'df'):
            return self.df

    
    def apply_window(self, window):

        if hasattr(self, 'gdf'):
            pass
        
        elif hasattr(self, 'raster'):
            np_array = read_raster_to_numpy(self.raster, window=window)
            return ShapeData(np_array=np_array, meta=self.meta)

        elif hasattr(self, 'np_array'):
            pass

        elif  hasattr(self, 'df'):
            pass

    def get_crs(self):
        if hasattr(self, 'gdf'):
            return self.gdf.crs.to_string()
        
        elif hasattr(self, 'raster'):
            return self.raster.crs.to_string()
        
        elif hasattr(self, 'np_array'):
            if "crs" not in self.meta.keys():
                return ""
            else:
                crs = self.meta['crs']
                if isinstance(crs, str):
                    return crs
                else:
                    return crs.to_string()
                
        elif hasattr(self, 'df'):
            if "crs" not in self.meta.keys():
                return ""
            else:
                crs = self.meta['crs']
                if isinstance(crs, str):
                    return crs
                else:
                    return crs.to_string()

    def project_to_target_crs(self, target_crs):

        source_crs = self.get_crs()

        if are_crs_equivalent(source_crs, target_crs):
            return self
        
        if hasattr(self, 'gdf'):
            gdf = standardize_crs_geo_df(target_crs, self.gdf)
            return ShapeData(gdf=gdf, meta=self.meta)
        
        elif hasattr(self, 'raster'):
            new_raster, new_meta = reproject_raster(self.raster, self.meta, target_crs)
            return ShapeData(raster=new_raster, meta=new_meta)

        elif hasattr(self, 'np_array'):
            new_np_array, new_meta = reproject_array(self.np_array, self.meta, target_crs)
            return ShapeData(np_array=new_np_array, meta=new_meta)

        elif hasattr(self, 'df'):
            
            source_transform = self.get_geo_transform()

            new_shape_data = self.row_column_to_x_y()

            source_crs = self.get_crs()

            transformer = Transformer.from_crs(source_crs, target_crs, always_xy=True)
            
            new_shape_data.df[new_shape_data.x_att], new_shape_data.df[new_shape_data.y_att] = transformer.transform(new_shape_data.df[new_shape_data.x_att].values, new_shape_data.df[new_shape_data.y_att].values)

            new_shape_data.meta['crs'] = target_crs

            
            return new_shape_data


    def row_column_to_x_y(self):

        if hasattr(self, 'gdf'):
            raise ValueError("not implemented yet")
        
        elif hasattr(self, 'raster'):
            raise ValueError("this is only for vector data")

        elif hasattr(self, 'np_array'):
            raise ValueError("this is only for vector data")

        elif hasattr(self, 'df'):
            source_transform = self.get_geo_transform()

            if source_transform is None:
                return self
            
            x_att = self.df[self.x_att]
            y_att = self.df[self.y_att]

            source_matrix = np.array([[source_transform.a, source_transform.b, source_transform.c],
                                        [source_transform.d, source_transform.e, source_transform.f],
                                        [0, 0, 1]])
            
            x_att, y_att = apply_affine_transform(source_matrix, x=x_att, y=y_att)

            new_df = lightweight_copy(self.df)

            new_df[self.x_att] = x_att
            new_df[self.y_att] = y_att

            new_meta = self.meta.copy()
            new_meta['transform'] = None

            return ShapeData(df=new_df, x_att=self.x_att, y_att=self.y_att, meta=new_meta)

    def is_aggregated(self):
        if hasattr(self, 'gdf'):
            raise ValueError("not implemented yet")
        
        elif hasattr(self, 'raster'):
            return True

        elif hasattr(self, 'np_array'):
            return True

        elif hasattr(self, 'df'):
            if "aggregated" in self.meta.keys():
                return self.meta["aggregated"]
            else:
                return False

    def set_aggregated(self, aggregated):
        if hasattr(self, 'gdf'):
            raise ValueError("not implemented yet")
        
        elif hasattr(self, 'raster'):
            raise ValueError("this is only for df")
        
        elif hasattr(self, 'np_array'):
            raise ValueError("this is only for df")

        elif hasattr(self, 'df'):
            self.meta["aggregated"] = aggregated

    def apply_aggregation(self, agg_dict=None, rename = None):
        group_by_key = [self.x_att, self.y_att]

        if agg_dict is None:
            agg_dict = {self.x_att: 'count'}
            if rename is None:
                rename = ['count']

        grouped_df = self.df.groupby(group_by_key).agg(agg_dict)

        if rename is not None:
            grouped_df.columns = rename

        grouped_df.reset_index(inplace=True)

        new_shape_data = ShapeData(df=grouped_df, x_att=self.x_att, y_att=self.y_att, meta=self.meta)

        new_shape_data.set_aggregated(True)

        return new_shape_data

    def x_y_to_row_column(self, resolution=None, target_geo_transform=None):

        if resolution is not None and target_geo_transform is not None:
            raise ValueError("resolution and target_geo_transform cannot be both provided")
        
        if resolution is None and target_geo_transform is None:
            raise ValueError("resolution and target_geo_transform cannot be both None")

        if resolution is not None:
            bounding_box = self.get_bounding_box()
            target_geo_transform = create_geotransform(bounding_box, resolution)

        if hasattr(self, 'gdf'):
            raise ValueError("not implemented yet")
        
        elif hasattr(self, 'raster'):
            raise ValueError("this is only for vector data")

        elif hasattr(self, 'np_array'):
            raise ValueError("this is only for vector data")

        elif hasattr(self, 'df'):

            source_transform = self.get_geo_transform()

            if source_transform is not None:
                raise ValueError("Please convert row and column to x and y first")

            affine_matrix = np.array([[target_geo_transform.a, target_geo_transform.b, target_geo_transform.c],
                                        [target_geo_transform.d, target_geo_transform.e, target_geo_transform.f],
                                        [0, 0, 1]])

            x_att = self.df[self.x_att]
            y_att = self.df[self.y_att]

            converted_cols, converted_rows = xy_to_colrow(affine_matrix, df_x, df_y)

            new_df = lightweight_copy(self.df)
            new_df[self.x_att] = converted_cols
            new_df[self.y_att] = converted_rows

            new_meta = self.meta.copy()
            new_meta['transform'] = target_geo_transform

            return ShapeData(df=new_df, x_att=self.x_att, y_att=self.y_att, meta=new_meta)
            
    
    def resample_to_target_transform(self, geo_transform = None, resolution = None):

        source_transform = self.get_geo_transform()

        if geo_transform is None and resolution is None:
            return self

        if source_transform is not None and geo_transform is not None:
            if source_transform == geo_transform:
                return self

        if hasattr(self, 'gdf'):
            np_array, new_meta = rasterize_gdf(self.gdf, transform=geo_transform, resolution=resolution)
            return ShapeData(np_array=np_array, meta=new_meta)
        
        elif hasattr(self, 'raster'):
            np_array,  new_meta = resample_raster_to_transform(self.raster, geo_transform)
            return ShapeData(np_array=np_array, meta=new_meta)

        elif hasattr(self, 'np_array'):
            bounds = self.get_bounding_box()
            new_np_array, new_meta = resample_array(self.np_array, bounds, self.meta, target_transform=geo_transform, resolution=resolution)
            return ShapeData(np_array=new_np_array, meta=new_meta)

        elif hasattr(self, 'df'):
            
            x_att = self.df[self.x_att]
            y_att = self.df[self.y_att]

            if source_transform is not None:
                source_matrix = np.array([[source_transform.a, source_transform.b, source_transform.c],
                                        [source_transform.d, source_transform.e, source_transform.f],
                                        [0, 0, 1]])
                x_att, y_att = apply_affine_transform(source_matrix, x=x_att, y=y_att)

            if geo_transform is not None:
                target_transform = geo_transform
            else:
                bounds = self.get_bounding_box()
                width = int((bounds[2] - bounds[0]) / resolution)
                height = int((bounds[3] - bounds[1]) / resolution)
                target_transform = create_geotransform(bounds, resolution)
   
            target_matrix = np.array([[target_transform.a, target_transform.b, target_transform.c],
                                    [target_transform.d, target_transform.e, target_transform.f],
                                    [0, 0, 1]])

            x_att, y_att = xy_to_colrow(target_matrix, x_att, y_att)

            new_df = lightweight_copy(self.df)

            new_df[self.x_att] = x_att
            new_df[self.y_att] = y_att

            new_meta = self.meta.copy()
            new_meta['transform'] = target_transform


            new_shape_data = ShapeData(df=new_df, x_att=self.x_att, y_att=self.y_att, meta=new_meta)
            if self.is_aggregated():
                print("⚠️ Warning: resampling aggregated data is not implemented yet")
                print("😊 Please send a feature request!")
                new_shape_data.set_aggregated(False)
            return new_shape_data

    def load_raster(self, raster_path):


        raster = rasterio.open(raster_path)

        self.np_array = read_raster_to_numpy(raster)

        self.meta = raster.meta

        self.meta["table_name"] = os.path.basename(raster_path).split('.')[0]

    def display_html(self, value_att=None):
        image_b64 = ""
        if hasattr(self, 'gdf'):
            image_b64 = plot_gdf(self.gdf)

        elif hasattr(self, 'raster'):
            image_b64 = plot_coarse_raster(self.raster)

        elif hasattr(self, 'np_array'):
            band_names = self.get_band_names()
            image_b64 = plot_np_array(self.np_array, self.meta, band_names=band_names)

        elif hasattr(self, 'df'):

            if self.is_aggregated():
                image_b64 = plot_efficient_grid(self.df, self.x_att, self.y_att, value_col=value_att)
            else:
                transform = self.get_geo_transform()

                invert = True
                if transform is None:
                    invert = False

                image_b64 = plot_df_with_geo(self.df, self.x_att, self.y_att, invert=invert, value_att=value_att)
            
        html_img = f'<img src="data:image/png;base64,{image_b64}" width="400"/>'
        return html_img

    def to_html(self, value_att=None, **kwargs):
        html = ""
        

        html += self.display_html(value_att=value_att)
        return html

    def display(self, value_att=None):
        html_img = self.display_html(value_att=value_att)
        if hasattr(self, 'gdf'):
            display(self.gdf.head())
        if hasattr(self, 'df'):
            display(self.df.head())
        
        display(HTML(html_img))

    def get_geo_transform(self):

        if hasattr(self, 'gdf'):
            if 'transform' not in self.meta.keys():
                return None
            return self.meta['transform']
        
        elif hasattr(self, 'raster'):
            return self.raster.transform
        
        elif hasattr(self, 'np_array'):
            if 'transform' not in self.meta.keys():
                return None
            return self.meta['transform']
        
        elif hasattr(self, 'df'):
            if 'transform' not in self.meta.keys():
                return None
            return self.meta['transform']

    def get_bounding_box(self):

        if hasattr(self, 'gdf'):
            return get_geodataframe_bbox(self.gdf)
        
        elif hasattr(self, 'raster'):
            return get_bounding_box(self.raster)
        
        elif hasattr(self, 'np_array'):
            return get_raster_bounding_box(self.meta)
        
        elif hasattr(self, 'df'):
            min_x = self.df[self.x_att].min()
            max_x = self.df[self.x_att].max()
            min_y = self.df[self.y_att].min()
            max_y = self.df[self.y_att].max()

            transform = self.get_geo_transform()

            if transform is not None:
                source_matrix = np.array([[transform.a, transform.b, transform.c],
                                        [transform.d, transform.e, transform.f],
                                        [0, 0, 1]])
                min_x, min_y = apply_affine_transform(source_matrix, x=min_x, y=min_y)
                max_x, max_y = apply_affine_transform(source_matrix, x=max_x, y=max_y)

                min_x, max_x = min(min_x, max_x), max(min_x, max_x)
                min_y, max_y = min(min_y, max_y), max(min_y, max_y)

            return (min_x, min_y, max_x, max_y)

    def get_height_width(self):

        if hasattr(self, 'gdf'):
            return self.gdf.height, self.gdf.width
        
        elif hasattr(self, 'raster'):
            return self.raster.height, self.raster.width
        
        elif hasattr(self, 'np_array'):
            return self.meta['height'], self.meta['width']
        
        elif hasattr(self, 'df'):
            pass

    def crop_by_bounding_box(self, bbox):
            
        if hasattr(self, 'gdf'):
            raise ValueError("Not implemented yet")
        
        elif hasattr(self, 'raster'):
            window = standardize_crs_bbox(self.raster.transform, bbox)
            np_array, new_meta = crop_raster_by_window(self.raster, self.meta, window)
            return ShapeData(np_array=np_array, meta=new_meta)
        
        elif hasattr(self, 'np_array'):
            window = standardize_crs_bbox(self.meta['transform'], bbox)
            np_array, new_meta = crop_np_array_by_window(self.np_array, self.meta, window)
            return ShapeData(np_array=np_array, meta=new_meta)
        
        elif hasattr(self, 'df'):
            new_shape = self.row_column_to_x_y()

            new_df, new_meta = crop_df_based_on_bbox(new_shape.df, new_shape.meta, new_shape.x_att, new_shape.y_att, bbox)

            return ShapeData(df=new_df, x_att=new_shape.x_att, y_att=new_shape.y_att, meta=new_meta)

    
    def crop(self, height, width):

        if hasattr(self, 'gdf'):
            raise ValueError("Not implemented yet")
        
        elif hasattr(self, 'raster'):
            np_array, new_meta = crop_raster(self.raster, self.meta, height, width)
            return ShapeData(np_array=np_array, meta=new_meta)
        
        elif hasattr(self, 'np_array'):
            new_np_array = crop_np_array(self.np_array, height, width)
            new_meta = self.meta.copy()
            new_meta['height'] = height
            new_meta['width'] = width

            return ShapeData(np_array=new_np_array, meta=new_meta)

        elif hasattr(self, 'df'):
            pass

    def get_np_array(self):
        if hasattr(self, 'gdf'):
            raise ValueError("Can't get np_array from gdf")
        
        elif hasattr(self, 'raster'):
            return read_raster_to_numpy(self.raster)
        
        elif hasattr(self, 'np_array'):
            return self.np_array

        elif hasattr(self, 'df'):
            raise ValueError("Can't get np_array from df")

    def to_np_array(self):
        if hasattr(self, 'gdf'):
            raise ValueError("Can't convert gdf to np_array")
        elif hasattr(self, 'raster'):
            np_array = read_raster_to_numpy(self.raster)
            return ShapeData(np_array=np_array, meta=self.meta)
        elif hasattr(self, 'np_array'):
            return self
        elif hasattr(self, 'df'):
            raise ValueError("Can't convert df to np_array")

    def __repr__(self):
        if hasattr(self, 'gdf'):
            print("This is a GeoDataFrame")
        
        elif hasattr(self, 'raster'):
            print("This is a raster of shape", self.raster.shape)
        
        elif hasattr(self, 'np_array'):
            print("This is a numpy array of shape", self.np_array.shape)

        elif hasattr(self, 'df'):
            print("This is a DataFrame")

        if hasattr(self, 'meta'):
            print("Meta: ", self.meta)
        
        self.display()

        return ""

    def transform(self):
        if not hasattr(self, 'cleaner'):
            self.cleaner = GeoDataCleaning(self)
        self.cleaner.display()

    def get_cleaner(self):
        if not hasattr(self, 'cleaner'):
            self.cleaner = GeoDataCleaning(self)
        return self.cleaner

    def get_shape(self):
        if hasattr(self, 'cleaner'):
            return self.cleaner.run_codes()
        
        return self
    

def crop_df_based_on_bbox(df, meta, x_att, y_att, bbox):

    min_x, min_y, max_x, max_y = bbox

    cropped_df = df[(df[x_att] >= min_x) & (df[x_att] <= max_x) &
                    (df[y_att] >= min_y) & (df[y_att] <= max_y)]

    new_meta = meta
    return cropped_df, new_meta

def plot_df_with_geo(df, x_att, y_att, value_att=None, invert=False):

    if len(df) > 10000:
        df = df.sample(10000)

    plt.figure(figsize=(5, 3))

    if value_att is not None:
        plt.scatter(df[x_att], df[y_att], c=df[value_att], cmap='viridis', alpha=0.2)
    else:
        plt.scatter(df[x_att], df[y_att], alpha=0.2)

    if invert:
        plt.gca().invert_yaxis()
        
    plt.grid(True)
    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')

    return image_base64

def crop_raster(raster, meta, height, width):
    window = Window(0, 0, width, height)

    cropped_data = raster.read(window=window)

    new_transform = raster.window_transform(window)

    new_meta = meta.copy()
    new_meta.update({
        "height": height,
        "width": width,
        "transform": new_transform
    })

    return cropped_data, new_meta



def crop_raster_by_window(raster, meta, window):

    cropped_data = raster.read(window=window)

    new_transform = raster.window_transform(window)

    new_meta = meta.copy()
    new_meta.update({
        "height": window.height,
        "width": window.width,
        "transform": new_transform
    })

    return cropped_data, new_meta


def update_transform(original_transform, col_start, row_start):
    new_origin_x = original_transform.c + col_start * original_transform.a
    new_origin_y = original_transform.f + row_start * original_transform.e

    new_transform = Affine(original_transform.a, 0.0, new_origin_x,
                           0.0, original_transform.e, new_origin_y)
    return new_transform

def crop_np_array_by_window(np_array, meta, window):
    row_start = max(0, min(int(window.row_off), np_array.shape[-2] - 1))
    row_stop = max(0, min(int(window.row_off + window.height), np_array.shape[-2]))
    col_start = max(0, min(int(window.col_off), np_array.shape[-1] - 1))
    col_stop = max(0, min(int(window.col_off + window.width), np_array.shape[-1]))

    if np_array.ndim == 3:
        cropped_array = np_array[:, row_start:row_stop, col_start:col_stop]
    elif np_array.ndim == 2:
        cropped_array = np_array[row_start:row_stop, col_start:col_stop]
    else:
        raise ValueError("Input array must be either 2D or 3D.")

    new_meta = meta.copy()
    new_meta.update({
        "height": row_stop - row_start,
        "width": col_stop - col_start,
        "transform": update_transform(meta['transform'], col_start, row_start)
    })

    return cropped_array, new_meta



def crop_np_array(np_array, height, width):
    if np_array.ndim == 2:
        return np_array[:height, :width]
    else:
        return np_array[:, :height, :width]


def get_geodataframe_bbox(geodf):
    bounds = geodf.total_bounds

    return bounds


def extract_values_by_indices(main_array, row_indices, col_indices):
    valid_rows = (row_indices >= 0) & (row_indices < main_array.shape[1])
    valid_cols = (col_indices >= 0) & (col_indices < main_array.shape[2])
    valid_indices = valid_rows & valid_cols

    if main_array.ndim == 2:
        result = np.full((1, len(row_indices)), np.nan)
        result[0, valid_indices] = main_array[row_indices[valid_indices], col_indices[valid_indices]]
        return result
    
    elif main_array.ndim == 3:
        result = np.full((main_array.shape[0], len(row_indices)), np.nan)

        for band in range(main_array.shape[0]):
            result[band, valid_indices] = main_array[band, row_indices[valid_indices], col_indices[valid_indices]]

        return result
    else: 
        raise ValueError("The input array must be 2D or 3D")






    


def to_target_shape_data(source_shape_data, target_shape_data, semi_join=True):
    shape_data_crs = target_shape_data.get_crs()
    shape_data_transform = target_shape_data.get_geo_transform()

    bounding_box = target_shape_data.get_bounding_box()

    return to_target_crs_and_transform(source_shape_data, 
                                        target_crs=shape_data_crs, 
                                        target_transform=shape_data_transform, 
                                        semi_join=semi_join,
                                        target_bounding_box=bounding_box)

def to_target_crs_and_transform(shape_data, target_crs, target_transform=None, resolution=None, semi_join=False, target_bounding_box=None):
    

    new_shape_data = shape_data

    if semi_join and target_bounding_box is None:
        raise ValueError("target_bounding_box cannot be None for semi_join")

    if hasattr(new_shape_data, 'gdf'):

        new_shape_data = new_shape_data.project_to_target_crs(target_crs)

        if semi_join:
            new_shape_data = new_shape_data.crop_by_bounding_box(target_bounding_box)

        new_shape_data = new_shape_data.resample_to_target_transform(resolution=resolution, geo_transform=target_transform)
    
    elif hasattr(new_shape_data, 'raster'):

        new_shape_data = new_shape_data.project_to_target_crs(target_crs)

        if semi_join:
            new_shape_data = new_shape_data.crop_by_bounding_box(target_bounding_box)

        new_shape_data = new_shape_data.resample_to_target_transform(resolution=resolution, geo_transform=target_transform)

    elif hasattr(new_shape_data, 'np_array'):
        new_shape_data = new_shape_data.project_to_target_crs(target_crs)

        if semi_join:
            new_shape_data = new_shape_data.crop_by_bounding_box(target_bounding_box)


        new_shape_data = new_shape_data.resample_to_target_transform(resolution=resolution, geo_transform=target_transform)

    elif hasattr(new_shape_data, 'df'):
        
        new_shape_data = new_shape_data.row_column_to_x_y()

        new_shape_data = new_shape_data.project_to_target_crs(target_crs)

        if semi_join:
            new_shape_data = new_shape_data.crop_by_bounding_box(target_bounding_box)

        new_shape_data = new_shape_data.resample_to_target_transform(resolution=resolution, geo_transform=target_transform)

    return new_shape_data

def plot_bounding_boxes(bounding_boxes):
    fig, ax = plt.subplots(1, figsize=(4, 2))

    if not isinstance(bounding_boxes, list):
        bounding_boxes = [bounding_boxes]

    colors = generate_seaborn_palette(len(bounding_boxes))
    line_styles = ['-', '--', '-.', ':']

    min_x, min_y, max_x, max_y = float('inf'), float('inf'), float('-inf'), float('-inf')

    for i, box in enumerate(bounding_boxes):
        left, bottom, right, top = box

        min_x = min(min_x, left)
        min_y = min(min_y, bottom)
        max_x = max(max_x, right)
        max_y = max(max_y, top)

        rect = patches.Rectangle((left, bottom), right - left, top - bottom, linewidth=2,
                                 edgecolor=colors[i % len(colors)], linestyle=line_styles[i % len(line_styles)],
                                 facecolor='none', alpha=0.7, label=f'Box {i+1}')

        ax.add_patch(rect)

    range_x = max_x - min_x
    range_y = max_y - min_y

    padding_x = range_x * 0.1
    padding_y = range_y * 0.1

    ax.set_xlim(min_x - padding_x, max_x + padding_x)
    ax.set_ylim(min_y - padding_y, max_y + padding_y)

    plt.grid(True, which='both', linestyle='--', linewidth=0.5)

    plt.xlabel('X', fontsize=8)
    plt.ylabel('Y', fontsize=8)
    plt.title('Bounding Boxes', fontsize=10)
    plt.legend(fontsize=8)

    ax.tick_params(axis='both', which='major', labelsize=8)

    plt.show()



def validate_bounding_box(bbox, is_longlat=False):

    min_x, min_y, max_x, max_y = bbox

    if is_longlat:
        lon_bounds = (-180, 180)
        lat_bounds = (-90, 90)

        if not (lon_bounds[0] <= min_x <= lon_bounds[1]):
            raise ValueError(f"Minimum longitude {min_x} is out of bounds {lon_bounds}.")
        if not (lon_bounds[0] <= max_x <= lon_bounds[1]):
            raise ValueError(f"Maximum longitude {max_x} is out of bounds {lon_bounds}.")
        if not (lat_bounds[0] <= min_y <= lat_bounds[1]):
            raise ValueError(f"Minimum latitude {min_y} is out of bounds {lat_bounds}.")
        if not (lat_bounds[0] <= max_y <= lat_bounds[1]):
            raise ValueError(f"Maximum latitude {max_y} is out of bounds {lat_bounds}.")
    else:
        if min_x >= max_x:
            raise ValueError(f"Minimum x-coordinate {min_x} is not less than maximum x-coordinate {max_x}.")
        if min_y >= max_y:
            raise ValueError(f"Minimum y-coordinate {min_y} is not less than maximum y-coordinate {max_y}.")



def is_valid_geo_transform(original_transform, new_transform, data_bounds=None):

    if not all(isinstance(t, Affine) for t in [original_transform, new_transform]):
        return False

    if (original_transform.a * new_transform.a < 0) or (original_transform.e * new_transform.e < 0):
        return False

    if data_bounds:
        min_x, min_y, max_x, max_y = data_bounds
        if not (min_x <= new_transform.c <= max_x) or not (min_y <= new_transform.f <= max_y):
            return False

    if original_transform.b != new_transform.b or original_transform.d != new_transform.d:
        return False

    return True






class EmbeddingSearcher:
    def __init__(self, df, embedding_col='embedding'):
        self.df = df
        self.embedding_col = embedding_col
        self.index = None
        self._create_index()

    def _create_index(self):
        embeddings = np.vstack(self.df[self.embedding_col].values)
        
        d = embeddings.shape[1]

        base_index = faiss.IndexFlatL2(d)

        self.index = faiss.IndexIDMap(base_index)

        ids = np.array(range(len(self.df))).astype(np.int64)
        self.index.add_with_ids(embeddings, ids)

    def remove_rows(self, row_indices):
        if np.isscalar(row_indices):
            row_indices = [row_indices]

        ids_to_remove = np.array(row_indices, dtype=np.int64)

        self.index.remove_ids(ids_to_remove)

    def get_closest_indices(self, query_embedding, k=5):
        if not isinstance(query_embedding, np.ndarray):
            query_embedding = np.array(query_embedding)

        if query_embedding.ndim == 1:
            query_embedding = np.expand_dims(query_embedding, axis=0)

        if query_embedding.shape[1] != self.index.d:
            raise ValueError("Dimension of query_embedding does not match the index dimension.")

        distances, indices = self.index.search(query_embedding, k)

        valid_indices = indices[0][indices[0] != -1]

        return valid_indices

    def get_closest_rows(self, query_embedding, k=5):
        closest_indices = self.get_closest_indices(query_embedding, k)

        return self.df.iloc[closest_indices]

    
    def search_by_row_index(self, row_idx, k=10):
        if row_idx < 0 or row_idx >= len(self.df):
            raise IndexError("Row index is out of bounds.")

        query_embedding = self.df.iloc[row_idx][self.embedding_col]
        
        search_results = self.get_closest_rows(query_embedding, k + 1)
        
        if row_idx in search_results.index:
            filtered_results = search_results.drop(index=row_idx)
        else:
            filtered_results = search_results

        return filtered_results.head(k)

    def is_index_empty(self):

        return self.index.ntotal == 0

    def get_valid_id(self):
        if self.is_index_empty():
            raise ValueError("The index is empty. No valid ID can be returned.")

        ids = faiss.vector_to_array(self.index.id_map)

        return ids[0]

    def get_size(self):
        return self.index.ntotal



def entity_relation_match_one(input_desc, refernece_desc):
    template = f"""Your goal is to build relations between input and reference entities.
The input entity has the following attributes:
{input_desc}
Below are reference entities:
{refernece_desc}
Do the following:
1. Read input entity attributes and guess what it is about.

2. Go through each output entity. Describe what it is and reason its relation.
For instance, given the input entity "small car":
if the same entity then EXACT_MATCH. 
E.g., "small automobile"
else if has assumptions that is clearly wrong then CONFLICTED_ASSUMPTION
E.g., "big car" is wrong because input entity clearly specify size as "small"
else if additional assumptions that can't be verified then ADDITIONAL_ASSUMPTION
E.g., "electronic car" is additional battery assumption can't be verified
else if it is general super class then GENERAL 
E.g., "small vehicle" and "car" are general category of "small car"
else it is irrelavent entity then NOT_RELATED
E.g., "cloth" is a irrelavent

Provide your answer as json:
```json
{{
    "Input Entity Guess": "...",
    "EXACT_MATCH": {{
        "reason": "The input entity is ... which matches ...",
        "entity": [...] (a list of index numbers. Note that each entity appears only once in one of the categories)
    }},
    "CONFLICTED_ASSUMPTION": {{
        "reason": "The (what specific) details are conflicted",
        "entity": [...]
    }},
    "ADDITIONAL_ASSUMPTION": {{
        "reason": "The (what specific) details are not mentioned",
        "entity": [...]
    }},
    "GENERAL": {{
        "reason": "...",
        "entity": [...],
    }},
    "NOT_RELATED": {{
        "reason": "...",
        "entity": [...],
    }},
    "Summary of Relations": "The input entity is ... (desrcibe its properties) It doesn't make assumptions about ... It is different from ..."
}}
```"""

    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
        write_log(message['content'])
        write_log("-----------------------------------")

    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_var = json.loads(json_code)
    
    return json_var

def find_similar_relation_match(input_desc, refernece_desc, related_rows_desc_str):

    template = f"""The input entity has the following attributes:
{input_desc}

Below are the previous matching results:
{refernece_desc}

Below are similar entities:
{related_rows_desc_str}

Now, go through each similar entity. Answer:
1. How they differ to the input entity?
2. Are they totally different entities, or entity with minor detail difference?

Conclude with the list of indices of entities with minor differences:
```json
{{
    "indices": [1, 2 ...]
}}
``` """
    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
        write_log(message['content'])
        write_log("-----------------------------------")


    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_var = json.loads(json_code)
    
    return json_var

def find_relation_satisfy_description(entity_desc, related_rows_desc_str):

    template = f"""Find entities that satisfy the description:
Below are entities:
{related_rows_desc_str}
Below are the description:
{entity_desc}

Now, find entities that satisfy the description. Provide your answer as json:
```json
{{
    "reasoning": "The entities are about ...",
    "indices": [...] (list of index numbers, could be empty)
}}
``` """
    messages = [{"role": "user", "content": template}]

    response = call_llm_chat(messages, temperature=0.1, top_p=0.1)

    assistant_message = response['choices'][0]['message']
    messages.append(assistant_message)

    for message in messages:
        write_log(message['content'])
        write_log("-----------------------------------")


    json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
    json_var = json.loads(json_code)
    
    return json_var
    
def parse_match_result(json_var, reference_entities):

    def replace_indices_with_entities(json_var, reference_entities):
        for category in json_var:
            if isinstance(json_var[category], dict) and "entity" in json_var[category]:
                json_var[category]["entity"] = [reference_entities[int(idx) - 1] for idx in json_var[category]["entity"]]
        return json_var

    updated_json_var = replace_indices_with_entities(json_var, reference_entities)

    
    def parse_json_to_string(json_var):
        parsed_string = ""
        if json_var['EXACT_MATCH']['entity']:
            parsed_string += f"The input is exactly matched to: {', '.join(json_var['EXACT_MATCH']['entity'])}.\n" if json_var['EXACT_MATCH']['entity'] else ""
            parsed_string += f"The reason is: {json_var['EXACT_MATCH']['reason']}.\n" if not json_var['EXACT_MATCH']['entity'] else ""

        if json_var['CONFLICTED_ASSUMPTION']['entity']:
            parsed_string += f"The input has conflicted assumption to: {', '.join(json_var['CONFLICTED_ASSUMPTION']['entity'])}.\n"
            parsed_string += f"The reason is: {json_var['CONFLICTED_ASSUMPTION']['reason']}.\n"

        if json_var['ADDITIONAL_ASSUMPTION']['entity']:
            parsed_string += f"The input has additional assumption to: {', '.join(json_var['ADDITIONAL_ASSUMPTION']['entity'])}.\n"
            parsed_string += f"The reason is: {json_var['ADDITIONAL_ASSUMPTION']['reason']}.\n"

        if json_var['GENERAL']['entity']:
            parsed_string += f"The input is generally related to: {', '.join(json_var['GENERAL']['entity'])}.\n"
            parsed_string += f"The reason is: {json_var['GENERAL']['reason']}.\n"

        return parsed_string

    parsed_json_string = parse_json_to_string(updated_json_var)

    return parsed_json_string





def create_geo_transform_widget(callback):
    def on_radio_button_change(change):
        if change['new'] == 'Geo Transform':
            geo_transform_widgets.layout.display = 'block'
            resolution_widget.layout.display = 'none'
        else:
            geo_transform_widgets.layout.display = 'none'
            resolution_widget.layout.display = 'block'

    def on_button_clicked(b):
        if radio_buttons.value == 'Geo Transform':
            geo_transform = Affine(pixel_size_x.value, rotation_x.value, origin_x.value,
                                   rotation_y.value, -pixel_size_y.value, origin_y.value)
            callback(geo_transform, None)
        else:
            callback(None, resolution.value)

    radio_buttons = widgets.RadioButtons(
        options=['Geo Transform', 'Resolution'],
        description='Select:',
        disabled=False
    )
    radio_buttons.observe(on_radio_button_change, 'value')

    origin_x = widgets.FloatText(value=0.0, description='Origin X:')
    origin_y = widgets.FloatText(value=0.0, description='Origin Y:')
    pixel_size_x = widgets.FloatText(value=1.0, description='Pixel Size X:')
    pixel_size_y = widgets.FloatText(value=1.0, description='Pixel Size Y:')
    rotation_x = widgets.FloatText(value=0.0, description='Rotation X:')
    rotation_y = widgets.FloatText(value=0.0, description='Rotation Y:')
    geo_transform_widgets = widgets.VBox([origin_x, origin_y, pixel_size_x, pixel_size_y, rotation_x, rotation_y])
    geo_transform_widgets.layout.display = 'block'

    resolution = widgets.FloatText(value=300.0, description='Resolution:')
    resolution_widget = widgets.VBox([resolution])
    resolution_widget.layout.display = 'none'

    button = widgets.Button(description="Submit")
    button.on_click(on_button_clicked)

    display(radio_buttons, geo_transform_widgets, resolution_widget, button)




def truncate_html_td(html, max_length=30):
    pattern = r'(<td[^>]*>)(.*?)(</td>)'
    
    def truncate_match(match):
        content = match.group(2).strip()
        if len(content) > max_length:
            content = content[:max_length] + '...'
        return match.group(1) + content + match.group(3)

    return re.sub(pattern, truncate_match, html, flags=re.DOTALL)



def save_np_array_as_raster(np_array, output_path, meta):
    if np_array.ndim == 2:
        height, width = np_array.shape
        count = 1
    elif np_array.ndim == 3:
        count, height, width = np_array.shape
    else:
        raise ValueError("NumPy array must be either 2D or 3D")

    meta.update({
        'height': height,
        'width': width,
        'count': count,
        'dtype': np_array.dtype
    })

    with rasterio.open(output_path, 'w', **meta) as dst:
        if np_array.ndim == 2:
            dst.write(np_array, 1)
        else:
            for i in range(count):
                dst.write(np_array[i, :, :], i + 1)


class GeoDataCleaning(DataCleaning):
    def __init__(self, shape_data):
        self.shape_data = shape_data
        source = SourceShapeStep(shape_data)
        self.pipeline = TransformationPipeline(steps = [source], edges=[])
        self.final_shape = self.pipeline.run_codes()
    
    def display(self):
        self.pipeline.display(call_back=self.display)
        display(HTML("<hr> <h3>🤓 Result Data</h3>"))
        self.final_shape.__repr__()
        display(HTML("<hr> <h3>🧹 Data Transformation</h3>"))
        data_type = self.final_shape.get_type()

        boxes = []
        
        def on_reproject_clicked(b):
            clear_output(wait=True)
            self.add_reproject_step()
        
        reproject_button = widgets.Button(description="Reproject")
        reproject_button.on_click(on_reproject_clicked)
        box = widgets.VBox([reproject_button])
        boxes.append(box)

        
        def on_resample_clicked(b):
            clear_output(wait=True)
            self.add_resample_step()

        resample_button = widgets.Button(description="Rasterize")
            
        if data_type == "raster" or data_type == "np_array":
            resample_button = widgets.Button(description="Resample")

        resample_button.on_click(on_resample_clicked)
        box = widgets.VBox([resample_button])
        boxes.append(box)

        def on_save_clicked(b):
            clear_output(wait=True)
            self.save()
        
        save_button = widgets.Button(description="💾 Save Result")
        save_button.on_click(on_save_clicked)
        box = widgets.VBox([save_button])
        boxes.append(box)

        def on_remove_last_clicked(b):
            clear_output(wait=True)
            self.add_remove_last_step()

        remove_last_button = widgets.Button(description="⚠️ Remove Last")
        remove_last_button.on_click(on_remove_last_clicked)
        box = widgets.VBox([remove_last_button])
        boxes.append(box)

        if data_type == "np_array":
            def on_to_df_clicked(b):
                clear_output(wait=True)
                self.add_to_df_step()
            
            to_df_button = widgets.Button(description="To DataFrame")

            to_df_button.on_click(on_to_df_clicked)
            box = widgets.VBox([to_df_button])
            boxes.append(box)

        label = widgets.HTML(value=f"🎲 Want to perform an ad hoc transformation?\n⚠️ Currently, ad hoc transformation can't change CRS or file type.")

        def on_ad_hoc_clicked(b):
            clear_output(wait=True)
            self.create_ad_hoc_step()

        adhoc_button = widgets.Button(description="Ad hoc")
        adhoc_button.on_click(on_ad_hoc_clicked)
        box = widgets.VBox([label, adhoc_button])
        boxes.append(box)

        display(widgets.VBox(boxes))


    def save(self):
        post_fix = self.final_shape.get_post_fix()

        file_name = f"cocoon_geo_result.{post_fix}"

        print(f"🤓 Do you want to save the result?")
        print(f"Note that only the given file type can be saved.")
        print("😊 More save options are under development. Please send a feature request!")

        def save_file(b):
            updated_file_name = file_name_input.value

            if os.path.exists(updated_file_name):
                print("Failed to save: File already exists.")
            else:
                self.final_shape.save_file(updated_file_name)
                print(f"🎉 File saved successfully as {updated_file_name}")

        file_name_input = Text(value=file_name, description='File Name:')
        
        save_button = Button(description="Save File")
        save_button.on_click(save_file)

        display(file_name_input, save_button)
        

    def add_reproject_step(self):

        print("🧐 Please specify the target CRS:")

        def call_back(crs_string):
            step = ReprojectStep(crs_string, sample_df = self.final_shape)

            try:
                step.run_codes(self.final_shape)
            except Exception as e:
                print("☹️ There is an error in the step you added:")
                print(e)
                return

            self.pipeline.add_step_to_final(step)
            self.final_shape = self.pipeline.run_codes()
            clear_output(wait=True)
            self.display()
        
        CRS_select(call_back)

    def add_remove_last_step(self):
        self.pipeline.remove_final_node()
        self.final_shape = self.pipeline.run_codes()
        clear_output(wait=True)
        self.display()


    def add_to_df_step(self):
        step = NumpyToDfStep(sample_df = self.final_shape)

        try:
            step.run_codes(self.final_shape)
        except Exception as e:
            print("☹️ There is an error in the step you added:")
            print(e)
            return
        
        self.pipeline.add_step_to_final(step)
        self.final_shape = self.pipeline.run_codes()
        clear_output(wait=True)
        self.display()

    def add_resample_step(self):

        print("🧐 Bounding box for the data")

        bounding_box = self.final_shape.get_bounding_box()
        plot_bounding_boxes(bounding_box)

        print("🧐 Please specify the target transform/resolution:")
        
        def call_back(geo_transform, resolution):
            if geo_transform:
                print("Geo Transform:", geo_transform)
            if resolution:
                print("Resolution:", resolution)
            
            step = ResampleStep(geo_transform=geo_transform, resolution=resolution, sample_df = self.final_shape)

            step.run_codes(self.final_shape)

            self.pipeline.add_step_to_final(step)
            self.final_shape = self.pipeline.run_codes()
            clear_output(wait=True)
            self.display()
        
        create_geo_transform_widget(call_back)

    def create_ad_hoc_step(self):
        sample_output = self.final_shape

        add_hoc_step = GeoShapeCustomTransformStep(name="Ad hoc", sample_df=sample_output)

        def callback(add_hoc_step):
            if add_hoc_step.explanation != "" or add_hoc_step.codes != "":
                add_hoc_step.rename_based_on_explanation()
                self.pipeline.add_step_to_final(add_hoc_step)
                self.final_shape = self.pipeline.run_codes()

            clear_output(wait=True)
            self.display()

        callbackfunc = callback

        add_hoc_step.edit_widget(callbackfunc=callbackfunc)
    

            





            

    



            
        







def create_np_array_from_df(df, x_col, y_col, height, width, nodata=0):

    included_columns = [col for col in df.columns if col not in [x_col, y_col]]

    output_array = np.full((len(included_columns), height, width), nodata, dtype=float)

    for i, col in enumerate(included_columns):
        valid_rows = df[(df[x_col] < width) & (df[y_col] < height)]
        x_values = valid_rows[x_col].astype(int).values
        y_values = valid_rows[y_col].astype(int).values
        values = valid_rows[col].values

        output_array[i, y_values, x_values] = values

    return output_array, included_columns




def create_df_from_np_array(np_array, column_names, nodata=0, x_col="x", y_col="y"):

    df = pd.DataFrame()

    for i, name in enumerate(column_names):
        if np_array.ndim == 3:
            slice_2d = np_array[i, :, :]
        elif np_array.ndim == 2:
            slice_2d = np_array[:, :]
        
        y_indices, x_indices = np.where(slice_2d != nodata)
        values = slice_2d[y_indices, x_indices]

        temp_df = pd.DataFrame({x_col: x_indices, y_col: y_indices, name: values})
        
        if df.empty:
            df = temp_df
        else:
            df = pd.merge(df, temp_df, on=[x_col, y_col], how='outer')

    return df



def parse_raster_to_dataframe(raster, window=None, table_name=""):
        
    all_bands = read_raster_to_numpy(raster, window=window)

    num_bands, num_rows, num_cols = all_bands.shape

    x_coords, y_coords = np.meshgrid(np.arange(num_cols), np.arange(num_rows))

    bands_reshaped = all_bands.reshape(num_bands, -1).T
    x_reshaped = x_coords.ravel()
    y_reshaped = y_coords.ravel()

    data = np.column_stack([x_reshaped, y_reshaped, bands_reshaped])
    data = np.column_stack([bands_reshaped])
    if table_name != "":
        table_name += "_"
    columns = ['x', 'y'] + [f'{table_name}band_{i+1}' for i in range(num_bands)]
    df = pd.DataFrame(data, columns=columns)

    return df

def crop_np_array(np_array_to_crop, target_shape, nodata=0):

    original_shape = np_array_to_crop.shape[1:]

    crop_height = min(original_shape[0], target_shape[0])
    crop_width = min(original_shape[1], target_shape[1])

    cropped_array = np_array_to_crop[:, :crop_height, :crop_width]

    if cropped_array.shape[1] < target_shape[0] or cropped_array.shape[2] < target_shape[1]:
        padding = (
            (0, 0),
            (0, target_shape[0] - cropped_array.shape[1]),
            (0, target_shape[1] - cropped_array.shape[2])
        )
        cropped_array = np.pad(cropped_array, padding, mode='constant', constant_values=nodata)

    return cropped_array

def integrate_np_array(np_array_1, np_array_2, nodata=0):

    if len(np_array_1.shape) == 2:
        np_array_1 = np.expand_dims(np_array_1, axis=0)
    if len(np_array_2.shape) == 2:
        np_array_2 = np.expand_dims(np_array_2, axis=0)

    if np_array_1.shape[1:] != np_array_2.shape[1:]:
        np_array_2 = crop_np_array(np_array_2, np_array_1.shape[1:], nodata=nodata)

    integrated_np_array = np.concatenate((np_array_1, np_array_2), axis=0)
    return integrated_np_array

def refill_nodata(np_array, old_no_data, new_no_data):
    output_array = np.copy(np_array)

    output_array[output_array == old_no_data] = new_no_data

    return output_array

def integrate_geo(main_geo_data, geo_data_arr):
    main_data_type = main_geo_data.get_type()
   
    if main_data_type == "df":


        main_df = main_geo_data.df
        main_x_att = main_geo_data.x_att
        main_y_att = main_geo_data.y_att

        for geo_data in geo_data_arr:

            data_type = geo_data.get_type()

            if data_type == "df":

                df = geo_data.df
                df_x_att = geo_data.x_att
                df_y_att = geo_data.y_att

                main_df = main_df.merge(df, left_on=[main_x_att, main_y_att], right_on=[df_x_att, df_y_att], how="left")
                
                if df_x_att != main_x_att:
                    main_df.drop(columns=[df_x_att], inplace=True)
                if df_y_att != main_y_att:
                    main_df.drop(columns=[df_y_att], inplace=True)

            elif data_type == "np_array":

                band_names = geo_data.get_band_names()

                main_geo_data_transformed = to_target_shape_data(main_geo_data, geo_data, semi_join=False)

                extracted_np_array = join_raster_to_df_points(raster_shape = geo_data, df_shape=main_geo_data_transformed)
                extracted_np_array = extracted_np_array.T
                print("Shape of extracted_np_array:", extracted_np_array.shape)
                print("Length of band_names:", len(band_names))
                print(band_names)
                print("Shape of main_df:", main_df.shape)
                
                main_df = pd.concat([main_df, pd.DataFrame(extracted_np_array, columns=band_names)], axis=1)

        
        new_shape_data = ShapeData(df=main_df, x_att=main_x_att, y_att=main_y_att, meta=main_geo_data.meta)
        return new_shape_data


    elif main_data_type == "np_array":
        main_no_data = main_geo_data.get_nodata()
        main_band_names = main_geo_data.get_band_names()
        main_np_array = main_geo_data.np_array

        if len(main_np_array.shape) == 3:
            height = main_np_array.shape[1]
            width = main_np_array.shape[2]
        elif len(main_np_array.shape) == 2:
            height = main_np_array.shape[0]
            width = main_np_array.shape[1]

        for geo_data in geo_data_arr:
            
            data_type = geo_data.get_type()

            if data_type == "df":

                df = geo_data.df
                x_col =  geo_data.x_att
                y_col = geo_data.y_att

                output_array, included_columns = create_np_array_from_df(df, x_col, y_col, height, width, nodata=main_no_data)

                main_np_array = integrate_np_array(main_np_array, output_array, nodata=main_no_data)

                main_band_names = main_band_names + included_columns

            elif data_type == "np_array":

                no_data = geo_data.get_nodata()
                np_array = geo_data.np_array
                band_names = geo_data.get_band_names()
                
                if main_no_data is not None and no_data is not None and main_no_data != no_data:
                    np_array = refill_nodata(np_array, no_data, main_no_data)

                main_np_array = integrate_np_array(main_np_array, np_array, nodata=main_no_data)
                
                main_band_names = main_band_names + band_names
        
        new_meta = main_geo_data.meta.copy()
        new_shape_data = ShapeData(np_array=main_np_array, meta=new_meta)
        new_shape_data.set_band_names(main_band_names)
        return new_shape_data

        

        
class GeoIntegration:
    
    def __init__(self, doc_dfs):
        if not isinstance(doc_dfs, list):
            raise ValueError("doc_dfs should be a list")

        self.doc_dfs = doc_dfs
        
        self.shape_data_arr = [None] * len(doc_dfs)

        self.document = {}

    def start(self):
        self.process_data()

    def get_result(self):
        return self.result

    def process_data(self):
        next_step = self.ask_for_attributes

        if "candidate_longitude_latitude" not in self.document:
            self.document["candidate_longitude_latitude"] = {}            
        
        create_progress_bar_with_numbers(0, geo_integration_steps)

        print("💡 Processing the data...")
        
        for i in range(len(self.doc_dfs)):
            id_str = f"{i}"
            
            if id_str in self.document["candidate_longitude_latitude"]:
                continue
            
            doc_df = self.doc_dfs[i]
            if isinstance(doc_df, pd.DataFrame):
                raise ValueError("""☹️ Cannot process DataFrame. Please read_data(df) first.
😊 Support for dataFrame is under development. Please send a feature request!""")
                
            elif isinstance(doc_df, DocumentedData):
                source_table_description = doc_df.get_summary()
                json_code =  identify_longitude_latitude(source_table_description)
                self.document["candidate_longitude_latitude"][id_str] = json_code
            
            elif isinstance(doc_df, ShapeData):
                data_type = doc_df.get_type()
                if data_type == "gdf":
                    print("☹️ Warning: GeoDataFrame is not well supported.")
                self.shape_data_arr[i] = doc_df.get_shape()
            
            else:
                raise ValueError(f"☹️ Cannot process {type(doc_df)}. Please read_data() first.")
        
        clear_output(wait=True)
        next_step()
    
    def ask_for_attributes(self):
        
        next_step = self.display_results

        if "decided_longitude_latitude" not in self.document:
            self.document["decided_longitude_latitude"] = {}

        for id_str in self.document["candidate_longitude_latitude"]:
            i = int(id_str)
            if id_str in self.document["decided_longitude_latitude"]:
                if self.shape_data_arr[i] is None:
                    x_att, y_att = self.document["decided_longitude_latitude"][id_str]
                    self.shape_data_arr[i] = ShapeData(df = self.doc_dfs[i].get_df(), x_att=x_att, y_att=y_att, meta={"crs": "epsg:4326"})
                continue


            df = self.doc_dfs[i].df
            json_code = self.document["candidate_longitude_latitude"][id_str]

            column_indices = [[df.columns.get_loc(pair["longitude_name"]), df.columns.get_loc(pair["latitude_name"])] for pair in json_code]

            colors = generate_seaborn_palette(len(column_indices))
            styled_df = color_columns_multiple(df.head(), colors, column_indices)
            display(HTML(wrap_in_scrollable_div(truncate_html_td(styled_df.to_html()))))
            
            
            def call_back(longitude, latitude):
                self.document["decided_longitude_latitude"][id_str] = [longitude, latitude]
                self.ask_for_attributes()
            
            display_longitude_latitude(json_code, list(df.columns), call_back)

            break
        
        if len(self.document["decided_longitude_latitude"]) == len(self.document["candidate_longitude_latitude"]):
            next_step()
    
    def display_results(self):
        create_progress_bar_with_numbers(1, geo_integration_steps)

        print("💡 Preview the data...")

        tab_data = [(f"{i}: {shapedata.get_name()}", 0, shapedata.to_html()) for i, shapedata in enumerate(self.shape_data_arr)]
        tabs = create_tabs_with_notifications(tab_data)
        display(tabs)

        print("💡 Please select the main CRS from one data")
        print("  We will transform all the other tables to the same CRS as the main table.")

        tables = [f"{i}: {shapedata.get_name()}" for i, shapedata in enumerate(self.shape_data_arr)]

        def my_callback(selected_item):
            index = tables.index(selected_item)
            clear_output(wait=True)
            self.transform_to_crs(index)

        create_select_widget(tables, my_callback)

    def transform_to_crs(self, crs_table_index):
        next_step = self.select_main_table

        self.crs_table_index = crs_table_index

        create_progress_bar_with_numbers(1, geo_integration_steps)
        print("💡 Transforming the data...")

        main_shape_data = self.shape_data_arr[crs_table_index]
        
        progress = show_progress(len(self.shape_data_arr) - 1)

        for i in range(len(self.shape_data_arr)):
            if i == crs_table_index:
                continue
            source_shape_data = self.shape_data_arr[i]
            result_shape_data = to_target_shape_data(source_shape_data, main_shape_data, semi_join=False)
            self.shape_data_arr[i] = result_shape_data
            progress.value += 1

        print("🎉 CRS has successfully aligned...")

        tab_data = [(f"{i}: {shapedata.get_name()}" + ("(main)" if i == crs_table_index else ""), 0, shapedata.to_html()) for i, shapedata in enumerate(self.shape_data_arr)]
        tabs = create_tabs_with_notifications(tab_data)
        display(tabs)

        print("🤓 Next we will integrate them")

        button = widgets.Button(description="Continue")

        def on_click(b):
            clear_output(wait=True)
            next_step()

        button.on_click(on_click)
        display(button)

    def select_main_table(self):
        next_step = self.aggregate_table

        create_progress_bar_with_numbers(2, geo_integration_steps)

        print("💡 Please select the main table")
        print(" We will integrate all the other tables to the main table.")

        tables = [f"{i}: {shapedata.get_name()}" for i, shapedata in enumerate(self.shape_data_arr)]

        def my_callback(selected_item):
            main_table_index = tables.index(selected_item)
            self.main_table_index = main_table_index
            clear_output(wait=True)
            self.aggregate_table()

        create_select_widget(tables, my_callback)
            
    def aggregate_table(self):
        create_progress_bar_with_numbers(2, geo_integration_steps)
        next_step = self.join_to_main_table

        main_table_index = self.main_table_index

        main_shape_data = self.shape_data_arr[main_table_index]


        for i in range(len(self.shape_data_arr)):
            if i == main_table_index:
                continue
            
            source_shape_data = self.shape_data_arr[i]

            data_type = source_shape_data.get_type()

            if data_type == "df":
                if source_shape_data.is_aggregated():
                    continue
                else:
                    print("💡 The following dataframe is not aggregated. Please aggregate and extract features.")
                    aggregate_step = GeoAggregationStep(shape_data=source_shape_data, sample_df=source_shape_data)

                    def callback(aggregate_step):
                        clear_output(wait=True)
                        final_shape = aggregate_step.run_codes(source_shape_data)
                        self.shape_data_arr[i] = final_shape
                        self.aggregate_table()
                    
                    aggregate_step.edit_widget(callbackfunc=callback)
                    return

        clear_output(wait=True)                      
        next_step()

    def join_to_main_table(self):

        print("💡 Integrating the data...")
        
        progress = show_progress(1)
        main_geo_data = self.shape_data_arr[self.main_table_index]
        geo_data_arr = [self.shape_data_arr[i] for i in range(len(self.shape_data_arr)) if i != self.main_table_index]
        result = integrate_geo(main_geo_data, geo_data_arr)
        progress.value += 1

        self.result = result

        print("🎉 Geo integration is done!")

        result.display()




    def write_document_to_disk(self, filepath: str):
        with open(filepath, 'w') as file:
            json.dump(self.document, file)

    def read_document_from_disk(self, filepath: str, viewer=True):
        with open(filepath, 'r') as file:
            self.document = json.load(file)

def join_raster_to_df_points(raster_shape, df_shape):

    raster_crs = raster_shape.get_crs()

    raster_transform = raster_shape.get_geo_transform()

    df_shape = to_target_crs_and_transform(df_shape, target_crs=raster_crs, target_transform=raster_transform)

    converted_rows = df_shape.df[df_shape.y_att].values.astype(int)
    converted_cols = df_shape.df[df_shape.x_att].values.astype(int)

    raster_np_array = raster_shape.get_np_array()

    result = extract_values_by_indices(raster_np_array, converted_rows, converted_cols)
    

    return result


class NestDocument(dict):
    def get_nested(self, path):
        current_dict = self
        for key in path:
            if key not in current_dict:
                return {}
            current_dict = current_dict[key]

        return current_dict

    def exist_nested(self, path):
        current_dict = self
        for key in path:
            if key not in current_dict:
                return False
            current_dict = current_dict[key]

        return True

    def set_nested(self, path, value):
        current_dict = self
        for key in path[:-1]:
            if key not in current_dict:
                current_dict[key] = {}
            current_dict = current_dict[key]
        current_dict[path[-1]] = value 
    
    def remove_nested(self, path):
        current_dict = self
        for key in path[:-1]:
            if key not in current_dict:
                return
            current_dict = current_dict[key]
        if path[-1] in current_dict:
            del current_dict[path[-1]]
            











class Node:
    default_name = "Node"
    default_description = "This is the base class for all nodes."
    retry_times = 3

    def __init__(self, name=None, description=None, viewer=False, para=None, output=None, id_para="element_name"):
        self.name = name if name is not None else self.default_name
        self.description = description if description is not None else self.default_description

        self.para = para if para is not None else {}
        self.viewer = viewer

        self.nodes = {self.name: self}
        self.edges = {}

        self.messages = []
        
        self.global_document = NestDocument()
        self.id_para = id_para
        self.init_path()

        self.output = output
    
    @contextmanager
    def output_context(self):
        if hasattr(self, 'output') and self.output is not None:
            with self.output:
                yield
        else:
            yield

    def init_path(self):
        self.path = [self.name]
        if self.id_para  in self.para:
            self.path.append(str(self.para[self.id_para]))

    def add_parent_path(self, parent_path):
        self.path = parent_path + self.path

    def add_parent_document(self, parent_document):
        self.global_document = parent_document

    def inherit(self, parent):
        self.add_parent_path(parent.path)
        self.add_parent_document(parent.global_document)

        if self.output is None:
            self.output = parent.output

        if not self.para:
            self.para = parent.para

        self.viewer = parent.viewer
        self.item = parent.item

    def set_global_document(self, value):
        self.global_document.set_nested(self.path, value)

    def get_global_document(self):
        return self.global_document.get_nested(self.path)

    def exist_global_document(self):
        return self.global_document.exist_nested(self.path)
    
    def remove_global_document(self):
        self.global_document.remove_nested(self.path)
        

    def to_html(self):
        html_content = f"<h2>{self.name}</h2>"
        html_content += f"<p>{self.description}</p>"
        return html_content

    def display_document(self):
        if self.global_document is not None:
            display(HTML("<h3>Document</h3>" + render_json_in_iframe_with_max_height(self.global_document)))
        else:
            display(HTML("<h3>Document</h3><p>Document is empty.</p>"))

    def display_messages(self):
        if len(self.messages) > 0:
            if isinstance(self.messages[0], list):

                def create_html_content(page_no):
                    html_content = generate_dialogue_html(self.messages[page_no])
                    return wrap_in_scrollable_div(html_content, height="500px")
                display(HTML("<h3>Message History</h3>"))
                display_pages(len(self.messages), create_html_content)

            else:
                html_content = generate_dialogue_html(self.messages)
                display(HTML("<h3>Message History</h3>" 
                            + wrap_in_scrollable_div(html_content, height="500px")))

            

    def display(self, call_back_list=[]):
        
        display(HTML(self.to_html()))

        self.display_document()
        self.display_messages()

        if len(call_back_list) > 0:
            button = widgets.Button(description="Return")

            def on_button_clicked(b):
                with self.output_context():
                    clear_output(wait=True)
                    call_back_func = call_back_list.pop()
                    call_back_func(call_back_list)

            button.on_click(on_button_clicked)
            display(button)

    def extract(self, input_item):
        self.input_item = input_item

        return None

    def run(self, extract_output, use_cache=True):
        
        print(f"Running {self.name}.")
        return extract_output
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {}
        
    
    def run_and_retry(self, extract_output):
        try:
            return self.run(extract_output, use_cache=True)
        except Exception as e:
            print(f"Failed to run {self.name}. Retrying...")
            
            for i in range(self.retry_times):
                try:
                    return self.run(extract_output, use_cache=False)
                except Exception as e:
                    print(f"😔 Failed to run {self.name}. Retrying...")
                     
                    write_log(f"""
The node is {self.name}
The error is: {e}
The messages are:
{self.messages}""")
                    
                    
            print(f"😔 Failed to run {self.name}. Please send us the error log (data_log.txt).")
            return self.run_but_fail(extract_output, use_cache=False)
            
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        self.run_output = run_output

        print(f"Postprocessing {self.name}.")

        document = run_output
        
        def on_button_click(b):
            with self.output_context():
                print("Button clicked.")
                callback(document)
        
        button = Button(description="Submit")
        button.on_click(on_button_click)
        display(button)

        if viewer:
            on_button_click(button)


    def get_sibling_document(self, sibling_name):
        new_path = self.path[:-1]
        new_path.append(sibling_name)

        return self.global_document.get_nested(new_path)


class ListNode(Node):
    default_name = "List of Nodes"
    default_description = "This node dynamically creates a list of run calls."
    retry_times = 0
    
    def run(self, extract_output, use_cache=True):
        return {}
    
    def merge_run_output(self, run_outputs):
        return run_outputs
    
    def run_and_retry(self, extract_outputs):
        run_outputs = []
        for extract_output in extract_outputs:
            run_output = super().run_and_retry(extract_output)
            run_outputs.append(run_output)
        return self.merge_run_output(run_outputs)
    
class Workflow(Node):

    default_name = "Workflow"
    default_description = "This is the base class for all workflows."

    def __init__(self, name=None, description=None, viewer=False, item=None, para={}, output=None, id_para="element_name"):
        self.name = name if name is not None else self.default_name
        self.description = description if description is not None else self.default_description
        self.nodes = {}
        self.edges = {}
        self.item = item

        self.para = para
        
        self.root_node = None
        self.viewer = viewer
        self.messages = []
        
        self.global_document = NestDocument()
        self.id_para = id_para
        self.init_path()

        self.output = output


    def extract(self, item):
        self.item = item
        return None

    def run(self, extract_output, use_cache=True):
        return None

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):

        self.finish_workflow = callback

        print(f"Starting workflow {self.name}.")
        self.start_workflow(run_output)

        
    def write_document_to_disk(self, filepath: str):
        with open(filepath, 'w') as file:
            json.dump(self.global_document, file)

    def read_document_from_disk(self, filepath: str, viewer=True):
        with open(filepath, 'r') as file:
            self.global_document = json.load(file)

    def update_node(self, new_node):
        node_name = new_node.name
        if node_name not in self.nodes:
            raise ValueError(f"Node {node_name} not found.")
        
        self.nodes[node_name] = new_node

        new_node.inherit(self)
        new_node.remove_global_document()

    def add_to_leaf(self, node):
        nodes, edges = list(self.nodes.keys()), self.edges 

        if len(nodes) == 0:
            self.register(node)
            return

        edges = replace_keys_and_values_with_index(nodes, edges)
        final_node_idx = find_final_node(nodes, edges)

        if final_node_idx is not None:
            final_node = nodes[final_node_idx]
            self.register(node, parent=final_node)
        else:
            raise ValueError("No leaf node found. Please manually add the node.")        

    def register(self, node, parent=None):
        if isinstance(parent, Node):
            parent = parent.name

        if node.name in self.nodes:
            raise ValueError(f"Node {node.name} is already registered.")

        self.nodes[node.name] = node
        node.inherit(self)

        if parent:
            if parent not in self.nodes:
                raise ValueError(f"Parent node {parent} not found.")
            if parent in self.edges:
                self.edges[parent].append(node.name)
            else:
                self.edges[parent] = [node.name]
        else:
            if self.root_node is not None:
                raise ValueError("A root node is already registered. Only one root node is allowed.")
            self.root_node = node.name
            self.edges[node.name] = []

    def start_workflow(self, meta_info = None):
        if self.root_node is None:
            raise ValueError("Workflow has no root node defined.")
        
        if self.output is not None:
            display(self.output)
        
        with self.output_context():
            self.execute_node(self.root_node)
        
    def execute_node(self, node_name):
        if node_name not in self.nodes:
            raise ValueError(f"Node {node_name} not found.")
            
        node = self.nodes[node_name]

        if node.exist_global_document():
            document = node.get_global_document()
            print(f"Node {node_name} already executed. Skipping.")
            self.callback(node_name, document)
            return 

        extract_output = node.extract(self.item)
        run_output = node.run_and_retry(extract_output)

        node.postprocess(run_output, lambda document: self.callback(node_name, document), viewer=self.viewer, extract_output=extract_output)
    
    def callback(self, node_name, document):
        node = self.nodes[node_name]

        node.set_global_document(document)
        
        children = self.edges.get(node_name, [])
        
        if len(children) == 0:
            this_document = self.get_global_document()
            self.finish_workflow(this_document)

        elif len(children) == 1:
            next_node = children[0]
            print(f"Automatically proceeding to the next node: {next_node}")
            self.execute_node(next_node)

        else:
            next_node = document.get("next_node")

            if next_node and next_node in children:
                print(f"Proceeding to the specified next node: {next_node}")
                self.execute_node(next_node)
                
            else:
                raise ValueError(f"Node {node_name} has multiple possible next nodes. 'next_node' must be specified in the document.")
    
    def finish_workflow(self, document=None):
        print(f"Workflow {self.name} completed.")

    def display_workflow(self):
        nodes, edges = list(self.nodes.keys()), self.edges 

        edges = replace_keys_and_values_with_index(nodes, edges)
        
        self.display_document()
        display(HTML(f"<h3>Flow Diagram</h3>"))
        display_workflow(nodes, edges)
        
    def display(self, call_back_list=[]):

        display(HTML(self.to_html()))
        

        def create_widget(nodes, instances):
            
            dropdown = widgets.Dropdown(
                options=nodes,
                disabled=False,
            )

            button1 = widgets.Button(description="View")

            def on_button_clicked(b):
                with self.output_context():
                    clear_output(wait=True)

                    idx = nodes.index(dropdown.value)
                    selected_instance = instances[idx]

                    call_back_list.append(self.display)
                    selected_instance.display(call_back_list=call_back_list)

            button1.on_click(on_button_clicked)

            button3 = widgets.Button(description="Return")

            def on_button_clicked3(b):
                with self.output_context():
                    clear_output(wait=True)
                    call_back_func = call_back_list.pop()
                    call_back_func(call_back_list)
            
            button3.on_click(on_button_clicked3)

            if len(nodes) == 0:
                display(HTML("<p>The workflow is empty.</p>"))
                
                if len(call_back_list) > 0:
                    display(button3)

            else:
                self.display_workflow()

                if len(call_back_list) > 0:
                    buttons = widgets.HBox([button1, button3])
                else:
                    buttons = widgets.HBox([button1])

                display(dropdown, buttons)


        nodes = list(self.nodes.keys())
        instances = list(self.nodes.values())
        create_widget(nodes, instances)



class MultipleNode(Workflow):

    default_name = "Multiple Node"
    default_description = "This node dynamically creates multiple nodes based on the input data."

    def __init__(self, name=None, description=None, viewer=False, item=None, para={}, output=None, id_para="element_name"):
        self.name = name if name is not None else self.default_name
        self.description = description if description is not None else self.default_description
        self.nodes = {}
        self.edges = {}

        self.elements = []
        self.item = item
        
        self.para = para
        self.viewer = viewer
        self.unit = "element"
        
        self.messages = []

        self.global_document = NestDocument()
        self.id_para = id_para
        self.init_path()

        self.output = output

        self.example_node = self.construct_node("example")



    def construct_node(self, element_name, idx=0, total=0):
        node = Node("Sub Node", para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node
    
    def extract(self, item):
        self.elements = ['element1', 'element2', 'element3']
        total = len(self.elements)
        self.nodes = {element: self.construct_node(element, idx, total) for idx, element in enumerate(self.elements)}

        return None
    
    def run(self, extract_output, use_cache=True):

        if len(self.elements) != len(set(self.elements)):
            raise ValueError("Element names must be unique.")
        
        return None

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):

        self.finish_workflow = partial(self.display_after_finish_workflow, callback)

        print(f"Starting workflow {self.name}.")
        self.start_workflow(run_output)

    def display_after_finish_workflow(self, callback, document):
        callback(document)

    def start_workflow(self, meta_info = None):
        if len(self.elements) == 0:
            document = self.get_global_document()
            self.finish_workflow(document)
            return 

        self.execute_node(self.elements[0])
    
    def callback(self, element_name, document):
        element_idx = self.elements.index(element_name)
        element_node = self.nodes[element_name]

        element_node.set_global_document(document)

        if element_idx == len(self.elements) - 1:
            document = self.get_global_document()
            self.finish_workflow(document)
        else:
            self.execute_node(self.elements[element_idx + 1])

    def display_workflow(self):
        nodes, edges = list(self.example_node.nodes.keys()), self.example_node.edges 

        edges = replace_keys_and_values_with_index(nodes, edges)

        def display_workflow_with_unit(nodes, edges, edge_labels=None, highlight_nodes=None, highlight_edges=None, height=400, unit="item"):
            encoded_image = generate_workflow_html(nodes, edges, edge_labels, highlight_nodes, highlight_edges, height)
            scrollable_html = f"""
            <div style="max-height: {height}px; overflow: auto; border: 1px solid #cccccc; position: relative;">
                <div style="background-color: rgba(255, 255, 255, 0.8); padding: 2px 5px; font-size: 14px; border-bottom: 1px solid #cccccc;">For each {unit}</div>
                <img src="data:image/png;base64,{encoded_image}" alt="Workflow Diagram" style="display: block; max-width: none; height: auto; margin-top: 5px;">
            </div>
            """
            display(HTML(scrollable_html))
        
        self.display_document()
        display(HTML(f"<h3>Flow Diagram</h3>"))
        display_workflow_with_unit(nodes, edges, unit=self.unit)

    def display(self, call_back_list=[]):

        display(HTML(self.to_html()))
        

        def create_widget(nodes, instances):
            
            dropdown = widgets.Dropdown(
                options=nodes,
                disabled=False,
                description=self.unit,
            )

            button1 = widgets.Button(description="View")

            def on_button_clicked(b):
                with self.output_context():
                    clear_output(wait=True)

                    idx = nodes.index(dropdown.value)
                    selected_instance = instances[idx]

                    call_back_list.append(self.display)
                    selected_instance.display(call_back_list=call_back_list)

            button1.on_click(on_button_clicked)

            button3 = widgets.Button(description="Return")

            def on_button_clicked3(b):
                with self.output_context():
                    clear_output(wait=True)
                    call_back_func = call_back_list.pop()
                    call_back_func(call_back_list)
            
            button3.on_click(on_button_clicked3)

            self.display_workflow()

            if len(nodes) == 0:
                display(HTML(f"<p>There is no {self.unit}.</p>"))
                
                if len(call_back_list) > 0:
                    display(button3)
            else:
                

                if len(call_back_list) > 0:
                    buttons = widgets.HBox([button1, button3])
                else:
                    buttons = widgets.HBox([button1])

                display(dropdown, buttons)


        nodes = list(self.nodes.keys())
        instances = list(self.nodes.values())
        create_widget(nodes, instances)








        




















def process_query_to_dbt(query, input_tables):
    pattern = r"^\s*CREATE\s+(?:OR\s+REPLACE)?(?:TABLE|VIEW)\s+\S+\s+AS"

    query = re.sub(pattern, "", query, flags=re.IGNORECASE)


    for table in input_tables:
        query = re.sub(rf"\b{table}\b", r"{{ ref('" + table + r"') }}", query)

    return query


class ProductSteps(Node):
    default_name = 'Product Steps'
    default_description = 'This is typically the dicussion result from business analysts and engineers'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)

        document = ["Setup", "Source", "Stage", "Model"]


        dbt_project_dir = self.input_item["dbt_directory"]


        header_html = f'<div style="display: flex; align-items: center;">' \
            f'<img src="data:image/png;base64,{cocoon_icon_64}" alt="cocoon icon" width=50 style="margin-right: 10px;">' \
            f'<div style="margin: 0; padding: 0;">' \
            f'<h1 style="margin: 0; padding: 0;">Data Product</h1>' \
            f'<p style="margin: 0; padding: 0;">Powered by cocoon</p>' \
            f'</div>' \
            f'</div><hr>'

        description_html = f"""
        <div>
            <h2>Welcome to Cocoon for your data product development! 🛠️</h2>
            <p>There are 4 steps:</p>
            <ol>
                <li><strong>Setup 📋</strong>
                    <ul>
                        <li>You provide:
                            <ul>
                                <li>Your dbt project ({dbt_project_dir}).</li>
                                <li>Your business workflow.</li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><strong>Source 🔍</strong>
                    <ul>
                        <li>We handle, you verify:
                            <ul>
                                <li>Integrating multiple partitions into a single table.</li>
                                <li>Aligning schemas from mismatched data sources.</li>
                                <li>Documenting data sources with semantic meanings.</li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><strong>Stage 🚧</strong>
                    <ul>
                        <li>We handle, you verify:
                            <ul>
                                <li>Cleaning, transforming and deduplicating tables.</li>
                                <li>Updating CRUD tables (with deletion and overwrite ops) to the latest snapshot.</li>
                                <li>Normalizing tables containing multiple entities.</li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><strong>Model 📊</strong>
                    <ul>
                        <li>We handle, you verify:
                            <ul>
                                <li>Linking data sources to your business workflow.</li>
                                <li>Creating dimension and fact tables with a join graph.</li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ol>
            <p>Congratulations! You've successfully created the data products, ready for dashboards, ad hoc queries, or LLM applications. 🌟</p>
        </div>
        """

        display(HTML(header_html + description_html))

        next_button = widgets.Button(description="Start", button_style='success')
        
        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)
        display(next_button)


class DataSource(Node):
    default_name = 'Data Source'
    default_description = 'This reads from the data source'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)

        con = self.input_item["con"]
        directory = self.input_item["dir"]

        create_progress_bar_with_numbers(0, self.global_document["Data Product"]['Product Steps'])

        idx = 1
        html_content = ""

        files = os.listdir(directory)

        print("🧐 Scanning the data source ...")

        num_files = len(files)
        increment = max(1, num_files // 10)
        progress_counter = 0

        self.progress = show_progress(10)

        for file in files:
            if file.endswith(".csv"):
                file_path = f"{directory}/{file}"
                table_name = file.split(".")[0]

                df = pd.read_csv(file_path)

                run_sql_return_df(con, f"CREATE TABLE {table_name} AS SELECT * FROM df")

                html_content += f"<b>{idx}. {table_name} (<a href=\"{file_path}\">{file_path}</a>)</b>"
                html_content += wrap_in_scrollable_div(truncate_html_td(df.head(2).to_html()))
                idx += 1

            progress_counter += 1
            if progress_counter % increment == 0 or progress_counter == num_files:
                self.progress.value += 1

        print(f"🤓 We found {idx-1} seed tables. Below are their {BOLD}samples{END}...")

        schema_df = run_sql_return_df(con, "describe;")

        tables = {}
        for _, row in schema_df.iterrows():
            table_name = row['name']
            column_name = row['column_names']
            tables[table_name] = column_name

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(tables)
                
        next_button.on_click(on_button_click)
        display(next_button)

        display(HTML(wrap_in_scrollable_div(html_content, height='800px')))


class BusinessWorkflow(Node):
    default_name = 'Business Workflow'
    default_description = 'This is typically the dicussion result from business analysts and engineers'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        create_progress_bar_with_numbers(0, self.global_document["Data Product"]['Product Steps'])

        print("🤓 The discussed business workflow is as follows...")

        document = { "title" : "Retail Brokerage",
                    "descriptions": [
                        ("Customer holds Account and engages Broker.", 
                        [["Customer", "holds", "Account"], 
                        ["Customer", "engages", "Broker"]]),
                        ("Broker monitors Security and advises on Trade for customers.", 
                        [["Broker", "monitors", "Security"],
                        ["Broker", "advises on", "Trade"]]),
                        ("Company issues Security.", 
                        [["Company", "issues", "Security"]]),
                        ("Account reflects CashBalances and Holdings, showing ownership and value.", 
                        [["Account", "reflects", "CashBalances"], 
                        ["Account", "reflects", "Holdings"]]),
                        ("Security has a MarketHistory, tracking its performance and trends.", 
                        [["Security", "has", "MarketHistory"]])
                    ]
        }

        display_pages(total_page=len(document["descriptions"]), 
                      create_html_content=partial(create_html_content_project, 
                                                  document["title"], document["descriptions"]))

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)
        display(next_button)

class GroupDataSource(Node):
    default_name = 'Group Data Source'
    default_description = 'This groups the data source'

    def extract(self, input_item):
        clear_output(wait=True)

        create_progress_bar_with_numbers(1, self.global_document["Data Product"]['Product Steps'])
        
        print("🧐 Grouping the data source ...")
        self.progress = show_progress(1)

        tables = self.global_document["Data Product"]["Data Source"]
        self.groups = group_tables_exclude_single(tables)
        table_list = "\n".join([f"{idx}. {names}: {tables[names[0]]}" for idx, names in enumerate(self.groups)])
        return table_list

    def run(self, extract_output, use_cache=True):
        table_list = extract_output
        template = f"""Below are a list of table groups. Each table group has the same attributes.
We list the [table names]: [attributes] for each group:
{table_list}

The goal is to pick new names for a dbt project. 
The new table name shall start with src_. It is preferably lowercase and retain original table names as much as possible.
Now, return in the following format:
```json
[
    "new name for group 0",
    ...
]
```"""

        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)

        assistant_message = response['choices'][0]['message']
        messages.append(assistant_message)
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        summary = json.loads(json_code)

        

        return summary


    def postprocess(self, run_output, callback, viewer=False, extract_output=None):

        self.progress.value += 1
        new_names = run_output

        grouped_tables = {}

        for i in range(len(new_names)):
            new_name = new_names[i]
            group = self.groups[i]
            grouped_tables[new_name] = group

        print("🤓 We have identified potentially partitioned tables... ")

        for table in grouped_tables:
            group = grouped_tables[table]
            if len(group) > 1:
                print(f"{BOLD}{table}{END}: The source is partitioned from {len(group)} tables:")
                print(f"    {group}")
                print(f"    {BOLD}Reason{END}: These partitions share the same attributes.")
                print()

        print("😎 Next we will write codes to load source ...")
                

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(grouped_tables)

        next_button.on_click(on_button_click)

        display(next_button)


class SourceCodeWriting(Node):
    default_name = 'Source Code Writing'
    default_description = 'This writes the SQL codes to load the source'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(1, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Writing the SQL code to load the src ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        group = self.global_document["Data Product"]["Group Data Source"][table_name]
        schema = self.global_document["Data Product"]["Data Source"][group[0]]

        self.group = group
        self.table_name = table_name

        return table_name, group, schema

    def run(self, extract_output, use_cache=True):
        new_table_name, group, schema = extract_output

        sql_query = ""

        if len(group) > 1:
            template = f"""Below are a list of table names, all with the same attriutes {schema}:
tables = {group}

Write a python function that takes the tables var and write the SQL query that 
(1) "CREATE TABLE {new_table_name} AS" that unions all the tables in the tables var. 
(2) extracts features from the table name, if there are any, and creates new columns for each

The function should return the SQL query as a string.
Now, first brainstorm the steps you would take. Conclude by filling in the function. Please don't change the function signature. Don't include example usage.
```python
def create_union_table(tables):
    # Write your code here
    return query
```"""
            messages = [{"role": "user", "content": template}]

            response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
            messages.append(response['choices'][0]['message'])
            self.messages = messages
            
            python_code = extract_python_code(response['choices'][0]['message']['content'])
            exec(python_code, globals())

            sql_query = create_union_table(group)

        else:
            sql_query = f"CREATE TABLE {new_table_name} AS SELECT * FROM {group[0]}"
    
        return sql_query
            
        
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        sql_query = run_output
        con = self.input_item["con"]
        run_sql_return_df(con, robust_create_to_replace(sql_query))

        input_tables = self.group
        dbt_formatted_query = process_query_to_dbt(sql_query, input_tables)
        dbt_project_dir = self.input_item["dbt_directory"]
        dbt_file_path = f"{dbt_project_dir}/models/source/{self.table_name}.sql"

        with open(dbt_file_path, "w") as f:
            f.write(dbt_formatted_query)

        callback(sql_query)
    
    
class SourceCodeWritingForAll(MultipleNode):

    default_name = 'Source Code Writing For All'
    default_description = 'This writes the SQL codes to load the source'

    def construct_node(self, element_name, idx=0, total=0):
        node = SourceCodeWriting(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):
        self.elements = list(self.global_document["Data Product"]["Group Data Source"].keys())
        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                      for idx, element in enumerate(self.elements)}
        self.item = item

    def display_after_finish_workflow(self, callback, document):

        clear_output(wait=True)

        tab_data = []

        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"

        border_style = """
        <style>
        .border-class {
            border: 1px solid black;
            padding: 10px;
            margin: 10px;
        }
        </style>
        """

        combined_css = css_style + border_style

        dbt_project_dir = self.item["dbt_directory"]
        

        for key in document["Source Code Writing"]:
            sql_query = document["Source Code Writing"][key]

            dbt_file_path = f"{dbt_project_dir}/models/source/{key}.sql"

            highlighted_sql = wrap_in_scrollable_div(highlight(sql_query, SqlLexer(), formatter))
            file_path_dbt = f"The dbt file is saved at <a href=\"{dbt_file_path}\">{dbt_file_path}</a>" 
            bordered_content = f'<div class="border-class">{file_path_dbt}{highlighted_sql}</div>'
            tab_data.append((key, combined_css + bordered_content))

        tabs = create_dropdown_with_content(tab_data)
        
        print("🎉 The SQL codes to load the src have been written ...")
        display(tabs)
        print("😎 Next we will document each src table ...")
        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)

        display(next_button)

class SourceDocument(Node):
    default_name = 'Source Document'
    default_description = 'This step documents each source table'
    clean = True

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):

        con = self.input_item["con"]
        table_name = self.para["element_name"]




        df = run_sql_return_df(con, f"select * from {table_name}")
        doc_df = DocumentedData(df, table_name=table_name)
        doc_df.rename_table=False

        doc_df.start(viewer=True)


        dbt_project_dir = self.input_item["dbt_directory"]
        dbt_file_path = f"{dbt_project_dir}/models/source/{table_name}.yml"

        yaml_dict = doc_df.to_yml()

        
        group = self.global_document["Data Product"]["Group Data Source"][table_name]

        for item in yaml_dict["models"]:
            if item["name"] == table_name:
                if "cocoon_tags" not in item:
                    item["cocoon_tags"] = {}
                if len(group) > 1:
                    item["cocoon_tags"]["partition"] = group
                else:
                    item["cocoon_tags"]["select_all"] = group[0]

        with open(dbt_file_path, 'w') as file:
            yaml.dump(yaml_dict, file)
            
            
        if "table_document" not in self.input_item:
            self.input_item["table_document"] = {}
        self.input_item["table_document"][table_name] = doc_df
        callback(doc_df.document)


class SourceDocumentForAll(MultipleNode):
    
    default_name = 'Source Document For All'
    default_description = 'This writes the SQL codes to load the source'

    def construct_node(self, element_name, idx=0, total=0):
        node = SourceDocument(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):
        self.elements = list(self.global_document["Data Product"]["Group Data Source"].keys())
        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                      for idx, element in enumerate(self.elements)}
        self.item = item
    
    def display_after_finish_workflow(self, callback, document):

        dropdown = widgets.Dropdown(
            options=document["Source Document"].keys(),
        )

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)


        def on_change(change):
            if change['type'] == 'change' and change['name'] == 'value':
                clear_output(wait=True)

                print("🎉 All the source tables have been documented!")
                
                print("😎 Next we will stage the tables ...")
                display(next_button)
                
                print("🧐 You can explore the documents below ...")
                display(dropdown)
                self.item["table_document"][change['new']].display_document()

        dropdown.observe(on_change)

        clear_output(wait=True)

        print("🎉 All the source tables have been documented!")
        print("😎 Next we will stage the tables ...")
        display(next_button)
        
        print("🧐 You can explore the documents for the source tables below ...")
        display(dropdown)
        if len(document["Source Document"]) > 0:
            self.item["table_document"][dropdown.value].display_document()

class BasicStage(Node):
    default_name = 'Basic Stage'
    default_description = 'This stages the source tables'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(2, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Writing the SQL code to stage the table ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        stg_table_name = table_name.replace("src", "stg")
        doc_df = item["table_document"][table_name]
        basic_description = doc_df.get_basic_description()

        return table_name, stg_table_name, basic_description

    def run(self, extract_output, use_cache=True):
        table_name, stg_table_name, basic_description = extract_output

        template = f"""Write the SQL query for the stg table of the following table:

{basic_description}

The stg table shall be a SELECT FROM {table_name}.
Most of the times, the columns will be the same as the src table.

However, there are simple transformation you want to perform:
- Change the data type of a column. E.g., some value shall be better represented as INT/DATETIME instead of string. 
- Trim the string columns if there are leading or trailing spaces.
- Are there any columns that are redundant? If so, remove them.
- Split a column into multiple columns. E.g., each cell contains multiple values.
First reason about the table. Go through each column and its values in the reasoning.
Finally provide a list of transformations and the SQL query with detailed comments (skip comments for unchanged columns). Please use duckdb syntax.

```json
{{
    "reason: "1. format ... 2. trim... 3. redundancy ... 4. split ..."
    "transformations": [
        "..."
    ],
    "sql": "CREATE TABLE {stg_table_name} AS
SELECT
    W as W,
    -- trim column X
    trim(X) as X,
    -- Y column is removed
    -- split column Z into Z1, Z2
    regexp_split_to_array(Z, ',')[1] AS Z1,
    regexp_split_to_array(Z, ',')[2] AS Z2
    ...
FROM {table_name}"
}}
```""" 
        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)

        return summary
            
        
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        sql_query = run_output['sql']
        con = self.input_item["con"]
        run_sql_return_df(con, robust_create_to_replace(sql_query))

        input_table = self.para["element_name"]
        output_table = self.para["element_name"].replace("src", "stg")
        dbt_formatted_query = process_query_to_dbt(sql_query, [input_table])
        dbt_project_dir = self.input_item["dbt_directory"]
        dbt_file_path = f"{dbt_project_dir}/models/stage/{output_table}.sql"

        with open(dbt_file_path, "w") as f:
            f.write(dbt_formatted_query)

        yml_file_path = f"{dbt_project_dir}/models/stage/{output_table}.yml"
        yml_dict = yml_from_name(output_table)

        for item in yml_dict["models"]:
            if item["name"] == output_table:
                if "cocoon_tags" not in item:
                    item["cocoon_tags"] = {}
                item["cocoon_tags"]["stage"] = None

        with open(yml_file_path, 'w') as file:
            yaml.dump(yml_dict, file)

        callback(sql_query)
    

class BasicStageForAll(MultipleNode):
    default_name = 'Basic Stage For All'
    default_description = 'This stages the source tables'

    def construct_node(self, element_name, idx=0, total=0):
        node = BasicStage(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):
        self.elements = list(self.global_document["Data Product"]["Group Data Source"].keys())
        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                      for idx, element in enumerate(self.elements)}
        self.item = item

    def display_after_finish_workflow(self, callback, document):

        tab_data = []

        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"
        border_style = """
        <style>
        .border-class {
            border: 1px solid black;
            padding: 10px;
            margin: 10px;
        }
        </style>
        """

        combined_css = css_style + border_style

        dbt_project_dir = self.item["dbt_directory"]

        for key in document["Basic Stage"]:
            sql_query = document["Basic Stage"][key]
            
            dbt_file_path = f"{dbt_project_dir}/models/source/{key}.sql"

            highlighted_sql = wrap_in_scrollable_div(highlight(sql_query, SqlLexer(), formatter))
            file_path_dbt = f"The dbt file is saved at <a href=\"{dbt_file_path}\">{dbt_file_path}</a>" 
            bordered_content = f'<div class="border-class">{file_path_dbt}{highlighted_sql}</div>'
            tab_data.append((key, combined_css + bordered_content))

        tabs = create_dropdown_with_content(tab_data)
        
        print("🎉 The SQL codes to stage the tables have been written!")
        display(tabs)
        print("😎 Next we will analyze the CRUD tables...")
        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)
        display(next_button)

class DecideCRUDTable(Node):
    default_name = 'Decide CRUD Table'
    default_description = 'This decide if the given table contains CRUD/overwriting'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(2, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Deciding the CRUD tables ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        doc_df = item["table_document"][table_name]
        basic_description = doc_df.get_basic_description()

        return basic_description

    def run(self, extract_output, use_cache=True):
        basic_description = extract_output

        template =  f"""{basic_description}

Does the table rows represent "Create Read Update Delete"/Overwriting Logics?
If so, what are the columns that represent the operation and date? Leave as null if date is not available.
Respond with the following format:
```json
{{
    "reasoning": "..."
    "crud": true/false,
    (if true)
    "op_cols": ["col1", "col2"...]
    "date_cols": ["col1", "col2"...]
}}
```"""
        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)
    
class DecideCRUDForAll(MultipleNode):
    default_name = 'Decide CRUD For All'
    default_description = 'This decide if the given table contains CRUD/overwriting'

    def construct_node(self, element_name, idx=0, total=0):
        node = DecideCRUDTable(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):
        self.elements = list(self.global_document["Data Product"]["Group Data Source"].keys())
        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                      for idx, element in enumerate(self.elements)}
        self.item = item

    def display_after_finish_workflow(self, callback, document):

        tab_data = []

        for key in document["Decide CRUD Table"]:
            if document["Decide CRUD Table"][key]["crud"]:
                op_cols = document["Decide CRUD Table"][key]["op_cols"]
                date_cols = document["Decide CRUD Table"][key]["date_cols"]
                doc_df = self.item["table_document"][key]

                columns = list(doc_df.df.columns)
                op_col_indices = [columns.index(col) for col in op_cols if col in columns]
                date_col_indices = [columns.index(col) for col in date_cols if col in columns]
                df_sample =  color_columns(doc_df.df.head(), 'lightgreen', op_col_indices+date_col_indices)

                tab_data.append((key, f"These columns represent CRUD operations: <i>{op_cols + date_cols}</i>" +\
                                        wrap_in_scrollable_div(truncate_html_td(df_sample.to_html()))))

        if len(tab_data) > 0:
            print(f"🧐 We have identified {BOLD}{len(tab_data)}{END} tables with CRUD logics:")
            tabs = create_dropdown_with_content(tab_data)
            display(tabs)

            print("😔 CRUD tables are hard to model and query.")
            print("😎 Instead, we will perform CRUD ops to create its latest snapshot ...")
        else:
            print("🤓 No CRUD/overwriting tables have been identified.")

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)
        

        next_button.on_click(on_button_click)
        display(next_button)

class PerformCRUD(Node):
    default_name = 'Perform CRUD'
    default_description = 'This performs CRUD operations'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(2, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Performing the CRUD operations ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        op_cols = self.global_document["Data Product"]["Decide CRUD For All"]["Decide CRUD Table"][table_name]["op_cols"]
        date_cols = self.global_document["Data Product"]["Decide CRUD For All"]["Decide CRUD Table"][table_name]["date_cols"]

        doc_df = item["table_document"][table_name]
        
        con = item["con"]
        stg_table_name = table_name.replace("src", "stg")
        df = run_sql_return_df(con, f"select * from {stg_table_name}")
        doc_df.table_name = stg_table_name

        return op_cols, date_cols, doc_df, df, con

    def run(self, extract_output, use_cache=True):
        summary = {}
        op_cols, date_cols, doc_df, df, con = extract_output

        template = f"""{doc_df.get_sample_text()}
{doc_df.document["table_summary"]["summary"]}

This table represents "Create Read Update Delete" operations. {op_cols + date_cols} represent the operation-related columns.
Suppose the operations has **been performed**. 
What are the primary key for the final table (should exclude any column for operation)? 
You should think about what the table is about. 
If it's about a single entity, the key is entity id.
If it's about relation, the key is all the entity keys.

```json
{{
    "reasoning": "..."
    "primary_key": ["col1", "col2"...]
}}
```"""
        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages.append(messages)
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)

        summary["primary_key"] = json_code["primary_key"]
        primary_key = json_code['primary_key']

        deduplicated_df = df.drop_duplicates(subset=op_cols, keep='first')
        op_col_desc = "\n".join([describe_column(doc_df.stats, col) for col in  op_cols])
        template = f"""{describe_df_in_natural_language(df=deduplicated_df, 
                                table_name=doc_df.table_name, 
                                num_rows_to_show=len(deduplicated_df))}
{op_cols} represent the operation-related columns:
{op_col_desc} 

Help me classify the values in operator columns into CUD.
You shall try to understand what each value mean, and what are they creating, updating, or deleting.
For operations like deactivate, classify them as delete.
```json
{{
    "reasoning": "The operator values are ... Each means..."
    "create": {{
        "values": ["val1", val2", ...]
        "explanation": "val1 creates ... val2 creates ..."
    }}
    "update": ...
    "delete": ..
}}
```"""

        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages.append(messages)
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)

        summary["attributes"] = json_code

        create = json_code["create"]
        update = json_code["update"]
        delete = json_code["delete"]

        deleted_table_name = doc_df.table_name.replace("stg", "txn")

        if len(create['values']) > 0:

            deleted_table_name += "_del"
            
            template = f"""{describe_df_in_natural_language(df=deduplicated_df, 
                                    table_name=doc_df.table_name, 
                                    num_rows_to_show=len(deduplicated_df))}
{op_cols} represent the operation-related columns.
The following values mean deletion: {delete['values']}
{delete['explanation']}

Write a SQL query that returns a new table '{deleted_table_name}' that performs all deletions.

First, read the rows for deletion. For each type of deletion, what it deletes, and how it use to identify the entities.
The primary key after the ops shall be {primary_key}. The ids likely come from them.
Then, remove the identified rows for each type of deletion.
Return the following:
```json
{{
    "reasoning": "For operator X, it identifies deleted rows by ..."
    "sql": "create table {deleted_table_name} as 
SELECT *
FROM {doc_df.table_name} as y
WHERE 
NOT EXISTS (SELECT 1 FROM stg_customer_mgmt 
            WHERE operator = del_op1
            AND id = t.id AND...) 
AND 
NOT EXISTS ... (for each deletion ops)"
}}
```"""
            messages = [{"role": "user", "content": template}]

            response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
            messages.append(response['choices'][0]['message'])
            self.messages.append(messages)
            
            json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
            json_code = replace_newline(json_code)
            json_code = json.loads(json_code)

            summary["deleted_table"] = json_code
            run_sql_return_df(con, robust_create_to_replace(json_code['sql']))
            df = run_sql_return_df(con, f"select * from {deleted_table_name}")

            input_table = doc_df.table_name
            output_table = deleted_table_name
            dbt_formatted_query = process_query_to_dbt(json_code['sql'], [input_table])
            dbt_project_dir = self.input_item["dbt_directory"]
            dbt_file_path = f"{dbt_project_dir}/models/stage/{output_table}.sql"
            with open(dbt_file_path, "w") as f:
                f.write(dbt_formatted_query)

        
        stats = collect_df_statistics_(df, doc_df.document)
        op_col_desc = "\n".join([describe_column(stats, col) for col in  op_cols + date_cols])
        deduplicated_df = df.drop_duplicates(subset=op_cols, keep='first')
        new_name_del = deleted_table_name
        new_name_final =  new_name_del.replace("_del", "_update")
        template = f"""{describe_df_in_natural_language(df=deduplicated_df, 
                                table_name=new_name_del, 
                                num_rows_to_show=len(deduplicated_df))}
{op_cols + date_cols} represent the operation-related columns.

The goal is to write a SQL query that returns a new table '{new_name_final}', which performs all updates in duckdb.
The primary keys for the final table shall be {primary_key}.

Now, write the SQL for update. The update rows may contain NULL for non-updated columns.
Use LAST_VALUE(value IGNORE NULLS) to get the latest value for each column.
Partition the table by the primary key and order by the transaction time
For the final table, exclude the columns for operation and date.

Now, respond in the following format:
```json
{{
    "reasoning": "For operator X, it identifies deleted rows by ..."
    "sql": "create table {new_name_final} as 

WITH imputed AS (            
    SELECT 
        LAST_VALUE(value IGNORE NULLS) OVER w as col1,
        ...
        ROW_NUMBER() OVER w AS rn
    FROM {new_name_del}
    WINDOW w AS (PARTITION BY primary keys ORDER BY timestamp DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
)

SELECT * EXCLUDE (rn)
FROM imputed
WHERE rn = 1
ORDER BY primary keys"}}
```"""
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages.append(messages)
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)

        summary["final_table"] = json_code
        run_sql_return_df(con, robust_create_to_replace(json_code['sql']))

        input_table = new_name_del
        output_table = new_name_final
        dbt_formatted_query = process_query_to_dbt(json_code['sql'], [input_table])
        dbt_project_dir = self.input_item["dbt_directory"]
        dbt_file_path = f"{dbt_project_dir}/models/stage/{output_table}.sql"
        with open(dbt_file_path, "w") as f:
            f.write(dbt_formatted_query)

        
        
        yml_file_path = f"{dbt_project_dir}/models/stage/{output_table}.yml"
        yml_dict = yml_from_name(output_table)

        for item in yml_dict["models"]:
            if item["name"] == output_table:
                if "cocoon_tags" not in item:
                    item["cocoon_tags"] = {}
                item["cocoon_tags"]["crud"] = None

        with open(yml_file_path, 'w') as file:
            yaml.dump(yml_dict, file)

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)


class PerformCRUDForAll(MultipleNode):
    default_name = 'Perform CRUD For All'
    default_description = 'This performs CRUD operations'

    def construct_node(self, element_name, idx=0, total=0):
        node = PerformCRUD(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):
        elements = []
        for key in self.global_document["Data Product"]["Decide CRUD For All"]["Decide CRUD Table"]:
            if self.global_document["Data Product"]["Decide CRUD For All"]["Decide CRUD Table"][key]["crud"]:
                elements.append(key)

        self.elements = elements
        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                      for idx, element in enumerate(self.elements)}
        self.item = item

    def display_after_finish_workflow(self, callback, document):

        if len(self.elements) == 0:
            callback(document)
            return

        tab_data = []

        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"
        border_style = """
        <style>
        .border-class {
            border: 1px solid black;
            padding: 10px;
            margin: 10px;
        }
        </style>
        """

        combined_css = css_style + border_style
        dbt_project_dir = self.item["dbt_directory"]

        for key in document["Perform CRUD"]:
            sql_query = document["Perform CRUD"][key]["final_table"]["sql"]

            if "deleted_table" in document["Perform CRUD"][key]:
                deleted_sql_query = document["Perform CRUD"][key]["deleted_table"]["sql"]
                sql_query = f"{deleted_sql_query}\n\n{sql_query}"

            output_table_name = key.replace("stg", "txn") + "_update"

            dbt_file_path = f"{dbt_project_dir}/models/stage/{output_table_name}.sql"
            file_path_dbt = f"The dbt file is saved at <a href=\"{dbt_file_path}\">{dbt_file_path}</a>" 

            highlighted_sql = wrap_in_scrollable_div(highlight(sql_query, SqlLexer(), formatter))
            bordered_content = f'<div class="border-class">{file_path_dbt}{highlighted_sql}</div>'

            tab_data.append((key.replace("src_", "stg_"), combined_css + bordered_content))

        print("🎉 The CRUD operations have been performed!")
        if len(tab_data) > 0:
            tabs = create_dropdown_with_content(tab_data)
            display(tabs)

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)
        display(next_button)

class DecideForeignKey(Node):
    default_name = 'Decide Foreign Key'
    default_description = 'This decides the foreign key'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(2, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Deciding the foreign key ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        source_table = self.para["source_table"]
        con = item["con"]
        df = run_sql_return_df(con, f"SELECT * FROM {table_name}")
        doc_df = item["table_document"][source_table]
        basic_summary = doc_df.document['main_entity']["summary"]

        return df, basic_summary, table_name

    def run(self, extract_output, use_cache=True):
        df, basic_summary, table_name = extract_output

        template = f"""{describe_df_in_natural_language(df=df, 
                        table_name=table_name, 
                        num_rows_to_show=2)}

The table is about {basic_summary}

Find the columns look like foreign key. For each foreign key, what dimension it refers to?

Respond in the following format:
```json
{{
    "reasoning": "This table bridges dimensions or not.  The foreign keys for X are ... They correspond to Y dim. ..",
    "foreign_keys": [
        {{"key": ["col1", "col2", ...],
          "dimension": "dim1"}},
          ...
    ]
}}
```"""  

        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)
        
        for message in messages:
            write_log(message['content'])
            write_log("---------------------")

        return json_code


    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)

class DecideForeignKeyForAll(MultipleNode):
    default_name = 'Decide Foreign Key For All'
    default_description = 'This decides the foreign key'

    def construct_node(self, element_name, idx=0, total=0, source_table=None):
        node = DecideForeignKey(para={"element_name": element_name, "idx": idx, "total": total, "source_table": source_table})
        node.inherit(self)
        return node

    def extract(self, item):
        source_tables = self.global_document["Data Product"]["Group Data Source"].keys()
        self.elements = []
        self.nodes = {}

        for idx, source_table in enumerate(source_tables):
            if source_table in self.global_document["Data Product"]["Perform CRUD For All"]["Perform CRUD"]:
                table_name = source_table.replace("src", "txn") + "_update"
                self.elements.append(table_name)
                self.nodes[table_name] = self.construct_node(table_name, idx, len(source_tables), source_table = source_table)

            else:
                table_name = source_table.replace("src", "stg")
                self.elements.append(table_name)
                self.nodes[table_name] = self.construct_node(table_name, idx, len(source_tables), source_table = source_table)

        self.item = item

class PerformNormalization(Node):
    default_name = 'Perform Normalization'
    default_description = 'This performs normalization'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(2, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Performing the normalization ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        self.table_name = table_name
        source_table = self.para["source_table"]
        con = item["con"]
        df = run_sql_return_df(con, f"SELECT * FROM {table_name}")
        doc_df = item["table_document"][source_table]

        self.foreign_keys = self.global_document["Data Product"]["Decide Foreign Key For All"]["Decide Foreign Key"][table_name]["foreign_keys"]
        fk_desc = []
        for entry in self.foreign_keys:
            key = entry["key"]
            dimension = entry["dimension"]
            fk_desc.append(f"{dimension}: {key}")
        fk_desc = "\n".join([f"{idx}. {entry}" for idx, entry in enumerate(fk_desc)]) 

        basic_summary = doc_df.document['main_entity']["summary"]

        return df, basic_summary, table_name, fk_desc, len(self.foreign_keys)

    def run(self, extract_output, use_cache=True):
        df, basic_summary, table_name, fk_desc, num_foreign_keys = extract_output

        template = f"""{describe_df_in_natural_language(df=df, 
                                table_name=table_name, 
                                num_rows_to_show=2)}

The table is about {basic_summary}

The table contains {num_foreign_keys} entities with their keys:
{fk_desc}

For each attribute, is it obviously **uniquely decided** by only one entity's key to normalize?

E.g, Country is **uniquely decided** by City. User Name is **uniquely decided** by User Id.
Note the difference between **uniquely decided** and **relates**.
However, City relates to Country, but is NOT **uniquely decided** by Country.

For each entity, return the list of attributes obviously **uniquely decided** by only this entity (and its key) independent of other info in the row.
Most of the time, the list shall be empty.

Respond in the following format:
```json
{{
    "reasoning": "The table is about ... X is **uniquely decided** by entity Y because when we know Y, we know X for sure.",
    "attributes": 
        {{"dim1": ["col1", "col2", ...],
          ...
        }}
    
}}
```"""
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])

        template = """Are there attributes from the previous answers also depend on other entities?
If so, remove them from the list.
Respond in the following format:
```json
{
    "reasoning": "col1 in dim1 also depend on dim2, so it's not **uniquely decided** by dim1",
    "attributes": 
        {"dim1": ["col2", ...],
          ...
        }
    
}
```"""
        messages += [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages

        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        json_code = json.loads(json_code)

        for message in messages:
            write_log(message['content'])
            write_log("---------------------")

        return json_code

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        def create_query(new_table_name1, new_table_name2, key_atts, non_key_atts, table):
            key_atts_str = ', '.join(key_atts)

            non_key_atts_str = ', '.join(f'MAX({att}) AS {att}' for att in non_key_atts)

            select_clause = f'{key_atts_str}, {non_key_atts_str}'

            sql_query1 = f"""CREATE TABLE {new_table_name1} AS
-- MAX is used to prioritize non-null values
SELECT {select_clause} 
FROM {table} 
GROUP BY {key_atts_str}
ORDER BY {key_atts_str}
"""

            sql_query2 = f"""CREATE TABLE {new_table_name2} AS    
SELECT * EXCLUDE ({", ".join(non_key_atts)})
FROM {table}"""
            
            return sql_query1, sql_query2

        con = self.input_item["con"]

        for entry in self.foreign_keys:
            key = entry["key"]
            dimension = entry["dimension"]

            if dimension in run_output["attributes"]:
                attributes = run_output["attributes"][dimension]
                non_key_attributes = list(set(attributes) - set(key))
                non_key_attributes = sorted(non_key_attributes)
                if non_key_attributes:
                    new_table_name1 =  f"stg_{dimension.lower()}"
                    new_table_name2 = self.table_name + "_normalized"
                    sql_query1, sql_query2 = create_query(new_table_name1,  new_table_name2, key, non_key_attributes, self.table_name)
                    if "normalize" not in run_output:
                        run_output["normalize"] = {}
                    run_output["normalize"][dimension] = {}
                    run_output["normalize"][dimension]["sql_query"] = [sql_query1, sql_query2]
                    run_output["normalize"][dimension]["new_table_name"] = [new_table_name1, new_table_name2]
                    run_sql_return_df(con, robust_create_to_replace(sql_query1))
                    run_sql_return_df(con, robust_create_to_replace(sql_query2))

                    input_table = self.table_name
                    output_table = new_table_name1
                    dbt_formatted_query = process_query_to_dbt(sql_query1, [input_table])
                    dbt_project_dir = self.input_item["dbt_directory"]
                    dbt_file_path = f"{dbt_project_dir}/models/stage/{output_table}.sql"
                    with open(dbt_file_path, "w") as f:
                        f.write(dbt_formatted_query)
                    

                    yml_file_path = f"{dbt_project_dir}/models/stage/{output_table}.yml"
                    yml_dict = yml_from_name(output_table)

                    for item in yml_dict["models"]:
                        if item["name"] == output_table:
                            if "cocoon_tags" not in item:
                                item["cocoon_tags"] = {}
                            item["cocoon_tags"]["normalization"] = None

                    with open(yml_file_path, 'w') as file:
                        yaml.dump(yml_dict, file)


                    input_table = self.table_name
                    output_table = new_table_name2
                    dbt_formatted_query = process_query_to_dbt(sql_query2, [input_table])
                    dbt_project_dir = self.input_item["dbt_directory"]
                    dbt_file_path = f"{dbt_project_dir}/models/stage/{output_table}.sql"
                    with open(dbt_file_path, "w") as f:
                        f.write(dbt_formatted_query)

                    
                    yml_file_path = f"{dbt_project_dir}/models/stage/{output_table}.yml"
                    yml_dict = yml_from_name(output_table)

                    for item in yml_dict["models"]:
                        if item["name"] == output_table:
                            if "cocoon_tags" not in item:
                                item["cocoon_tags"] = {}
                            item["cocoon_tags"]["normalization"] = None

                    with open(yml_file_path, 'w') as file:
                        yaml.dump(yml_dict, file)
    
        callback(run_output)


class PerformNormalizationForAll(MultipleNode):
    default_name = 'Perform Normalization For All'
    default_description = 'This performs normalization'

    def construct_node(self, element_name, idx=0, total=0, source_table=None):
        node = PerformNormalization(para={"element_name": element_name, "idx": idx, "total": total, "source_table": source_table})
        node.inherit(self)
        return node

    def extract(self, item):
        self.elements = []

        source_tables = self.global_document["Data Product"]["Group Data Source"].keys()
        self.elements = []
        table_to_source = {}

        for source_table in source_tables:
            if source_table in self.global_document["Data Product"]["Perform CRUD For All"]["Perform CRUD"]:
                table_name = source_table.replace("src", "txn") + "_update"
            else:
                table_name = source_table.replace("src", "stg")

            table_to_source[table_name] = source_table

            foreign_keys = self.global_document["Data Product"]["Decide Foreign Key For All"]["Decide Foreign Key"][table_name]["foreign_keys"]
            if len(foreign_keys) == 0:
                continue
            
            self.elements.append(table_name)

        self.nodes = {element: self.construct_node(element, idx, len(self.elements), source_table=table_to_source[element])
                        for idx, element in enumerate(self.elements)}
        
        self.item = item

    def display_after_finish_workflow(self, callback, document):

        if len(self.elements) == 0:
            callback(document)
            return
        
        tabs = []

        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"

        for key in document["Perform Normalization"]:
            if "normalize" in document["Perform Normalization"][key]:
                for dimension in document["Perform Normalization"][key]["normalize"]:
                    sql_queries = document["Perform Normalization"][key]["normalize"][dimension]["sql_query"]
                    highlighted_sql = wrap_in_scrollable_div(highlight("\n\n".join(sql_queries), SqlLexer(), formatter))
                    tabs.append((f"{key} - {dimension}", css_style + highlighted_sql))

        print("🎉 We have normalized your tables!")
        
        if len(tabs) > 0:        
            tabs = create_dropdown_with_content(tabs)
            display(tabs)

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)

        display(next_button)


class ClassifyDimFact(Node):
    default_name = 'Classify Dim Fact'
    default_description = 'This classifies the dimension and fact tables'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(3, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Classifying the dimension and fact tables ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        self.table_name = table_name
        source_table = self.para["source_table"]
        con = item["con"]
        df = run_sql_return_df(con, f"SELECT * FROM {table_name}")
        doc_df = item["table_document"][source_table]


        return df, table_name

    def run(self, extract_output, use_cache=True):
        df, table_name = extract_output

        table_name = table_name.replace("_update", "")
        table_name = table_name.replace("_normalized", "")
        table_name = table_name.replace("txn_", "stg_")

        template = f"""{describe_df_in_natural_language(df=df, 
                                table_name=table_name, 
                                num_rows_to_show=2)}

Now, classify the tables:
1. Is this table about events, or matching between entities? If so, it's a fact table.
2. Is this table about entity attributes? If so, it's a dimension table.

Respond with following format:
```json
{{
    "reasoning": "...",
    "type": "fact/dimension"
    "summary": "this is for facts/dimensions of ..."
}}
```"""
        
        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)

        for message in messages:
            write_log(message['content'])
            write_log("---------------------")

        return summary
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)

class ClassifyDimFactForAll(MultipleNode):
    default_name = 'Classify Dim Fact For All'
    default_description = 'This classifies the dimension and fact tables'

    def construct_node(self, element_name, idx=0, total=0, source_table=None):
        node = ClassifyDimFact(para={"element_name": element_name, "idx": idx, "total": total, "source_table": source_table})
        node.inherit(self)
        return node

    def extract(self, item):
        self.elements = []

        source_tables = self.global_document["Data Product"]["Group Data Source"].keys()
        self.elements = []
        table_to_source = {}

        for source_table in source_tables:
            if source_table in self.global_document["Data Product"]["Perform CRUD For All"]["Perform CRUD"]:
                table_name = source_table.replace("src", "txn") + "_update"
            else:
                table_name = source_table.replace("src", "stg")

            table_to_source[table_name] = source_table

            if table_name in self.global_document["Data Product"]["Perform Normalization For All"]["Perform Normalization"]:
                if "normalize" in self.global_document["Data Product"]["Perform Normalization For All"]["Perform Normalization"][table_name]:
                    for dimension in self.global_document["Data Product"]["Perform Normalization For All"]["Perform Normalization"][table_name]["normalize"]:
                        tables = self.global_document["Data Product"]["Perform Normalization For All"]["Perform Normalization"][table_name]["normalize"][dimension]["new_table_name"]
                        for table_name in tables:
                            table_to_source[table_name] = source_table
                            self.elements.append(table_name)
                    continue
            
            self.elements.append(table_name)

        self.nodes = {element: self.construct_node(element, idx, len(self.elements), source_table=table_to_source[element])
                        for idx, element in enumerate(self.elements)}
        
        self.item = item

    def display_after_finish_workflow(self, callback, document):

        data = []

        for key in document["Classify Dim Fact"]:
            if document["Classify Dim Fact"][key]["type"] == "fact":
                data.append([key, "✔", "", document['Classify Dim Fact'][key]['summary']])
            else:
                data.append((key, "", "✔", document['Classify Dim Fact'][key]['summary']))

                import pandas as pd

        df = pd.DataFrame(data, columns=["Table Name", "Fact", "Dimension", "Reason"])

        print("🎉 The dimension and fact tables have been classified!")

        display(df)

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)

        display(next_button)


class CreateFactTable(Node):
    default_name = 'Create Fact Table'
    default_description = 'This creates the fact table'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(3, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Creating the fact table ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        descriptions =  self.global_document["Data Product"]["Business Workflow"]["descriptions"]
        entities = set()
        relation_all = []
        nl_descs = []

        for line in descriptions:
            nl_desc, relations = line
            for relation in relations:
                entity1, action, entity2 = relation
                entities.add(entity1)
                entities.add(entity2)
                relation_all.append(relation)
            nl_descs.append(nl_desc)

        nl_descs = "\n".join(nl_descs)
        entity_desc = "\n".join(f"{idx+1}. {entity}" for idx, entity in enumerate(entities))
        relation_desc = "\n".join(f"{idx+1}. {relation}" for idx, relation in enumerate(relation_all))

        table_name = self.para["element_name"]
        con = item["con"]
        df = run_sql_return_df(con, f"SELECT * FROM {table_name}")


        return df, table_name, relation_desc

    def run(self, extract_output, use_cache=True):
        df, table_name, relation_desc = extract_output

        template = f"""You have the relations in the business Workflow:
{relation_desc}

{describe_df_in_natural_language(df=df, 
                                table_name=table_name, 
                                num_rows_to_show=2)}

This table is a fact table. 
1. First identify the relations this table directly describe. Provide its index.
2. Choose a new name for this table. The new name should begin with "fact_", followed by a concise, lowercase nouns.
Try to reuse the terms from the business workflow/table name. Don't invent new term 

Respond with following format:
```json
{{
    "reasoning": "The table is about ...",
    "related_relations": [1],
    "name": "fact_...",
    "summary": "This table is for ..."
}}
```"""
            
        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages

        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)

        return summary
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        con = self.input_item["con"]
        table_name = self.para["element_name"]
        new_table_name = run_output["name"]
        sql_query = f"CREATE TABLE {new_table_name} AS SELECT * FROM {table_name}"
        run_sql_return_df(con, robust_create_to_replace(sql_query))

        input_table = table_name
        output_table = new_table_name
        dbt_formatted_query = process_query_to_dbt(sql_query, [input_table])
        dbt_project_dir = self.input_item["dbt_directory"]
        dbt_file_path = f"{dbt_project_dir}/models/model/{output_table}.sql"
        with open(dbt_file_path, "w") as f:
            f.write(dbt_formatted_query)

        callback(run_output)

class CreateFactTableForAll(MultipleNode):
    default_name = 'Create Fact Table For All'
    default_description = 'This creates the fact table'

    def construct_node(self, element_name, idx=0, total=0):
        node = CreateFactTable(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):

        self.elements = []

        for table_name in self.global_document["Data Product"]["Classify Dim Fact For All"]["Classify Dim Fact"]:
            if self.global_document["Data Product"]["Classify Dim Fact For All"]["Classify Dim Fact"][table_name]["type"] == "fact":
                self.elements.append(table_name)

        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                        for idx, element in enumerate(self.elements)}
        
        self.item = item

    def display_after_finish_workflow(self, callback, document):
        callback(document)

class CreateDimensionTable(Node):
    default_name = 'Create Dimension Table'
    default_description = 'This creates the dimension table'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(3, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Creating the dimension table ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        descriptions =  self.global_document["Data Product"]["Business Workflow"]["descriptions"]
        entities = set()
        relation_all = []
        nl_descs = []

        for line in descriptions:
            nl_desc, relations = line
            for relation in relations:
                entity1, action, entity2 = relation
                entities.add(entity1)
                entities.add(entity2)
                relation_all.append(relation)
            nl_descs.append(nl_desc)

        nl_descs = "\n".join(nl_descs)
        entity_desc = "\n".join(f"{idx+1}. {entity}" for idx, entity in enumerate(entities))
        relation_desc = "\n".join(f"{idx+1}. {relation}" for idx, relation in enumerate(relation_all))

        table_name = self.para["element_name"]
        con = item["con"]
        df = run_sql_return_df(con, f"SELECT * FROM {table_name}")

        return df, table_name, nl_descs

    def run(self, extract_output, use_cache=True):
        df, table_name, nl_descs = extract_output

        template = template = f"""You have the business Workflow:
{nl_descs}


{describe_df_in_natural_language(df=df, 
                                table_name=table_name, 
                                num_rows_to_show=2)}

This table is a dimension table. 
First, identify the primary key for this table. 
Then, choose a new name for this table. The new name should begin with "dim_", followed by a concise, lowercase nouns.
Try to reuse the terms from the business workflow/table name. Don't invent new term 

Respond with following format:
```json
{{
    "reasoning": "The table is about ... XXX could be used to uniquely identify ...",
    "primary_key": ["col", ...],
    "name": "dim_...",
    "summary": "This table is for ..."
}}
```"""
                
        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)        

        for message in messages:
            write_log(message['content'])
            write_log("---------------------")

        return summary
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        con = self.input_item["con"]
        table_name = self.para["element_name"]
        new_table_name = run_output["name"]
        sql_query = f"CREATE TABLE {new_table_name} AS SELECT * FROM {table_name}"
        run_sql_return_df(con, robust_create_to_replace(sql_query))

        input_table = table_name
        output_table = new_table_name
        dbt_formatted_query = process_query_to_dbt(sql_query, [input_table])
        dbt_project_dir = self.input_item["dbt_directory"]
        dbt_file_path = f"{dbt_project_dir}/models/model/{output_table}.sql"
        with open(dbt_file_path, "w") as f:
            f.write(dbt_formatted_query)

        callback(run_output)

class CreateDimensionTableForAll(MultipleNode):
    default_name = 'Create Dimension Table For All'
    default_description = 'This creates the dimension table'

    def construct_node(self, element_name, idx=0, total=0):
        node = CreateDimensionTable(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):

        self.elements = []

        for table_name in self.global_document["Data Product"]["Classify Dim Fact For All"]["Classify Dim Fact"]:
            if self.global_document["Data Product"]["Classify Dim Fact For All"]["Classify Dim Fact"][table_name]["type"] == "dimension":
                self.elements.append(table_name)

        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                        for idx, element in enumerate(self.elements)}
        
        self.item = item

    def display_after_finish_workflow(self, callback, document):

        fact_document = self.global_document["Data Product"]["Create Fact Table For All"]
        num_fact  = len(fact_document["Create Fact Table"])
        print(f"🎉 The following {num_fact} fact tables have been created!")

        for idx, key in enumerate(fact_document["Create Fact Table"]):
            print(f"{idx+1}. {BOLD}{fact_document['Create Fact Table'][key]['name']}{END} (from {BOLD}{key}{END})")
            print(f"   {ITALIC}{fact_document['Create Fact Table'][key]['summary']}{END}")

        print("")
        num_dim  = len(document["Create Dimension Table"])
        print(f"🎉 The following {num_dim} dimension tables have been created!")

        for idx, key in enumerate(document["Create Dimension Table"]):
            print(f"{idx+1}. {BOLD}{document['Create Dimension Table'][key]['name']}{END} (from {BOLD}{key}{END})")
            print(f"   {ITALIC}{document['Create Dimension Table'][key]['summary']}{END}")
        
        
        title = self.global_document["Data Product"]["Business Workflow"]["title"]
        descriptions = self.global_document["Data Product"]["Business Workflow"]["descriptions"]

        descriptions_size = [len(desc[1]) for desc in descriptions]
        descriptions_size_array = np.array(descriptions_size)
        descriptions_size_max = descriptions_size_array.cumsum()
        descriptions_size_max

        table_to_summary_map = {}
        new_table_name = {}

        def find_index(value, max_sizes):
            for i, size in enumerate(max_sizes):
                if value <= size:
                    return i
            return len(max_sizes) - 1

        related_tables = [set() for _ in range(len(descriptions))]

        for table in fact_document["Create Fact Table"]:
            table_to_summary_map[table] = fact_document["Create Fact Table"][table]["summary"]
            new_table_name[table] = fact_document["Create Fact Table"][table]["name"]

            for idx in fact_document["Create Fact Table"][table]["related_relations"]:
                i = find_index(idx, descriptions_size_max)
                related_tables[i].add(table)

        new_descriptions = []

        for i, desc in enumerate(descriptions):
            text, list_r = desc 
            related_table_set = related_tables[i]
            
            text += "<ul>"
            for table in related_table_set:
                new_name = new_table_name[table]
                text += f"<li><i>{new_name}</i></li>"
            text += "</ul>"
            new_descriptions.append((text, list_r))

        print("")
        print("🧐 The fact tables are related to the business workflow as follows ...")

        display_pages(total_page=len(new_descriptions), 
                create_html_content=partial(create_html_content_project, 
                                            title, new_descriptions))

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(document)
        
        next_button.on_click(on_button_click)
        display(next_button)

class ProductDocument(Node):
    default_name = 'Product Document'
    default_description = 'This step documents each product table'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        con = self.input_item["con"]
        table_name = self.para["element_name"]
        df = run_sql_return_df(con, f"select * from {table_name}")
        doc_df = DocumentedData(df, table_name=table_name)
        doc_df.rename_table=False
        doc_df.start(viewer=True)
        if "product_document" not in self.input_item:
            self.input_item["product_document"] = {}
        self.input_item["product_document"][table_name] = doc_df
        callback(doc_df.document)


class ProductDocumentForAll(MultipleNode):
    
    default_name = 'Product Document For All'
    default_description = 'This step documents all product tables'

    def construct_node(self, element_name, idx=0, total=0):
        node = ProductDocument(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):
        fact_names = []
        for table_name in self.global_document["Data Product"]["Create Fact Table For All"]["Create Fact Table"]:
            fact_name = self.global_document["Data Product"]["Create Fact Table For All"]["Create Fact Table"][table_name]["name"]
            fact_names.append(fact_name)
        

        dimension_tables = []
        for table_name in self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"]:
            dim_name = self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"][table_name]["name"]
            dimension_tables.append(dim_name)
        
        self.elements = fact_names + dimension_tables

        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                      for idx, element in enumerate(self.elements)}
        self.item = item
    
    def display_after_finish_workflow(self, callback, document):

        dropdown = widgets.Dropdown(
            options=document["Product Document"].keys(),
        )

        next_button = widgets.Button(description="Next Step", button_style='success')
        
        def on_button_click(b):
            with self.output_context():
                callback(document)
        
        next_button.on_click(on_button_click)

        def on_change(change):
            if change['type'] == 'change' and change['name'] == 'value':
                clear_output(wait=True)

                print("🎉 All the fact and dimension tables have been documented!")
                
                print("😎 Next we will build the join graph ...")
                display(next_button)
                
                print("🧐 You can explore the documents below ...")
                display(dropdown)
                self.item["product_document"][change['new']].display_document()

        dropdown.observe(on_change)

        clear_output(wait=True)
        
        print("🎉 All the fact and dimension tables have been documented!")
        
        print("😎 Next we will build the join graph ...")
        display(next_button)
        
        print("🧐 You can explore the documents for the product tables below ...")
        display(dropdown)
        if len(document["Product Document"]) > 0:
            self.item["product_document"][dropdown.value].display_document()

class CreateFactMatchDim(Node):
    default_name = 'Create Fact Match Dim'
    default_description = 'This creates the fact match dim'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(3, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Creating the fact match dim ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        con = item["con"]

        fact_name = self.global_document["Data Product"]["Create Fact Table For All"]["Create Fact Table"][table_name]["name"]
        summary = self.global_document["Data Product"]["Create Fact Table For All"]["Create Fact Table"][table_name]["summary"]

        dimension_tables = []
        for table_name in self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"]:
            dim_name = self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"][table_name]["name"]
            table_key = self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"][table_name]["primary_key"]
            dimension_tables.append((dim_name, table_key))

        dim_desc = ""
        for idx, (dim_name, table_key) in enumerate(dimension_tables):
            dim_desc += f"{idx+1}. {dim_name}: {table_key}\n"

        df = run_sql_return_df(con, f"SELECT * FROM {fact_name}")

        return df, fact_name, dim_desc, summary

    def run(self, extract_output, use_cache=True):
        df, table_name, dim_desc, fact_summary = extract_output

        template = template = f"""You have the following fact table:
{describe_df_in_natural_language(df=df, 
                                table_name=table_name, 
                                num_rows_to_show=2)}
This table is a fact table. {fact_summary}

You have the following dimension tables with their keys
{dim_desc}

First go through each attribute, especially the foreign keys. If they are abbreviation, guess the full name.
Then, find the corresponding dimension table. 

Respond with following format:
```json
{{
    "reasoning": "The table is about ... X column means, which matches Y dimension ...",
    "dimensons": ["dim_table_name" ...]
}}
```"""
                    
        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)

class CreateFactMatchDimForAll(MultipleNode):
    default_name = 'Create Fact Match Dim For All'
    default_description = 'This creates the fact match dim'

    def construct_node(self, element_name, idx=0, total=0):
        node = CreateFactMatchDim(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):

        self.elements = list(self.global_document["Data Product"]["Create Fact Table For All"]["Create Fact Table"].keys())

        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                        for idx, element in enumerate(self.elements)}
        
        self.item = item

    def display_after_finish_workflow(self, callback, document):
        callback(document)


        



class MatchDimensions(Node):
    default_name = 'Match Dimensions'
    default_description = 'This matches the dimensions'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(3, self.global_document["Data Product"]['Product Steps'])

        print("🤓 Matching the dimensions ...")
        self.progress = show_progress()

        dimension_tables = []
        for table_name in self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"]:
            dim_name = self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"][table_name]["name"]
            table_key = self.global_document["Data Product"]["Create Dimension Table For All"]["Create Dimension Table"][table_name]["primary_key"]
            dimension_tables.append((dim_name, table_key))

        dim_desc = ""
        for idx, (dim_name, table_key) in enumerate(dimension_tables):
            dim_desc += f"{idx+1}. {dim_name}: {table_key}\n"

        return  dim_desc

    def run(self, extract_output, use_cache=True):
        dim_desc = extract_output

        template = f"""You have the following dimension tables with their keys
{dim_desc}

First go through each table and guess what they mean.
Then, find the pair of dimension tables that are joinable, e.g., because they are hierarchical and have the keys joinable.
E.g., dim_state(state_id, city_id) and dim_city(city_id)
Sometimes the pair may be joinable. Classify the confidence into "definite", and "maybe".

Respond with following format:
```json
{{
    "reasoning": "The dimensions are  ... X and Y and joinable pair",
    "definite_pairs": [["dim1", "dim2"] ... ],
    "maybe_pairs": [...]
}}
```"""

        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)


class BuildDataMart(Node):
    default_name = 'Build Data Mart'
    default_description = 'This builds the data mart'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(3, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Building the data mart ...")

        idx = self.para["idx"]
        total = self.para["total"]
        self.progress = show_progress(max_value=total, value=idx)

        table_name = self.para["element_name"]
        con = item["con"]

        fact_name = self.global_document["Data Product"]["Create Fact Table For All"]["Create Fact Table"][table_name]["name"]
        self.fact_name = fact_name

        def get_table_description(con, table_name, row=2):
            df = run_sql_return_df(con, f"SELECT * FROM {table_name}")
            return describe_df_in_natural_language(df, table_name, row)

        fact_table_desc = get_table_description(con, fact_name , 2)

        dimensions = self.global_document["Data Product"]["Create Fact Match Dim For All"]["Create Fact Match Dim"][table_name]["dimensions"]
        
        self.dimensions = dimensions

        dim_table_desc = ""
        for dim_name in dimensions:
            dim_table_desc += get_table_description(con, dim_name, 2)

        join_conditions = "\nAND ".join([f"JOIN {dim_name} ON (...)" for dim_name in dimensions])

        return fact_table_desc, dim_table_desc, join_conditions, fact_name

    def run(self, extract_output, use_cache=True):
        fact_table_desc, dim_table_desc, join_conditions, fact_name = extract_output

        template = f"""You have the following fact table:
{fact_table_desc}

The fact table joins with the following dimension tables:
{dim_table_desc}

Now, write the sql query to join the tables.

Respond with following format:
```json
{{
    "reasoning": "The table is about ... To join with the dimension tables ...",
    "sql": "SELECT * FROM {fact_name} 
{join_conditions}
"
}}
```"""

        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = replace_newline(json_code)
        summary = json.loads(json_code)

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        con = self.input_item["con"]
        fact_name = self.fact_name.replace("fact_", "dm_")
        sql_query = run_output["sql"]
        sql_query = f"CREATE TABLE {fact_name} AS\n {sql_query}"
        run_output["sql"] = sql_query

        input_table = [self.fact_name] + self.dimensions
        output_table = fact_name
        dbt_formatted_query = process_query_to_dbt(sql_query, input_table)
        dbt_project_dir = self.input_item["dbt_directory"]
        dbt_file_path = f"{dbt_project_dir}/models/mart/{output_table}.sql"
        with open(dbt_file_path, "w") as f:
            f.write(dbt_formatted_query)


        callback(run_output)


class SourceToBusiness(Node):
    default_name = 'Source Business'
    default_description = 'Analyze how each source table is related to the business workflow'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item
        create_progress_bar_with_numbers(1, self.global_document["Data Product"]['Product Steps'])
        print("🤓 Analyzing the high-level purpose of source tables ...")

        con = item["con"]
        descriptions = self.global_document["Data Product"]["Business Workflow"]["descriptions"]
    
        def get_nl_entity_rel_desc(descriptions):
            entities = set()
            relation_all = []
            nl_descs = []

            for line in descriptions:
                nl_desc, relations = line
                for relation in relations:
                    entity1, action, entity2 = relation
                    entities.add(entity1)
                    entities.add(entity2)
                    relation_all.append(relation)
                nl_descs.append(nl_desc)

            nl_descs = "\n".join(nl_descs)
            entity_desc = "\n".join(f"{idx+1}. {entity}" for idx, entity in enumerate(entities))
            relation_desc = "\n".join(f"{idx+1}. {relation}" for idx, relation in enumerate(relation_all))
            return nl_descs, entity_desc, relation_desc

        nl_descs, entity_desc, relation_desc = get_nl_entity_rel_desc(descriptions)

        num_tables = len(self.global_document["Data Product"]["Group Data Source"])
        table_desc = f"You have the following {num_tables} tables: \n\n"
        for table_name in self.global_document["Data Product"]["Group Data Source"]:
            df = run_sql_return_df(con, f"SELECT * FROM {table_name}")
            table_desc += describe_df_in_natural_language(df=df, 
                                        table_name=table_name, 
                                        num_rows_to_show=2)
            table_desc += "\n\n"

        return nl_descs, table_desc

    def run(self, extract_output, use_cache=True):
        nl_descs, table_desc = extract_output

        template = f"""You have the following business workflow: {nl_descs}.

{table_desc}

Summarize how each table is related to the business workflow.
Return the result in yml
```yml
- table_name: xxx
  description: short simple desc in < 10 words.
...
```"""

        messages = [{"role": "user", "content": template}]

        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        yml_code = extract_yml_code(response['choices'][0]['message']["content"])
        summary = yaml.safe_load(yml_code)

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        summary = run_output

        df = pd.DataFrame(summary)

        print("🎉 Here are the understanding results")

        display(df)

        print("🧐 Is the understanding correct?")
        yes_button = widgets.Button(description="Yes", button_style='success')
        no_button = widgets.Button(description="No", button_style='danger')
        display(HBox([yes_button, no_button]))

        print("🤓 Next we will dive deep into each table ...")

        next_button = widgets.Button(description="Next Step", button_style='success')

        def on_button_click(b):
            with self.output_context():
                callback(summary)

        next_button.on_click(on_button_click)

        display(next_button)
        

class BuildDataMartForAll(MultipleNode):
    default_name = 'Build Data Mart For All'
    default_description = 'This builds the data mart'

    def construct_node(self, element_name, idx=0, total=0):
        node = BuildDataMart(para={"element_name": element_name, "idx": idx, "total": total})
        node.inherit(self)
        return node

    def extract(self, item):

        self.elements = []

        for fact_name in self.global_document["Data Product"]["Create Fact Match Dim For All"]["Create Fact Match Dim"]:
            dimensions = self.global_document["Data Product"]["Create Fact Match Dim For All"]["Create Fact Match Dim"][fact_name]["dimensions"]
            if len(dimensions) > 0:
                self.elements.append(fact_name)

        self.nodes = {element: self.construct_node(element, idx, len(self.elements))
                        for idx, element in enumerate(self.elements)}
        
        self.item = item

    def display_after_finish_workflow(self, callback, document):
        
        match_document = self.global_document["Data Product"]["Match Dimensions"]
        edges = match_document["definite_pairs"]

        for table_name in self.global_document["Data Product"]["Create Fact Match Dim For All"]["Create Fact Match Dim"]:
            fact_name = self.global_document["Data Product"]["Create Fact Table For All"]["Create Fact Table"][table_name]["name"]
            dimensions = self.global_document["Data Product"]["Create Fact Match Dim For All"]["Create Fact Match Dim"][table_name]["dimensions"]
            edges += [[fact_name, dim] for dim in dimensions]

        nodes = list({node for edge in edges for node in edge})

        data = {
            "nodes": [{"id": node} for node in nodes],
            "links": [{"source": edge[0], "target": edge[1]} for edge in edges]
        }
        print("🎉 The join graph has been constructed!")
        html_content = generate_draggable_graph_html(data)
        display(HTML(wrap_in_iframe(html_content, width=1000)))



        tab_data = []
        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"

        for key in document["Build Data Mart"]:
            sql_query = document["Build Data Mart"][key]["sql"]
            highlighted_sql = wrap_in_scrollable_div(highlight(sql_query, SqlLexer(), formatter))
            tab_data.append((key.replace("stg", "dm"), css_style + highlighted_sql))

        tabs = create_dropdown_with_content(tab_data)  

        num_fact  = len(document["Build Data Mart"])
        print(f"🎉 The following are the denormalized data marts!")
        display(tabs)

        print(f"Congratulations! You've successfully created the data products, ready for dashboards, ad hoc queries, or LLM applications. 🌟")
        next_button = widgets.Button(description="Next Step", button_style='success')\
    
        def on_button_click(b):
            with self.output_context():
                callback(document)

        next_button.on_click(on_button_click)
        display(next_button)



def create_data_product_workflow(dbt_directory, output=False):

    item = {
        "con": duckdb.connect(database=':memory:'),
        "dir": dbt_directory + "/seeds",
        "dbt_directory": dbt_directory,
    }
    if output:
        output = Output()
    else:
        output = None

    main_workflow = Workflow("Data Product", 
                            item = item, 
                            description="A workflow to transform raw data into data product",
                            output=output)

    main_workflow.add_to_leaf(ProductSteps(output=output))
    main_workflow.add_to_leaf(DataSource(output=output))
    main_workflow.add_to_leaf(BusinessWorkflow(output=output))
    main_workflow.add_to_leaf(GroupDataSource(output=output))
    main_workflow.add_to_leaf(SourceCodeWritingForAll(output=output))
    main_workflow.add_to_leaf(SourceToBusiness(output=output))
    main_workflow.add_to_leaf(SourceDocumentForAll(output=output))
    main_workflow.add_to_leaf(BasicStageForAll(output=output))
    main_workflow.add_to_leaf(DecideCRUDForAll(output=output))
    main_workflow.add_to_leaf(PerformCRUDForAll(output=output))
    main_workflow.add_to_leaf(DecideForeignKeyForAll(output=output))
    main_workflow.add_to_leaf(PerformNormalizationForAll(output=output))
    main_workflow.add_to_leaf(ClassifyDimFactForAll(output=output))
    main_workflow.add_to_leaf(CreateFactTableForAll(output=output))
    main_workflow.add_to_leaf(CreateDimensionTableForAll(output=output))
    main_workflow.add_to_leaf(ProductDocumentForAll(output=output))
    main_workflow.add_to_leaf(CreateFactMatchDimForAll(output=output))
    main_workflow.add_to_leaf(MatchDimensions(output=output))
    main_workflow.add_to_leaf(BuildDataMartForAll(output=output))
    return main_workflow


import yaml
import os
import re

def get_dbt_model_info(sql_file_path):
    model_name = os.path.splitext(os.path.basename(sql_file_path))[0]
    referenced_tables = []
    referenced_sources = []
    used_variables = []
    used_macros = []

    try:
        with open(sql_file_path, 'r') as file:
            content = file.read()

            config_match = re.search(r"\{\{\s*config\([^)]*alias=['\"]([^'\"]+)['\"]", content)
            if config_match:
                model_name = config_match.group(1)

            blocks = re.findall(r"\{\{(.+?)\}\}", content, re.DOTALL)

            for block in blocks:
                referenced_tables.extend(re.findall(r"ref\(['\"]([^'\"]+)['\"]\)", block))

                referenced_sources.extend(re.sub(r"\s*,\s*", ",", match) for match in re.findall(r"source\(.*?\)", block))

                referenced_sources.extend(re.findall(r"unpack_jotform\(.*?\)", block))

                used_variables.extend(re.findall(r"var\(['\"]([^'\"]+)['\"]\)", block))

                used_macros.extend(re.findall(r"([a-zA-Z0-9_]+)\(", block))

    except IOError:
        print(f"Error: File {sql_file_path} not accessible.")
        return None, None, None, None, None

    used_macros = list(set(used_macros) - {'config', 'ref', 'source', 'var'})

    referenced_tables = list(set(referenced_tables))
    referenced_sources = list(set(referenced_sources))
    used_variables = list(set(used_variables))
    used_macros = list(set(used_macros))

    return model_name, referenced_tables, referenced_sources, used_variables, used_macros



class DbtTable:
    def __init__(self):
        self.name = None
        self.description = None
        self.columns = []
        self.tests = []
        self.meta = {}
        self.config = {}
        self.sql_query = None
        self.referenced_models = []
        self.referenced_sources = []
        self.used_variables = []
        self.used_macros = []
        self.source = None 
        self.tags = []
        self.tag_results = {}
        self.source_purpose = None
        self.cocoon_tags = {}
    
    def add_yaml_info(self, table_data):
        self.name = table_data.get('name')
        self.description = table_data.get('description')
        self.columns = table_data.get('columns', [])
        self.tests = table_data.get('tests', [])
        self.meta = table_data.get('meta', {})
        self.config = table_data.get('config', {})
        self.cocoon_tags = table_data.get('cocoon_tags', {})

    def add_tag_result(self, tag):
        self.tag_results = tag
        for key, value in tag.items():
            if value["Label"] == True:
                self.tags.append(key)    

    def add_source_purpose(self, purpose):
        self.source_purpose = purpose
                
    def add_sql_info(self, sql_file_path):

        with open(sql_file_path, 'r') as file:
            sql_content = file.read()
            self.sql_query = sql_content

        model_name, referenced_tables, referenced_sources, used_variables, used_macros = get_dbt_model_info(sql_file_path)
        self.name = model_name
        self.referenced_models = referenced_tables
        self.referenced_sources = referenced_sources
        self.used_variables = used_variables
        self.used_macros = used_macros

    def get_name(self):
        if self.source:
            return f"source('{self.source.name}','{self.name}')"
        else:
            return self.name

    def get_tagged_name(self):
        tags_formatted = ''
        for tag in self.tags:
            tags_formatted += f"\n{tag}"
        for tag in self.cocoon_tags:
            tags_formatted += f"\n{tag}"
            
        return f"{self.name}{tags_formatted}"

    def add_source(self, source):
        if not isinstance(source, DbtSource):
            raise ValueError("The source must be a DbtSource instance.")
        self.source = source

    def get_source(self):

        if "partition" in self.cocoon_tags:
            group = self.cocoon_tags["partition"]
            return [f"{self.name} {len(group)} partitions"]
        return self.referenced_models + self.referenced_sources

    def __repr__(self):
        source_info = f"Source: '{self.source.name}'" if self.source else "No source associated"

        repr_str = f"DbtTable '{self.name}':\n"
        repr_str += f"  Description: {self.description or 'Not provided'}.\n"
        
        if self.columns:
            column_names = [col.get('name', 'Unnamed') for col in self.columns]
            repr_str += f"  Columns: {', '.join(column_names)}.\n"
        else:
            repr_str += "  Columns: None.\n"

        repr_str += f"  Tests: {len(self.tests)} defined.\n"
        repr_str += f"  Metadata: {'Provided' if self.meta else 'Not available'}.\n"
        repr_str += f"  Configuration: {'Customized' if self.config else 'Default'}.\n"
        repr_str += f"  SQL Query: {'Included' if self.sql_query else 'Not available'}.\n"
        repr_str += f"  Referenced Models: {', '.join(self.referenced_models) or 'None'}.\n"
        repr_str += f"  Referenced Sources: {', '.join(self.referenced_sources) if self.referenced_sources else 'None'}.\n"
        repr_str += f"  Used Variables: {', '.join(self.used_variables) if self.used_variables else 'None'}.\n"
        repr_str += f"  Used Macros: {', '.join(self.used_macros) if self.used_macros else 'None'}.\n"
        repr_str += f"  {source_info}\n"

        return repr_str

    def to_html(self):
        css = HtmlFormatter().get_style_defs('.highlight')
        html_content = f"<style>{css}</style>"

        label_emoji_map = {
            'Filtering': '🔍 Filtering',
            'Cleaning': '🧼 Cleaning',
            'Featurization': '⚙️ Featurization',
            'Integration': '🤝 Integration',
            'Other': '❓ Other'
        }


        if self.tag_results:
            html_content += "<h3>Tag Results:</h3>"
            html_content += "<ul>"
            for key, value in self.tag_results.items():
                if value['Label'] == True:
                    html_content += f"<li><b>{label_emoji_map[key]}</b>: {value['Reasoning']}</p></li>"
            html_content += "</ul>"

        if self.source_purpose:
            html_content += f"<h3>Source Purpose:</h3>"
            html_content += f"<ul>"
            for key, value in self.source_purpose.items():
                html_content += f"<li><b>{key}</b>: {value}</p></li>"
            html_content += "</ul>"

        html_content += f"<h2>{self.name} YML description</h2>"
        html_content += f"<p><b>Description:</b> {self.description or 'Not provided'}.</p>"
        if self.columns:
            column_names = [col.get('name', 'Unnamed') for col in self.columns]
            html_content += f"<p><b>Columns:</b> {', '.join(column_names)}.</p>"
        else:
            html_content += "<p><b>Columns:</b> Not available.</p>"

        if self.sql_query:
            html_content += wrap_in_scrollable_div(highlight(self.sql_query, SqlLexer(), HtmlFormatter()))
        else:
            html_content += "<p>No SQL query available.</p>"
        
        return html_content


    def display(self):
        html_content = self.to_html()
        display(HTML(html_content))
    
    def merge_with(self, other_table):

        if not isinstance(other_table, DbtTable):
            raise ValueError("Can only merge with another DbtTable.")

        self.name = self.name or other_table.name
        self.description = self.description or other_table.description
        self.sql_query = self.sql_query or other_table.sql_query

        self.columns = self.columns or other_table.columns
        self.tests += [test for test in other_table.tests if test not in self.tests]
        self.referenced_models += [rm for rm in other_table.referenced_models if rm not in self.referenced_models]
        self.referenced_sources += [rs for rs in other_table.referenced_sources if rs not in self.referenced_sources]
        self.used_variables += [var for var in other_table.used_variables if var not in self.used_variables]
        self.used_macros += [macro for macro in other_table.used_macros if macro not in self.used_macros]

        self.meta = {**other_table.meta, **{k: v for k, v in self.meta.items() if v is not None}}
        self.config = {**other_table.config, **{k: v for k, v in self.config.items() if v is not None}}
        self.cocoon_tags = {**other_table.cocoon_tags, **{k: v for k, v in self.cocoon_tags.items()}}

class DbtMetric:
    def __init__(self, metric_data):
        self.name = metric_data.get('name')
        self.description = metric_data.get('description')
        self.model = metric_data.get('model')
        self.expression = metric_data.get('expression')

        self.additional_attributes = {key: value for key, value in metric_data.items() 
                                      if key not in ['name', 'description', 'model', 'expression']}

    def get_name(self):
        """Return the name of the metric."""
        return self.name

    def __repr__(self):
        return (f"DbtMetric '{self.name}' based on the model '{self.model}', "
                f"using the expression '{self.expression}'.")

class DbtSource:
    def __init__(self, source_data):
        self.name = source_data.get('name')
        self.description = source_data.get('description')
        self.tables = []

        for table_data in source_data.get('tables', []):
            table = DbtTable()
            table.add_yaml_info(table_data)
            table.add_source(self)
            self.tables.append(table)

    def get_name(self):
        """Return the name of the source."""
        return self.name

    def __repr__(self):
        return (f"DbtSource named '{self.name}' with "
                f"{len(self.tables)} associated tables: " +
                ", ".join(table.name for table in self.tables if table.name))

class DbtSchema:
    def __init__(self, file_path):
        self.file_path = file_path
        self.version = None
        self.tables = {}
        self.metrics = {}
        self.sources = {}

        self._parse_file()

    def _parse_file(self):
        with open(self.file_path, 'r') as file:
            data = yaml.safe_load(file)

        self.version = data.get('version')

        for table_data in data.get('models', []):
            table = DbtTable()
            table.add_yaml_info(table_data)
            self.tables[table.get_name()] = table

        for source_data in data.get('sources', []):
            source = DbtSource(source_data)
            self.sources[source.get_name()] = source
            for table_data in source_data.get('tables', []):
                table = DbtTable()
                table.add_yaml_info(table_data)
                table.add_source(source)
                self.tables[table.get_name()] = table

        for metric_data in data.get('metrics', []):
            metric = DbtMetric(metric_data)
            self.metrics[metric.get_name()] = metric

    def add_to_project(self, project):
        if not isinstance(project, DbtProject):
            raise ValueError("project must be an instance of DbtProject")

        for table in self.tables.values():
            project.add_table(table)

        for metric in self.metrics.values():
            if metric.get_name() in project.metrics:
                raise ValueError(f"Metric '{metric.get_name()}' already exists in the project.")
            project.add_metric(metric)

        for source in self.sources.values():
            if source.get_name() in project.sources:
                raise ValueError(f"Source '{source.get_name()}' already exists in the project.")
            project.add_source(source)

    def __repr__(self):
        return (f"DbtSchema at '{self.file_path}' with version {self.version}, "
                f"containing {len(self.tables)} tables, "
                f"{len(self.metrics)} metrics, and "
                f"{len(self.sources)} sources.")


class DbtProject:
    def __init__(self):
        self.tables = {}
        self.metrics = {}
        self.sources = {}

    def add_table(self, table):
        if table.name in self.tables:
            self.tables[table.name].merge_with(table)
        else:
            self.tables[table.name] = table

    def add_metric(self, metric):
        if metric.name in self.metrics:
            raise ValueError(f"A metric with the name '{metric.name}' already exists.")
        self.metrics[metric.name] = metric

    def add_source(self, source):
        if source.name in self.sources:
            raise ValueError(f"A source with the name '{source.name}' already exists.")
        self.sources[source.name] = source

    def __repr__(self):
        tables_repr = ', '.join(self.tables.keys())
        metrics_repr = ', '.join(self.metrics.keys())
        sources_repr = ', '.join(self.sources.keys())

        return (f"DbtProject:\n"
                f"  Tables: {tables_repr or 'None'}\n"
                f"  Metrics: {metrics_repr or 'None'}\n"
                f"  Sources: {sources_repr or 'None'}")

    def process_dbt_files(self, file_path):
        for root, dirs, files in os.walk(file_path):
            for file in files:
                
                full_path = os.path.join(root, file)


                if file.endswith('.yml') or file.endswith('.yaml'):
                    with open(full_path, 'r') as yml_file:
                        schema_data = yaml.safe_load(yml_file)
                        schema = DbtSchema(full_path)
                        schema.add_to_project(self)

                elif file.endswith('.sql'):
                    table = DbtTable()
                    table.add_sql_info(full_path)
                    self.add_table(table)

        nodes, edges = self.build_graph_from_project()
        self.nodes = nodes
        self.edges = edges

        tagged_names = []

        instance_names= []
        instances = []

        idx = 1

        for node in self.nodes:
            if node in self.tables:
                tagged_name = self.tables[node].get_tagged_name()
                tagged_names.append(str(idx) + ". " + tagged_name)
                instance_names.append(str(idx) + ". " + tagged_name)
                instances.append(self.tables[node])
                idx += 1
                
            else:
                tagged_name = node
                tagged_names.append(tagged_name)
  

        self.tagged_names = tagged_names
        self.instances = instances
        self.instance_names = instance_names

    def update_tagged_names(self):
        tagged_names = []

        idx = 1

        for node in self.nodes:
            if node in self.tables:
                tagged_name = self.tables[node].get_tagged_name()
                tagged_names.append(str(idx) + ". " + tagged_name)
                idx += 1
            else:
                tagged_name = node
                tagged_names.append(tagged_name)

        self.tagged_names = tagged_names
        
    def display_workflow(self):
        display_workflow(self.tagged_names, self.edges, height=400)
    
    def display(self, call_back=None):

        if call_back is None:
            call_back = self.display

        def create_widget(nodes, instances):
            
            dropdown = widgets.Dropdown(
                options=nodes,
                disabled=False,
            )

            button1 = widgets.Button(description="View")

            button3 = widgets.Button(description="Return")

            def on_button_clicked3(b):
                clear_output(wait=True)
                call_back()

            def on_button_clicked(b):




                idx = nodes.index(dropdown.value)

                selected_instance = instances[idx]
                html_content = selected_instance.to_html()
                html_widget.value = html_content

            button1.on_click(on_button_clicked)

            self.display_workflow()

            buttons = widgets.HBox([button1])

            html_widget = widgets.HTML(
                value="",
                placeholder='',
                description='',
            )

            display(dropdown, buttons, html_widget)


        create_widget(self.instance_names, self.instances)
        

    def build_graph_from_project(self):
        nodes_set = set()

        for table in self.tables.values():
            nodes_set.add(table.get_name())

            for source in table.get_source():
                nodes_set.add(source)

        nodes = list(nodes_set)

        edges = {}
        for idx, node in enumerate(nodes):
            table = self.tables.get(node)
            if table:


                for ref_source in table.get_source():
                    if ref_source in nodes_set:
                        ref_idx = nodes.index(ref_source)
                        if ref_idx not in edges:
                            edges[ref_idx] = []
                        edges[ref_idx].append(idx)
                    else:
                        raise ValueError(f"Source '{ref_source}' not found in the project.")

        return nodes, edges






def find_nodes_with_no_parents(nodes, edges):
    destination_indices = set()

    for destinations in edges.values():
        destination_indices.update(destinations)

    no_parent_nodes = [node for idx, node in enumerate(nodes) if idx not in destination_indices]

    return no_parent_nodes






class SQLStep(TransformationStep):
    def __init__(self, table_name, con, sql_code= "", *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.explanation = ""
        self.name = table_name
        self.sql_code = sql_code
        self.schema = None
        self.distinct_count = None
        self.con =con

    def generate_codes(self):
        pass

    def get_schema(self):
        if self.schema is None:
            schema = get_table_schema(self.con, self.name)
            self.schema = schema
        return self.schema

    def get_distinct_count(self):
        if self.distinct_count is None:
            distinct_count = {}
            schema = self.get_schema()
            for col in schema:
                distinct_count[col] = count_total_distinct(self.con, self.name, col)
            self.distinct_count = distinct_count
        return self.distinct_count

    def run_codes(self, mode="VIEW"):
        sql_code = self.get_codes(mode=mode)
        run_sql_return_df(self.con, sql_code)

    def display(self):
        print(self.name)

    def edit_widget(self, callbackfunc=None):
        self.display()
        print("\033[91mEdit Source File is under development!\033[0m")

        return_button = widgets.Button(description="Return")

        def on_return_clicked(b):
            clear_output(wait=True)
            callbackfunc(self)
        
        return_button.on_click(on_return_clicked)

        display(return_button)
    
    def get_codes(self, target_id=0, source_ids=[], mode=""):
        modes = ["", "TABLE", "VIEW", "AS"]

        if mode not in modes:
            raise("Mode not supported")

        if mode == "":
            return self.sql_code
        
        if mode == "TABLE":
            return f"CREATE TABLE OR REPLACE {self.name} AS\n{indent_paragraph(self.sql_code)}"

        if mode == "VIEW":
            return f"CREATE OR REPLACE VIEW {self.name} AS\n{indent_paragraph(self.sql_code)}"
        
        if mode == "AS":
            return f"{self.name} AS (\n{indent_paragraph(self.sql_code)}\n)"

class TransformationSQLPipeline(TransformationPipeline):

    def get_codes(self, mode="dbt"):
        sorted_step_idx = topological_sort(self.steps, self.edges)
        
        if mode == "dbt":
            
            with_clauses = []
            
            for step_idx  in sorted_step_idx[1:-1]:
                step = self.steps[step_idx]
                codes = step.get_codes(target_id=step_idx, mode="AS")
                with_clauses.append(cocoon_comment_start + codes + cocoon_comment_end)

            codes = ""
            if len(with_clauses) > 0:
                codes += "WITH \n" + ",\n\n".join(with_clauses) + "\n\n"

            codes += self.steps[sorted_step_idx[-1]].get_codes(target_id=sorted_step_idx[-1], mode="")

            return codes

        if mode == "TABLE":
            
            table_clauses = []
            
            for step_idx  in sorted_step_idx[1:]:
                step = self.steps[step_idx]
                codes = step.get_codes(target_id=step_idx, mode="TABLE")
                table_clauses.append(codes)
                
            return "\n\n".join(table_clauses)
            
            

    def __repr__(self):
        final_step = self.get_final_step()
        return final_step.name




def find_duplicate_rows(con, table_name, sample_size=0):
    sql_query = f"""
SELECT *, COUNT(*) as cocoon_count
FROM {table_name}
GROUP BY ALL
HAVING COUNT(*) > 1"""
    duplicate_count_sql = f"SELECT COUNT(*) from ({sql_query});"
    duplicate_count = run_sql_return_df(con, duplicate_count_sql).iloc[0, 0]

    sample_sql = sql_query
    if sample_size > 0:
        sample_sql += f" LIMIT {sample_size}"

    sample_duplicate_rows = run_sql_return_df(con,sample_sql)
    return duplicate_count, sample_duplicate_rows

def create_sample_distinct_query(table_name, column_name, sample_size=None):
    query =  f"SELECT {column_name} \nFROM {table_name} \nWHERE {column_name} IS NOT NULL \nGROUP BY {column_name} \nORDER BY COUNT(*) DESC,  {column_name}\n"
    if sample_size is not None:
        query += f" LIMIT {sample_size}"
    return query
    
def create_sample_distinct(con, table_name, column_name, sample_size):

    query = create_sample_distinct_query(table_name, column_name, sample_size)
    sample_values = run_sql_return_df(con,query)

    return sample_values

def count_total_distinct(con, table_name, column_name):
    total_distinct_count = run_sql_return_df(con,f"SELECT COUNT(DISTINCT {column_name}) FROM {table_name} WHERE {column_name} IS NOT NULL").iloc[0, 0]
    return total_distinct_count

def indent_paragraph(paragraph, spaces=4):
    indent = ' ' * spaces
    return '\n'.join(indent + line for line in paragraph.split('\n'))




 
class DataProject:
    def __init__(self):
        self.tables = {}

        self.links = {}

        self.story = []

    def add_links(self, join_infos):
        for join_info in join_infos:
            table1, table2 = join_info['tables'][:2]
            keys1, keys2 = join_info['join_keys'][:2]

            if table1 not in self.links:
                self.links[table1] = {}

            if table2 not in self.links:
                self.links[table2] = {}

            self.links[table1][table2] = [keys1, keys2]
            self.links[table2][table1] = [keys2, keys1]
    
    def get_story(self):
        return self.story

    def set_story(self, story):
        self.story = story

    def add_table(self, table_name, attributes):
        if table_name in self.tables:
            pass
        else:
            self.tables[table_name] = attributes

    def get_columns(self, table_name):
        if table_name in self.tables:
            return self.tables[table_name]
        else:
            return []

    def remove_table(self, table_name):
        if table_name in self.tables:
            del self.tables[table_name]

        else:
            pass
        
        if table_name in self.links:
            del self.links[table_name]

        for table_name_source in list(self.links.keys()):
            if table_name in self.links[table_name_source]:
                del self.links[table_name_source][table_name]

    def list_tables(self):
        return list(self.tables.keys())

    def describe_project(self):
        description = ""
        for idx, (table, attributes) in enumerate(self.tables.items()):
            if len(attributes) < 10:
                description += f"{idx+1}. {table}: {attributes}\n"
            else:
                description += f"{idx+1}. {table}: {attributes[:10] + ['...']}\n"
        return description

    def display_graph(self):
        tables = self.list_tables()

        graph_data = {}
        graph_data["nodes"] = [{"id": table} for table in tables]
        links = []

        source_target_pair = {}

        for table1 in self.links:
            for table2 in self.links[table1]:
                key = min(table1, table2)
                value = max(table1, table2)

                if key not in source_target_pair:
                    source_target_pair[key] = set()

                source_target_pair[key].add(value)

        for table1 in source_target_pair:
            for table2 in source_target_pair[table1]:
                links.append({"source": table1, "target": table2})

        graph_data["links"] = links

        display_draggable_graph_html(graph_data)






def display_duplicated_rows_html2(df):
    if 'cocoon_count' in df.columns:
        count_col = 'cocoon_count'
    elif 'COCOON_COUNT' in df.columns:
        count_col = 'COCOON_COUNT'
    else:
        raise ValueError("Expected column 'cocoon_count' or 'COCOON_COUNT' not found in DataFrame")

    html_output = f"<p>🤨 There are {len(df)} groups of duplicated rows.</p>"
    for i, row in df.iterrows():
        html_output += f"<p>Group {i+1} appear {row[count_col]} times:</p>"
        row_without_cocoon_count = row.drop(labels=[count_col])
        html_output += row_without_cocoon_count.to_frame().T.to_html(index=False)

    if len(df) > 5:
        html_output += "<p>...</p>"
    html_output += "<p>🧐 Do you want to remove the duplicated rows?</p>"
    
    display(HTML(html_output))

def create_explore_button(query_widget, table_name=None, query=""):
    if isinstance(table_name, list):
        dropdown = widgets.Dropdown(
            options=[(name, name) for name in table_name],
            disabled=False,
        )
        
        explore_button = widgets.Button(
            description='Explore',
            disabled=False,
            button_style='info',
            tooltip='Click to explore',
            icon='search'
        )
        
        def on_button_clicked(b):
            selected_table = dropdown.value
            if selected_table:
                query = f"SELECT * FROM {selected_table}"
                print(f"😎 Query submitted for {selected_table}. Check out the data widget!")
                query_widget.run_query(query)
            else:
                print("Please select a table from the dropdown.")
        
        explore_button.on_click(on_button_clicked)
        
        display(widgets.HBox([dropdown, explore_button]))
        return dropdown
        
    else:
        if table_name is not None:
            query = f"SELECT * FROM {table_name}"
        explore_button = widgets.Button(
            description='Explore',
            disabled=False,
            button_style='info',
            tooltip='Click to explore',
            icon='search'
        )

        def on_button_clicked(b):
            print("😎 Query submitted. Check out the data widget!")
            query_widget.run_query(query)

        explore_button.on_click(on_button_clicked)

        display(explore_button)
        


class DescribeColumns(Node):
    default_name = 'Describe Columns'
    default_description = 'This node allows users to describe the columns of a table.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Checking columns ...")
        
        create_progress_bar_with_numbers(1, doc_steps)
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        sample_size = 5
        
        table_summary = self.get_sibling_document("Create Table Summary")

        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")
        table_desc = sample_df.to_csv(index=False, quoting=2)
        
        return table_desc, table_summary, columns

    def run(self, extract_output, use_cache=True):
        table_desc, table_summary, column_names = extract_output

        template = f"""You have the following table:
{table_desc}

{table_summary}

Task: Describe the columns in the table.

Return in the following format:
```json
{{
    "{column_names[0]}": "Short description in < 10 words",
    ...
}}
```"""

        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        return json_code
    
    def run_but_fail(self, extract_output, use_cache=True):
        default_response = {column: column for column in extract_output[2]}
        return default_response
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        json_code = run_output
        
        self.progress.value += 1

        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        schema = table_pipeline.get_final_step().get_schema()

        rows_list = []

        for col in schema:
            rows_list.append({
                "Column": col,
                "Summary": json_code[col],
            })

        df = pd.DataFrame(rows_list)
        
        editable_columns = [False, True]
        grid = create_dataframe_grid(df, editable_columns, reset=True)
        print("😎 We have described the columns:")
        display(grid)

        next_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )  

        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            document = new_df.to_json(orient="split")
            callback(document)

        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
        
        
class DecideProjection(Node):
    default_name = 'Decide Projection'
    default_description = 'This allows users to select a subset of columns.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        create_progress_bar_with_numbers(0, doc_steps)

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        schema = get_table_schema(con, table_pipeline)

        print(f"🔍 Exploring table {BOLD}{table_pipeline}{END} ...")
        
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)

        num_cols = len(schema)

        print(f"🧐 Please select the columns to {UNDERLINE}{BOLD}include{END}{END}.")
        print(f"😊 Cocoon is currently not robust for >50 columns. Support for wide table is under development.")
        
        column_names = list(schema.keys())

        document = {"selected_columns": []}

        def callback_next(selected_indices):
            

            if len(selected_indices) == 0:
                print("🙁 Please keep at least one column.")
                return

            
            clear_output(wait=True)
            document["selected_columns"] = [column_names[i] for i in selected_indices]

            if len(selected_indices) < num_cols:
                new_table_name = f"{table_pipeline}_projected"
                selection_clause = ',\n'.join(document['selected_columns'])
                sql_query = f"SELECT \n{indent_paragraph(selection_clause)}\nFROM {table_pipeline}"
                sql_query = f"-- Projection: Selecting {len(document['selected_columns'])} out of {num_cols} columns\n" + sql_query
                step = SQLStep(table_name=new_table_name, sql_code=sql_query, con=con)
                step.run_codes()
                table_pipeline.add_step_to_final(step)
            callback(document)

        create_column_selector(column_names, callback_next, default=True)

        if self.viewer:
            callback_next(list(range(num_cols)))

class CreateColumnGrouping(Node):
    default_name = 'Create Column Grouping'
    default_description = 'This node allows users to group columns based on their meanings.'
    retry_times = 3

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Building column hierarchy ...")
        create_progress_bar_with_numbers(1, doc_steps)
        
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        sample_size = 5

        table_summary = self.get_sibling_document("Create Table Summary")
        schema = get_table_schema(con, table_pipeline)
        columns = list(schema.keys())

        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")
        self.sample_df = sample_df
        table_desc = sample_df.to_csv(index=False, quoting=2)

        schema = table_pipeline.get_final_step().get_schema()
        column_names = list(schema.keys())

        return table_desc, table_summary, column_names
    
    def run(self, extract_output, use_cache=True):
        table_desc, table_summary, column_names = extract_output

        template = f"""You have the following table:
{table_desc}

- Task: Recursively group the attributes based on inherent entity association, not conceptual similarity.
    E.g., for [student name, student grade, teacher grade], group by student and teacher, not by name.
Avoid groups with too many/few subgroups. 

Conclude with the final result as a multi-level JSON. 

```json
{{
    "reasoning": "There are {len(column_names)} columns. The groups shall be ...",
    "Main group": # group name shall not be attribute name
        {{
        "Sub group": {{ 
            "sub-sub group": ["attribute1", "attribute2", ...], # Make sure each attribute is included exactly one array
        }},
    }}
}}
```"""
        
            
                        
                        
                            

            


            




        
        messages =[ {"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        assistant_message = response['choices'][0]['message']
        messages.append(assistant_message)
        self.messages = messages
        
        json_code = extract_json_code_safe(assistant_message['content'])
        json_var = json.loads(json_code)
        json_var.pop("reasoning", None)
        
        
        def repair_json_attributes(json_var, reference_attributes):
            seen_attributes = set()
            reference_set = set(reference_attributes)
            other_attributes = []

            def traverse(element):
                if isinstance(element, dict):
                    for key, value in list(element.items()):
                        if isinstance(value, list):
                            new_list = []
                            for item in value:
                                if isinstance(item, str):
                                    if item not in seen_attributes and item in reference_set:
                                        new_list.append(item)
                                        seen_attributes.add(item)
                                else:
                                    traverse(item)
                            element[key] = new_list
                        else:
                            traverse(value)
                elif isinstance(element, list):
                    for i, item in enumerate(list(element)):
                        if isinstance(item, str):
                            if item not in seen_attributes and item in reference_set:
                                seen_attributes.add(item)
                            else:
                                element.pop(i)
                        else:
                            traverse(item)

            traverse(json_var)
            
            missing_attributes = reference_set - seen_attributes
            if missing_attributes:
                json_var['Other'] = list(missing_attributes)

            return json_var

        repaired_json = repair_json_attributes(json_var, column_names)

        
        return repaired_json
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        
        self.progress.value += 1
        
        json_code = run_output
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        
        table_name = f"{table_pipeline}"
        json_code_new = {}
        json_code_new[table_name] = json_code
        json_code = json_code_new
    
        html_content_updated, _, height = get_tree_html(json_code)

        print(f"😎 We have built the Column Hierarchy:")

        display_html_iframe(html_content_updated, height=f"{height+50}px")

        print("🧐 Next we will delve into the columns")

        edit_button = widgets.Button(
            description='Edit',
            disabled=False,
            button_style='danger', 
            tooltip='Click to edit',
            icon='edit'
        )

        def on_edit_clicked(b):
            print("Not implemented yet")

        edit_button.on_click(on_edit_clicked)

        def on_button_clicked(b):
            clear_output(wait=True)
            print("Submission received.")
            callback(json_code)

        submit_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )

        submit_button.on_click(on_button_clicked)

        display(HBox([edit_button, submit_button]))
        
        if self.viewer:
            on_button_clicked(submit_button)
        
    
class CreateTableSummary(Node):
    default_name = 'Create Table Summary'
    default_description = 'This node creates a summary of the table.'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item

        print("📝 Generating table summary ...")
        
        create_progress_bar_with_numbers(1, doc_steps)

        self.progress = show_progress(1)

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        sample_size = 5

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")
        table_desc = sample_df.to_csv(index=False, quoting=2)

        self.sample_df = sample_df

        return table_desc, columns
    
    def run(self, extract_output, use_cache=True):
        table_desc, table_columns = extract_output

        template = f"""You have the following table:
{table_desc}
        
- Task: Summarize the table.
-  Highlight: Include and highlight ALL attributes as **Attribute**. 
-  Structure: Start with the big picture, then explain how attributes are related
-  Requirement: ALL attributes must be mentioned and **highlighted**. The attribute name should be exactly the same (case sensitive and no extra space or _).
-  Style: Use a few short sentences with very simple words.

Example: The table is about ... at **Time**, in **Location**...
Now, your summary:
```"""

        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)

        summary = response['choices'][0]['message']['content']
        assistant_message = response['choices'][0]['message']
        messages.append(assistant_message)
        self.messages = messages




        def extract_words_in_asterisks(text):
            import re

            pattern = r'\*\*(.*?)\*\*'

            matches = re.findall(pattern, text)

            return matches

        def find_extra_columns(text_columns, table_columns):
            text_columns_set = set(text_columns)
            table_columns_set = set(table_columns)

            if text_columns_set.issuperset(table_columns_set):
                extra_columns = text_columns_set - table_columns_set
                return list(extra_columns)
            else:
                raise ValueError(f"text_columns is not a superset of table_columns. text_columns: {text_columns}, table_columns: {table_columns}")

        def update_summary(summary, extra_columns):
            for column in extra_columns:
                summary = summary.replace(f"**{column}**", column)

            return summary

        

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        summary = run_output 
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        self.progress.value += 1

        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)

        display(HTML(f"<b>Table Summary</b>:\n{replace_asterisks_with_tags(summary)}"))

        edit_button = widgets.Button(
            description='Edit',
            disabled=False,
            button_style='danger', 
            tooltip='Click to edit',
            icon='edit'
        )

        def on_edit_clicked(b):
            print("Not implemented yet")

        edit_button.on_click(on_edit_clicked)

        def on_button_clicked(b):
            clear_output(wait=True)
            print("Submission received.")
            callback(summary)

        submit_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )

        submit_button.on_click(on_button_clicked)

        display(HBox([edit_button, submit_button]))
        
        if self.viewer:
            on_button_clicked(submit_button)



class DecideDuplicate(Node):
    default_name = 'Decide Duplicate'
    default_description = 'This allows users to decide how to handle duplicated rows.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        print("🔍 Checking duplicated rows ...")
        
        create_progress_bar_with_numbers(0, doc_steps)
        self.progress = show_progress(1)

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]

        duplicate_count, sample_duplicate_rows = find_duplicate_rows(con, table_pipeline)

        document = {"duplicate_count": duplicate_count}
        
        self.progress.value += 1

        if duplicate_count > 0:
            display_duplicated_rows_html2(sample_duplicate_rows)

            def on_button_clicked(b):
                clear_output(wait=True)
                if b.description == 'Yes':
                    new_table_name = f"{self.para['table_pipeline']}_dedup"
                    
                    sql_query = f"""SELECT DISTINCT * FROM {table_pipeline}"""
                    sql_query = f"-- Deduplication: Removed {duplicate_count} duplicated rows\n" + sql_query
                    step = SQLStep(table_name=new_table_name, sql_code=sql_query, con=self.item["con"])
                    step.run_codes()
                    self.para["table_pipeline"].add_step_to_final(step)
                callback(document)

            yes_button = widgets.Button(
                description='Yes',
                disabled=False,
                button_style='success',
                tooltip='Click to submit Yes',
                icon='check'
            )

            no_button = widgets.Button(
                description='No',
                disabled=False,
                button_style='danger',
                tooltip='Click to submit No',
                icon='times'
            )

            yes_button.on_click(on_button_clicked)
            no_button.on_click(on_button_clicked)

            display(HBox([no_button, yes_button]))

            if self.viewer:
                on_button_clicked(no_button)


        else:
            callback(document)   




def get_missing_percentage(con, table_name, column_name):
    query = f"""
    SELECT COUNT(*) as total_count, COUNT({column_name}) as non_missing_count
    FROM {table_name}
    """
    
    result = run_sql_return_df(con, query)
    total_count = result.iloc[0, 0]
    non_missing_count = result.iloc[0, 1]
    
    return (total_count - non_missing_count) / total_count



class DecideRegex(Node):
    default_name = 'Decide Regex'
    default_description = 'This node allows users to decide the regex pattern for a string column.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Reading regex pattern ...")
        create_progress_bar_with_numbers(2, doc_steps)

        self.input_item = item

        idx = self.para["column_idx"]
        total = self.para["total_columns"]

        show_progress(max_value=total, value=idx)

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        column_name = self.para["column_name"]
        sample_size = 20

        sample_values = create_sample_distinct(con, table_pipeline, column_name, sample_size)

        return column_name, sample_values
    
    def run(self, extract_output, use_cache=True):
        column_name, sample_values = extract_output

        template = f"""{column_name}' has the following distinct values (sep by "):
{sample_values.to_csv(index=False, header=False, quoting=1)}

Task: Identify the *meaningful* regular expression pattern for the column.
E.g., Date string "1972/01/01" has regex of ^\d{{4}}\/\d{{2}}\/\d{{2}}$
Free text doesn't have meaningful regex. Just use .*
Some columns may have multiple patterns. Please analyze the semantic meaning of these values and provide the categories.

Return the result in yml
```yml
reasoning: |
    This column contains X types of values...

patterns: # shall be a short list, mostly jsut one
    -   name: |
            semantic meaning of these values (e.g., date, free text)
        regex: | 
            .* # don't use quotes
    - ...
```"""
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages

        yml_code = extract_yml_code(response['choices'][0]['message']["content"])
        summary = yaml.safe_load(yml_code)
        
        

        return summary

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)

class DecideRegexForAll(MultipleNode):
    default_name = 'Decide Regex For All'
    default_description = 'This node allows users to decide the regex pattern for all string columns.'

    def construct_node(self, element_name, idx=0, total=0):
        para = self.para.copy()
        para["column_name"] = element_name
        para["column_idx"] = idx
        para["total_columns"] = total
        node = DecideRegex(para=para, id_para ="column_name")
        node.inherit(self)
        return node

    def extract(self, item):
        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        self.elements = []
        self.nodes = {}
        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        distinct_count = table_pipeline.get_final_step().get_distinct_count()

        for col in columns:
            if schema[col] == 'VARCHAR' and distinct_count[col] > 50:
                self.elements.append(col)

        self.nodes = {col: self.construct_node(col, idx, len(self.elements)) for idx, col in enumerate(self.elements)}

    def display_after_finish_workflow(self, callback, document):
        callback(document)


class DecideUnusual(Node):
    default_name = 'Decide Unusual'
    default_description = 'This node allows users to decide how to handle unusual values.'

    def extract(self, input_item):
        clear_output(wait=True)

        print("🔍 Understanding unusual values ...")
        create_progress_bar_with_numbers(3, doc_steps)

        idx = self.para["column_idx"]
        total = self.para["total_columns"]
        show_progress(max_value=total, value=idx)

        self.input_item = input_item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        column_name = self.para["column_name"]
        sample_size = 20

        sample_values = run_sql_return_df(con, f"SELECT {column_name} FROM {table_pipeline} WHERE {column_name} IS NOT NULL GROUP BY {column_name} ORDER BY COUNT(*) DESC,  {column_name} LIMIT {sample_size}")
        
        return column_name, sample_values

    def run(self, extract_output, use_cache=True):
        column_name, sample_values = extract_output

        template = f"""{column_name} has the following distinct values:
{sample_values.to_csv(index=False, header=False, quoting=2)}

Review if there are any unusual values. Look out for:
1. Values too large/small that are inconsistent with the context.
E.g., age 999 or -5.
Outlier is fine as long as it falls in a reasonable range, e.g., person age 120 is fine.
2. Patterns that don't align with the nature of the data.
E.g., age 10.22
3. Special characters that don't fit within the real-world domain.
E.g., age X21b 

Now, respond in Json:
```json
{{
    "Reaonsing": "The valuses are ... They are unusual/acceptable ...",
    "Unusualness": true/false,
    "Explanation": "xxx values are unusual because ..." # if unusual, short in 10 words
}}
```"""
        
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        return json_code
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)


class DecideUnusualForAll(MultipleNode):
    default_name = 'Decide Unusual For All'
    default_description = 'This node allows users to decide how to handle unusual values for all columns.'

    def construct_node(self, element_name, idx=0, total=0):
        para = self.para.copy()
        para["column_name"] = element_name
        para["column_idx"] = idx
        para["total_columns"] = total
        node = DecideUnusual(para=para, id_para ="column_name")
        node.inherit(self)
        return node

    def extract(self, item):
        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = [col for col in schema if schema[col] in data_types['VARCHAR']]
        self.elements = []
        self.nodes = {}

        idx = 0
        for col in columns:
            self.elements.append(col)
            self.nodes[col] = self.construct_node(col, idx, len(columns))
            idx += 1

    def display_after_finish_workflow(self, callback, document):
        clear_output(wait=True)
        create_progress_bar_with_numbers(3, doc_steps)
        
        data = []
        if "Decide Unusual" in document:
            for key in document["Decide Unusual"]:
                if document["Decide Unusual"][key]["Unusualness"]:
                    data.append([key, document["Decide Unusual"][key]["Explanation"], True])
        

        
        df = pd.DataFrame(data, columns=["Column", "Explanation", "Endorse"])
        
        if len(df) == 0:
            callback(df.to_json(orient="split"))
            return
        
        editable_columns = [False, True, True]
        grid = create_dataframe_grid(df, editable_columns, reset=True)
        
        print("The following columns have unusual values: ❓")
        display(grid)
      
        next_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            document = new_df.to_json(orient="split")
            callback(document)
        
        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
        
class DecideLongitudeLatitude(Node):
    default_name = 'Decide Longitude Latitude'
    default_description = 'This node allows users to decide the longitude and latitude columns.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Deciding longitude and latitude columns ...")
        create_progress_bar_with_numbers(2, doc_steps)

        self.input_item = item

        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        
        sample_size = 5
        con = self.item["con"]
        all_columns = [col for col in schema if schema[col] in data_types['INT'] or schema[col] in data_types['DECIMAL']]
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")
        table_desc = sample_df.to_csv(index=False, quoting=2)
        
        return table_desc
    
    def run(self, extract_output, use_cache=True):
        table_desc = extract_output

        template = f"""You have the following table:
{table_desc}

Task: Identify the pairs of longitude/latitude attribute names (case sensitive), if any.
Respond in JSON format:
```json
[["longitude", "latitude"],...]
```"""

        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        return json_code
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        if not isinstance(run_output, list):
            run_output = []

        cleaned_output = [pair for pair in run_output if isinstance(pair, list) and len(pair) == 2]

        callback(cleaned_output)


class DecideColumnRange(Node):
    default_name = 'Decide Column Range'
    default_description = 'This node allows users to decide the range of numerical columns.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Deciding column range ...")
        create_progress_bar_with_numbers(2, doc_steps)

        self.input_item = item

        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        
        sample_size = 5
        con = self.item["con"]
        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")
        table_desc = sample_df.to_csv(index=False, quoting=2)
        database_name = get_database_name(con)
        
        numerical_columns = [col for col in schema if get_reverse_type(schema[col], database_name) in ['INT', 'DECIMAL']]
        
        min_max = {}
        for col in numerical_columns:
            min_max_tuple = run_sql_return_df(con, f"SELECT MIN({col}) as min, MAX({col}) as max FROM {table_pipeline}").iloc[0]
            min_max[col] = [min_max_tuple["min"], min_max_tuple["max"]]
        
        return table_desc, numerical_columns, min_max
    
    def run(self, extract_output, use_cache=True):
        table_desc, numerical_columns, min_max = extract_output
        
        if len(numerical_columns) == 0:
            return {}

        template = f"""You have the following table:
{table_desc}

The numerical columns in the table are: {numerical_columns}
Task: based on the understanding of the data, decide the normal range for numerical columns.
E.g., for a column "age", the normal range could be 0-150.
Skip the column if the range is unclear.

Now, return in the following format:
```json
{{
    "{numerical_columns[0]}": {{
        "explanation": "short in < 10 words",
        "min": 0,
        "max": 150
    }}, ...
}}
```"""

        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages

        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        
        return json_code
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        json_code = run_output
        _, _, min_max = extract_output

        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        schema = table_pipeline.get_final_step().get_schema()

        rows_list = []

        for col in schema:
            if col in json_code:
                rows_list.append({
                    "Column": col,
                    "True Range": min_max[col],
                    "Expected Range": [json_code[col]["min"],json_code[col]["max"]],
                    "Explanation": json_code[col]["explanation"],
                    "Within Range?": "❌ No" if json_code[col]["min"] > min_max[col][0] or json_code[col]["max"] < min_max[col][1] else "✔️ Yes",
                })

        df = pd.DataFrame(rows_list)
        
        if len(df) == 0:
            callback(df.to_json(orient="split"))
            return
        
        editable_columns = [False, False, False, True, False]
        grid = create_dataframe_grid(df, editable_columns, reset=True)
        print("😎 We have decided the column range:")
        display(grid)

        next_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )  

        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            document = new_df.to_json(orient="split")
            callback(document)

        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if viewer:
            on_button_clicked(next_button)

class DecideMissing(Node):
    default_name = 'Decide Missing Values'
    default_description = 'This node allows users to decide how to handle missing values.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Checking missing values ...")
        create_progress_bar_with_numbers(2, doc_steps)
        
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        table_name = table_pipeline.get_final_step().name

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        sample_size = 5

        missing_columns = {}

        for col in columns:
            missing_percentage = get_missing_percentage(con, table_name, col)
            if missing_percentage > 0:
                missing_columns[col] = missing_percentage

        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_name} LIMIT {sample_size}")
        sample_df_str = sample_df.to_csv(index=False, quoting=2)    

        return missing_columns, sample_df_str, table_name

    def run(self, extract_output, use_cache=True):
        
        missing_columns, sample_df_str, table_name = extract_output
        
        if len(missing_columns) == 0:
            return {"reasoning": "No missing values found.", "columns_obvious_not_applicable": {}}

        missing_desc = "\n".join([f'{idx+1}. {col}: {missing_columns[col]}' for idx, (col, desc) in enumerate(missing_columns.items())])

        template = f"""You have the following table:
{sample_df_str}

The following columns have percentage of missing values:
{missing_desc}

For each column, decide whether there is an obvious reason for the missing values to be "not applicable"
E.g., if the column is 'Date of Death', it is "not applicable" for patients still alive.
Reasons like not not collected, sensitive info, encryted, data corruption, etc. are not considered 'not applicable'.

Return in the following format:
```json
{{
    "reasoning": "X column has an obvious not applicable reason... The rest don't.",
    "columns_obvious_not_applicable": {{
        "column_name": "Short specific reason why not applicable, in < 10 words.",
        ...
    }}
}}
"""
            
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        if not isinstance(json_code, dict) or "reasoning" not in json_code or "columns_obvious_not_applicable" not in json_code:
            raise ValueError("The returned JSON code does not adhere to the required format.")
        
        for col_name in json_code["columns_obvious_not_applicable"]:
            if col_name not in missing_columns:
                raise ValueError(f"The column '{col_name}' specified in 'columns_obvious_not_applicable' is not present in the missing columns.")
            
        return json_code
    
    def run_but_fail(self, extract_output, use_cache=True):
        missing_columns, sample_df_str, table_name = extract_output
        
        if len(missing_columns) == 0:
            return {"reasoning": "No missing values found. ", "columns_obvious_not_applicable": {}}
        else:
            return {
                "reasoning": "Failed to analyze the data due to an error.",
                "columns_obvious_not_applicable": {}
            }

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        
        self.progress.value += 1
        json_code = run_output
        missing_columns, sample_df_str, table_name = extract_output
        
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))
        
        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)

        rows_list = []
        for col in missing_columns:
            missing_percentage = missing_columns[col]
            reason = json_code["columns_obvious_not_applicable"].get(col, "")
            rows_list.append({
                "Column": col,
                "NULL (%)": f"{missing_percentage*100:.2f}",
                "Is NULL Acceptable?": True if reason != "" else False,
                "Explanation": reason
            })
            
        df = pd.DataFrame(rows_list)
        
        if len(rows_list) == 0:
            df = pd.DataFrame(columns=["Column", "NULL (%)", "Is NULL Acceptable?", "Explanation"])
        else:
            df = pd.DataFrame(rows_list)

        if len(df) == 0:
            callback(df.to_json(orient="split"))
            return
        
        editable_columns = [False, False, True, True]
        grid = create_dataframe_grid(df, editable_columns, reset=True)
        
        print("😎 We have identified missing values, and potential causes:")
        display(grid)
        
        next_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            document = new_df.to_json(orient="split")

            callback(document)
        
        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
            
class DecideDMV(Node):
    default_name = 'Decide Disguised Missing Values'
    default_description = 'This node allows users to decide how to handle disguised missing values.'

    def extract(self, input_item):
        clear_output(wait=True)

        print("🔍 Understanding disguised missing values ...")
        create_progress_bar_with_numbers(3, doc_steps)

        idx = self.para["column_idx"]
        total = self.para["total_columns"]
        show_progress(max_value=total, value=idx)

        self.input_item = input_item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        column_name = self.para["column_name"]
        sample_size = 20

        sample_values = run_sql_return_df(con, f"SELECT {column_name} FROM {table_pipeline} WHERE {column_name} IS NOT NULL GROUP BY {column_name} ORDER BY COUNT(*) DESC,  {column_name} LIMIT {sample_size}")
        
        return column_name, sample_values

    def run(self, extract_output, use_cache=True):
        column_name, sample_values = extract_output

        template = f"""{column_name} has the following distinct values:
{sample_values.to_csv(index=False, header=False, quoting=2)}

From these values, detect disguised missing values: values that are not null but should be considered as missing.

Return in json format:
```json
{{
    "reasoning": "xxx values are disguised missing values because ...",
    "DMV": ["N/A", "-1", ...], (empty if no disguised missing values)
    "explanation": "if has DMV, short explanation in <10 words"
}}
```"""

        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)
        
        
        
        return json_code
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)

class DecideDMVforAll(MultipleNode):
    default_name = 'Decide Disguised Missing Values For All'
    default_description = 'This node allows users to decide how to handle disguised missing values for all columns.'
    
    def construct_node(self, element_name, idx=0, total=0):
        para = self.para.copy()
        para["column_name"] = element_name
        para["column_idx"] = idx
        para["total_columns"] = total
        node = DecideDMV(para=para, id_para ="column_name")
        node.inherit(self)
        return node
    
    def extract(self, item):
        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        self.elements = []
        self.nodes = {}
        
        idx = 0
        for col in columns:
            self.elements.append(col)
            self.nodes[col] = self.construct_node(col, idx, len(columns))
            idx += 1
            
    def display_after_finish_workflow(self, callback, document):
        clear_output(wait=True)
        
        data = []
        if "Decide Disguised Missing Values" in document:
            for key in document["Decide Disguised Missing Values"]:
                if document["Decide Disguised Missing Values"][key]["DMV"]:
                    data.append([key, document["Decide Disguised Missing Values"][key]["DMV"], 
                                document["Decide Disguised Missing Values"][key]["explanation"], 
                                True,])
                    
                    
        if not data:
            callback(document)
            return
        
        
        if not data:
            callback(document)
            return
        
        df = pd.DataFrame(data, columns=["Column", "Disguised Missing Values", "Explanation", "Endorse"])
        
        if len(df) == 0:
            callback(df.to_json(orient="split"))
            return
        
        editable_columns = [False, True, True, True]
        grid = create_dataframe_grid(df, editable_columns, reset=True, lists=["Disguised Missing Values"])
        
        print("😎 We have identified disguised missing values:")
        display(grid)
        
        next_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid, lists=["Disguised Missing Values"])
            document = new_df.to_json(orient="split")

            callback(document)
        
        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)

def check_column_uniqueness(con, table_name, column_name, allow_null=False):
    if not allow_null:
        query = f"""
        SELECT COUNT(DISTINCT {column_name}) AS DISTINCT_COUNT,
               COUNT(*) AS TOTAL_COUNT
        FROM {table_name}
        """
    else:
        query = f"""
        SELECT COUNT(DISTINCT {column_name}) AS DISTINCT_COUNT,
               COUNT({column_name}) AS NON_NULL_COUNT
        FROM {table_name}
        """

    result = run_sql_return_df(con, query)
    distinct_count = result.iloc[0]['DISTINCT_COUNT']
    
    total_count = result.iloc[0]['TOTAL_COUNT'] if not allow_null else result.iloc[0]['NON_NULL_COUNT']

    return distinct_count == total_count


class DecideUnique(Node):
    default_name = 'Decide Unique Columns'
    default_description = 'This node allows users to decide which columns should be unique.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Checking uniqueness ...")
        create_progress_bar_with_numbers(2, doc_steps)
        
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        table_name = table_pipeline.get_final_step().name

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        sample_size = 5

        unique_columns = {}

        for col in columns:
            unique_columns[col] = check_column_uniqueness(con, table_name, col, allow_null=True)

        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_name} LIMIT {sample_size}")
        sample_df_str = sample_df.to_csv(index=False, quoting=2)    

        return unique_columns, sample_df_str, table_name

    def run(self, extract_output, use_cache=True):
        
        unique_columns, sample_df_str, table_name = extract_output

        unique_desc = "\n".join([f'{idx+1}. {col}: {unique_columns[col]}' for idx, (col, desc) in enumerate(unique_columns.items())])

        template = f"""You have the following table:
{sample_df_str}

Identify the single column can be the candidate key.
E.g., for a table of customer data, 'Customer ID' can be the candidate key as it uniquely identify rows. But 'First Name' may not.

Return in the following format:
```json
{{
    "reasoning": "The table is about ... Each row is about ... X column can be candidate key/ There is no single column that can be candidate key.",
    "candidate_key": {{ # dictionary of columns, each is candidate key. Leave empty if no single column that can be candidate key
        "column_name": "Short specific reason it uniquely identifies rows, in < 10 words.",
        ...
    }}
}}
"""
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        return json_code
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        
        json_code = run_output
        unique_columns, _, _ = extract_output
        
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))
        
        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        
        
        rows_list = []
        for col in unique_columns:
            is_unique = unique_columns[col]
            reason = json_code["candidate_key"].get(col, "")
            rows_list.append({
                "Column": col,
                "Is Unique": is_unique,
                "Should be Unique?": True if reason != "" else False,
                "Explanation": reason
            })
        
        df = pd.DataFrame(rows_list)
        df = df[df["Is Unique"] | df["Should be Unique?"]]
        
        editable_columns = [False, False, True, True]
        grid = create_dataframe_grid(df, editable_columns, reset=True)
        
        print("😎 We have identified columns that should be unique:")
        display(grid)
        
        next_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            document = new_df.to_json(orient="split")

            callback(document)
        
        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)



def create_profile_workflow(table_name, con, viewer=True):
        
    query_widget = QueryWidget(con)

    item = {
        "con": con,
        "query_widget": query_widget
    }

    sql_step = SQLStep(table_name=table_name, con=con)
    pipeline = TransformationSQLPipeline(steps = [sql_step], edges=[])

    para = {"table_pipeline": pipeline}

    main_workflow = Workflow("Data Profiling Workflow", 
                            item = item, 
                            description="A workflow to profile dataset",
                            viewer=viewer,
                            para = para)

    main_workflow.add_to_leaf(DecideProjection())
    main_workflow.add_to_leaf(DecideDuplicate())
    main_workflow.add_to_leaf(CreateTableSummary())
    main_workflow.add_to_leaf(DescribeColumns())
    main_workflow.add_to_leaf(CreateColumnGrouping())
    main_workflow.add_to_leaf(DecideDataType())
    main_workflow.add_to_leaf(DecideMissing())
    main_workflow.add_to_leaf(DecideUnique())
    main_workflow.add_to_leaf(DecideUnusualForAll())
    main_workflow.add_to_leaf(DecideColumnRange())
    main_workflow.add_to_leaf(DecideLongitudeLatitude())
    main_workflow.add_to_leaf(GenerateReport())
    
    return query_widget, main_workflow




def truncate_text_vectorized(df, max_length=100, col_max_length=10):
    def truncate_series(series):
        mask = series.str.len() > max_length
        truncated = series[mask].str.slice(0, max_length//2) + '...' + series[mask].str.slice(-max_length//2)
        series[mask] = truncated
        return series

    for column in df.select_dtypes(include=[object]).columns:
        df[column] = truncate_series(df[column])

    new_columns = []
    for column in df.columns:
        if len(column) > col_max_length:
            half_len = col_max_length // 2
            new_column = column[:half_len] + '_' + column[-half_len:]
        else:
            new_column = column
        new_columns.append(new_column)
    df.columns = new_columns
    
    return df



def create_select_html_from_list(list_of_values):
    options = ''.join(f"<option value='{item}'>{item}</option>" for item in list_of_values)
    dropdown_html = f"<select>{options}</select>"
    return dropdown_html

def replace_df_html_col_with_dropdown(df, df_html, col_name):
    soup = BeautifulSoup(df_html, 'html.parser')

    for idx, row in df.iterrows():
        dropdown_html = create_select_html_from_list(row[col_name])
        soup.find_all('td')[idx*len(df.columns) + df.columns.get_loc(col_name)].string.replace_with(BeautifulSoup(dropdown_html, 'html.parser'))

    modified_html = str(soup)
    return modified_html





def build_histogram_inputs(con, column, tablename):
    num_bins = 20
    query_min_max = f'SELECT MIN({column}) AS min_val, MAX({column}) AS max_val FROM {tablename};'
    min_val, max_val = run_sql_return_df(con, query_min_max).iloc[0]
    
    if min_val == max_val:
        total_count_query = f'SELECT COUNT(*) FROM {tablename};'
        total_count = run_sql_return_df(con, total_count_query).iloc[0][0]
        return [total_count], min_val, [min_val]
    
    bin_width = (max_val - min_val) / num_bins
    bin_edges = np.linspace(min_val, max_val, num_bins + 1)
    
    bin_centers = []
    counts = []
    bin_width = bin_edges[1] - bin_edges[0]

    for i in range(num_bins):
        bin_start = bin_edges[i]
        bin_end = bin_edges[i + 1]
        if i == num_bins - 1:
            query = f'SELECT COUNT(*) FROM {tablename} WHERE {column} >= {bin_start} AND {column} <= {bin_end}'
        else:
            query = f'SELECT COUNT(*) FROM {tablename} WHERE {column} >= {bin_start} AND {column} < {bin_end}'
        count = run_sql_return_df(con, query).iloc[0][0]
        bin_center = (bin_start + bin_end) / 2

        bin_centers.append(bin_center)
        counts.append(count)
    return counts, bin_width, bin_centers


def df_to_list(df):
    return [tuple(row) for row in df.itertuples(index=False, name=None)]

def build_barchat_input(con, column, tablename):
    count_query = f'SELECT COUNT(DISTINCT {column}) AS distinct_count FROM {tablename} WHERE {column} IS NOT NULL'
    distinct_count_result = run_sql_return_df(con, count_query).iloc[0][0]

    if distinct_count_result > 6:
        fetch_query = f'''
        WITH CityCounts AS (
            SELECT CAST({column} AS VARCHAR) AS {column}, COUNT(*) AS count
            FROM {tablename}
            WHERE {column} IS NOT NULL
            GROUP BY {column}
            ORDER BY count DESC
        ),
        TopCities AS (
            SELECT {column}, count
            FROM CityCounts
            LIMIT 5
        ),
        OtherGroup AS (
            SELECT 'Other values' AS {column}, SUM(count) AS count
            FROM CityCounts
            WHERE {column} NOT IN (SELECT {column} FROM TopCities) AND {column} IS NOT NULL
        )
        SELECT {column}, count FROM TopCities
        UNION ALL
        SELECT * FROM OtherGroup
        '''
    else:
        fetch_query = f'''
        SELECT {column}, COUNT(*) AS count
        FROM {tablename}
        WHERE {column} IS NOT NULL
        GROUP BY {column}
        ORDER BY count DESC
        '''

    result = df_to_list(run_sql_return_df(con, fetch_query))
    result_dict = {row[0]: row[1] for row in result}
    return result_dict

def filter_attributes(attributes, groups):
    retained_groups = []
    
    for group in groups:
        if all(item in attributes for item in group):
            retained_groups.append(group)
    
    all_retained = set([item for sublist in retained_groups for item in sublist])
    
    filtered_attributes = [attr for attr in attributes if attr not in all_retained]
    
    return filtered_attributes, retained_groups




def build_map_inputs(con, column, column2, tablename):
    result = run_sql_return_df(con, f'SELECT {column}, {column2} FROM {tablename} WHERE {column} IS NOT NULL AND {column2} IS NOT NULL LIMIT 100')
    result = np.array(result)
    return result.tolist()



            
            
class GenerateReport(Node):
    default_name = 'Generate Report'
    default_description = 'This node generates a report based on the profiling results.'

    def extract(self, item):
        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        df = run_sql_return_df(con, f"SELECT * FROM {table_pipeline} LIMIT  100")
        table_name = table_pipeline

        def replace_pattern(text):
            return re.sub(r'\*\*(.*?)\*\*', r'<u>\1</u>', text)

        table_summary = self.get_sibling_document('Create Table Summary')
        table_summary = replace_pattern(table_summary)
        table_summary

        group_json = self.get_sibling_document('Create Column Grouping')
        javascript_content, _, _ = get_tree_javascript(group_json)

        column_df = pd.read_json(self.get_sibling_document('Describe Columns'), orient="split")

        error_html = ""
        duplication_count = self.get_sibling_document('Decide Duplicate')['duplicate_count']

        if duplication_count > 0:
            error_html += f"<h2>Duplicate Rows</h2> There are <b>{duplication_count}</b> duplicated rows in the dataset.<br><br>"

        data_type_df = pd.read_json(self.get_sibling_document('Decide Data Type'), orient="split")
        error_html += f"<h2>Data Type</h2> {data_type_df.to_html()} <br>"

       


        missing_df = pd.read_json(self.get_sibling_document('Decide Missing Values'), orient="split")
        if len(missing_df) > 0:
            missing_df = missing_df.replace({"Is NULL Acceptable?": {True: "✔️ Yes", False: "❌ No"}})
            error_html += f"<h2>Missing Value</h2> {missing_df.to_html()} <br>"

        unique_df = pd.read_json(self.get_sibling_document('Decide Unique Columns'), orient="split")
        error_html += f"<h2>Column Uniqueness</h2> {unique_df.to_html()} <br>"

        numerical_df = pd.read_json(self.get_sibling_document('Decide Column Range'), orient="split")
        if len(numerical_df) > 0:
            error_html += f"<h2>Column Range</h2> {numerical_df.to_html()} <br>"
            
        unusual_text_df = pd.read_json(self.get_sibling_document('Decide Unusual For All'), orient="split")
        if len(unusual_text_df) > 0:
            unusual_text_df = unusual_text_df[unusual_text_df['Endorse']]
            unusual_text_df = unusual_text_df.drop(columns=['Endorse'])
        if len(unusual_text_df) > 0:
            error_html += f"<h2>Unusual Values</h2> {unusual_text_df.to_html()} <br>"
            
        lon_lat_groups = self.get_sibling_document('Decide Longitude Latitude')

        def build_column_details(column_name):
            html_content = ""
            errors = 0
            column_desc = column_df[column_df["Column"] == column_name]["Summary"].iloc[0]
            html_content += f'<b>{column_name}</b> {column_desc}<br>'
            
            current_datatype = data_type_df[data_type_df["Column"] == column_name]["Current Type"].iloc[0]
            target_datatype = data_type_df[data_type_df["Column"] == column_name]["Target Type"].iloc[0]
            
            if current_datatype != target_datatype:
                errors += 1
                html_content += f'<span class="circle">!</span> <b>{column_name} Data Type:</b>{current_datatype}. However, should be {target_datatype}<br>'
            else:
                html_content += f'<span class="circle2">✓</span> <b>{column_name} Data Type:</b> {current_datatype}<br>'
                
                
                    
                
            if len(missing_df) > 0 and column_name in missing_df["Column"].values:
                missing = missing_df[missing_df["Column"] == column_name]["NULL (%)"].iloc[0]
                
                if missing_df[missing_df["Column"] == column_name]["Is NULL Acceptable?"].iloc[0] == "✔️ Yes":
                    explanation = missing_df[missing_df["Column"] == column_name]["Explanation"].iloc[0]
                    html_content += f'<span class="circle2">✓</span> <b>{column_name} has {missing}% Missing Values</b>: {explanation}<br>'
                else:
                    errors += 1
                    html_content += f'<span class="circle">!</span> <b>{column_name} has {missing}% Missing Values</b><br>'
                    
            if len(unique_df) > 0 and column_name in unique_df["Column"].values:
                is_unique = unique_df[unique_df["Column"] == column_name]["Is Unique"].iloc[0]
                should_unique = unique_df[unique_df["Column"] == column_name]["Should be Unique?"].iloc[0]
                explanation = unique_df[unique_df["Column"] == column_name]["Explanation"].iloc[0]
                
                if is_unique and should_unique:
                    html_content += f'<span class="circle2">✓</span> <b>{column_name} is Unique</b><br>'
                elif not is_unique and should_unique:
                    errors += 1
                    html_content += f'<span class="circle">!</span> <b>{column_name} is not Unique</b> However, it should be unique: {explanation}<br>'
                
            if len(numerical_df) > 0 and column_name in numerical_df["Column"].values:
                within_range = numerical_df[numerical_df["Column"] == column_name]["Within Range?"].iloc[0]
                
                if within_range == "❌ No":
                    errors += 1
                    expected_range = numerical_df[numerical_df["Column"] == column_name]["Expected Range"].iloc[0]
                    true_range = numerical_df[numerical_df["Column"] == column_name]["True Range"].iloc[0]
                    explanation = numerical_df[numerical_df["Column"] == column_name]["Explanation"].iloc[0]
                    html_content += f'<span class="circle">!</span> <b>{column_name} has unexpected range:</b> It\'s expected be in: {expected_range}, because: {explanation}. However, its true range is: {true_range}<br>'
            
            if len(unusual_text_df) > 0 and column_name in unusual_text_df["Column"].values:
                explanation = unusual_text_df[unusual_text_df["Column"] == column_name]["Explanation"].iloc[0]
                errors += 1
                html_content += f'<span class="circle">!</span> <b>{column_name} is errorenous:</b> {explanation}<br>'
            
            return html_content, errors


        def build_column_group_html(d):
            html_output = ""
            javascript_output = ""
            total_errors = 0

            for key, value in d.items():
                column_html, column_javascript, errors = build_column_html(key, value)
                html_output += column_html
                javascript_output += column_javascript
                total_errors += errors

            return html_output, javascript_output, total_errors

        def build_column_html(column_name, value):

            html_output = ""
            javascript_output = ""
            
            errors = 0
            if isinstance(value, dict):
                child_html, child_javascript, child_errors = build_column_group_html(value)
                html_output += f'<div class="indent">\n{child_html}</div>\n'
                javascript_output += child_javascript
                errors += child_errors
            elif isinstance(value, list):
                html_output += '<div class="indent">\n'
                filtered_attributes, retained_groups = filter_attributes(value, lon_lat_groups)
                
                for item in retained_groups:
                    item_html, item_javascript, item_errors = handle_lon_lat(item)
                    html_output += item_html
                    javascript_output += item_javascript
                    errors += item_errors
                    
                for item in filtered_attributes:
                    item_html, item_javascript, item_errors = handle_list_item(item)
                    html_output += item_html
                    javascript_output += item_javascript
                    errors += item_errors
                
                html_output += '</div>\n'
                    
            final_html_output = f"""<div class="card-item">
            <span class="field-name">Group: {column_name}</span>
            <div class="card-controls">
                {'<span class="circle">' + str(errors) + '</span>' if errors > 0 else ""}
                <span class="toggle">▼</span>
            </div>
            </div>""" + html_output 
            
            return final_html_output, javascript_output, errors

        def handle_lon_lat(lon_lat_group):
            
            viz_html, viz_javascript = build_map_viz(lon_lat_group[0], lon_lat_group[1])
            detail_html1, errors1 = build_column_details(lon_lat_group[0])
            detail_html2, errors2 = build_column_details(lon_lat_group[1])
            errors = errors1+errors2
            
            html_output = "<div class=\"indent\">"
            html_output += viz_html
            html_output += detail_html1
            html_output += detail_html2
            html_output += "</div>"
            
            final_html_output = f"""<div class="card-item">
            <span class="field-name">Columns: {lon_lat_group[0], lon_lat_group[1]}</span>
            <div class="card-controls">
                {'<span class="circle">' + str(errors) + '</span>' if errors > 0 else ""}
                <span class="toggle">▼</span>
            </div>
            </div>""" + html_output 

            javascript_output = ""
            javascript_output += viz_javascript
            
            return final_html_output, javascript_output, errors

        def build_map_viz(lon_column, lat_column):
            html_output = ""
            javascript_output = ""
            
            html_output += f"<div id=\"map_viz_{lon_column}_{lat_column}\"></div>"
            data = build_map_inputs(con, lon_column, lat_column, table_pipeline)
            javascript_output += f"""data = {data};
            drawMap("map_viz_{lon_column}_{lat_column}", data);
        """
            
            return html_output, javascript_output

        def build_column_viz(column_name):
            html_output = ""
            javascript_output = ""
            data_type = schema[column_name]
            if data_type in data_types["INT"] or data_type in data_types["DECIMAL"]:
                html_output += f"<div id=\"hist_viz_{column_name}\"></div>"
                counts, bin_width, bin_centers = build_histogram_inputs(con, column_name, table_pipeline)
                javascript_output += f"""data = {[
                {"x": center, "y": count} for center, count in zip(bin_centers, counts)
            ]};
            binWidth = {bin_width};
            drawHistogram("hist_viz_{column_name}", data, binWidth);
        """
            
            else:
                html_output += f"<div id=\"bar_viz_{column_name}\"></div>"
                data_dict = build_barchat_input(con, column_name, table_pipeline)
                total_value = sum(data_dict.values())
                data = [{"label": (str(label)[:15] + "...") if len(str(label)) > 15 else str(label), "value": (value / total_value) * 100} for label, value in data_dict.items()]
                javascript_output += f"""data = {data};
            drawBarChart("bar_viz_{column_name}", data);
        """  
            
            return html_output, javascript_output
                

        def handle_list_item(column_name):

            
            viz_html, viz_javascript = build_column_viz(column_name)
            
            detail_html, errors = build_column_details(column_name)

            html_output = "<div class=\"indent\">"
            html_output += viz_html
            html_output += detail_html
            html_output += "</div>"
            
            final_html_output = f"""<div class="card-item">
            <span class="field-name">Column: {column_name}</span>
            <div class="card-controls">
                {'<span class="circle">' + str(errors) + '</span>' if errors > 0 else ""}
                <span class="toggle">▼</span>
            </div>
            </div>""" + html_output 

            javascript_output = ""
            javascript_output += viz_javascript
            
            return final_html_output, javascript_output, errors


        column_html, column_javascript, total_errors = build_column_group_html(group_json)


        html_content = f"""<!DOCTYPE html>
<html lang="en">
<head>
<title>Cocoon</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>

html {{
    height: 100%; /* Ensure the html element covers the full height */
    background-color: #f0f0f0; /* Set your desired background color */
}}

body {{
    /* Scale the entire content to 70% */
    transform: scale(0.75);
    transform-origin: top left; /* Adjust as needed */
    width: 133.33%; /* Increase width to fit, since scaling down shrinks the viewport */
    height: 133.33%; /* Adjust height similarly if necessary */
    overflow: auto; /* Add scrollbars if content overflows */
}}

  body, h1, h2, p {{
    margin: 0;
    padding: 0;
    font-family: 'Arial', sans-serif;
  }}

  .container {{
      display: flex;
      justify-content: space-between;
      align-items: center; /* This ensures the items are aligned in the middle vertically */
  }}

  .map-container {{
    width: 300px;
    height: 200px;
    border: 1px solid black;
  }}
  
  .histogram-container {{
    width: 300px;
    height: 100px;
    border: 1px solid black;
  }}

  .chart-container {{ /* Style for the container */
      width: 200px;
      height: 80px;
      border: 1px solid black;
  }}
  
  .bar-chart-container {{
    width: 300px;
    height: 100px;
    border: 1px solid black;
  }}

  .dashboard {{
    display: grid;
    grid-template-areas:
      "main-panel right-panel"
      "bottom-panel right-panel";
    grid-template-rows: 1fr 1fr; /* Equal height for both rows */
    gap: 10px;
    height: 130vh;
    padding: 10px;
    background-color: #f0f0f0;
  }}

  .main-panel {{
      grid-area: main-panel;
      background-color: #ffffff;
      padding: 20px;
      position: relative; /* Set the main-panel to relative to position the chat box inside it */
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      overflow: hidden;
      display: flex;
      flex-direction: column; /* Stack the children vertically */
  }}

  .table-container {{
      overflow-x: auto; /* Allows horizontal scrolling for the table */
      overflow-y: auto; /* Allows vertical scrolling for the table */
      flex-grow: 1;
      max-width: 100%; /* Ensures that the container doesn't exceed the width of its parent */
  }}

  .right-panel {{
    grid-area: right-panel;
    background-color: #fff;
    padding: 15px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    overflow-y: auto; /* Enable scrolling for the panel */
    width: 360px;
  }}

  .indent {{
      padding-left: 5px; /* Increase as needed for deeper indents */
      font-size: small;
      display: none;
  }}

  .card-item {{
    display: flex;
    align-items: center;
    background-color: #626262; /* White background for the card */
    border: 1px solid #626262; /* Light grey border */
    color: white;
    border-radius: 4px; /* Slightly rounded corners */
    margin-bottom: 6px; /* Space between card items */
    padding: 3px;
    padding-left: 10px;
    width: 320px;
  }}

  .card-item-collapsed {{
      background-color: #d0d0d0; /* Lighter background for collapsed card */
      border: 1px solid #d0d0d0; /* Lighter border for collapsed card */
      color: black; /* Change text color for better contrast on light background */
  }}

  .icon {{
    /* Styles for the icon, you can replace it with an actual icon font or image */
    padding-right: 20px;
  }}

  .field-name {{
    /* Styles for the field name */
    flex-grow: 1;
    padding-right: 20px;
    font-size: 14px;

  }}

  .circle {{
      background-color: red;
      font-size: small;
      border-radius: 50%;
      color: white;
      padding: 0px;
      text-align: center;
      display: inline-block;
        width: 16px;         /* Fixed width */
        height: 16px;        /* Fixed height */
        line-height: 16px;   /* Center the number vertically */
  }}

  .circle2 {{
      background-color: green;
      font-size: small;
      border-radius: 50%;
      color: white;
      padding: 0px;
      text-align: center;
      display: inline-block;
      /* Changes for a better circle */
        width: 16px;         /* Fixed width */
        height: 16px;        /* Fixed height */
        line-height: 16px;   /* Center the number vertically */
  }}

  .card-controls {{
    display: flex;
  }}

  .drop-down-btn,
  .add-btn {{
    /* Shared styles for buttons */
    background-color: #4CAF50; /* Green background */
    color: white;
    border: none;
    border-radius: 2px; /* Slightly rounded corners for the buttons */
    cursor: pointer;
    padding: 2px 6px; /* Smaller padding for a compact look */
    margin-left: 4px; /* Spacing between buttons */
  }}

  .drop-down-btn:hover,
  .add-btn:hover {{
    background-color: #45a049; /* Darker green on hover */
  }}


  .bottom-panel {{
    grid-area: bottom-panel;
    background-color: #ffffff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    overflow-x: auto;
  }}

  table {{
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    font-size: 0.9em;
    border-radius: 8px;
    overflow: hidden;

  }}

  th, td {{
    padding: 6px 8px;
    text-align: left;
    border-bottom: 1px solid #dddddd;
    border-right: 1px solid #dddddd;
  }}


  th:last-child, td:last-child {{
    border-right: none; /* Removes the border from the last cell of each row */
  }}

  thead tr {{
    background-color: #009879; /* Changed color for header */
    color: #ffffff; /* Changed text color for better contrast */
    text-align: left;
    font-weight: bold;
    font-size: 14px;
  }}

  th {{
    top: 0;
    background-color: #bebebe; /* Ensure the sticky header has the same background color */
  }}

  tbody tr {{
    background-color: #f9f9f9; /* Lighter color for content rows */
    font-size: 14px
  }}


  tbody tr:last-of-type {{
    border-bottom: 2px solid #009879;
  }}

  tbody tr.active-row {{
    font-weight: bold;
    color: #009879;
  }}

  .link {{
      fill: none;
      stroke: #555;
      stroke-opacity: 0.4;
      stroke-width: 1.5px;
  }}

  .node {{
      cursor: pointer;
  }}

  .node circle {{
      fill: #999;
      stroke: black;
      stroke-width: 1.5px;
  }}

  .node text {{
      font: 12px sans-serif;
      fill: #555;
  }}

  .icons {{
    /* Making the icon larger */
    font-size: 20px; /* You can adjust this value as needed */
    color: white; /* Icon color */
    background-color: black; /* Background color */
    padding: 6px 6px; /* Top/bottom padding and left/right padding */
    border-radius: 3px; /* Making the corners sharp for a rectangular look */
  }}

</style>
</head>
<body>

<div class="dashboard">

    <div class="main-panel">
        <div class="container">
            <a href="https://github.com/Cocoon-Data-Transformation/cocoon" target="_blank" style="display: flex; align-items: center; text-decoration: none; color: black;">
                <img src="https://raw.githubusercontent.com/Cocoon-Data-Transformation/cocoon/main/images/cocoon_icon.png" alt="cocoon icon" width=50 style="margin-right: 10px;">
                <div style="margin: 0; padding: 0;"><h2 style="margin: 0; padding: 0;">Table Profile</h2>
                    <p style="margin: 0; padding: 0;">Powered by cocoon</p>
                </div>
            </a>
            <div><h1>{table_name}</h1>(First 100 rows)</div>
            <div>
                <p style="text-align: right">Share Cocoon with the World 😊</p>
                <div>
                    <a href="https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon&text=Can%27t+believe+how+amazing+the+table+profiles+are+created+by+Cocoon+using+AI.+It%27s+Open+sourced%21&related=ZacharyHuang12" target="_blank"  style="text-decoration: none;">
                        <i class="fa-brands fa-twitter icons"></i>
                    </a>
                    <a href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon" target="_blank"  style="text-decoration: none;">
                        <i class="fa-brands fa-facebook icons"></i>
                    </a>
                    <a href="https://www.linkedin.com/sharing/share-offsite/?url=https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon" target="_blank" style="text-decoration: none;">
                        <i class="fa-brands fa-linkedin icons"></i>
                    </a>
                    <a href="https://api.whatsapp.com/send?text=Can%27t%20believe%20how%20amazing%20the%20table%20profiles%20are%20created%20by%20Cocoon%20using%20AI.%20It%27s%20Open%20sourced%21%20https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon" target="_blank" style="text-decoration: none;">
                        <i class="fa-brands fa-whatsapp icons"></i>
                    </a>
                    <a href="https://www.reddit.com/submit?url=https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon&title=Can%27t%20believe%20how%20amazing%20the%20table%20profiles%20are%20created%20by%20Cocoon%20using%20AI.%20It%27s%20Open%20sourced%21" target="_blank" style="text-decoration: none;">
                        <i class="fa-brands fa-reddit icons"></i>
                    </a>
                    <a href="https://pinterest.com/pin/create/button/?url=https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon&media=&description=Can%27t%20believe%20how%20amazing%20the%20table%20profiles%20are%20created%20by%20Cocoon%20using%20AI.%20It%27s%20Open%20sourced%21" target="_blank" style="text-decoration: none;">
                        <i class="fa-brands fa-pinterest icons"></i>
                    </a>
                    <a href="https://www.tumblr.com/widgets/share/tool?posttype=link&title=Can%27t%20believe%20how%20amazing%20the%20table%20profiles%20are%20created%20by%20Cocoon%20using%20AI.%20It%27s%20Open%20sourced%21&caption=&content=https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon&canonicalUrl=https%3A%2F%2Fgithub.com%2FCocoon-Data-Transformation%2Fcocoon&shareSource=tumblr_share_button" target="_blank" style="text-decoration: none;">
                        <i class="fa-brands fa-tumblr icons"></i>
                    </a>

                </div>
            </div>
        </div>

        <div class="table-container">
            {df[:100].to_html()}
        </div>
    </div>
    <div class="right-panel">
{column_html}
    </div>

    <div class="bottom-panel">
        <div class="container">
            <h2>Table Summary</h2>
        </div>
        <p style="font-size: 15px;">{table_summary}</p>
        <br>
        <h2>Column Grouping</h2>
        <div id="tree"></div>
        
        <h2>Column Summary</h2>
        <div class="table-container">{column_df[:100].to_html()}</div>
        <br>
        {error_html}
    </div>
</div>

<script src="https://d3js.org/d3.v6.min.js"  charset="utf-8"></script>
<script src="https://d3js.org/topojson.v3.min.js"></script>
<script>
    document.querySelectorAll('.card-item').forEach(function(card) {{
        card.addEventListener('click', function() {{
            var indent = this.nextElementSibling;
            var toggle = this.querySelector('.toggle');
            if (indent.style.display === "block") {{
                indent.style.display = "none";
                toggle.textContent = '▼';
                this.classList.remove('card-item-collapsed');
            }} else {{
                indent.style.display = "block";
                toggle.textContent = '▲';
                this.classList.add('card-item-collapsed');
            }}
        }});
    }});
</script>
<script>
{javascript_content}
</script>
<script>
    function drawBarChart(divId, data) {{
      const margin = {{top: 10, right: 10, bottom: 25, left: 100}},
            width = 300 - margin.left - margin.right,
            height = 100 - margin.top - margin.bottom;

      const targetDiv = d3.select("#" + divId);
      targetDiv.classed("bar-chart-container", true);

      const svg = targetDiv
                    .append("svg")
                      .attr("width", width + margin.left + margin.right)
                      .attr("height", height + margin.top + margin.bottom)
                    .append("g")
                      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      const y = d3.scaleBand()
                  .range([0, height])
                  .domain(data.map(d => d.label))
                  .padding(0.1);

      const x = d3.scaleLinear()
                  .domain([0, d3.max(data, d => d.value)])  // Percent scale
                  .range([0, width]);

      svg.append("g")
         .call(d3.axisLeft(y));

      svg.selectAll(".bar")
         .data(data)
         .enter().append("rect")
           .attr("class", "bar")
           .attr("y", d => y(d.label))
           .attr("height", y.bandwidth())
           .attr("x", 0)
           .attr("width", d => x(d.value))
           .attr("fill", "steelblue");

      svg.append("g")
         .attr("transform", "translate(0," + height + ")")
         .call(d3.axisBottom(x).ticks(5).tickFormat(d => d + "%"));
    }}
    
    function drawHistogram(divId, data, binWidth) {{
      const margin = {{top: 10, right: 10, bottom: 20, left: 40}},
            width = 300 - margin.left - margin.right,
            height = 100 - margin.top - margin.bottom;
            
      const targetDiv = d3.select("#" + divId);
      targetDiv.classed("histogram-container", true);

      const svg = targetDiv
                    .append("svg")
                      .attr("width", width + margin.left + margin.right)
                      .attr("height", height + margin.top + margin.bottom)
                    .append("g")
                      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      const x = d3.scaleLinear()
                  .domain([d3.min(data, d => d.x) - binWidth, d3.max(data, d => d.x) + binWidth])
                  .range([0, width]);

      const y = d3.scaleLinear()
                  .domain([0, d3.max(data, d => d.y) * 1.1]) // Increase the y-axis limit by 10% for margin
                  .range([height, 0]);

      const xAxis = d3.axisBottom(x).ticks(5);
      const yAxis = d3.axisLeft(y).ticks(5);

      svg.append("g")
         .attr("transform", "translate(0," + height + ")")
         .call(xAxis)

      svg.append("g")
         .call(yAxis)

      svg.selectAll("rect")
         .data(data)
         .enter().append("rect")
           .attr("x", d => x(d.x - binWidth / 2))
           .attr("y", d => y(d.y))
           .attr("width", x(binWidth) - x(0))
           .attr("height", d => height - y(d.y))
           .attr("fill", "steelblue");
    }}
    
    function drawMap(divId, coordinates) {{
      const targetDiv = d3.select("#" + divId);
      targetDiv.classed("map-container", true);

      const width = 300;
      const height = 200;
      const projection = d3.geoNaturalEarth1()
          .scale(width / 1.5 / Math.PI)
          .translate([width / 2, height / 2]);
      const path = d3.geoPath().projection(projection);

      const svg = targetDiv.append("svg")
          .attr("width", width)
          .attr("height", height);

      d3.json("https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/world.geojson").then(data => {{
        // Draw the map
        svg.append("g")
          .selectAll("path")
          .data(data.features)
          .join("path")
              .attr("fill", "#ccc")
              .attr("d", path)
              .style("stroke", "#fff");

        // Plotting the points
        coordinates.forEach(coords => {{
          svg.append("circle")
            .attr("cx", projection(coords)[0])
            .attr("cy", projection(coords)[1])
            .attr("r", 2)
            .attr("fill", "red");
        }});
      }});
    }}
    
    let data = [];
    let binWidth = 5;
    {column_javascript}

</script>
</body>
</html>
"""
        return html_content

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        html_content = extract_output
        display(HTML(wrap_in_iframe(html_content)))
        table_pipeline = self.para["table_pipeline"]
        
        ask_save_file(f"Cocoon_Profile_{table_pipeline}.html", html_content)
        callback(html_content)
    


def ask_save_file(file_name, content):
    print(f"🤓 Do you want to save the file?")

    def save_file_click(b):
        updated_file_name = file_name_input.value
        allow_overwrite = overwrite_checkbox.value

        if os.path.exists(updated_file_name) and not allow_overwrite:
            print("\x1b[31m" + "Warning: Failed to save. File already exists." + "\x1b[0m")
        else:
            with open(updated_file_name, "w") as file:
                file.write(content)
            print(f"🎉 File saved successfully as {updated_file_name}")

    file_name_input = Text(value=file_name, description='File Name:')

    save_button = Button(description="Save File")
    save_button.on_click(save_file_click)

    overwrite_checkbox = Checkbox(value=False, description='Allow Overwrite')

    display(HBox([file_name_input, overwrite_checkbox]), save_button)
    


        
class CleanUnusual(Node):
    default_name = 'Clean Unusual'
    default_description = 'This node allows users to clean the unusual values.'

    def extract(self, item):
        clear_output(wait=True)

        print("🧹 Cleaning unusual values ...")
        create_progress_bar_with_numbers(3, doc_steps)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]

        idx = self.para["column_idx"]
        total = self.para["total_columns"]
        unusual_reason = self.para["unusual_reason"]

        show_progress(max_value=total, value=idx)

        column_name = self.para["column_name"]

        sample_size = 100
    

        sample_values = create_sample_distinct(con, table_pipeline, column_name, sample_size)
        total_distinct_count = count_total_distinct(con, table_pipeline, column_name)

        return column_name, sample_values, unusual_reason, sample_size, total_distinct_count

    def run(self, extract_output, use_cache=True):
        column_name, sample_values, unusual_reason, sample_size, total_distinct_count = extract_output

        if sample_size < total_distinct_count:

            template = f"""{column_name} has the following distinct values:
{sample_values.to_csv(index=False, header=False, quoting=2)}

This column is unusual: {unusual_reason}

Task: Reason if it is possible to use a simple projection to the clean values.
The clause will be filled in the following format: SELECT (Clause?) AS {column_name} ...
If so, provide the projection clause.

Return in the following format:
```json
{{  
    "explanation": "The problem is ... A simple projection is (not) suffice because ...",
    "could_clean": true/false,
    "projection_clause": "{column_name}..."
}}

```yml
explanation: |
    The error is caused by ...
could_clean: |
    true/false
projection_clause: |
    {column_name}...
```
"""

            messages = [{"role": "user", "content": template}]
            response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
            messages.append(response['choices'][0]['message'])
            self.messages = messages
            
            yml_code = extract_yml_code(response['choices'][0]['message']["content"])
            summary = yaml.safe_load(yml_code)
            summary["projection"] = True
            

        else:

            template = f"""{column_name}  column is unusual: {unusual_reason}
It has the following values, ordered by frequency:
{sample_values.to_csv(index=False, header=False, quoting=2)}

Task: First, understand what are the unusual values and why.
Then, reason if the corrected value is obvious.
If so, maps old values to correct values to fix the problems.
If the old values have inconsistent cases, map to the most frequent case.
If a few old values are meaningless, map to empty string.
If almost all old values are meaningless, it is not possible to clean.

Return in the following format:
```yml
explanation: |
    The problem is ... The correct values are ...
could_clean: true/false
mapping:
    {sample_values.iloc[0, 0]}: {sample_values.iloc[0, 0]}
    ...
```
"""

            messages = [{"role": "user", "content": template}]
            response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
            messages.append(response['choices'][0]['message'])
            self.messages = messages
            
            yml_code = extract_yml_code(response['choices'][0]['message']["content"])
            summary = yaml.safe_load(yml_code)
            summary["projection"] = False 

        return summary
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {"explanation": "Fail to run", "could_clean": False}
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        
        json_code = run_output
        column_name, sample_values, unusual_reason, _, _ = extract_output
        
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))
        

        html_content = f"⚠️ <b>We've found errors in</b>: {column_name} <br><i>{unusual_reason}</i>"
        display(HTML(html_content))
        
        table_pipeline = self.para["table_pipeline"]
        column_name = self.para["column_name"]
        query_widget = self.item["query_widget"]

        query = create_sample_distinct_query(table_name=table_pipeline, column_name=column_name)
        create_explore_button(query_widget=query_widget, query=query)


        if not json_code["could_clean"]:
            print("☹️ Cocoon can't clean this for you, as it's too complex...")
            print("😎 We'll log this for future cleanings and analyses")
            
            submit_button = widgets.Button(
                description='Next',
                disabled=False,
                button_style='success',
                tooltip='Click to submit',
                icon='check'
            )

            def on_button_clicked(b):
                clear_output(wait=True)
                callback(json_code)
            
            submit_button.on_click(on_button_clicked)

            display(submit_button)
            return


        if json_code["projection"]:
            
            print("🧐 It is possible to use a simple projection to the clean values.")

            explanation = json_code["explanation"]

            print(f" {ITALIC}{explanation}{END}")
            text_area = create_text_area(json_code["projection_clause"])

            toggle_button = widgets.Button(
                description='Reject Clean',
                disabled=False,
                button_style='danger',
                tooltip='Click to reject',
                icon='check'
            )
            def on_reject_button_clicked(b):
                clear_output(wait=True)
                json_code["could_clean"] = False
                callback(json_code)

            toggle_button.on_click(on_reject_button_clicked)


            submit_button = widgets.Button(
                description='Endorse Clean',
                disabled=False,
                button_style='success',
                tooltip='Click to endorse',
                icon='check'
            )
            def on_button_clicked(b):
                clear_output(wait=True)
                json_code["could_clean"] = True
                json_code["projection_clause"] = text_area.value                    
                callback(json_code)
            
            submit_button.on_click(on_button_clicked)

            display(text_area)
            display(HBox([toggle_button, submit_button]))

        else:
            html_content = "🧐 We recommend the following transformation of values:<br>"
            explanation = json_code["explanation"]
            mapping = json_code["mapping"]

            html_content += f"<i>{explanation}</i>"
            display(HTML(html_content))

            grid = create_dictionary_grid_remove(mapping, "Old Value", "New Value")

            submit_button = widgets.Button(
                description='Submit',
                disabled=False,
                button_style='success',
                tooltip='Click to submit',
                icon='check'
            )

            def on_button_clicked(b):
                clear_output(wait=True)
                old_values_to_remove, non_removed_values = process_grid_changes_remove(grid)
                json_code["mapping"] = non_removed_values
                json_code["old_values_to_remove"] = old_values_to_remove
            
                callback(json_code)

            submit_button.on_click(on_button_clicked)

            toggle_button = widgets.Button(
                description='Reject Clean',
                disabled=False,
                button_style='danger',
                tooltip='Click to reject',
                icon='check'
            )
            def on_reject_button_clicked(b):
                clear_output(wait=True)
                json_code["could_clean"] = False
                callback(json_code)

            toggle_button.on_click(on_reject_button_clicked)

            display(grid)
            display(HBox([toggle_button, submit_button]))


class CleanUnusualForAll(MultipleNode):
    default_name = 'Clean Unusual For All'
    default_description = 'This node allows users to clean the unusual values for all columns.'

    def construct_node(self, element_name, idx=0, total=0, unusual_reason=""):
        para = self.para.copy()
        para["column_name"] = element_name
        para["column_idx"] = idx
        para["total_columns"] = total
        para["unusual_reason"] = unusual_reason
        node = CleanUnusual(para=para, id_para ="column_name")
        node.inherit(self)
        return node

    def extract(self, item):
        clear_output(wait=True)

        document = self.get_sibling_document("Decide Unusual String For All")["Decide String Unusual"]

        columns = list(document.keys())
        self.elements = []
        self.nodes = {}

        idx = 0
        for col in columns:
            if document[col]["Unusualness"]:
                unusual_reason = document[col]["Examples"]
                self.elements.append(col)
                self.nodes[col] = self.construct_node(col, idx, len(columns), unusual_reason)
                idx += 1

    def display_after_finish_workflow(self, callback, document):
        
        

        clean_unusual = document.get("Clean Unusual", {})

        all_no_clean = True

        for col in clean_unusual:
            if clean_unusual[col]["could_clean"]:
                all_no_clean = False
                break

        if all_no_clean:
            callback(document)
            return

        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        
        new_table_name = f"{table_pipeline}_cleaned"

        selections = []
        filters = []

        comment = "-- Clean unusual string values: \n"
        
        for col in columns:
            
            if col not in clean_unusual:
                selections.append(col)
                continue
                
            clean_unusual_col = clean_unusual[col]
            
            comment += f"-- {col}: {clean_unusual_col.get('explanation', '')}\n"

            if clean_unusual_col["projection"]:
                if clean_unusual_col["could_use_projection"]:
                    selections.append(clean_unusual_col["projection_clause"] + " AS " + col)
                else:
                    selections.append(col)
            else:
                mapping = clean_unusual_col["mapping"]
                old_values_to_remove = clean_unusual_col.get("old_values_to_remove", [])
                remove_list_str = "(" + ", ".join([f"'{val}'" for val in old_values_to_remove]) + ")"
                if old_values_to_remove:
                    filters.append(f"{col} NOT IN {remove_list_str}")

                selection_str = "CASE\n"
                for old_value, new_value in mapping.items():
                    selection_str += f"    WHEN {col} = '{old_value}' THEN '{new_value}'\n"
                selection_str += f"    ELSE {col}\n"
                selection_str += "END AS " + col
                selections.append(selection_str)

        selection_sql = indent_paragraph(",\n".join(selections))
        where_sql = ""
        if len(filters) > 0:
            where_sql = "\nWHERE\n" + indent_paragraph(" AND\n".join(filters) if filters else "")

        sql_query = f"""SELECT
{selection_sql}
FROM {table_pipeline}{where_sql}"""     
        
        sql_query = comment + sql_query
        
        step = SQLStep(table_name=new_table_name, sql_code=sql_query, con=self.item["con"])
        step.run_codes()

        table_pipeline.add_step_to_final(step)



        callback(document)
        
        
class HandleMissing(Node):
    default_name = 'Handle Missing Values'
    default_description = 'This node allows users to handle missing values.'
    
    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Handling missing values ...")
        create_progress_bar_with_numbers(2, doc_steps)

        document = self.get_sibling_document("Decide Missing Values")
        schema = self.para["table_pipeline"].get_final_step().get_schema()
        
        return document, schema
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        document, schema = extract_output
        
        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        
        df = pd.read_json(document, orient="split")
        
        
        df = df[~df["Is NULL Acceptable?"]]
        
        if len(df) == 0:
            df = pd.DataFrame(columns=["Column", "NULL (%)", "Strategy"])
            document = df.to_json(orient="split")
            callback(document)
            return
        
        df = df.drop(columns=["Is NULL Acceptable?"])
        df = df.drop(columns=["Explanation"])
        
        print("🧹 The following columns have abnormal missing values. Please select a strategy to handle them.")
        categories = ["Unchanged", "Drop Column", "Remove Rows"]

        df["Strategy"] = "Unchanged"
        
        editable_columns = [False, False, True]
        reset = True
        category = {
            'Strategy': categories
        }

        grid = create_dataframe_grid(df, editable_columns, reset, category)
        display(grid)
        
        print("😎 More missing value handling strategies coming soon...")
        
        next_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )
        
        
        def create_missing_handling_sql(df, schema, table_name):
            drop_columns = df[df["Strategy"] == "Drop Column"]["Column"].tolist()
            remove_rows = df[df["Strategy"] == "Remove Rows"]["Column"].tolist()
            
            if len(drop_columns) == len(schema):
                raise ValueError("All columns are dropped. Please keep at least one column.")
            
            if len(remove_rows) == 0 and len(drop_columns) == 0:
                return ""
                        
            select_columns = [col for col in schema if col not in drop_columns]
            selection_sql = indent_paragraph(',\n'.join(select_columns))
            sql_query = f"""SELECT
{selection_sql}
FROM {table_name}"""
            
            where_clause = " AND\n".join([f"{col} IS NOT NULL" for col in remove_rows])
            
            if where_clause:
                sql_query += f"\nWHERE \n{indent_paragraph(where_clause)}"
            
            handling_comments = f"-- Handling missing values: There are {len(df)} columns with unacceptable missing values\n"
            
            for index, row in df.iterrows():
                handling_comments += f"-- {row['Column']} has {row['NULL (%)']} percent missing. Strategy: {row['Strategy']}\n"
            
            sql_query = handling_comments + sql_query
            
            return sql_query
        
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            table_pipeline = self.para["table_pipeline"]
            missing_handling_sql = create_missing_handling_sql(new_df, schema, table_pipeline)
            
            if missing_handling_sql != "":
                new_table_name = f"{table_pipeline}_missing_handled"
                step = SQLStep(table_name=new_table_name, sql_code=missing_handling_sql, con=self.item["con"])
                step.run_codes()
                self.para["table_pipeline"].add_step_to_final(step)
            
            document = new_df.to_json(orient="split")

            callback(document)
            
        next_button.on_click(on_button_clicked)
        
        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
        
class DecideDataType(Node):
    default_name = 'Decide Data Type'
    default_description = 'This node allows users to decide the data type for each column.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Checking data types ...")
        create_progress_bar_with_numbers(2, doc_steps)
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        sample_size = 5
        
        database_name = get_database_name(con)
        all_data_types = list(data_types_database[database_name].keys())

        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")
        schema = table_pipeline.get_final_step().get_schema()

        return sample_df, all_data_types, database_name, schema

    def run(self, extract_output, use_cache=True):
        sample_df, all_data_types, database_name, schema = extract_output

        template = f"""You have the following table:
{sample_df.to_csv(index=False, quoting=2)}

For each column, classify what the column type should be.
The column type should be one of the following:
{all_data_types}

Return in the following format:
```json
{{
    "column_type": {{
        "column1": "INT",
        ...
    }}
}}
```"""
        
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        checks = [
            (lambda jc: isinstance(jc, dict), "The returned JSON code is not a dictionary."),
            (lambda jc: "column_type" in jc, "The 'column_type' key is missing in the JSON code."),
            (lambda jc: all(col_type in all_data_types for col_type in jc["column_type"].values()), "The column types are not all strings."),
            (lambda jc: all(col_name in sample_df.columns for col_name in jc["column_type"]), "One or more column names specified in 'column_type' are not present in the sample DataFrame."),
        ]

        for check, error_message in checks:
            if not check(json_code):
                raise ValueError(f"Validation failed: {error_message}")
            
        return json_code
    
    def run_but_fail(self, extract_output, use_cache=True):
        _, _, database_name, schema = extract_output
        return {"column_type": {col: get_reverse_type(schema[col], database_name) for col in schema}}

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        json_code = run_output
        _, all_data_types, database_name, schema = extract_output
        self.progress.value += 1
        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        

        rows_list = []

        for col in schema:
            current_type = get_reverse_type(schema[col], database_name)
            target_type = json_code["column_type"][col]

            rows_list.append({
                "column_name": col,
                "current_type": current_type,
                "target_type": target_type,
            })

        df = pd.DataFrame(rows_list)
        
        grid = create_data_type_grid(df, all_data_types = all_data_types)
        print("😎 We have recommended the Data Types for Columns:")
        display(grid)

        next_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )  

        def on_button_clicked(b):
            clear_output(wait=True)
            df = extract_grid_data_type(grid)
            
            callback(df.to_json(orient="split"))

        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
            

class TransformType(Node):
    default_name = 'Transform Type'
    default_description = 'This node allows users to transform the data type for a column.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Transforming data type ...")
        create_progress_bar_with_numbers(2, doc_steps)

        self.input_item = item

        idx = self.para["column_idx"]
        total = self.para["total_columns"]

        show_progress(max_value=total, value=idx)

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        column_name = self.para["column_name"]
        current_type = self.para["current_type"]
        target_type = self.para["target_type"]
        database_name = get_database_name(con)
        sample_size = 5

        sample_values = create_sample_distinct(con, table_pipeline, column_name, sample_size)
        
        hint = ""
        if current_type in transform_hints:
            if target_type in transform_hints[current_type]:
                if database_name in transform_hints[current_type][target_type]:
                    hint = transform_hints[current_type][target_type][database_name]
        
        
        return column_name, sample_values, current_type, target_type, database_name, table_pipeline, con, hint
    
    def run(self, extract_output, use_cache=True):
        column_name, sample_values, current_type, target_type, database_name, table_pipeline, con, hint= extract_output
        max_iterations = 10
        self.messages = []

        template = f"""'{column_name}' has the following distinct values:
{sample_values.to_csv(index=False, header=False, quoting=1)}

Task: Transform the data type of the column from '{current_type}' to '{target_type}', in a simple SELECT clause.
Note that we use {database_name} syntax. {hint}

Return the result in yml
```yml
reasoning: |
    To transform, we need to ...

cast_clause: |
    CAST({column_name} AS {target_type}) AS {column_name}
```"""
        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages.append(messages)

        yml_code = extract_yml_code(response['choices'][0]['message']["content"])
        summary = yaml.safe_load(yml_code)
        reasoning = summary["reasoning"]
        
        def clean_clause(clause):

            if clause.lower().startswith("select"):
                clause = clause[6:].strip()

            clause = clause.replace("\n", " ")
            return  clause

        summary["cast_clause"] = clean_clause(summary["cast_clause"]) 
        
        for i in range(max_iterations):
            
            try:
                sql = f"""SELECT {summary['cast_clause']}
FROM {table_pipeline}"""
                df = run_sql_return_df(con, sql)
                break
            except Exception: 
                detailed_error_info = get_detailed_error_info()
                template = f"""You have the following CAST clause:
{summary['cast_clause']}
It has an error: {detailed_error_info}

Please correct the CAST clause, but don't change the logic.
Note that we use {database_name} syntax. {hint}
Return the result in yml
```yml
reasoning: |
    The error is caused by ...

cast_clause: |
    CAST({column_name} AS {target_type}) AS {column_name}
```
"""

                messages = [{"role": "user", "content": template}]
                response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
                messages.append(response['choices'][0]['message'])
                self.messages.append(messages)

                yml_code = extract_yml_code(response['choices'][0]['message']["content"])
                summary = yaml.safe_load(yml_code)
                summary["cast_clause"] = clean_clause(summary["cast_clause"]) 
        
        summary["reasoning"] = reasoning
        return summary
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {"reasoning": "Fail to cast", "cast_clause": "Fail to cast"}
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        return callback(run_output)
    

class TransformTypeForAll(MultipleNode):
    default_name = 'Transform Type For All'
    default_description = 'This node allows users to transform the data type for all columns.'

    def construct_node(self, element_name, current_type="", target_type="", idx=0, total=0):
        para = self.para.copy()
        para["column_name"] = element_name
        para["column_idx"] = idx
        para["total_columns"] = total
        para["current_type"] = current_type
        para["target_type"] = target_type
        node = TransformType(para=para, id_para ="column_name")
        node.inherit(self)
        return node

    def extract(self, item):

        document = self.get_sibling_document("Decide Data Type")
        df = pd.read_json(document, orient="split")
        
        self.elements = []
        self.nodes = {}

        
        for idx, row in df.iterrows():
            column_name = row['Column']
            current_type = row['Current Type']
            target_type = row['Target Type']
            if current_type != target_type:
                self.elements.append(column_name)

        idx = 0
        for idx, row in df.iterrows():
            column_name = row['Column']
            current_type = row['Current Type']
            target_type = row['Target Type']
            if current_type != target_type:
                self.nodes[column_name] = self.construct_node(column_name, 
                                                                current_type, target_type,
                                                              idx, len(self.elements))
                idx += 1

    def display_after_finish_workflow(self, callback, document):
        clear_output(wait=True)

        create_progress_bar_with_numbers(2, doc_steps)

        data = {
            'Column Name': [],
            'Clause': [],
            'Reasoning': []
        }

        decided_column_type = self.get_sibling_document("Decide Data Type")
        decided_column_type_df = pd.read_json(decided_column_type, orient="split")
        
        if "Transform Type" in document:
            for column_name, details in document["Transform Type"].items():
                data['Column Name'].append(column_name)
                data['Clause'].append(details['cast_clause'])
                data['Reasoning'].append(details['reasoning'])

        df = pd.DataFrame(data)

        if len(df) == 0:
            callback(document)
            return

        editable_columns = [False, True, False]
        grid = create_dataframe_grid(df, editable_columns, reset=True, long_text=["Reasoning"])

        print("😎 We have written the clause to cast the columns:")
        display(grid)

        query_widget = self.item["query_widget"]

        test_button = widgets.Button(
            description='Test Cast',
            disabled=False,
            button_style='info',
            tooltip='Click to test',
            icon='play'
        )
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            query = f"SELECT\n"
            for i, row in new_df.iterrows():
                column_name = row["Column Name"]
                clause = row["Clause"]
                query += f"    {column_name} AS {column_name},\n"
                query += f"    {clause},\n"
            query = query[:-2] + f"\nFROM {self.para['table_pipeline']}"
            query_widget.run_query(query)
            print("😎 Query submitted. Check out the data widget!")
        
        test_button.on_click(on_button_clicked)
        print("🧪 Please test the cast and ensure the result is as expected.")
        display(test_button)

        next_button = widgets.Button(
            description='Endorse Cast',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )


        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            affected_columns = new_df["Column Name"].tolist()
            document["Transform Type"] = new_df.to_json(orient="records")
            new_table_name = f"{self.para['table_pipeline']}_casted"
            schema = self.para["table_pipeline"].get_final_step().get_schema()
            columns = list(schema.keys())
            non_affected_columns = [col for col in columns if col not in affected_columns]

            sql_query = f"SELECT\n"
            sql_query += indent_paragraph(",\n".join(non_affected_columns + [f"{row['Clause']}" for i, row in new_df.iterrows()])) 
            sql_query += f"\nFROM {self.para['table_pipeline']}"

                
            
            comment = "-- Column Type Casting: \n"
            
            for idx, row in decided_column_type_df.iterrows():
                column_name = row['Column']
                current_type = row['Current Type']
                target_type = row['Target Type']
                if current_type != target_type:
                    comment += f"-- {column_name}: from {current_type} to {target_type}\n"
                    
            sql_query = comment + sql_query

            step = SQLStep(table_name=new_table_name, sql_code=sql_query, con=self.item["con"])
            step.run_codes()
            self.para["table_pipeline"].add_step_to_final(step)

            callback(document)
        
        next_button.on_click(on_button_clicked)

        display(next_button)
        
def where_clause_for_space(column_name):
    return f"{column_name} <> TRIM({column_name})"

class DecideTrim(Node):
    default_name = 'Decide Trim'
    default_description = 'This node allows users to decide how to handle leading and trailing spaces.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Deciding Trim ...")
        create_progress_bar_with_numbers(2, doc_steps)

        con = self.item["con"]
        database_name = get_database_name(con)

        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = []

        for column in schema:
            current_type = get_reverse_type(schema[column], database_name)
            if current_type == "VARCHAR":
                where_clause = where_clause_for_space(column)
                count = run_sql_return_df(con, f"SELECT COUNT(*) FROM {table_pipeline} WHERE {where_clause}").iloc[0, 0]
                if count > 0:
                    columns.append(column)

        sample_size = 2
        sample_df = None
        if len(columns) > 0:
            all_columns = ", ".join(columns)
            sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")

        return columns, sample_df
    
    def run(self, extract_output, use_cache=True):
        columns, sample_df = extract_output

        if len(columns) == 0:
            return {}, columns

        template = f"""You have a table, and the following columns have leading or trailing spaces:
{sample_df.to_csv(index=False, quoting=2)}

Task: Decide whether to keep the leading and trailing spaces.
Most of the time, they are not meaningful.
Some special cases are: password, code snippet...

Return in the following format:
```json
{{
    "reasoning": "The columns mean ... The spaces are (not) meaningful...",
    "columns_to_keep_spaces": ["col1", ...]
}}
```"""
        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages

        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)
        
        checks = [
            (lambda jc: isinstance(jc, dict), "The returned JSON code is not a dictionary."),
            (lambda jc: "reasoning" in jc and "columns_to_keep_spaces" in jc, "The 'reasoning' or 'columns_to_keep_spaces' key is missing in the JSON code."),
            (lambda jc: isinstance(jc["columns_to_keep_spaces"], list), "The 'columns_to_keep_spaces' value is not a list."),
            (lambda jc: all(col_name in columns for col_name in jc["columns_to_keep_spaces"]), "One or more column names specified in 'columns_to_keep_spaces' are not present in the columns list."),
        ]

        for check, error_message in checks:
            if not check(json_code):
                raise ValueError(f"Validation failed: {error_message}")

        return json_code
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {"reasoning": "failed", "columns_to_keep_spaces": []}, 


    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        json_code = run_output
        columns, _  = extract_output
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        if len(columns) == 0:
            callback({})
            return

        df = pd.DataFrame(columns=["Column Name", "Trim?"])

        df["Column Name"] = columns

        df["Trim?"] = [not (col in json_code["columns_to_keep_spaces"]) for col in columns]

        grid = create_dataframe_grid(df, [False, True], reset=True)
        print(f"😎 We have found the following columns with leading or trailing spaces, and recommend to {BOLD}trim{END} them:")
        display(grid)

        query_widget = self.item["query_widget"]
        table_pipeline = self.para["table_pipeline"]

        columns_str = ", ".join(columns)

        explore_button = widgets.Button(
            description='Explore',
            disabled=False,
            button_style='info',
            tooltip='Click to explore',
            icon='search'
        )

        def on_button_clicked(b):
            print("😎 Query submitted. Check out the data widget!")
            query_widget.run_query(f"SELECT {columns_str} FROM {table_pipeline}")

        explore_button.on_click(on_button_clicked)

        display(explore_button)

        next_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )

        def on_button_clicked(b):
            clear_output(wait=True)
            new_df =  grid_to_updated_dataframe(grid)

            new_table_name = f"{self.para['table_pipeline']}_trimmed"

            schema = self.para["table_pipeline"].get_final_step().get_schema()
            all_columns = list(schema.keys())
            non_affected_columns = [col for col in all_columns if col not in new_df["Column Name"].tolist()]
            sql_query = f"SELECT\n"

            columns_to_trim = []
            columns_not_to_trim = []

            for i, row in new_df.iterrows():
                column_name = row["Column Name"]
                trim = row["Trim?"]
                if trim:
                    columns_to_trim.append(column_name)
                else:
                    columns_not_to_trim.append(column_name)

            sql_query += indent_paragraph(",\n".join(non_affected_columns + \
                                                     columns_not_to_trim +\
                                                     [f"TRIM({col}) AS {col}" for col in columns_to_trim]))

            sql_query += f"\nFROM {self.para['table_pipeline']}"
            
            sql_query = f"-- Trim Leading and Trailing Spaces\n" + {sql_query}

            step = SQLStep(table_name=new_table_name, sql_code=sql_query, con=self.item["con"])
            step.run_codes()
            self.para["table_pipeline"].add_step_to_final(step)

            callback(new_df.to_json(orient="records"))

        next_button.on_click(on_button_clicked)

        display(next_button)
        
class DecideStringUnusual(Node):
    default_name = 'Decide String Unusual'
    default_description = 'This node allows users to decide how to handle unusual values.'

    def extract(self, input_item):
        clear_output(wait=True)

        print("🔍 Understanding unusual values ...")
        create_progress_bar_with_numbers(3, doc_steps)

        idx = self.para["column_idx"]
        total = self.para["total_columns"]
        show_progress(max_value=total, value=idx)

        self.input_item = input_item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        column_name = self.para["column_name"]
        sample_size = 20

        sample_values = run_sql_return_df(con, f"SELECT {column_name} FROM {table_pipeline} WHERE {column_name} IS NOT NULL GROUP BY {column_name} ORDER BY COUNT(*) DESC,  {column_name} LIMIT {sample_size}")
        
        return column_name, sample_values

    def run(self, extract_output, use_cache=True):
        column_name, sample_values = extract_output
        
        if len(sample_values) == 0:
            return {"Reaonsing": "Column is fully missing", "Unusualness": False}

        template = f"""{column_name} has the following distinct values:
{sample_values.to_csv(index=False, header=False, quoting=2)}

Review if there are any unusual values. 
Look out for, patterns that don't align with the nature of the data.
Weird characters/typo.

Now, respond in Json:
```json
{{
    "Reaonsing": "The valuses are ... They are unusual/acceptable ...",
    "Unusualness": true/false,
    "Examples": "xxx values are unusual because ..." (empty if not unusual) 
}}
```"""
        
        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)
        
        checks = [
            (lambda jc: isinstance(jc, dict), "The returned JSON code is not a dictionary."),
            (lambda jc: "Reasoning" in jc, "The 'Reasoning' key is missing in the JSON code."),
            (lambda jc: "Unusualness" in jc, "The 'Unusualness' key is missing in the JSON code."),
            (lambda jc: isinstance(jc["Unusualness"], bool), "The value of 'Unusualness' must be a boolean."),
            (lambda jc: "Examples" in jc, "The 'Examples' key is missing in the JSON code."),
            (lambda jc: isinstance(jc["Examples"], str), "The value of 'Examples' must be a string."),
        ]

        for check, error_message in checks:
            if not check(json_code):
                raise ValueError(f"Validation failed: {error_message}")

        return json_code
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {"Reaonsing": "Fail to run", "Unusualness": False}
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)

class DecideStringUnusualForAll(MultipleNode):
    default_name = 'Decide Unusual String For All'
    default_description = 'This node allows users to decide how to handle unusual values for all columns.'

    def construct_node(self, element_name, idx=0, total=0):
        para = self.para.copy()
        para["column_name"] = element_name
        para["column_idx"] = idx
        para["total_columns"] = total
        node = DecideStringUnusual(para=para, id_para ="column_name")
        node.inherit(self)
        return node

    def extract(self, item):
        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        con = self.item["con"]
        database_name = get_database_name(con)

        columns = [col for col in schema if get_reverse_type(schema[col], database_name) =='VARCHAR']
        self.elements = []
        self.nodes = {}

        idx = 0
        for col in columns:
            self.elements.append(col)
            self.nodes[col] = self.construct_node(col, idx, len(columns))
            idx += 1
            







            



            
            
            

            
            

                    
                        



    
    
def create_dbt_schema_yml(table_name, table_summary, columns, column_desc, miss_df):
    yml_content = f"""version: 2

models:
  - name: {table_name}
    description: "{table_summary}"
    columns:"""

    for column in columns:
        description = column_desc.loc[column_desc['Column'] == column, 'Summary'].values[0]

        is_null_acceptable = miss_df.loc[miss_df['Column'] == column, 'Is NULL Acceptable?'].values
        tests = "- not_null" if not is_null_acceptable or pd.isnull(is_null_acceptable[0]) else ""

        if is_null_acceptable and not is_null_acceptable[0]:
            explanation = miss_df.loc[miss_df['Column'] == column, 'Explanation'].values[0]
            description += f"\nMissing Value is Acceptable: {explanation}"

        yml_content += f"""
      - name: {column}
        description: "{description}"
        tests:
          {tests}"""

    return yml_content




class WriteStageYMLCode(Node):
    default_name = 'Write Stage Code'
    default_description = 'This node allows users to write the code for the stage.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        create_progress_bar_with_numbers(1, self.get_sibling_document('Product Steps'))
        border_style = """
<style>
.border-class {
    border: 1px solid black;
    padding: 10px;
    margin: 10px;
}
</style>
"""

        print("🎉 Congratulations! Below is the stage codes.")

        table_pipeline = self.para["table_pipeline"]
        old_table_name = table_pipeline.get_source_step().name
        new_table_name = "stg_" + old_table_name.replace("src_", "")

        sql_query = f"""SELECT * FROM {table_pipeline}"""

        step = SQLStep(table_name=new_table_name, sql_code=sql_query, con=self.item["con"])
        step.run_codes()

        table_pipeline.add_step_to_final(step)

        tab_data = []
        
        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"

        combined_css = css_style + border_style
        
        sql_query = table_pipeline.get_codes()
        input_table = table_pipeline.get_source_step().name
        sql_query = process_query_to_dbt(sql_query, [input_table])

        highlighted_sql = wrap_in_scrollable_div(highlight(sql_query, SqlLexer(), formatter), height='600px')
        bordered_content = f'<div class="border-class">{highlighted_sql}</div>'
        combined_html = combined_css + bordered_content
        
        tab_data.append(("sql", combined_html))
        
        table_pipeline = self.para["table_pipeline"]
        table_name = "stg_" + table_pipeline.get_source_step().name
        table_summary = self.get_sibling_document("Create Short Table Summary").replace("**","")
        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        column_desc = pd.read_json(self.get_sibling_document("Describe Columns"), orient="split")
        miss_df = pd.read_json(self.get_sibling_document("Decide Missing Values"), orient="split")

        yml_content = create_dbt_schema_yml(table_name, table_summary, columns, column_desc, miss_df)

        
        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"

        highlighted_yml = highlight(yml_content, YamlLexer(), formatter)

        bordered_content = f'<div class="border-class">{highlighted_yml}</div>'

        combined_html = css_style + border_style + bordered_content

        tab_data.append(("yml", combined_html))
        
        tabs = create_dropdown_with_content(tab_data) 
        display(tabs)
        




        

def create_stage_workflow(table_name, con, viewer=True):
    query_widget = QueryWidget(con)

    item = {
        "con": con,
        "query_widget": query_widget
    }

    sql_step = SQLStep(table_name=table_name, con=con)
    pipeline = TransformationSQLPipeline(steps = [sql_step], edges=[])

    para = {"table_pipeline": pipeline}

    main_workflow = Workflow("Data Stage", 
                            item = item, 
                            description="A workflow to stage table",
                            para = para)

    main_workflow.add_to_leaf(DecideProjection())
    main_workflow.add_to_leaf(CreateShortTableSummary())
    main_workflow.add_to_leaf(DecideDuplicate())
    main_workflow.add_to_leaf(DescribeColumns())
    main_workflow.add_to_leaf(DecideMissing())
    main_workflow.add_to_leaf(HandleMissing())
    main_workflow.add_to_leaf(DecideDataType())
    main_workflow.add_to_leaf(TransformTypeForAll())
    main_workflow.add_to_leaf(DecideTrim())
    main_workflow.add_to_leaf(DecideStringUnusualForAll())
    main_workflow.add_to_leaf(CleanUnusualForAll())
    main_workflow.add_to_leaf(WriteStageYMLCode())
    
    return query_widget, main_workflow
    
class CreateShortTableSummary(Node):
    default_name = 'Create Short Table Summary'
    default_description = 'This node creates a short summary of the table.'

    def extract(self, item):
        clear_output(wait=True)
        self.input_item = item

        print("📝 Generating table summary ...")
        
        create_progress_bar_with_numbers(1, doc_steps)

        self.progress = show_progress(1)

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        sample_size = 5

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        all_columns = ", ".join(columns)
        sample_df = run_sql_return_df(con, f"SELECT {all_columns} FROM {table_pipeline} LIMIT {sample_size}")
        table_desc = sample_df.to_csv(index=False, quoting=2)

        self.sample_df = sample_df

        return f"{table_pipeline}", table_desc
    
    def run(self, extract_output, use_cache=True):
        table_name, table_desc = extract_output

        template = f"""You have the following table:
{table_desc}
        
- Task: Summarize the table.
-  Structure: Start with the big picture. Then explain what are the details mentioned, with related columns in ().
-  Style: Use a few short sentences with very simple words.

Example: 
The table is about ... It discusses customers (customer_id, customer_name) and their orders (order_id, order_date).
Now, your summary in a few sentences and < 500 chars:"""

        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)

        summary = response['choices'][0]['message']['content']
        assistant_message = response['choices'][0]['message']
        messages.append(assistant_message)
        self.messages = messages

        return summary
    
    def run_but_fail(self, extract_output, use_cache=True):
        return "Please summarize the table"

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        summary = run_output 
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        self.progress.value += 1

        table_name, _ = extract_output
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_name)

        print(f"📝 Here is the summary for {table_name}, please keep it concise:")
        
        text_area, char_count_label = create_text_area_with_char_count(summary, max_chars=500)
        display(VBox([text_area, char_count_label]))

        def on_button_clicked(b):
            clear_output(wait=True)
            print("Submission received.")
            callback(text_area.value)

        submit_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )

        submit_button.on_click(on_button_clicked)

        display(submit_button)
        
        if self.viewer:
            on_button_clicked(submit_button)
            
class SelectMainVocabularyTable(Node):
    default_name = 'Select Main and Vocabulary Table'
    default_description = 'This step allows you to select the main table and vocabulary table for the fuzzy join.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)

        con = self.input_item["con"]
        query_widget = self.item["query_widget"]
        
        tables = get_table_names(con)
        
        print(f"🧐 There are {len(tables)} tables in your database.")
        print(f"🤓 Please select the {BOLD}main table{END} and {BOLD}vocabulary table{END}.")
        print(f"Each row in the {BOLD}main table{END} will be mapped to vocabulary.")
        print(f"If unsure, choose the smaller table as the {BOLD}main table{END}.")
        
        print(f"{BOLD}Main Table:{END}", flush=True)
        dropdown =  create_explore_button(query_widget, table_name=tables)
        
        print(f"{BOLD}Vocabulary Table:{END}")
        dropdown_vocabulary = create_explore_button(query_widget, table_name=tables)

        next_button = widgets.Button(description="Next", button_style='success')

        def on_button_click(b):
            main_table = dropdown.value
            vocabulary_table = dropdown_vocabulary.value
            selected_tables = {"main_table": main_table, "vocabulary_table": vocabulary_table}
            callback(selected_tables)
                
        next_button.on_click(on_button_click)
        display(next_button)
        
        
class DecideFuzzyColumns(Node):
    default_name = 'Decide Fuzzy Columns'
    default_description = 'This allows users to select the columns for fuzzy join.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        
        con = self.item["con"]
        vocabulary_table = self.get_sibling_document("Select Main and Vocabulary Table")["vocabulary_table"]
        main_table = self.get_sibling_document("Select Main and Vocabulary Table")["main_table"]
        
        vocabulary_schema = get_table_schema(con, vocabulary_table)
        main_schema = get_table_schema(con, main_table)

        print(f"🔍 Exploring the tables:")
        query_widget = self.item["query_widget"]
        create_explore_button(query_widget, table_name=[vocabulary_table, main_table])

        print(f"🧐 Please select the columns for fuzzy match.")
        print(f"😊 For the vocabulary table: {vocabulary_table}")
        vocabulary_columns = list(vocabulary_schema.keys())
        vocabulary_multi_select = create_column_selector_(columns=vocabulary_columns)
        
        print(f"😊 For the main table: {main_table}")
        main_columns = list(main_schema.keys())
        main_multi_select = create_column_selector_(columns=main_columns)
        
        next_button = widgets.Button(description="Next", button_style='success')

        def callback_next(button):

            selected_vocabulary_columns = vocabulary_multi_select.value
            selected_main_columns = main_multi_select.value
            
            if not selected_vocabulary_columns or not selected_main_columns:
                print("🙁 Please select at least one column for each table.")
                return
            
            selected_columns = {"vocabulary_columns": [vocabulary_columns[i] for i in selected_vocabulary_columns],
                                "main_columns": [main_columns[i] for i in selected_main_columns]}
            clear_output(wait=True)            
            callback(selected_columns)
            
        next_button.on_click(callback_next)
        
        display(next_button)
        
class PrepareFuzzyJoin(Node):
    default_name = 'Prepare Fuzzy Join'
    default_description = 'This step allows you to prepare the fuzzy join.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        
        con = self.item["con"]
        vocabulary_table = self.get_sibling_document("Select Main and Vocabulary Table")["vocabulary_table"]
        main_table = self.get_sibling_document("Select Main and Vocabulary Table")["main_table"]
        selected_columns = self.get_sibling_document("Decide Fuzzy Columns")
        vocabulary_columns = selected_columns["vocabulary_columns"]
        main_columns = selected_columns["main_columns"]
        
        query = f"SELECT DISTINCT {', '.join(vocabulary_columns)} FROM {vocabulary_table}"
        vocabulary_df = run_sql_return_df(con, query)
        vocabulary_df.fillna(' ', inplace=True)
        vocabulary_df['label'] = vocabulary_df.agg(''.join, axis=1)
        query = f"SELECT DISTINCT {', '.join(main_columns)} FROM {main_table}"
        main_df = run_sql_return_df(con, query)
        main_df.fillna(' ', inplace=True)
        main_df['label'] = main_df.agg(''.join, axis=1)
        
        print(f"🔍 There are {len(vocabulary_df) + len(main_df)} unique vocabularies. We are preparing them...")
        
        if len(vocabulary_df) + len(main_df) > 10000:
            print(f"🤔 The number of unique vocabularies is too many.")
            print(f"😊 Support for large vocabulary is under development.")
            return
        
        for table, df in [(vocabulary_table, vocabulary_df), (main_table, main_df)]:
            embedding_file = f"{table}_cocoon_embedding"
            embed_labels(df, f'./{embedding_file}.csv')
            embedding_df = pd.read_csv(f'./{embedding_file}.csv')
            
        callback({})
    
class MatchEntity(Node):
    default_name = 'Match Entity'
    default_description = 'This step allows you to match entities.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        
        con = self.item["con"]
        vocabulary_table = self.get_sibling_document("Select Main and Vocabulary Table")["vocabulary_table"]
        main_table = self.get_sibling_document("Select Main and Vocabulary Table")["main_table"]
        selected_columns = self.get_sibling_document("Decide Fuzzy Columns")
        vocabulary_columns = selected_columns["vocabulary_columns"]
        main_columns = selected_columns["main_columns"]
        
        vocabulary_df = pd.read_csv(f'./{vocabulary_table}_cocoon_embedding.csv')
        main_df = pd.read_csv(f'./{main_table}_cocoon_embedding.csv')
        main_df = main_df.head(10)
        
        print(f"🔍 Matching rows... We will only match the first 10 rows for trial.")
        print(f"😊 Please let us know if you want the complete feature!")
        index = load_embedding(vocabulary_df, label_embedding='embedding')
        D, I = df_search(main_df, index)
        
        entity_relation_match(input_df = main_df, 
                            attributes = main_columns,
                            I = I,
                            refernece_df = vocabulary_df)
        
        html_content = generate_report(main_df)
        
        display(HTML(wrap_in_iframe(html_content)))
        ask_save_file(f"Cocoon_EM_{main_table}.html", html_content)
        

def create_matching_workflow(con, query_widget=None, viewer=True):
    if query_widget is None:
        query_widget = QueryWidget(con)

    query_widget = QueryWidget(con)

    item = {
        "con": con,
        "query_widget": query_widget,
    }

    para={}

    main_workflow = Workflow("Fuzzy Join Workflow", 
                            item = item, 
                            description="A workflow to perform fuzzy join on two tables.",
                            para=para)

    main_workflow.add_to_leaf(SelectMainVocabularyTable())
    main_workflow.add_to_leaf(DecideFuzzyColumns())
    main_workflow.add_to_leaf(PrepareFuzzyJoin())
    main_workflow.add_to_leaf(MatchEntity())
    
    return query_widget, main_workflow


class SelectTable(Node):
    default_name = 'Select Table'
    default_description = 'This step allows you to select the table.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)

        con = self.input_item["con"]
        query_widget = self.item["query_widget"]
        
        tables = get_table_names(con)
        
        print(f"🧐 There are {len(tables)} tables in your database.")
        print(f"🤓 Please select the table:")
        
        dropdown = create_explore_button(query_widget, table_name=tables)
        
        next_button = widgets.Button(description="Next", button_style='success')

        def on_button_click(b):
            table_name = dropdown.value
            sql_step = SQLStep(table_name=table_name, con=con)
            pipeline = TransformationSQLPipeline(steps = [sql_step], edges=[])
            self.para["table_pipeline"] = pipeline
            
            callback({"table_name": table_name})
                
        next_button.on_click(on_button_click)
        display(next_button)
        
        
def create_cocoon_stage_workflow(con, query_widget=None, viewer=True):
    if query_widget is None:
        query_widget = QueryWidget(con)

    item = {
        "con": con,
        "query_widget": query_widget
    }

    main_workflow = Workflow("Data Stage Workflow", 
                            item = item, 
                            description="A workflow to stage table",
                            para = {})
    
    main_workflow.add_to_leaf(SelectTable())
    main_workflow.add_to_leaf(DecideColumnsPattern())
    main_workflow.add_to_leaf(DecideProjection())
    main_workflow.add_to_leaf(CreateShortTableSummary())
    main_workflow.add_to_leaf(DecideDuplicate())
    main_workflow.add_to_leaf(DescribeColumnsList())
    main_workflow.add_to_leaf(DecideMissingList())
    main_workflow.add_to_leaf(HandleMissing())
    main_workflow.add_to_leaf(DecideDataTypeList())
    main_workflow.add_to_leaf(TransformTypeForAll())
    main_workflow.add_to_leaf(DecideTrim())
    main_workflow.add_to_leaf(DecideStringUnusualForAll())
    main_workflow.add_to_leaf(CleanUnusualForAll())
    main_workflow.add_to_leaf(WriteStageYMLCode())
    
    return query_widget, main_workflow

class DescribeColumnsList(ListNode):
    default_name = 'Describe Columns'
    default_description = 'This node allows users to describe the columns of a table.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Checking columns ...")
        
        create_progress_bar_with_numbers(1, doc_steps)
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        sample_size = 5
        
        table_summary = self.get_sibling_document("Create Table Summary")
        
        outputs = []
        
        columns = sorted(columns)
        
        for i in range(0, len(columns), 30):
            chunk_columns = columns[i:i + 30]
            sample_df = run_sql_return_df(con, f"SELECT {', '.join(chunk_columns)} FROM {table_pipeline} LIMIT {sample_size}")
            table_desc = sample_df.to_csv(index=False, quoting=2)
            outputs.append((table_desc, table_summary, chunk_columns))
        
        return outputs
    
    def run(self, extract_output, use_cache=True):
        table_desc, table_summary, column_names = extract_output

        template = f"""You have the following table:
{table_desc}

{table_summary}

Task: Describe the columns in the table.

Return in the following format:
```json
{{
    "{column_names[0]}": "Short description in < 10 words",
    ...
}}
```"""

        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        return json_code

    def run_but_fail(self, extract_output, use_cache=True):
        default_response = {column: column for column in extract_output[2]}
        return default_response
    
    
    def merge_run_output(self, run_outputs):
        merged_output = {}
        for run_output in run_outputs:
            merged_output.update(run_output)
        return merged_output
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        json_code = run_output
        
        self.progress.value += 1

        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        schema = table_pipeline.get_final_step().get_schema()

        rows_list = []

        for col in schema:
            rows_list.append({
                "Column": col,
                "Summary": json_code[col],
            })

        df = pd.DataFrame(rows_list)
        
        editable_columns = [False, True]
        grid = create_dataframe_grid(df, editable_columns, reset=True)
        print("😎 We have described the columns:")
        display(grid)

        next_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )  

        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            document = new_df.to_json(orient="split")
            callback(document)

        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
            
            
class DecideMissingList(ListNode):
    default_name = 'Decide Missing Values'
    default_description = 'This node allows users to decide how to handle missing values.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Checking missing values ...")
        create_progress_bar_with_numbers(2, doc_steps)
        
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]
        table_name = table_pipeline.get_final_step().name

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        columns = sorted(columns)
        sample_size = 5
        
        outputs = []
                
        for i in range(0, len(columns), 50):
            chunk_columns = columns[i:i + 50]
            
            missing_columns = {}
            
            for col in chunk_columns:
                missing_percentage = get_missing_percentage(con, table_name, col)
                if missing_percentage > 0:
                    missing_columns[col] = missing_percentage
            
            sample_df = run_sql_return_df(con, f"SELECT {', '.join(chunk_columns)} FROM {table_name} LIMIT {sample_size}")
            sample_df_str = sample_df.to_csv(index=False, quoting=2)
            
            outputs.append((missing_columns, sample_df_str))

        return outputs

    def run(self, extract_output, use_cache=True):
        
        missing_columns, sample_df_str = extract_output
        
        if len(missing_columns) == 0:
            return {"reasoning": "No missing values found.", "columns_obvious_not_applicable": {}}

        missing_desc = "\n".join([f'{idx+1}. {col}: {missing_columns[col]}' for idx, (col, desc) in enumerate(missing_columns.items())])

        template = f"""You have the following table:
{sample_df_str}

The following columns have percentage of missing values:
{missing_desc}

For each column, decide whether there is an obvious reason for the missing values to be "not applicable"
E.g., if the column is 'Date of Death', it is "not applicable" for patients still alive.
Reasons like not not collected, sensitive info, encryted, data corruption, etc. are not considered 'not applicable'.

Return in the following format:
```json
{{
    "reasoning": "X column has an obvious not applicable reason... The rest don't.",
    "columns_obvious_not_applicable": {{
        "column_name": "Short specific reason why not applicable, in < 10 words.",
        ...
    }}
}}
"""
            
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        if not isinstance(json_code, dict) or "reasoning" not in json_code or "columns_obvious_not_applicable" not in json_code:
            raise ValueError("The returned JSON code does not adhere to the required format.")
        
        for col_name in json_code["columns_obvious_not_applicable"]:
            if col_name not in missing_columns:
                raise ValueError(f"The column '{col_name}' specified in 'columns_obvious_not_applicable' is not present in the missing columns.")
            
        return json_code
    
    def merge_run_output(self, run_outputs):
        merged_output = {}
        for run_output in run_outputs:
            merged_output.update(run_output["columns_obvious_not_applicable"])
        return {"columns_obvious_not_applicable": merged_output}
    
    def run_but_fail(self, extract_output, use_cache=True):
        missing_columns, sample_df_str = extract_output
        
        if len(missing_columns) == 0:
            return {"reasoning": "No missing values found. ", "columns_obvious_not_applicable": {}}
        else:
            return {
                "reasoning": "Failed to analyze the data due to an error.",
                "columns_obvious_not_applicable": {}
            }

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        
        self.progress.value += 1
        json_code = run_output
        
        outputs = extract_output
        missing_columns = {}
        
        for output in outputs:
            missing_columns.update(output[0])
        
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))
        
        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)

        rows_list = []
        for col in missing_columns:
            missing_percentage = missing_columns[col]
            reason = json_code["columns_obvious_not_applicable"].get(col, "")
            rows_list.append({
                "Column": col,
                "NULL (%)": f"{missing_percentage*100:.2f}",
                "Is NULL Acceptable?": True if reason != "" else False,
                "Explanation": reason
            })
            
        df = pd.DataFrame(rows_list)
        
        if len(rows_list) == 0:
            df = pd.DataFrame(columns=["Column", "NULL (%)", "Is NULL Acceptable?", "Explanation"])
        else:
            df = pd.DataFrame(rows_list)

        if len(df) == 0:
            callback(df.to_json(orient="split"))
            return
        
        editable_columns = [False, False, True, True]
        grid = create_dataframe_grid(df, editable_columns, reset=True)
        
        print("😎 We have identified missing values, and potential causes:")
        display(grid)
        
        next_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid)
            document = new_df.to_json(orient="split")

            callback(document)
        
        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
            
            
class DecideDataTypeList(ListNode):
    default_name = 'Decide Data Type'
    default_description = 'This node allows users to decide the data type for each column.'

    def extract(self, item):
        clear_output(wait=True)

        print("🔍 Checking data types ...")
        create_progress_bar_with_numbers(2, doc_steps)
        self.progress = show_progress(1)

        self.input_item = item

        con = self.item["con"]
        table_pipeline = self.para["table_pipeline"]

        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        columns = sorted(columns)
        sample_size = 5
        
        database_name = get_database_name(con)
        all_data_types = list(data_types_database[database_name].keys())
        
        outputs = []
                
        for i in range(0, len(columns), 30):
            chunk_columns = columns[i:i + 30]
            sample_df = run_sql_return_df(con, f"SELECT {', '.join(chunk_columns)} FROM {table_pipeline} LIMIT {sample_size}")
            table_desc = sample_df.to_csv(index=False, quoting=2)
            chunk_schema = {col: schema[col] for col in chunk_columns}
            outputs.append((table_desc, all_data_types, database_name, chunk_schema))

        return outputs

    def run(self, extract_output, use_cache=True):
        table_desc, all_data_types, database_name, schema = extract_output

        template = f"""You have the following table:
{table_desc}

For each column, classify what the column type should be.
The column type should be one of the following:
{all_data_types}

Return in the following format:
```json
{{
    "column1": "INT",
    ...
}}
```"""
        
        messages = [{"role": "user", "content": template}]
        response =  call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)

        checks = [
            (lambda jc: isinstance(jc, dict), "The returned JSON code is not a dictionary."),
            (lambda jc: all(col_type in all_data_types for col_type in jc.values()), "The column types are not all strings."),
            (lambda jc: all(col_name in schema for col_name in jc), "One or more column names specified in 'column_type' are not present in the sample DataFrame."),
        ]

        for check, error_message in checks:
            if not check(json_code):
                raise ValueError(f"Validation failed: {error_message}")
            
        return json_code
    
    def merge_run_output(self, run_outputs):
        merged_output = {}
        for run_output in run_outputs:
            merged_output.update(run_output)
        return merged_output
    
    def run_but_fail(self, extract_output, use_cache=True):
        _, _, database_name, schema = extract_output
        return {"column_type": {col: get_reverse_type(schema[col], database_name) for col in schema}}

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        if icon_import:
            display(HTML('''<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> '''))

        json_code = run_output
        _, all_data_types, database_name, _ = extract_output[0]
        
        schema = {}
        outputs = extract_output
        for output in outputs:
            schema.update(output[3])
        
        self.progress.value += 1
        table_pipeline = self.para["table_pipeline"]
        query_widget = self.item["query_widget"]

        create_explore_button(query_widget, table_pipeline)
        

        rows_list = []

        for col in schema:
            current_type = get_reverse_type(schema[col], database_name)
            target_type = json_code[col]

            rows_list.append({
                "column_name": col,
                "current_type": current_type,
                "target_type": target_type,
            })

        df = pd.DataFrame(rows_list)
        
        grid = create_data_type_grid(df, all_data_types = all_data_types)
        print("😎 We have recommended the Data Types for Columns:")
        display(grid)

        next_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )  

        def on_button_clicked(b):
            clear_output(wait=True)
            df = extract_grid_data_type(grid)
            
            callback(df.to_json(orient="split"))

        next_button.on_click(on_button_clicked)

        display(next_button)
        
        if self.viewer:
            on_button_clicked(next_button)
            

def create_cocoon_table_transform_workflow(con, query_widget=None, viewer=True):
    if query_widget is None:
        query_widget = QueryWidget(con)

    item = {
        "con": con,
        "query_widget": query_widget
    }

    main_workflow = Workflow("Single Table Transformation Workflow", 
                            item = item, 
                            description="A workflow to transform a table into another table")

    main_workflow.add_to_leaf(SelectSourceTargetTable())
    main_workflow.add_to_leaf(CreateShortSourceTableSummary())
    main_workflow.add_to_leaf(CreateShortTargetTableSummary())
    main_workflow.add_to_leaf(UnderstandSourceToTargetTransform())
    main_workflow.add_to_leaf(WriteCode())
    main_workflow.add_to_leaf(DebugCode())
        
    return query_widget, main_workflow

def create_cocoon_profile_workflow(con, query_widget=None, viewer=False):
    if query_widget is None:
        query_widget = QueryWidget(con)

    item = {
        "con": con,
        "query_widget": query_widget
    }

    main_workflow = Workflow("Data Profiling Workflow", 
                            item = item, 
                            description="A workflow to profile dataset",
                            viewer=viewer,
                            para = {})

    main_workflow.add_to_leaf(SelectTable())
    main_workflow.add_to_leaf(DecideProjection())
    main_workflow.add_to_leaf(DecideDuplicate())
    main_workflow.add_to_leaf(CreateTableSummary())
    main_workflow.add_to_leaf(DescribeColumns())
    main_workflow.add_to_leaf(CreateColumnGrouping())
    main_workflow.add_to_leaf(DecideDataType())
    main_workflow.add_to_leaf(DecideMissing())
    main_workflow.add_to_leaf(DecideUnique())
    main_workflow.add_to_leaf(DecideUnusualForAll())
    main_workflow.add_to_leaf(DecideColumnRange())
    main_workflow.add_to_leaf(DecideLongitudeLatitude())
    main_workflow.add_to_leaf(GenerateReport())
    
    return query_widget, main_workflow

def create_cocoon_dbt_explore_workflow():
    main_workflow = Workflow("DBT Project Explore Workflow", 
                         item = {},
                        description="A workflow to explore a DBT project ")

    main_workflow.add_to_leaf(SpecifyDirectory())
    main_workflow.add_to_leaf(ProcessDirectory())
    main_workflow.add_to_leaf(TagTableForAll())
    main_workflow.add_to_leaf(InputRelationshipForAll())
    main_workflow.add_to_leaf(BuildFinalLineage())
    
    return main_workflow


class CocoonBranchStep(Node):
    default_name = 'Product Steps'
    default_description = 'This is typically the dicussion result from business analysts and engineers'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)

        header_html = f'''
<div style="display: flex; align-items: center;">
<img src="data:image/png;base64,{cocoon_icon_64}" alt="cocoon icon" width=50 style="margin-right: 10px;">
<div style="margin: 0; padding: 0;">
<h1 style="margin: 0; padding: 0;">Cocoon</h1>
<p style="margin: 0; padding: 0;">Use LLMs to augment data tasks.</p>
</div>
</div><hr>
🤓 Please select the data task:
'''

        display(HTML(header_html))
        
        html_labels = [
            "🧹 <b>Stage:</b> Give us a table, we'll clean it and document your source table in DBT SQL/YAML files.",
            "🔍 <b>Profile:</b> Give us a table, we'll understand your table and identify anomalies. The output is an HTML profile.",
            "🔗 <b>(Preview) Fuzzy Join:</b> Give us two tables, we'll fuzzily match them and explain the relation. The output is an HTML report.",
            "🔧 <b>(Preview) Fuzzy Union/ Table Transform:</b> Give us a source and target table, we will transform/fuzzy union them.",
            "👓 <b>(Preview) Explore DBT:</b> Give us a DBT project directory, we'll visualize the lineage and interpret each model.",
        ]
        
        next_nodes = [
            "Data Stage Workflow",
            "Data Profiling Workflow",
            "Fuzzy Join Workflow",
            "Single Table Transformation Workflow",
            "DBT Project Explore Workflow",
        ]

        radio_buttons_widget, checkboxes = create_html_radio_buttons(html_labels)

        display(radio_buttons_widget)

        next_button = widgets.Button(description="Start", button_style='success')
        
        def on_button_click(b):
            selected_index = get_selected_index(checkboxes)
            callback({"next_node": next_nodes[selected_index]})

        next_button.on_click(on_button_click)
        display(next_button)
        
def create_cocoon_workflow(con):
    
    item = {}
    query_widget = None
    
    if con is not None:
        query_widget = QueryWidget(con)
        item["con"] = con
        item["query_widget"] = query_widget

    main_workflow = Workflow("Cocoon Workflow", 
                            item = item, 
                            description="This is the main workflow for the Cocoon tool.")
    
    branch_node = CocoonBranchStep()
    main_workflow.add_to_leaf(branch_node)
    

    _, stage_workflow = create_cocoon_stage_workflow(con=con, query_widget=query_widget)
    _, profile_workflow = create_cocoon_profile_workflow(con=con, query_widget=query_widget)
    _, fuzzy_join_workflow = create_matching_workflow(con=con, query_widget=query_widget)    
    dbt_explore_workflow = create_cocoon_dbt_explore_workflow()
    _, table_transform_workflow = create_cocoon_table_transform_workflow(con=con, query_widget=query_widget)
    
    main_workflow.register(stage_workflow, parent=branch_node)
    main_workflow.register(profile_workflow, parent=branch_node)
    main_workflow.register(fuzzy_join_workflow, parent=branch_node)
    main_workflow.register(dbt_explore_workflow, parent=branch_node)
    main_workflow.register(table_transform_workflow, parent=branch_node)
    
    return query_widget, main_workflow

def get_columns_pattern(columns, use_cache=True):
    template = f"""You have the following columns:
{columns}

Are there column groups that:
1. Column names follow the same pattern, but have varying *numbers*, that can be expressed by regular expression pattern with \d. 
2. Is large with > 10 columns
E.g., columns "year_1", "year_2", ... follow the pattern: ^year_\d+$

Return the result in yml
```yml
reasoning: |
    The columns follow ... They have varying numbers...

patterns:
    - ^year_\d+$
    - ...
```"""

    messages = [{"role": "user", "content": template}]
    response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
    messages.append(response['choices'][0]['message'])
    yml_code = extract_yml_code(response['choices'][0]['message']["content"])
    summary = yaml.safe_load(yml_code)
    return summary


class DecideColumnsPattern(Node):
    default_name = 'Decide Columns Pattern'
    default_description = 'This node allows users to decide the columns pattern.'

    def extract(self, item):
        clear_output(wait=True)
        print("🔍 Analyzing columns ...")
        create_progress_bar_with_numbers(2, doc_steps)
        
        self.progress = show_progress(1)

        table_pipeline = self.para["table_pipeline"]
        schema = table_pipeline.get_final_step().get_schema()
        columns = list(schema.keys())
        columns = sorted(columns)
        
        return columns
    
    def run(self, extract_output, use_cache=True):
        columns = extract_output
        
        if len(columns) <= 50:
            return {}
        
        print(f"😲 Your table has {len(columns)} columns!")
        print(f"🧐 Don't worry! We will find if there are some patterns!")
        
        columns = sorted(columns)

        start = 0
        column_group = {}

        def get_columns(pattern, columns):
            return [col for col in columns if re.match(pattern, col)]

        use_cache = True

        while start < len(columns):
            
            
            summary = get_columns_pattern(columns[start:start+50], use_cache) 
            use_cache = True
            
            if len(summary["patterns"]) > 0:
                for pattern in summary["patterns"]:
                    fitted_columns = get_columns(pattern, columns)
                    if len(fitted_columns) > 0:
                        column_group[pattern] = fitted_columns
                        columns = [col for col in columns if col not in fitted_columns]
                        use_cache = True
                    else:
                        use_cache = False 
                    
            else:
                start += 50
                
        return column_group
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        
        self.progress.value += 1
        
        column_group = run_output
        columns = extract_output
        
        if not column_group:
            callback(column_group)
            return
        
        df_group = pd.DataFrame(column_group.items(), columns=["Pattern", "Columns"])
        df_group["Remove?"] = True
        editable_columns = [False, True, True]
        grid = create_dataframe_grid(df_group, editable_columns, reset=True, lists=['Columns'])

        print("😎 We have identified column groups with the same pattern:")
        print("Cocoon currently struggles with wide tables. We recommend removing them.")
        display(grid)
        
        def on_button_clicked(b):
            new_df =  grid_to_updated_dataframe(grid, lists=["Columns"])
            table_pipeline = self.para["table_pipeline"]
            con = self.item["con"]
            
            columns_to_remove = []
            for index, row in new_df.iterrows():
                if row["Remove?"]:
                    columns_to_remove.extend(row["Columns"])
            
            if len(columns_to_remove) > 0:
                new_table_name = f"{table_pipeline}_removeWideColumns"
                selected_columns = [col for col in columns if col not in columns_to_remove] 
            
                selection_clause = ',\n'.join(selected_columns)
                sql_query = f"SELECT \n{indent_paragraph(selection_clause)}\nFROM {table_pipeline}"
                
                comment = "-- Remove wide columns with pattern. The regex and columns are:\n"
                for index, row in new_df.iterrows():
                    if row["Remove?"]:
                        if len(row["Columns"]) > 10:
                            comment += f"-- {row['Pattern']}: {', '.join(row['Columns'][0:10])} ...\n"
                        else:
                            comment += f"-- {row['Pattern']}: {', '.join(row['Columns'])}\n"
                
                sql_query = f"{comment}{sql_query}"
                
                step = SQLStep(table_name=new_table_name, sql_code=sql_query, con=con)
                step.run_codes()
                table_pipeline.add_step_to_final(step)
                
            document = new_df.to_json(orient="split")

            callback(document)
        
        next_button = widgets.Button(
            description='Submit',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
            icon='check'
        )
        
        next_button.on_click(on_button_clicked)
        
        display(next_button)

class SpecifyDirectory(Node):
    default_name = 'Specify Directory'
    default_description = 'This step allows you to specify the directory.'

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        
        print(f"🧐 Please specify the directory:")
        
        directory_widget = widgets.Text(value='', placeholder='Please provide the directory', disabled=False)
        
        next_button = widgets.Button(description="Next", button_style='success')

        def on_button_click(b):
            directory = directory_widget.value
            
            if not os.path.exists(directory):
                print(f"❌ The directory {directory} does not exist.")
                return
            
            callback({"directory": directory})
                
        next_button.on_click(on_button_click)
        display(directory_widget, next_button)
        
class ProcessDirectory(Node):
    default_name = 'Process Directory'
    default_description = 'This step processes the directory.'

    def extract(self, item):
        directory = self.get_sibling_document('Specify Directory')["directory"]
        
        print(f"🚀 Processing the directory: {directory}")
        
        dbt_project = DbtProject()
        dbt_project.process_dbt_files(directory)
        
        self.item["dbt_project"] = dbt_project
        
        return dbt_project
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)
        
        dbt_project = extract_output
        
        print(f"🚀 The directory has been processed successfully. We've found {len(dbt_project.tables)} tables")
        
        tables = dbt_project.tables.keys()
        
        table_widget = widgets.Dropdown(options=tables, disabled=False)
        display(table_widget)
        
        print("🧐 Next, we will understand these tables!")
        
        next_button = widgets.Button(description="Next", button_style='success')
        next_button.on_click(lambda b: callback({}))
        display(next_button)

                
class TagTableForAll(MultipleNode):
    default_name = 'Tag Table For All'
    default_description = 'This node tags all the table.'
    
    def construct_node(self, element_name, idx=0, total=0):
        para = self.para.copy()
        para["table_name"] = element_name
        para["table_idx"] = idx
        para["total_tables"] = total
        node = TagTable(para=para, id_para="table_name")
        node.inherit(self)
        return node
    
    def extract(self, item):
        tables = list(self.item["dbt_project"].tables.keys())
        self.elements = tables
        total = len(tables)
        self.nodes =  {table_name: self.construct_node(table_name, idx, total) for idx, table_name in enumerate(tables)}
                                            

class TagTable(Node):
    default_name = 'Tag Table'
    default_description = 'This node tags the table.'

    def extract(self, item):
        table_name = self.para["table_name"]
        dbt_project = self.item["dbt_project"]
        
        clear_output(wait=True)
        print("🔍 Tagging table:", table_name)
        
        idx = self.para["table_idx"]
        total = self.para["total_tables"]
        show_progress(max_value=total, value=idx)
        
        sql_query = dbt_project.tables[table_name].sql_query

        return sql_query
    
    def run(self, extract_output, use_cache=True):
        
        sql_query = extract_output
        
        if sql_query is  None or sql_query == "":
            return {"Filtering": {"Reasoning": "No SQL query found", "Label": False},
                    "Cleaning": {"Reasoning": "No SQL query found", "Label": False},
                    "Featurization": {"Reasoning": "No SQL query found", "Label": False},
                    "Integration": {"Reasoning": "No SQL query found", "Label": False},
                    "Other": {"Reasoning": "No SQL query found", "Label": False}}
        
        template = f"""## SQL query
{sql_query}

## Label the dbt script.
1. Filtering: the script selects (or semi-join) the table based on some criteria. 
2. Cleaning: the script deduplicate the table, or clean the existing columns by, e.g., trim, standardizing, formating...
3. Featurization: the script extract new features from the existing columns. E.g., the script extracts whether weekend/weekday from date, or aggregate the table
4. Integration: the script join and union tables to integrate information. Note that semi-join is not considered as integration
5. Other: there is other significant tasks performed beyond the above.

## Return a json:
```json
{{
	"Filtering": {{
		"Reasoning": …
		"Label": true/false
    }},
    ...
}}
```
"""
        
        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)
        
        def verify_json_result(json_code):
            expected_labels = ['Filtering', 'Cleaning', 'Featurization', 'Integration', 'Other']

            if not isinstance(json_code, dict):
                raise ValueError("JSON code should be a dictionary.")

            for label in expected_labels:
                if label not in json_code:
                    raise ValueError(f"Key '{label}' is missing.")

                if not isinstance(json_code[label], dict):
                    raise ValueError(f"'{label}' should be a dictionary.")

                if 'Reasoning' not in json_code[label] or 'Label' not in json_code[label]:
                    raise ValueError(f"'{label}' must contain 'Reasoning' and 'Label' keys.")

                if not isinstance(json_code[label]['Label'], bool):
                    raise ValueError(f"'Label' under '{label}' should be a boolean.")


            return True

        verify_json_result(json_code)
        return json_code
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {"Filtering": {"Reasoning": "Failed", "Label": False},
                    "Cleaning": {"Reasoning": "Failed", "Label": False},
                    "Featurization": {"Reasoning": "Failed", "Label": False},
                    "Integration": {"Reasoning": "Failed", "Label": False},
                    "Other": {"Reasoning": "Failed", "Label": False}}
        
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        return callback(run_output)
    

class InputRelationshipForAll(MultipleNode):
    default_name = 'Input Relationship For All'
    default_description = 'This node tags all the table.'        
        
    def construct_node(self, element_name, tags = {}, idx=0, total=0):
        para = self.para.copy()
        para["table_name"] = element_name
        para["table_idx"] = idx
        para["tags"] = tags
        para["total_tables"] = total
        node = InputRelationship(para=para, id_para="table_name")
        node.inherit(self)
        return node
    
    def extract(self, item):
        tables = list(self.item["dbt_project"].tables.keys())
        self.elements = tables
        total = len(tables)
        tag_map = self.get_sibling_document('Tag Table For All')['Tag Table']
        self.nodes =  {table_name: self.construct_node(table_name, tag_map[table_name], idx, total) for idx, table_name in enumerate(tables)}
                                     
        
class InputRelationship(Node):
    default_name = 'Input Relationship'
    default_description = 'This node understands the input relationship.'

    def extract(self, item):
        table_name = self.para["table_name"]
        dbt_project = self.item["dbt_project"]
        
        clear_output(wait=True)
        print("🔍 Understanding table relationship...")
        
        idx = self.para["table_idx"]
        total = self.para["total_tables"]
        show_progress(max_value=total, value=idx)
        
        sql_query = dbt_project.tables[table_name].sql_query
        input_tables = dbt_project.tables[table_name].referenced_models + dbt_project.tables[table_name].referenced_sources
        input_tables = sorted(input_tables) 
        tags = self.para["tags"]
        
        return sql_query, input_tables, tags
    
    def run(self, extract_output, use_cache=True):
        sql_query, input_tables, tags = extract_output
        
        if sql_query is  None or sql_query == "":
            return {}
        
        purpose_summary = ""
        for key, value in tags.items():
            if value["Label"] == True:
                purpose_summary += f"{key}: {value['Reasoning']}\n"

        output_format = ""
        for input_table in input_tables:
            output_format += f"    \"{input_table}\": \"...\",\n"
        output_format = output_format[:-2]
        
        template = f"""## SQL query
{sql_query}

## SQL query purpose
{purpose_summary}

## Given the SQL query, summarize how each input table is used:
E.g., table A is the main table, table B is to enrich table A, table C is to filter table A, etc.

## Return a json:
```json
{{
{output_format}
}}
```
"""
        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1, use_cache=use_cache)
        messages.append(response['choices'][0]['message'])
        self.messages = messages
        processed_string  = extract_json_code_safe(response['choices'][0]['message']['content'])
        json_code = json.loads(processed_string)
        
        def verify_json_result(json_code):
            for input_table in input_tables:
                if input_table not in json_code:
                    raise ValueError(f"Table {input_table} is not in the json code.")
        
        verify_json_result(json_code)
        return json_code
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {}
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        return callback(run_output)

class BuildFinalLineage(Node):
    default_name = 'Build Final Lineage'
    default_description = 'This node builds the final lineage.'

    def extract(self, item):
        
        clear_output(wait=True)
        print("🚀 Your DBT project has been analyzed:")
        dbt_project = self.item["dbt_project"]
        
        tag_json = self.get_sibling_document('Tag Table For All')['Tag Table']
        for table_name in tag_json:
            dbt_project.tables[table_name].add_tag_result(tag_json[table_name])
            
        source_purpose_json = self.get_sibling_document('Input Relationship For All')['Input Relationship']
        for table_name in source_purpose_json:
            dbt_project.tables[table_name].add_source_purpose(source_purpose_json[table_name])
            
        dbt_project.update_tagged_names()

        dbt_project.display()
        return 
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        pass
    
    
class SelectSourceTargetTable(Node):
    default_name = 'Select Source and Target Table'
    default_description = 'This step allows you to select the source and target table for the transformation.'
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        clear_output(wait=True)

        con = self.input_item["con"]
        query_widget = self.item["query_widget"]
        
        tables = get_table_names(con)
        
        header_html = f'<div style="display: flex; align-items: center;">' \
            f'<img src="data:image/png;base64,{cocoon_icon_64}" alt="cocoon icon" width=50 style="margin-right: 10px;">' \
            f'<div style="margin: 0; padding: 0;">' \
            f'<h1 style="margin: 0; padding: 0;">Cocoon</h1>' \
            f'<p style="margin: 0; padding: 0;">Table Transformation</p>' \
            f'</div>' \
            f'</div><hr>'

        display(HTML(header_html))

        html_content = f"""🧐 There are {len(tables)} tables in your database.<br>
🤓 Please select the <b>Source</b> and <b>Target</b> tables.<br>
We will transform the Source table to the Target table.<br>
<b>Source Table:</b>"""
        display(HTML(html_content))
        dropdown_source = create_explore_button(query_widget, table_name=tables)
        display(HTML("<b>Target Table:</b>"))
        dropdown_target = create_explore_button(query_widget, table_name=tables)

        next_button = widgets.Button(description="Next", button_style='success')

        def on_button_click(b):
            source_table = dropdown_source.value
            target_table = dropdown_target.value
            
            if source_table == target_table:
                print("❌ Source and target tables cannot be the same.")
                return
            
            selected_tables = {"source_table": source_table, "target_table": target_table}
            callback(selected_tables)
                
        next_button.on_click(on_button_click)
        display(next_button)
        
class CreateShortSourceTableSummary(CreateShortTableSummary):
    default_name = 'Create Short Source Table Summary'
    default_description = 'Create a short summary of the source table'
    
    def extract(self, input_item):
        clear_output(wait=True)

        print("📝 Generating table summary ...")
    
        self.progress = show_progress(1)

        con = self.item["con"]
        source_table = self.get_sibling_document('Select Source and Target Table')["source_table"]
        sample_size = 5

        sample_df = run_sql_return_df(con, f"SELECT * FROM {source_table} LIMIT {sample_size}")
        table_desc = sample_df.to_csv(index=False, quoting=2)
        
        self.sample_df = sample_df

        return source_table, table_desc
    
class CreateShortTargetTableSummary(CreateShortTableSummary):
    default_name = 'Create Short Target Table Summary'
    default_description = 'Create a short summary of the target table'
    
    def extract(self, input_item):
        clear_output(wait=True)

        print("📝 Generating table summary ...")
    
        self.progress = show_progress(1)

        con = self.item["con"]
        target_table = self.get_sibling_document('Select Source and Target Table')["target_table"]
        sample_size = 5

        sample_df = run_sql_return_df(con, f"SELECT * FROM {target_table} LIMIT {sample_size}")
        table_desc = sample_df.to_csv(index=False, quoting=2)

        self.sample_df = sample_df

        return target_table, table_desc
    
    
class UnderstandSourceToTargetTransform(Node):
    default_name = 'Understand Source to Target Transform'
    default_description = 'Understand the transformation from source to target table'
    
    def extract(self, item):
        clear_output(wait=True)
        print("🔍 Verifying the target table...")
        self.progress = show_progress(1)
        
        self.item = item
        con = self.item["con"]
        
        source_table = self.get_sibling_document('Select Source and Target Table')["source_table"]
        target_table = self.get_sibling_document('Select Source and Target Table')["target_table"]
        
        source_table_summary = self.get_sibling_document('Create Short Source Table Summary')
        target_table_summary = self.get_sibling_document('Create Short Target Table Summary')
        
        sample_size = 5

        source_sample_df = run_sql_return_df(con, f"SELECT * FROM {source_table} LIMIT {sample_size}")
        source_table_desc = source_sample_df.to_csv(index=False, quoting=2)
        
        target_sample_df = run_sql_return_df(con, f"SELECT * FROM {target_table} LIMIT {sample_size}")
        target_table_desc = target_sample_df.to_csv(index=False, quoting=2)
        
        return source_table_desc, source_table_summary, target_table_desc, target_table_summary
    
    def run(self, extract_output, use_cache=True):
        source_table_sample, source_table_description, target_table_sample, target_table_description = extract_output
        
        template = f"""You have a source table: {source_table_description}
{source_table_sample}

And target table: {target_table_description}
{target_table_sample}

Now, verify if any of the target table columns can be derived from source table through SQL. 
If so, describe the detailed SQL clause.
Respond in the following json:
```json
{{  
    "reasoning": "The transformation is (not) possible through SQL for any column. For X column in the target is semantically the same as column Y in the source. So we can tranformed through a mapping/string manipulation/math calculation...",
    "transformable": true/false,
}}
"""

        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)
        assistant_message = response['choices'][0]['message']
        messages.append(assistant_message)
        self.messages = messages
        
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        summry = json.loads(json_code)
        
        return summry
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {"reasoning": "There is some issue with this transformation", "transformable": False}
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        self.progress.value += 1
        
        summary = run_output
        if summary["transformable"]:
            print("✔️ The transformation is possible through SQL.")
        else:
            print("❌ The transformation doesn't seem to be possible through SQL.")
            print("Please edit below to provide more information.")

        text_area, char_count_label = create_text_area_with_char_count(summary['reasoning'], max_chars=1000)
        display(VBox([text_area, char_count_label]))
        
        next_button = widgets.Button(
            description='Next',
            disabled=False,
            button_style='success',
            tooltip='Click to submit',
        )
        
        def on_next_button_clicked(b):
            clear_output(wait=True)
            reason = text_area.value
            callback(reason)
        
        next_button.on_click(on_next_button_clicked)
        display(next_button)
        
        
class WriteCode(Node):
    default_name = 'Write Code'
    default_description = 'Write code for table transformation'

    def extract(self, input_item):
        
        print("💻 Writing the codes...")
        self.progress = show_progress(1)
        con = self.item["con"]
        
        source_table = self.get_sibling_document('Select Source and Target Table')["source_table"]
        target_table = self.get_sibling_document('Select Source and Target Table')["target_table"]
        
        sample_size = 5

        source_sample_df = run_sql_return_df(con, f"SELECT * FROM {source_table} LIMIT {sample_size}")
        source_table_desc = source_sample_df.to_csv(index=False, quoting=2)
        
        target_sample_df = run_sql_return_df(con, f"SELECT * FROM {target_table} LIMIT {sample_size}")
        target_table_desc = target_sample_df.to_csv(index=False, quoting=2)
        
        transformation_reasoning = self.get_sibling_document('Understand Source to Target Transform')
        
        return source_table_desc, target_table_desc, transformation_reasoning
    
    def run(self, extract_output, use_cache=True):
        source_table_sample, target_table_sample, transformation_reasoning = extract_output
        
        template = f"""You have a source table: 
{source_table_sample}
        
And target table:
{target_table_sample}

{transformation_reasoning}

Now, write the SQL clause to transform the source table to the target table.

SELECT {{need_distinct}} {{selection_clause}}
FROM source_table
WHERE {{condition_clause}}
GROUP BY {{group_by_clause}}
HAVING {{having_clause}}

Respond in the following json:
```json
{{  
    "reasoning": "To transform, we (don't) need aggregation. We select ...",
    "need_aggregation": true/false,
    "need_distinct": true/false,
    "selection_clause": "A as A, B as B, ...", # ignore not transformable columns
    "condition_clause": "A > 10 AND B < 20", # "" if no condition
    "group_by_clause": "A, B",  # "" if no group by
    "having_clause": "COUNT(*) > 1" # "" if no having
}}
"""

        messages = [{"role": "user", "content": template}]
        response = call_llm_chat(messages, temperature=0.1, top_p=0.1)
        
        assistant_message = response['choices'][0]['message']
        messages.append(assistant_message)
        self.messages = messages
        
        json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
        summry = json.loads(json_code)

        
        return summry
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {"reasoning": "There is some issue with this transformation", 
                "need_aggregation": False,
                "need_distinct": False,
                "selection_clause": "*",
                "condition_clause": "",
                "group_by_clause": "",
                "having_clause": ""
          }
        
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        callback(run_output)

class DebugCode(Node):
    default_name = 'Debug Code'
    default_description = 'Debug the code'

    def extract(self, input_item):
        clear_output(wait=True)
        
        display("🐞 Debugging the code...")
        self.progress = show_progress(1)
        
        con = self.item["con"]
        source_table = self.get_sibling_document('Select Source and Target Table')["source_table"]
        code_clauses = self.get_sibling_document("Write Code")
        
        code_clauses = code_clauses.copy()
        
        return con, code_clauses, source_table
    
    def run(self, extract_output, use_cache=True):
        
        con, code_clauses, table_pipeline = extract_output
        max_iterations = 10
        self.messages = []
        
        for i in range(max_iterations):
            try:
                sql = f"""SELECT {code_clauses['selection_clause']}
FROM {table_pipeline}
{'WHERE ' + code_clauses['condition_clause'] if code_clauses['condition_clause'] else ''}
{'' if not code_clauses['group_by_clause'] else 'GROUP BY ' + code_clauses['group_by_clause']}
{'' if not code_clauses['having_clause'] else 'HAVING ' + code_clauses['having_clause']}"""
                df = run_sql_return_df(con, sql)
                code_clauses["output_columns"] = list(df.columns)
                break
            except Exception: 
                detailed_error_info = get_detailed_error_info()
                json_template =""
                if "condition_clause" in code_clauses and code_clauses["condition_clause"]:
                    json_template += f',\n    "condition_clause": "{code_clauses["condition_clause"]}"'
                if "group_by_clause" in code_clauses and code_clauses["group_by_clause"]:
                    json_template += f',\n    "group_by_clause": "{code_clauses["group_by_clause"]}"'
                if "having_clause" in code_clauses and code_clauses["having_clause"]:
                    json_template += f',\n    "having_clause": "{code_clauses["having_clause"]}"'
                template = f"""You have the following SQL:
{sql}
It has an error: {detailed_error_info}

Please correct the SQL, but don't change the logic. Respond in the following json:
```json
{{  
    "reasoning": "The error is caused by ...",
    "selection_clause": "{code_clauses['selection_clause']}" (correct it){json_template}
}}
"""

                messages = [{"role": "user", "content": template}]
                response = call_llm_chat(messages, temperature=0.1, top_p=0.1)
                
                json_code = extract_json_code_safe(response['choices'][0]['message']['content'])
                summry = json.loads(json_code)
                
                assistant_message = response['choices'][0]['message']
                messages.append(assistant_message)
                self.messages.append(messages)
                
                if "selection_clause" in summry:
                    code_clauses["selection_clause"] = summry["selection_clause"]
                if "condition_clause" in summry:
                    code_clauses["condition_clause"] = summry["condition_clause"]
                if "group_by_clause" in summry:
                    code_clauses["group_by_clause"] = summry["group_by_clause"]
                if "having_clause" in summry:
                    code_clauses["having_clause"] = summry["having_clause"]
                    
        return code_clauses
    
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        
        print("🎉 We have finished the coding!")
        
        _, _, source_table = extract_output
        
        formatter = HtmlFormatter(style='default')
        css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"
        border_style = """
        <style>
        .border-class {
            border: 1px solid black;
            padding: 10px;
            margin: 10px;
        }
        </style>
        """
        combined_css = css_style + border_style
        
        selection_clause = ',\n'.join(run_output['selection_clause'].split(','))
        
        sql_query = f"""SELECT 
{indent_paragraph(selection_clause)}
FROM {source_table}
{'WHERE ' + run_output['condition_clause'] if run_output['condition_clause'] else ''}
{'' if not run_output['group_by_clause'] else 'GROUP BY ' + run_output['group_by_clause']} 
{'' if not run_output['having_clause'] else 'HAVING ' + run_output['having_clause']}"""

        highlighted_sql = wrap_in_scrollable_div(highlight(sql_query, SqlLexer(), formatter))
        bordered_content = f'<div class="border-class">{highlighted_sql}</div>'
        display(HTML(combined_css + bordered_content))
        
        test_button = widgets.Button(
            description='Test Transform',
            disabled=False,
            button_style='info',
            tooltip='Click to test',
            icon='play'
        )
        query_widget = self.item["query_widget"]
        def on_button_clicked(b):
            query_widget.run_query(sql_query)
            print("😎 Query submitted. Check out the data widget!")
        
        test_button.on_click(on_button_clicked)
        print("🧪 Please test the cast and ensure the result is as expected.")
        display(test_button)
        
        
        
        
        
             