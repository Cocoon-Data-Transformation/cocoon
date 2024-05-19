from ipywidgets import *
import ipywidgets
import ipywidgets as widgets
from IPython.display import *
import pandas as pd
from html.parser import HTMLParser

text_area_style = """
<style>
textarea, input {
    font-family:  'Verdana', serif;
    
}
:root {
    --jp-ui-font-size1: 12px;
}
</style>
"""

display(HTML(text_area_style))

def create_list_of_strings(initial_strings, ordered=True):
    def move_string_up(btn):
        index = btn.index
        if index > 0:
            strings = extract_strings_from_display(display_container)
            strings[index], strings[index-1] = strings[index-1], strings[index]
            update_display(strings)

    def move_string_down(btn):
        index = btn.index
        strings = extract_strings_from_display(display_container)
        if index < len(strings) - 1:
            strings[index], strings[index+1] = strings[index+1], strings[index]
            update_display(strings)

    def update_display(strings):
        display_container.children = tuple(build_widgets(strings) + [reset_btn])

    def update_display(strings):
        display_container.children = tuple(build_widgets(strings) + [reset_btn])

    def delete_string(btn):
        index = btn.index
        strings = extract_strings_from_display(display_container)
        del strings[index]
        update_display(strings)

    def add_string(btn):
        new_string = new_string_input.value.strip()
        if new_string:
            strings = extract_strings_from_display(display_container)
            strings.append(new_string)
            new_string_input.value = ''
            update_display(strings)

    def reset_list(btn):
        update_display(initial_strings)

    def build_widgets(strings):
        widgets_list = []
        for index, string in enumerate(strings):
            text_widget = widgets.Text(value=string)
            delete_btn = widgets.Button(icon='trash', button_style='danger', layout=widgets.Layout(width='32px'))
            up_btn = widgets.Button(icon='angle-up', button_style='info', layout=widgets.Layout(width='32px'))
            down_btn = widgets.Button(icon='angle-down', button_style='info', layout=widgets.Layout(width='32px'))

            delete_btn.index = up_btn.index = down_btn.index = index

            delete_btn.on_click(delete_string)
            up_btn.on_click(move_string_up)
            down_btn.on_click(move_string_down)

            if ordered:
                hbox = widgets.HBox([text_widget, up_btn, down_btn, delete_btn])
            else:
                hbox = widgets.HBox([text_widget, delete_btn])
            widgets_list.append(hbox)

        widgets_list.append(widgets.HBox([new_string_input, add_string_btn]))
        return widgets_list

    current_strings = initial_strings.copy()

    new_string_input = widgets.Text()
    add_string_btn = widgets.Button(icon='plus-circle', button_style='primary', layout=widgets.Layout(width='32px'))
    add_string_btn.on_click(add_string)

    reset_btn = widgets.Button(icon="fast-backward", description='Reset', button_style='warning')
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
    grid[0, 2] = widgets.HTML(value='<b>Remove Rows With This Value</b>')
    grid[0, 3] = widgets.HTML(value='<b>Reset</b>') 

    def create_reset_function(text_widget, toggle_widget, key):
        """Create a closure that resets the text widget's value to the dictionary's original value and turns the toggle off."""
        def reset_value(b):
            text_widget.value = input_dict[key]
            toggle_widget.value = False
            text_widget.disabled = False
        return reset_value

    for i, (key, value) in enumerate(input_dict.items(), start=1):
        grid[i, 0] = widgets.Label(value=str(key))
        
        text_input = widgets.Text(value=str(value))
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



def create_text_area_with_char_count(initial_value, max_chars=300):

    text_area = Textarea(layout=Layout(height='200px', width='600px'),
                            value=initial_value,
                            style={'description_width': 'initial'})

    char_count_label = ipywidgets.HTML()

    def update_char_count(change):
        if len(text_area.value) <= max_chars:
            char_count_label.value = f"<p style='color: #333;'>Characters entered: {len(text_area.value)}</p>"
        else:
            char_count_label.value = f"<p style='color: red;'>Characters entered: {len(text_area.value)} ⚠️ Too long!</p>"

    text_area.observe(update_char_count, names='value')

    update_char_count(None)

    return text_area, char_count_label


def create_text_area(initial_value):

    text_area = Textarea(layout={'height': '100px', 'width': '400px'},
                            value=initial_value)
    
    return text_area



def display_pages(total_page, create_html_content):
    
    current_page = 0

    def update_html_display(page_no):
        html_display.value = create_html_content(page_no)
        page_label.value = f'Page {page_no + 1} of {total_page}'
    
    def on_prev_clicked(b):
        nonlocal current_page
        if current_page > 0:
            current_page -= 1
            update_html_display(current_page)

    def on_next_clicked(b):
        nonlocal current_page
        if current_page < total_page - 1:
            current_page += 1
            update_html_display(current_page)
    
    html_display = widgets.HTML(value=create_html_content(current_page))
    
    btn_prev = widgets.Button(description='Previous Page', button_style='success')
    btn_next = widgets.Button(description='Next Page', button_style='success')

    btn_prev.on_click(on_prev_clicked)
    btn_next.on_click(on_next_clicked)

    page_label = widgets.Label(value=f'Page {current_page + 1} of {total_page}')
    
    navigation_bar = widgets.HBox([btn_prev, page_label, btn_next])
    
    display(navigation_bar, html_display)
    
def create_select_widget(options, callback):
    list_widget = widgets.Select(
        options=options,
        description='Choices:',
        disabled=False
    )

    button = widgets.Button(description="Submit")

    def on_button_clicked(b):
        callback(list_widget.value)

    button.on_click(on_button_clicked)

    display(list_widget, button)


def create_selection_grid(columns1, columns2, table1_name, table2_name, call_back_func):
    table1_label = widgets.Label(value=table1_name)
    table2_label = widgets.Label(value=table2_name)

    table1_selectors = [widgets.Checkbox() for col in columns1]
    table2_selectors = [widgets.Checkbox() for col in columns2]

    def on_submit_clicked(b):
        selected_table1_indices = [i for i, selected in enumerate(table1_selectors) if selected.value]
        selected_table2_indices = [i for i, selected in enumerate(table2_selectors) if selected.value]
        call_back_func(selected_table1_indices, selected_table2_indices)

    submit_button = widgets.Button(description="Submit")
    submit_button.on_click(on_submit_clicked)

    grid = widgets.GridspecLayout(2 + max(len(columns1), len(columns2)), 4)
    grid[0, 0] = table1_label
    grid[0, 2] = table2_label

    for i, selector in enumerate(table1_selectors):
        grid[i + 1, 0] = widgets.Label(columns1[i])
        grid[i + 1, 1] = selector

    for i, selector in enumerate(table2_selectors):
        grid[i + 1, 2] = widgets.Label(columns2[i])
        grid[i + 1, 3] = selector

    grid[-1, :] = submit_button
    return grid

def create_column_selector(columns, callback, default=False):
    multi_select = widgets.SelectMultiple(
        options=[(column, i) for i, column in enumerate(columns)],
        disabled=False,
        layout={'width': '600px', 'height': '200px'}
    )
    
    instructions_text = "Tip: Hold Ctrl (or Cmd on Mac) to select multiple options. Currently, 0 are selected."
    instructions = widgets.Label(value=instructions_text)
    
    def update_instructions(change):
        selected_count = len(multi_select.value)
        instructions.value = f"Tip: Hold Ctrl (or Cmd on Mac) to select multiple options. Currently, {selected_count} are selected."
    
    multi_select.observe(update_instructions, 'value')
    
    select_all_button = widgets.Button(description="Select All", button_style='info', icon='check-square')
    deselect_all_button = widgets.Button(description="Deselect All", button_style='danger', icon='square-o')
    reverse_selection_button = widgets.Button(description="Reverse Selection", button_style='warning', icon='exchange')
    submit_button = widgets.Button(description="Submit", button_style='success', icon='check')
    
    def select_all(b):
        multi_select.value = tuple(range(len(columns)))
        
    def deselect_all(b):
        multi_select.value = ()
    
    def reverse_selection(b):
        current_selection = set(multi_select.value)
        all_indices = set(range(len(columns)))
        new_selection = tuple(all_indices - current_selection)
        multi_select.value = new_selection
    
    def submit(b):
        selected_indices = multi_select.value
        callback(selected_indices)
    
    select_all_button.on_click(select_all)
    deselect_all_button.on_click(deselect_all)
    reverse_selection_button.on_click(reverse_selection)
    submit_button.on_click(submit)
    
    buttons = widgets.HBox([select_all_button, deselect_all_button, reverse_selection_button])
    ui = widgets.VBox([instructions, multi_select, buttons, submit_button])
    display(ui)
    
    if default:
        multi_select.value = tuple(range(len(columns)))





def create_column_selector_(columns, default=False):
    multi_select = widgets.SelectMultiple(
        options=[(column, i) for i, column in enumerate(columns)],
        disabled=False,
        layout={'width': '600px', 'height': '200px'}
    )
    
    instructions_text = "Tip: Hold Ctrl (or Cmd on Mac) to select multiple options. Currently, 0 are selected."
    instructions = widgets.Label(value=instructions_text)
    
    def update_instructions(change):
        selected_count = len(multi_select.value)
        instructions.value = f"Tip: Hold Ctrl (or Cmd on Mac) to select multiple options. Currently, {selected_count} are selected."
    
    multi_select.observe(update_instructions, 'value')
    
    select_all_button = widgets.Button(description="Select All", button_style='info', icon='check-square')
    deselect_all_button = widgets.Button(description="Deselect All", button_style='danger', icon='square-o')
    reverse_selection_button = widgets.Button(description="Reverse Selection", button_style='warning', icon='exchange')
        
    def select_all(b):
        multi_select.value = tuple(range(len(columns)))
        
    def deselect_all(b):
        multi_select.value = ()
    
    def reverse_selection(b):
        current_selection = set(multi_select.value)
        all_indices = set(range(len(columns)))
        new_selection = tuple(all_indices - current_selection)
        multi_select.value = new_selection
    
    
    select_all_button.on_click(select_all)
    deselect_all_button.on_click(deselect_all)
    reverse_selection_button.on_click(reverse_selection)
    
    buttons = widgets.HBox([select_all_button, deselect_all_button, reverse_selection_button])
    ui = widgets.VBox([instructions, multi_select, buttons])
    display(ui)
    
    if default:
        multi_select.value = tuple(range(len(columns)))
        
    return multi_select




def create_progress_bar_with_numbers(current, labels):

    total = len(labels)
    circles_with_labels = []
    for i in range(total):
        color = "#274e13" if i == current else "#d9ead3"
        circle_html = f'''
        <div style="display: inline-block; text-align: center; width: 60px;">
            <span style="display: block; width: 20px; height: 20px; border-radius: 50%; background: {color}; margin: 0 auto; line-height: 20px; color: white; font-size: 12px;">{i+1}</span>
            <label style="display: block; margin-top: 5px; font-size: 12px;">{labels[i]}</label>
        </div>
        '''
        circles_with_labels.append(circle_html)

    display(HTML(''.join(circles_with_labels)))


def color_columns_multiple(df, colors, column_indices_list):

    def apply_color_to_columns(styler, colors, column_indices_list):
        for color, indices in zip(colors, column_indices_list):
            for index in indices:
                styler = styler.set_properties(**{'background-color': color}, subset=df.columns[index])
        return styler

    styled_df = apply_color_to_columns(df.style, colors, column_indices_list)

    return styled_df




def create_html_radio_buttons(html_labels):
    labels_html = [widgets.HTML(value=label) for label in html_labels]
    
    checkbox_style = {'description_width': '0px', 'handle_color': 'lightblue'}
    
    checkboxes = [widgets.Checkbox(value=False, description='', style=checkbox_style, layout={'width': 'initial'}) for _ in html_labels]
    
    checkboxes[0].value = True
    
    def on_checkbox_change(change):
        if change['new']:
            for checkbox in checkboxes:
                if checkbox is not change['owner']:
                    checkbox.value = False
    
    for checkbox in checkboxes:
        checkbox.observe(on_checkbox_change, names='value')
    
    radio_buttons_widget = widgets.VBox([widgets.HBox([cb, label], layout=widgets.Layout(align_items='center', margin='0')) for cb, label in zip(checkboxes, labels_html)])
    
    return radio_buttons_widget, checkboxes

def get_selected_index(checkboxes):
    return next((index for index, checkbox in enumerate(checkboxes) if checkbox.value), None)






