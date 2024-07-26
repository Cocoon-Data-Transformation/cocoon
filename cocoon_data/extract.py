import re
import yaml
from collections import OrderedDict
from collections import defaultdict
import json
import os

def extract_json_code_safe(s):
    s_stripped = s.strip()
    if (s_stripped.startswith('{') and s_stripped.endswith('}')) or \
       (s_stripped.startswith('[') and s_stripped.endswith(']')):
        return s_stripped

    json_code =  extract_json_code(s_stripped)

    if json_code is not None:
        return json_code

    start_brace = s_stripped.find('{')
    start_bracket = s_stripped.find('[')
    start_index = start_brace if start_bracket == -1 else (start_bracket if start_brace == -1 else min(start_brace, start_bracket))

    if start_index == -1:
        return None

    end_brace = s_stripped.rfind('}')
    end_bracket = s_stripped.rfind(']')
    end_index = end_brace if end_bracket == -1 else (end_bracket if end_brace == -1 else max(end_brace, end_bracket))

    if end_index == -1:
        return None

    potential_json = s_stripped[start_index:end_index + 1]
    return potential_json

def extract_json_code(s):
    import re
    pattern = r"```json(.*?)```"
    match = re.search(pattern, s, re.DOTALL)
    return match.group(1).strip() if match else None

def extract_python_code(s):
    import re
    pattern = r"```python(.*?)```"
    match = re.search(pattern, s, re.DOTALL)
    return match.group(1).strip() if match else None


def extract_yml_code(s):
    import re
    pattern = r"```yml(.*?)```"
    match = re.search(pattern, s, re.DOTALL)
    return match.group(1).strip() if match else None


def represent_ordereddict(dumper, data):
    value = []
    for item_key, item_value in data.items():
        node_key = dumper.represent_data(item_key)
        node_value = dumper.represent_data(item_value)
        value.append((node_key, node_value))
    return yaml.nodes.MappingNode(u'tag:yaml.org,2002:map', value)


yaml.add_representer(OrderedDict, represent_ordereddict)




def custom_constructor(loader, node):
    value = loader.construct_scalar(node)
    if value in ['true', 'True', 'TRUE']:
        return True
    elif value in ['false', 'False', 'FALSE']:
        return False
    return str(value)

yaml.SafeLoader.add_constructor('tag:yaml.org,2002:bool', custom_constructor)
yaml.SafeLoader.add_constructor('tag:yaml.org,2002:str', custom_constructor)





def is_test_node(node_id, node_info):
    return node_info.get('resource_type') == 'test'

def build_lineage_graph(dbt_path, manifest_path=None, catalog_path=None):
    if manifest_path is None:
        manifest_path = os.path.join(dbt_path, 'target', 'manifest.json')
    if catalog_path is None:
        catalog_path = os.path.join(dbt_path, 'target', 'catalog.json')
    
    if not os.path.exists(manifest_path):
        raise FileNotFoundError(f"Manifest file not found at {manifest_path}. Please specify the path to the manifest file using the 'manifest_path' argument.")
    if not os.path.exists(catalog_path):
        raise FileNotFoundError(f"Catalog file not found at {catalog_path}. Please specify the path to the catalog file using the 'catalog_path' argument.")

    with open(manifest_path, 'r') as f:
        manifest = json.load(f)
    
    with open(catalog_path, 'r') as f:
        catalog = json.load(f)
    
    nodes = set()
    dependencies = defaultdict(set)
    sql_content_mapping = {}
    column_mapping = {}
    
    for node_id, node_info in manifest['nodes'].items():
        if not is_test_node(node_id, node_info):
            nodes.add(node_id)
            
            compiled_path = node_info.get('compiled_path')
            if compiled_path:
                full_sql_path = os.path.join(dbt_path, compiled_path)
                if os.path.exists(full_sql_path):
                    try:
                        with open(full_sql_path, 'r') as sql_file:
                            sql_content = sql_file.read()
                        sql_content_mapping[node_id] = sql_content
                    except Exception as e:
                        print(f"Error reading SQL file for {node_id}: {str(e)}")
                else:
                    print(f"Compiled SQL file not found at {full_sql_path}")
            
            if node_id in catalog['nodes']:
                column_mapping[node_id] = catalog['nodes'][node_id]['columns']
            else:
                print(f"Node {node_id} not found in catalog")
            
            if 'depends_on' in node_info and 'nodes' in node_info['depends_on']:
                for dep in node_info['depends_on']['nodes']:
                    dep_info = manifest['nodes'].get(dep, {})
                    if not is_test_node(dep, dep_info):
                        dependencies[node_id].add(dep)
                        nodes.add(dep)
    
    nodes_list = sorted(list(nodes))
    node_to_index = {node: index for index, node in enumerate(nodes_list)}
    
    edges = []
    for node, deps in dependencies.items():
        for dep in deps:
            edges.append((node_to_index[dep], node_to_index[node]))
    
    return nodes_list, edges, sql_content_mapping, column_mapping




