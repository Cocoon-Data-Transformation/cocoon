import json
import matplotlib.pyplot as plt
import numpy as np
from matplotlib_venn import venn2
import seaborn as sns
import base64
from graphviz import Digraph
from matplotlib.ticker import EngFormatter
import networkx as nx
from IPython.display import HTML



def wrap_in_iframe(html_code, width=800, height=400):

    escaped_html = html_code.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#039;")

    iframe_code = f"<iframe srcdoc=\"{escaped_html}\" width=\"{width}\" height=\"{height}\" frameborder=\"0\"></iframe>"

    return iframe_code

def eng_formatter_with_precision(precision):
    def _formatter(x, pos):
        eng = EngFormatter(places=precision, sep="\N{THIN SPACE}")
        return eng.format_eng(x)
    return _formatter

def plot_distribution_numerical(con, table_name, column_name):
    """
    This function takes a database connection, table name, and a column name as input.
    It plots a vertical histogram for the numeric column and returns it as a base64-encoded PNG string.
    """
    counts, bin_width, bin_centers = build_histogram_inputs(con, column_name, table_name)

    sns.set_style("whitegrid")
    plt.figure(figsize=(4, 2))

    hist_plot = plt.bar(bin_centers, counts, width=bin_width, align='center', color="#5DADE2", edgecolor="black")

    plt.gca().xaxis.set_major_formatter(eng_formatter_with_precision(precision=1))
    plt.xticks(bin_centers[::6])

    for rect in hist_plot:
        height = rect.get_height()
        plt.text(rect.get_x() + rect.get_width() / 2, height, f'{int(height)}', ha='center', va='bottom', fontsize=8)

    plt.ylabel('Frequency')
    plt.xlabel(column_name)

    plt.subplots_adjust(top=0.9)

    plt.tight_layout()

    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)

    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')

    return image_base64


def plot_distribution_category(con, table_name, column_name):

    result_dict = build_barchat_input(con, column_name, table_name, limit=11)
    result_dict = modify_data_dict(result_dict, limit=30)
    
    plt.figure(figsize=(4, 2))
    
    categories = list(result_dict.keys())
    counts = list(result_dict.values())
    
    bar_plot = sns.barplot(y=categories, x=counts, color="#5DADE2", edgecolor="black")
    
    if 'Other values' in categories:
        other_index = categories.index('Other values')
        bar_plot.patches[other_index].set_facecolor('orange')
    
    for index, value in enumerate(counts):
        bar_plot.text(value, index, f'{value}', color='black', va='center', fontsize=8)
    
    plt.xlabel(column_name)
    
    plt.tight_layout()
    
    buf = io.BytesIO()
    plt.savefig(buf, format='png', dpi=300)
    plt.close()
    buf.seek(0)
    
    image_base64 = base64.b64encode(buf.getvalue()).decode('utf-8')
    
    return image_base64

def modify_data_dict(data_dict, limit=30):
    modified_dict = {}
    for label, value in data_dict.items():
        new_label = (str(label)[:limit] + "...") if len(str(label)) > limit else str(label)
        
        if new_label in modified_dict:
            if isinstance(modified_dict[new_label], list):
                modified_dict[new_label].append(value)
            else:
                modified_dict[new_label] = [modified_dict[new_label], value]
        else:
            modified_dict[new_label] = value
    
    return modified_dict
  

def plot_venn_percentage(array1, array2, name1, name2):

    if not isinstance(array1, np.ndarray) or not isinstance(array2, np.ndarray):
        raise TypeError("Both inputs must be numpy arrays.")

    plt.figure(figsize=(3, 2))

    set1 = set(array1)
    set2 = set(array2)

    total_elements = len(set1.union(set2))

    if total_elements == 0:
        overlap = 0
        only_set1 = 0
        only_set2 = 0
    else:
        overlap = len(set1.intersection(set2)) / total_elements * 100
        only_set1 = len(set1 - set2) / total_elements * 100
        only_set2 = len(set2 - set1) / total_elements * 100

    font_size=8
    
    venn_diagram = venn2(subsets=(only_set1, only_set2, overlap), set_labels=(name1, name2))

    for patch in venn_diagram.patches:
        if patch: 
            patch.set_alpha(0.5)

    venn_diagram.get_label_by_id('10').set_text(f'{round(only_set1, 1)}%')
    venn_diagram.get_label_by_id('10').set_fontsize(font_size)
    venn_diagram.get_label_by_id('01').set_text(f'{round(only_set2, 1)}%')
    venn_diagram.get_label_by_id('01').set_fontsize(font_size)
    if overlap > 0 and venn_diagram.get_label_by_id('11'):
        venn_diagram.get_label_by_id('11').set_text(f'{round(overlap, 1)}%')
        venn_diagram.get_label_by_id('11').set_fontsize(font_size)

    for label in venn_diagram.set_labels:
        label.set_fontsize(font_size)
        
    plt.show()

    return overlap, only_set1, only_set2




def create_bar_chart_viz_html(data_dict):

    total_value = sum(data_dict.values())
    data = [{"label": (str(label)[:15] + "...") if len(str(label)) > 15 else str(label), "value": (value / total_value) * 100}
        for label, value in data_dict.items()]

    bar_chart_html = f"""
<!DOCTYPE html>
<html>
<head>
  <style>
    .bar-chart-container {{
      width: 300px;
      height: 100px;
      border: 1px solid black;
    }}

  </style>
</head>
<body>
  <div id="barChartArea"></div>

  <script src="https://d3js.org/d3.v6.js"></script>
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

    const data = {data};
    drawBarChart("barChartArea", data);
  </script>
</body>
</html>
"""
    return bar_chart_html




def generate_draggable_graph_html_color(data, svg_height=300, svg_width=1000):
    graph_data = json.dumps(data)
    graph_html = f"""<!DOCTYPE html>
<meta charset="utf-8">
<style>
  .links line {{
    stroke: #aaa;
    stroke-width: 2px;
  }}

  .nodetext {{
    text-anchor: middle;
    alignment-baseline: middle;
  }}

  html {{
      font-family: sans-serif;
      font-size: 12px;
  }}
</style>
<script src="https://d3js.org/d3.v4.min.js" charset="utf-8"></script>
<svg id="session1" width="{svg_width}" height="{svg_height}"></svg>

<script>
  var svg = d3.select("#session1"),
      width = +svg.attr("width"),
      height = +svg.attr("height");

  var graph = {graph_data};

  var nodeWidth = 100;
  var nodeHeight = 30;

  var simulation = d3.forceSimulation()
      .force("link", d3.forceLink().id(function(d) {{ return d.id; }}))
      .force("charge", d3.forceManyBody().strength(-180))
      .force("center", d3.forceCenter(width / 2, height / 2));

  var link = svg.append("g")
      .attr("class", "links")
      .selectAll("line")
      .data(graph.links)
      .enter().append("line");

  var node = svg.append("g")
      .attr("class", "nodes")
      .selectAll("g")
      .data(graph.nodes)
      .enter().append("g")
      .call(d3.drag()
          .on("start", dragstarted)
          .on("drag", dragged)
          .on("end", dragended));

  // Append the rectangles first
  node.append("rect")
      .attr("width", 60) // Temporary default width
      .attr("height", nodeHeight)
      .attr("stroke", function(d) {{ return d.border_color; }}) // Set the border color based on the node's border_color property
      .attr("fill", function(d) {{ return d.fill_color; }}); // Set the fill color based on the node's fill_color property

  // Then append the text
  var texts = node.append("text")
      .attr("class", "nodetext")
      .attr("x", 30) // Temporary x position, half of the default width
      .attr("y", nodeHeight / 2)
      .text(function(d) {{ return d.id; }});

  // Update the width of the rectangles and reposition the text
  node.each(function(d, i) {{
      var rect = d3.select(this).select("rect");
      var text = d3.select(this).select("text");

      var textLength = text.node().getComputedTextLength();
      var newWidth = textLength + 20; // Adjust padding as needed

      // Update rect width
      rect.attr("width", newWidth);

      // Update text position
      text.attr("x", newWidth / 2);
  }});

  simulation
      .nodes(graph.nodes)
      .on("tick", ticked);

  simulation.force("link")
      .links(graph.links)
      .distance(100);

  function ticked() {{
    link
        .attr("x1", function(d) {{ return Math.max(0,Math.min(width, d.source.x)); }})
        .attr("y1", function(d) {{ return Math.max(0,Math.min(height, d.source.y)); }})
        .attr("x2", function(d) {{ return Math.max(0,Math.min(width, d.target.x)); }})
        .attr("y2", function(d) {{ return Math.max(0,Math.min(height, d.target.y)); }});
    node
        .attr("transform", function(d) {{
            var x = Math.max(0, Math.min(width, d.x)) - this.getBBox().width / 2;
            var y = Math.max(0, Math.min(height, d.y)) - this.getBBox().height / 2;
            return "translate(" + x + "," + y + ")";
        }});
  }}

  function dragstarted(d) {{
    if (!d3.event.active) simulation.alphaTarget(0.3).restart();
    d.fx = d.x;
    d.fy = d.y;
  }}

  function dragged(d) {{
    d.fx = Math.max(0, Math.min(width - nodeWidth, d3.event.x));
    d.fy = Math.max(0, Math.min(height - nodeHeight, d3.event.y));
  }}

  function dragended(d) {{
    if (!d3.event.active) simulation.alphaTarget(0);
    d.fx = null;
    d.fy = null;
  }}
</script>
"""
    return graph_html




def create_histogram_viz_html(counts, bin_width, bin_centers):

    histogram_html = f"""
<!DOCTYPE html>
<html>
<head>
  <style>
    .histogram-container {{
      width: 300px;
      height: 100px;
      border: 1px solid black;
    }}
    svg {{
      font: 10px sans-serif;
    }}
  </style>
</head>
<body>
  <div id="histogramArea"></div>

  <script src="https://d3js.org/d3.v6.js"></script>
  <script>
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

    const data = {[
        {"x": center, "y": count} for center, count in zip(bin_centers, counts)
    ]};
    const binWidth = {bin_width};
    drawHistogram("histogramArea", data, binWidth);
  </script>
</body>
</html>
"""
    return histogram_html





def create_map_viz_html(coordinates):
    map_html = f"""
<!DOCTYPE html>
<head>
  <style>
    .map-container {{
      width: 300px;
      height: 200px;
      border: 1px solid black;
    }}
  </style>
</head>
<body>
  <div id="mapArea"></div>

  <script src="https://d3js.org/d3.v6.js"></script>
  <script>
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

    let coordinates = {coordinates}
    // Example usage: Plotting a point in Boston
    drawMap("mapArea", coordinates)
  </script>
</body>
</html>
"""
    return map_html
  



def generate_draggable_graph_html(data, svg_height=300, svg_width=1000):
    graph_data = json.dumps(data)
    graph_html = f"""<!DOCTYPE html>
<meta charset="utf-8">
<style>
  .nodes rect {{
    stroke: #aaa;
    fill: #fff;
  }}

  .links line {{
    stroke: #aaa;
    stroke-width: 2px;
  }}

  .nodetext {{
    text-anchor: middle;
    alignment-baseline: middle;
  }}

  html {{
      font-family: sans-serif;
      font-size: 12px;
  }}
</style>
<script src="https://d3js.org/d3.v4.min.js" charset="utf-8"></script>
<svg id="session1" width="{svg_width}" height="{svg_height}"></svg>

<script>
  var svg = d3.select("#session1"),
      width = +svg.attr("width"),
      height = +svg.attr("height");

  var graph = {graph_data};

  var nodeWidth = 100;
  var nodeHeight = 30;

  var simulation = d3.forceSimulation()
      .force("link", d3.forceLink().id(function(d) {{ return d.id; }}))
      .force("charge", d3.forceManyBody().strength(-180))
      .force("center", d3.forceCenter(width / 2, height / 2));

  var link = svg.append("g")
      .attr("class", "links")
      .selectAll("line")
      .data(graph.links)
      .enter().append("line");

var node = svg.append("g")
    .attr("class", "nodes")
    .selectAll("g")
    .data(graph.nodes)
    .enter().append("g")
    .call(d3.drag()
        .on("start", dragstarted)
        .on("drag", dragged)
        .on("end", dragended));

// Append the rectangles first
node.append("rect")
    .attr("width", 60) // Temporary default width
    .attr("height", nodeHeight);

// Then append the text
var texts = node.append("text")
    .attr("class", "nodetext")
    .attr("x", 30) // Temporary x position, half of the default width
    .attr("y", nodeHeight / 2)
    .text(function(d) {{ return d.id; }});

// Update the width of the rectangles and reposition the text
node.each(function(d, i) {{
    var rect = d3.select(this).select("rect");
    var text = d3.select(this).select("text");

    var textLength = text.node().getComputedTextLength();
    var newWidth = textLength + 20; // Adjust padding as needed

    // Update rect width
    rect.attr("width", newWidth);

    // Update text position
    text.attr("x", newWidth / 2);
}});



  simulation
      .nodes(graph.nodes)
      .on("tick", ticked);

  simulation.force("link")
      .links(graph.links)
      .distance(100);

  function ticked() {{
  link
      .attr("x1", function(d) {{ return Math.max(0,Math.min(width, d.source.x)); }})
      .attr("y1", function(d) {{ return Math.max(0,Math.min(height, d.source.y)); }})
      .attr("x2", function(d) {{ return Math.max(0,Math.min(width, d.target.x)); }})
      .attr("y2", function(d) {{ return Math.max(0,Math.min(height, d.target.y)); }});
    node
        .attr("transform", function(d) {{
            var x = Math.max(0, Math.min(width, d.x)) - this.getBBox().width / 2;
            var y = Math.max(0, Math.min(height, d.y)) - this.getBBox().height / 2;
            return "translate(" + x + "," + y + ")";
        }});
  }}

  function dragstarted(d) {{
    if (!d3.event.active) simulation.alphaTarget(0.3).restart();
    d.fx = d.x;
    d.fy = d.y;
  }}

  function dragged(d) {{
    d.fx = Math.max(0, Math.min(width - nodeWidth, d3.event.x));
    d.fy = Math.max(0, Math.min(height - nodeHeight, d3.event.y));
  }}

  function dragended(d) {{
    if (!d3.event.active) simulation.alphaTarget(0);
    d.fx = null;
    d.fy = null;
  }}
</script>
"""
    return graph_html



def generate_dialogue_html(dialogue):
    html_content = """
<style>
    .dialogue-table {
        width: 100%;
        border-collapse: collapse;
    }
    .dialogue-table th {
        background-color: black;
        color: white;
        padding: 8px;
        text-align: left;
    }
    .dialogue-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    .user td {background-color: #e8f5e9;} /* Apply background color to td for user messages */
    .assistant td {background-color: #e3f2fd;} /* Apply background color to td for assistant messages */
    .system td {background-color: #fff3e0;} /* Apply background color to td for system messages */
</style>


<table class="dialogue-table">
    <tr>
        <th>Sender</th>
        <th>Message</th>
    </tr>
    """


    for msg in dialogue:
        if msg["role"] == "user":
            row_class = "user"
        elif msg["role"] == "assistant":
            row_class = "assistant"
        else:
            row_class = "system"
        
        html_content += f"""
        <tr class="{row_class}">
            <td>{msg["role"].capitalize()}</td>
            <td><pre>{msg["content"]}</pre></td>
        </tr>
        """

    html_content += "</table>"

    return html_content


def generate_seaborn_palette(n_colors):
    palette = sns.husl_palette(n_colors, s=0.7, l=0.8)
    hex_colors = ["#{:02x}{:02x}{:02x}".format(int(rgb[0]*255), int(rgb[1]*255), int(rgb[2]*255)) for rgb in palette]
    
    return hex_colors


def generate_workflow_html_multiple(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, height=400):
    dot = Digraph(format='png')

    highlight_color = '#FFA500'

    if highlight_nodes_indices is None:
        highlight_nodes_indices = []
    if highlight_edges_indices is None:
        highlight_edges_indices = []

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


    for i, node in enumerate(nodes):
        if i in highlight_nodes_indices:
            dot.node(node, node, **{**node_style, **highlighted_node_style})
        else:
            dot.node(node, node, **node_style)

    for i, (tail, head) in enumerate(edges):
        label = edge_labels[i] if edge_labels and i < len(edge_labels) else ''
        if i in highlight_edges_indices:
            dot.edge(nodes[tail], nodes[head], label=label, **{**edge_style, **highlighted_edge_style})
        else:
            dot.edge(nodes[tail], nodes[head], label=label, **edge_style)

    png_image = dot.pipe()

    encoded_image = base64.b64encode(png_image).decode()

    scrollable_html = f"""
    <div style="max-height: {height}px; overflow: auto; border: 1px solid #cccccc;">
        <img src="data:image/png;base64,{encoded_image}" alt="Workflow Diagram" style="display: block; max-width: none; height: auto;">
    </div>
    """
    return scrollable_html









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





def visualize_data_vault(hubs, links, satellites, hub_link_edges, link_satellite_edges, hub_satellite_edges):
    G = nx.Graph()

    hubs = [f"Hub\n{hub}" for hub in hubs]

    links = [f"Link\n{link}" for link in links]

    satellites = [f"Satellite\n{satellite}" for satellite in satellites]

    G.add_nodes_from(hubs, color='#FF4136', node_shape='s', node_size=160)

    G.add_nodes_from(links, color='#0074D9', node_shape='s', node_size=180)

    G.add_nodes_from(satellites, color='#111111', node_shape='s', node_size=240)

    for link_idx, hub_indices in hub_link_edges.items():
        for hub_idx in hub_indices:
            G.add_edge(links[link_idx], hubs[hub_idx])

    for link_idx, satellite_indices in link_satellite_edges.items():
        for satellite_idx in satellite_indices:
            G.add_edge(links[link_idx], satellites[satellite_idx])

    for hub_idx, satellite_indices in hub_satellite_edges.items():
        for satellite_idx in satellite_indices:
            G.add_edge(hubs[hub_idx], satellites[satellite_idx])

    pos = nx.spring_layout(G, iterations=200)

    scale = 2
    for node in pos:
        pos[node] = (pos[node][0] * scale, pos[node][1] * scale)

    
    num_nodes = len(G.nodes())
    height = 3 + num_nodes // 5
    fig, ax = plt.subplots(figsize=(6, 5))

    node_colors = [G.nodes[n]['color'] for n in G.nodes()]
    node_shapes = [G.nodes[n]['node_shape'] for n in G.nodes()]
    node_sizes = [G.nodes[n]['node_size'] for n in G.nodes()]

    def custom_rectangle(x, y, width, height):
        return np.array([[x - width/2, y - height/2],
                         [x + width/2, y - height/2],
                         [x + width/2, y + height/2],
                         [x - width/2, y + height/2],
                         [x - width/2, y - height/2]])

    nx.draw_networkx(G, pos, edge_color='#CCCCCC', width=0.8, ax=ax, with_labels=False, node_size=0)

    for node in G.nodes():
        x, y = pos[node]
        node_color = G.nodes[node]['color']
        node_size = G.nodes[node]['node_size']
        width = np.sqrt(node_size) / 25
        height = width / 2
        node_shape = custom_rectangle(x, y, width, height)
        ax.add_patch(plt.Polygon(node_shape, closed=True, edgecolor=node_color, facecolor='white', linewidth=0.8))

    nx.draw_networkx_labels(G, pos, font_size=6, ax=ax)

    ax.set_facecolor('white')

    x_coords = [pos[node][0] for node in G.nodes()]
    y_coords = [pos[node][1] for node in G.nodes()]
    x_min, x_max = min(x_coords), max(x_coords)
    y_min, y_max = min(y_coords), max(y_coords)

    x_range = x_max - x_min + 1
    y_range = y_max - y_min + 0.5

    x_center = (x_min + x_max) / 2
    y_center = (y_min + y_max) / 2

    max_range = max(x_range, y_range)
    aspect_ratio = 1

    x_lim_min = x_center - max_range / 2
    x_lim_max = x_center + max_range / 2
    y_lim_min = y_center - (max_range / aspect_ratio) / 2
    y_lim_max = y_center + (max_range / aspect_ratio) / 2

    ax.set_xlim([x_lim_min, x_lim_max])
    ax.set_ylim([y_lim_min, y_lim_max])

    ax.set_axis_off()

    plt.tight_layout()
    plt.show()










def create_graph_data(hubs, links, satellites, hub_link_edges, link_satellite_edges, hub_satellite_edges):
    graph_data = {"nodes": [], "links": []}

    for hub in hubs:
        graph_data["nodes"].append({"id": hub, "border_color": "red", "fill_color": "lightpink"})

    for link in links:
        graph_data["nodes"].append({"id": link, "border_color": "blue", "fill_color": "lightblue"})

    for satellite in satellites:
        graph_data["nodes"].append({"id": satellite, "border_color": "black", "fill_color": "white"})

    for link_index, hub_indices in hub_link_edges.items():
        for hub_index in hub_indices:
            graph_data["links"].append({"source": hubs[hub_index], "target": links[link_index]})

    for link_index, satellite_indices in link_satellite_edges.items():
        for satellite_index in satellite_indices:
            graph_data["links"].append({"source": links[link_index], "target": satellites[satellite_index]})

    for hub_index, satellite_indices in hub_satellite_edges.items():
        for satellite_index in satellite_indices:
            graph_data["links"].append({"source": hubs[hub_index], "target": satellites[satellite_index]})

    svg_height=300 + 10 * len(graph_data["nodes"])
    svg_width=700

    html_content = generate_draggable_graph_html_color(graph_data, svg_height=svg_height, svg_width=svg_width)
    return wrap_in_iframe(html_content, width=svg_width+20, height=svg_height+20)




