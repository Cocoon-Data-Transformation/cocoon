from contextlib import contextmanager
from functools import partial
import time

from .viz import *
from .widgets import *
from .utils import *

def render_json_in_iframe_with_max_height(json_data, max_height=200):
    def default_serializer(obj):
        if isinstance(obj, np.integer):
            return int(obj)
        raise TypeError(f"Object of type {obj.__class__.__name__} is not JSON serializable")

    try:
        json_str = json.dumps(json_data, default=default_serializer, indent=2)
    except Exception as e:
        json_str = f"Error: {str(e)}"
     
        
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



def replace_keys_and_values_with_index(nodes, edges):
    node_index = {node: index for index, node in enumerate(nodes)}
    updated_edges = {node_index[node]: [node_index[edge] for edge in edges[node]] for node in edges}
    return updated_edges






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

    def __init__(self, name=None, description=None, viewer=False, item=None, 
                 para=None, output=None, id_para="element_name", class_para = {}):
        self.name = name if name is not None else self.default_name
        self.description = description if description is not None else self.default_description

        self.para = para if para is not None else {}
        self.item = item
        self.viewer = viewer

        self.nodes = {self.name: self}
        self.edges = {}

        self.messages = []
        
        self.global_document = NestDocument()
        self.id_para = id_para
        self.init_path()

        self.output = output
        self.class_para = class_para
        
    
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
        
        if not self.item:
            self.item = parent.item
        
        self.parent_node = parent
    
    def get_sibling_node(self, sibling_name):
        return self.parent_node.nodes[sibling_name]

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
            display(HTML(f"<h3>Document</h3>" + render_json_in_iframe_with_max_height(self.global_document)))
        else:
            display(HTML(f"<h3>Document</h3><p>Document is empty.</p>"))

    def display_messages(self):
        if len(self.messages) > 0:
            if isinstance(self.messages[0], list):

                def create_html_content(page_no):
                    html_content = generate_dialogue_html(self.messages[page_no])
                    return wrap_in_scrollable_div(html_content, height="500px", width="800px")
                display(HTML(f"<h3>Message History</h3>"))
                display_pages(len(self.messages), create_html_content)

            else:
                html_content = generate_dialogue_html(self.messages)
                display(HTML(f"<h3>Message History</h3>" 
                            + wrap_in_scrollable_div(html_content, height="500px")))

            

    def display(self, call_back_list=None):
        
        if call_back_list is None:
            call_back_list = []
        
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
        if cocoon_main_setting['DEBUG_MODE']:
            print(f"Running {self.name}.")
        return extract_output
    
    def run_but_fail(self, extract_output, use_cache=True):
        return {}
        
    
    def run_and_retry(self, extract_output):
        try:
            return self.run(extract_output, use_cache=True)
        except Exception as e:
            print(f"😲 Failed to run {self.name}...")
            write_log(f"""
The node is {self.name}
The error is: {e}
The messages are:
{self.messages}""")
            
            if cocoon_main_setting['DEBUG_MODE']:
                raise e
            
            for i in range(self.retry_times):
                try:           
                    print(f"🕗 Waiting for 10s before retrying...")
                    time.sleep(10)  
                    return self.run(extract_output, use_cache=False)
                except Exception as e:
                    print(f"😔 Failed to run {self.name}...")
                    
                    write_log(f"""
The node is {self.name}
The error is: {e}
The messages are:
{self.messages}""")
                
            
                    
            print(f"😔 Failed to run {self.name}. Please send us the error log (error_log.txt).")
            return self.run_but_fail(extract_output, use_cache=False)
            
    def postprocess(self, run_output, callback, viewer=False, extract_output=None):
        self.run_output = run_output
        
        if cocoon_main_setting['DEBUG_MODE']:
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
    
    def get_multi_node_parent_sibling_document(self, sibling_name):
        new_path = self.path[:-3]
        new_path.append(sibling_name)

        return self.global_document.get_nested(new_path)


class ListNode(Node):
    default_name = "List of Nodes"
    default_description = "This node dynamically creates a list of run calls."
    retry_times = 3
    
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

    def __init__(self, name=None, description=None, viewer=False, item=None, para=None, 
                 output=None, id_para="element_name", class_para=None):
        self.name = name if name is not None else self.default_name
        self.description = description if description is not None else self.default_description
        self.nodes = {}
        self.edges = {}
        self.item = item

        if para is None:
            para = {}
        self.para = para
        
        self.root_node = None
        self.viewer = viewer
        self.messages = []
        
        self.global_document = NestDocument()
        self.id_para = id_para
        self.init_path()

        self.output = output
        if class_para is None:
            class_para = {}
        self.class_para = class_para


    def extract(self, item):
        self.item = item
        return None

    def run(self, extract_output, use_cache=True):
        return None

    def postprocess(self, run_output, callback, viewer=False, extract_output=None):

        self.finish_workflow = callback

        print(f"Starting workflow {self.name}.")
        self.start_workflow()

        
    def write_document_to_disk(self, filepath: str):
        with open(filepath, 'w', encoding="utf-8") as file:
            json.dump(self.global_document, file)

    def read_document_from_disk(self, filepath: str, viewer=True):
        with open(filepath, 'r', encoding="utf-8") as file:
            self.global_document = json.load(file)

    def update_node(self, new_node):
        node_name = new_node.name
        if node_name not in self.nodes:
            raise ValueError(f"Node {node_name} not found.")
        
        self.nodes[node_name] = new_node

        new_node.inherit(self)
        new_node.remove_global_document()
        
    def add_as_root(self, node):
        nodes, edges = list(self.nodes.keys()), self.edges 
        
        if len(nodes) == 0:
            self.register(node)
            return
        
        self.register(node, children=[self.root_node])

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

    def register(self, node, parent=None, children=None):
        
        if children is None:
            children = []
            
        if isinstance(parent, Node):
            parent = parent.name

        if node.name in self.nodes:
            raise ValueError(f"Node {node.name} is already registered.")
        
        for child in children:
            if child not in self.nodes:
                raise ValueError(f"Child node {child} not found.")
        
        if parent:
            if parent not in self.nodes:
                raise ValueError(f"Parent node {parent} not found.")
            if parent in self.edges:
                self.edges[parent].append(node.name)
            else:
                self.edges[parent] = [node.name]
        else:
            if self.root_node is not None and self.root_node not in children:
                raise ValueError("A root node is already registered. Only one root node is allowed.")
            self.root_node = node.name
    
        self.nodes[node.name] = node
        node.inherit(self)
        self.edges[node.name] = children

    def start_workflow(self):
        if self.root_node is None:
            raise ValueError("Workflow has no root node defined.")
        
        self.execute_node(self.root_node)
        
    def start(self):
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
        
        def finish_this_workflow():
            this_document = self.get_global_document()
            self.finish_workflow(this_document)
            
        if "next_node" in document:
            next_node = document.get("next_node")

            if next_node == "COCOON_END_WORKFLOW":
                finish_this_workflow()
            
            elif next_node and next_node in children:
                print(f"Proceeding to the specified next node: {next_node}")
                self.execute_node(next_node)
                
            else:
                raise ValueError(f"Node {node_name} specified an invalid 'next_node'.")
        
        elif len(children) == 0:
            finish_this_workflow()

        elif len(children) == 1:
            next_node = children[0]
            if cocoon_main_setting['DEBUG_MODE']:
                print(f"Automatically proceeding to the next node: {next_node}")
            self.execute_node(next_node)

        else:
            raise ValueError(f"Node {node_name} has multiple possible next nodes. 'next_node' must be specified in the document.")
    
    def finish_workflow(self, document=None):
        if cocoon_main_setting['DEBUG_MODE']:
            print(f"Workflow {self.name} completed.")

    def display_workflow(self):
        nodes, edges = list(self.nodes.keys()), self.edges 

        edges = replace_keys_and_values_with_index(nodes, edges)
        
        self.display_document()
        display(HTML(f"<h3>Flow Diagram</h3>"))
        display_workflow(nodes, edges)
        
    def display(self, call_back_list=None):
        
        if call_back_list is None:
            call_back_list = []

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
                display(HTML(f"<p>The workflow is empty.</p>"))
                
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

    def __init__(self, name=None, description=None, viewer=False, item=None, para=None, 
                 output=None, id_para="element_name", class_para=None):
        self.name = name if name is not None else self.default_name
        self.description = description if description is not None else self.default_description
        self.nodes = {}
        self.edges = {}

        self.elements = []
        self.item = item
        
        if para is None:
            para = {}
        self.para = para
        self.viewer = viewer
        self.unit = "element"
        
        self.messages = []

        self.global_document = NestDocument()
        self.id_para = id_para
        self.init_path()

        self.output = output
        if class_para is None:
            class_para = {}
        self.class_para = class_para
        
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
        
        
        if self.viewer or ("viewer" in self.para and self.para["viewer"]):
            self.multi_node_viewer = True
        else:
            self.multi_node_viewer = False
        
        
        if not self.multi_node_viewer:
            self.execute_node(self.elements[0])
            
        else:
            
            
            for element in self.elements:
                self.execute_node(element)

            document = self.get_global_document()
            self.finish_workflow(document)

    
    def callback(self, element_name, document):
        element_idx = self.elements.index(element_name)
        element_node = self.nodes[element_name]

        element_node.set_global_document(document)

        if not self.multi_node_viewer:
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

    def display(self, call_back_list=None):
        
        if call_back_list is None:
            call_back_list = []

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


