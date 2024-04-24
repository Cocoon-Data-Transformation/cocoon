from ipywidgets import *
import ipywidgets as widgets
from IPython.display import *
import pandas as pd
from html.parser import HTMLParser

def create_list_of_strings(initial_strings):
    def move_string_up(btn):
        index = btn.index
        if index > 0:
            current_strings[index], current_strings[index-1] = current_strings[index-1], current_strings[index]
            update_display(current_strings)

    def move_string_down(btn):
        index = btn.index
        if index < len(current_strings) - 1:
            current_strings[index], current_strings[index+1] = current_strings[index+1], current_strings[index]
            update_display(current_strings)

    def update_display(strings):
        display_container.children = tuple(build_widgets(strings) + [reset_btn])

    def update_display(strings):
        display_container.children = tuple(build_widgets(strings) + [reset_btn])

    def delete_string(btn):
        index = btn.index
        del current_strings[index]
        update_display(current_strings)

    def add_string(btn):
        new_string = new_string_input.value.strip()
        if new_string:
            current_strings.append(new_string)
            new_string_input.value = ''
            update_display(current_strings)

    def reset_list(btn):
        global current_strings
        current_strings = initial_strings.copy()
        update_display(current_strings)

    def build_widgets(strings):
        widgets_list = []
        for index, string in enumerate(strings):
            text_widget = widgets.Text(value=string)
            delete_btn = widgets.Button(icon='fa-trash', button_style='danger', layout=widgets.Layout(width='32px'))
            up_btn = widgets.Button(icon='fa-angle-up', button_style='info', layout=widgets.Layout(width='32px'))
            down_btn = widgets.Button(icon='fa-angle-down', button_style='info', layout=widgets.Layout(width='32px'))

            delete_btn.index = up_btn.index = down_btn.index = index

            delete_btn.on_click(delete_string)
            up_btn.on_click(move_string_up)
            down_btn.on_click(move_string_down)

            hbox = widgets.HBox([text_widget, up_btn, down_btn, delete_btn])
            widgets_list.append(hbox)

        widgets_list.append(widgets.HBox([new_string_input, add_string_btn]))
        return widgets_list

    current_strings = initial_strings.copy()

    new_string_input = widgets.Text()
    add_string_btn = widgets.Button(icon='fa-plus-circle', button_style='primary', layout=widgets.Layout(width='32px'))
    add_string_btn.on_click(add_string)

    reset_btn = widgets.Button(icon="fa-fast-backward", description='Reset', button_style='warning')
    reset_btn.on_click(reset_list)

    display_container = widgets.VBox()
    update_display(current_strings)

    return display_container




def extract_strings_from_display(container):
    extracted_strings = []
    
    for child in container.children[:-2]:
        text_widget = child.children[0]
        extracted_strings.append(text_widget.value)
    
    return extracted_strings



class MyHTMLParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.data = []

    def handle_data(self, data):
        self.data.append(data)

def extract_text_from_html(html_str):
    parser = MyHTMLParser()
    parser.feed(html_str)
    return ''.join(parser.data)

def grid_to_updated_dataframe(grid, reset=True, lists=[]):
    updated_data = []

    if reset:
        j_max = grid.n_columns - 1
    else:
        j_max = grid.n_columns
    
    column_names = [extract_text_from_html(str(grid[0, j].value)) for j in range(j_max)]  
    
    for i in range(1, grid.n_rows):
        row_data = []

        for j in range(j_max):
            widget = grid[i, j]
            
            column_name = column_names[j]

            if column_name in lists:
                value = widget.options
            elif isinstance(widget, widgets.FloatText) or isinstance(widget, widgets.Text):
                value = widget.value
            elif isinstance(widget, widgets.Checkbox):
                value = widget.value
            elif isinstance(widget, widgets.Dropdown):
                value = widget.value
            else:
                value = None
            
            row_data.append(value)
        
        updated_data.append(row_data)
    
    updated_df = pd.DataFrame(updated_data, columns=column_names)
    
    return updated_df

def create_dataframe_grid(df, editable_columns, reset=False, category={}, lists= [], long_text = []):

    rows = len(df) + 1
    columns = len(df.columns) + (1 if reset else 0)
    grid = widgets.GridspecLayout(rows, columns, width='100%')

    for j, col_name in enumerate(df.columns):
        grid[0, j] = widgets.HTML(value=f'<b>{col_name}</b>')
    
    if reset:
        grid[0, -1] = widgets.HTML(value='<b>Reset</b>')
    
    row_widgets = []

    def highlight_change(change):
        change.owner.layout.border = '1px solid #fc5656'


    for i, (index, row) in enumerate(df.iterrows()):
        widgets_in_row = []
        for j, col_name in enumerate(df.columns):
            value = row[col_name]
            widget = None
            
            if col_name in category:
                widget = widgets.Dropdown(options=category[col_name], value=value)
            elif col_name in lists:
                widget = widgets.Dropdown(options=value)
            elif col_name in long_text:
                widget = widgets.Button(description='Hover over me', 
                      button_style='',
                      tooltip=value,
                      icon='fa-commenting-o')
            elif pd.api.types.is_bool_dtype(df[col_name]):
                widget = widgets.Checkbox(value=bool(value))
            elif pd.api.types.is_numeric_dtype(df[col_name]):
                widget = widgets.FloatText(value=float(value))
            else:
                widget = widgets.Text(value=str(value))

            if not editable_columns[j]:
                widget.disabled = True
            else:
                widget.disabled = False
                widget.observe(highlight_change, names='value')

            grid[i+1, j] = widget
            widgets_in_row.append(widget)

        row_widgets.append(widgets_in_row)

        if reset:
            reset_button = widgets.Button(description="Reset", button_style='danger')

            def create_reset_handler(row_index):
                def handler(b):
                    for k, cell in enumerate(df.iloc[row_index]):
                        widget = row_widgets[row_index][k]
                        value = cell
                        if isinstance(widget, widgets.FloatText):
                            widget.value = float(value)
                        elif isinstance(widget, widgets.Checkbox):
                            widget.value = bool(value)
                        elif isinstance(widget, widgets.Dropdown):
                            widget.value = value
                        elif isinstance(widget, widgets.Text):
                            widget.value = str(value)
                        
                        widget.layout.border = ''
                return handler

            reset_button.on_click(create_reset_handler(i))
            grid[i+1, -1] = reset_button

    return grid






def create_dictionary_grid_remove(input_dict, col1="Key", col2="Value"):
    grid = widgets.GridspecLayout(len(input_dict) + 2, 4, width='100%')

    grid[0, 0] = widgets.HTML(value=f'<b>{col1}</b>')
    grid[0, 1] = widgets.HTML(value=f'<b>{col2}</b>')
    grid[0, 2] = widgets.HTML(value='<b>Remove Rows</b>')
    grid[0, 3] = widgets.HTML(value='<b>Reset</b>') 

    def create_reset_function(text_widget, toggle_widget, key):
        """Create a closure that resets the text widget's value to the dictionary's original value and turns the toggle off."""
        def reset_value(b):
            text_widget.value = input_dict[key]
            toggle_widget.value = False
            text_widget.disabled = False
        return reset_value

    for i, (key, value) in enumerate(input_dict.items(), start=1):
        grid[i, 0] = widgets.Label(value=key)
        
        text_input = widgets.Text(value=value)
        grid[i, 1] = text_input
        
        reset_button = widgets.Button(description="Reset",
                                      button_style = "danger")
        
        toggle_button = widgets.ToggleButton(value=False, 
                                             description='Remove', 
                                             tooltip='Remove rows with this value',
                                             button_style='')
        toggle_button.observe(lambda change, text_input=text_input: toggle_text_input(change, text_input), names='value')
        
        reset_button.on_click(create_reset_function(text_input, toggle_button, key))
        grid[i, 3] = reset_button
        grid[i, 2] = toggle_button
    
    return grid

def toggle_text_input(change, text_input):
    """Disable or enable the text input based on the toggle's state."""
    text_input.disabled = change['new']



def process_grid_changes_remove(grid):
    old_values_to_remove = []
    non_removed_values = {}
    
    for i in range(1, len(grid.children) // 4):
        key_label = grid[i, 0]
        text_input = grid[i, 1]
        toggle_button = grid[i, 2]
        
        key = key_label.value
        old_value = text_input.value
        
        if toggle_button.value:
            old_values_to_remove.append(old_value)
        else:
            non_removed_values[key] = old_value

    return old_values_to_remove, non_removed_values



def create_dictonary_grid(input_dict, col1="Key", col2="Value"):
    grid = widgets.GridspecLayout(len(input_dict) + 2, 3, width='100%')

    grid[0, 0] = widgets.HTML(value=f'<b>{col1}</b>')
    grid[0, 1] = widgets.HTML(value=f'<b>{col2}</b>')
    grid[0, 2] = widgets.HTML(value='<b>Reset</b>')

    def create_reset_function(text_widget, key):
        """Create a closure that resets the text widget's value to the dictionary's original value."""
        def reset_value(b):
            text_widget.value = input_dict[key]
        return reset_value

    for i, (key, value) in enumerate(input_dict.items(), start=1):
        grid[i, 0] = widgets.Label(value=key)
        
        text_input = widgets.Text(value=value)
        text_input.observe(lambda change, key=key: on_text_change(change, key), names='value')
        grid[i, 1] = text_input
        
        reset_button = widgets.Button(description="Reset")
        reset_button.on_click(create_reset_function(text_input, key))
        grid[i, 2] = reset_button
    
    return grid




def collect_updated_dict_from_grid(grid):
    updated_dict = {}
    for i in range(1, grid.n_rows - 1):
        key_widget = grid[i, 0]
        value_widget = grid[i, 1]
        
        key = key_widget.value
        updated_value = value_widget.value
        updated_dict[key] = updated_value

    return updated_dict



def create_text_area_with_char_count(initial_value):

    text_area = Textarea(layout={'height': '200px', 'width': '600px'},
                            value=initial_value)

    char_count_label = Label()

    def update_char_count(change):
        if len(text_area.value) < 300:
            char_count_label.value = f"Characters entered: {len(text_area.value)}"
        else:
            char_count_label.value = f"Characters entered: {len(text_area.value)} ⚠️ Too long!"

    text_area.observe(update_char_count, names='value')

    update_char_count(None)

    return text_area, char_count_label


def create_text_area(initial_value):

    text_area = Textarea(layout={'height': '100px', 'width': '400px'},
                            value=initial_value)
    
    return text_area

