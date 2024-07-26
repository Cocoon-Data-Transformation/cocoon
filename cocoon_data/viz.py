import json
import matplotlib.pyplot as plt
import numpy as np
from matplotlib_venn import venn2
import seaborn as sns
import base64
from graphviz import Digraph, Graph
from matplotlib.ticker import EngFormatter
import networkx as nx
from IPython.display import HTML
import io
from pygments import highlight
from pygments.lexers import PythonLexer, SqlLexer, YamlLexer
from pygments.formatters import Terminal256Formatter, HtmlFormatter
import html

_cocoon_global_values = {
    'IMAGE_MODE': "graphviz"
}

def get_image_mode():
    return _cocoon_global_values['IMAGE_MODE']

def set_image_mode(value):
    _cocoon_global_values['IMAGE_MODE'] = value

def wrap_in_iframe(html_code, width=800, height=400):

    escaped_html = html_code.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#039;")

    iframe_code = f"<iframe srcdoc=\"{escaped_html}\" width=\"{width}\" height=\"{height}\" frameborder=\"0\"></iframe>"

    return iframe_code


def plot_venn_percentage_by_stats(only1, only2, overlap, name1, name2):
    fig, ax = plt.subplots(figsize=(3, 2))
   
    total_elements = only1 + only2 + overlap
    if total_elements == 0:
        overlap = 0
        only_set1 = 0
        only_set2 = 0
    else:
        overlap =  overlap/ total_elements * 100
        only_set1 = only1 / total_elements * 100
        only_set2 = only2 / total_elements * 100
    font_size=8
   
    venn_diagram = venn2(subsets=(only_set1, only_set2, overlap), set_labels=(name1, name2), ax=ax)
    for patch in venn_diagram.patches:
        if patch:
            patch.set_alpha(0.5)
    if only_set1 > 0:
        venn_diagram.get_label_by_id('10').set_text(f'{round(only_set1, 1)}%')
        venn_diagram.get_label_by_id('10').set_fontsize(font_size)
    else:
        venn_diagram.get_label_by_id('10').set_text('')
    if only_set2 > 0:
        venn_diagram.get_label_by_id('01').set_text(f'{round(only_set2, 1)}%')
        venn_diagram.get_label_by_id('01').set_fontsize(font_size)
    else:
        venn_diagram.get_label_by_id('01').set_text('')
    if overlap > 0 and venn_diagram.get_label_by_id('11'):
        venn_diagram.get_label_by_id('11').set_text(f'{round(overlap, 1)}%')
        venn_diagram.get_label_by_id('11').set_fontsize(font_size)
    else:
        venn_diagram.get_label_by_id('11').set_text('')
    for label in venn_diagram.set_labels:
        label.set_fontsize(font_size)
       
    buffer = io.BytesIO()
    plt.tight_layout()
    plt.savefig(buffer, format='png')
    plt.close(fig)
    buffer.seek(0)
   
    image_base64 = base64.b64encode(buffer.getvalue()).decode()
   
    return image_base64


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
    
    if "nodes" not in data or "links" not in data:
        raise ValueError("The data dictionary must contain 'nodes' and 'links' keys")
    
    for node in data["nodes"]:
        if "border_color" not in node:
            node["border_color"] = "black"
        if "fill_color" not in node:
            node["fill_color"] = "white"
    
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
  .links line {{
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
      .enter().append("line")
      .style("stroke", function(d) {{ return d.color || "#aaa"; }});

var node = svg.append("g")
    .attr("class", "nodes")
    .selectAll("g")
    .data(graph.nodes)
    .enter().append("g")
    .call(d3.drag()
        .on("start", dragstarted)
        .on("drag", dragged)
        .on("end", dragended));

// Append the shapes based on node shape
node.each(function(d) {{
    if (d.shape === "ellipse") {{
        d3.select(this).append("ellipse")
            .attr("cx", nodeWidth/2)
            .attr("cy", nodeHeight/2)
            .attr("rx", nodeWidth / 2)
            .attr("ry", nodeHeight / 2)
            .style("stroke", d.borderColor || "#aaa")
            .style("fill", d.fillColor || "#fff");
    }} else {{
        d3.select(this).append("rect")
            .attr("width", nodeWidth)
            .attr("height", nodeHeight)
            .style("stroke", d.borderColor || "#aaa")
            .style("fill", d.fillColor || "#fff");
    }}
}});

// Then append the text
var texts = node.append("text")
    .attr("class", "nodetext")
    .attr("x", nodeWidth / 2)
    .attr("y", nodeHeight / 2)
    .text(function(d) {{ return d.id; }});

// Update the width of the shapes and reposition the text
node.each(function(d, i) {{
    var shape = d3.select(this).select(d.shape);
    var text = d3.select(this).select("text");

    var textLength = text.node().getComputedTextLength();
    var newWidth = textLength + 40;

    // Update shape width
    if (d.shape === "ellipse") {{
        let newWidthEllipse = newWidth;
        shape.attr("rx", newWidthEllipse / 2);
        shape.attr("cx", newWidthEllipse / 2);
    }} else {{
        shape.attr("width", newWidth);
    }}

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














def generate_workflow_image(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, node_shape=None, directional=True, format='svg'):
    if directional:
        dot = Digraph(format=format)
    else:
        dot = Graph(format=format)

    if highlight_nodes_indices is None:
        highlight_nodes_indices = []
    if highlight_edges_indices is None:
        highlight_edges_indices = []

    node_style = {
        'style': 'filled',
        'fillcolor': '#ffffff',
        'color': '#000000',
        'shape': 'box',
        'fontname': 'Segoe UI',
        'fontsize': '8',
        'margin': '0,0',
        'fontcolor': '#000000',
        'height': '0.3',
        'width': '0.5'
    }

    highlighted_node_style = {
        'fillcolor': '#e1f5fe',
        'color': '#4fc3f7'
    }

    edge_style = {
        'color': '#000000',
        'arrowsize': '0.6',
        'penwidth': '0.6',
        'fontname': 'Helvetica',
        'fontsize': '8',
        'fontcolor': '#2E4057',
    }

    highlighted_edge_style = {
        'color': '#4fc3f7',
        'penwidth': '1.0'
    }

    for i, node in enumerate(nodes):
        if node_shape and i < len(node_shape):
            node_style['shape'] = node_shape[i]
        if i in highlight_nodes_indices:
            dot.node(node, node, **{**node_style, **highlighted_node_style})
        else:
            dot.node(node, node, **node_style)

    for i, (tail, head) in enumerate(edges):
        label = edge_labels[i] if edge_labels and i < len(edge_labels) else ''
        if i in highlight_edges_indices:
            if directional:
                dot.edge(nodes[tail], nodes[head], label=label, **{**edge_style, **highlighted_edge_style})
            else:
                dot.edge(nodes[tail], nodes[head], label=label, dir='none', **{**edge_style, **highlighted_edge_style})
        else:
            if directional:
                dot.edge(nodes[tail], nodes[head], label=label, **edge_style)
            else:
                dot.edge(nodes[tail], nodes[head], label=label, dir='none', **edge_style)


    image = dot.pipe()
    return image

def wrap_image_in_html(image_data, height=None, format='svg'):
    height_str = f'max-height: {height}px; ' if height else ''
    if format == 'svg':
        svg_content = image_data.decode('utf-8')
        scrollable_html = f"""
        <div style="{height_str}overflow: auto; border: 1px solid #cccccc;">
            {svg_content}
        </div>
        """
    else:
        encoded_image = base64.b64encode(image_data).decode()
        mime_type = f'image/{format}'
        scrollable_html = f"""
        <div style="m{height_str}overflow: auto; border: 1px solid #cccccc;">
            <img src="data:{mime_type};base64,{encoded_image}" style="display: block; max-width: none; height: auto;">
        </div>
        """
    return scrollable_html

def generate_workflow_html_multiple_graphviz(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, node_shape=None, directional=True, height=None, format='svg'):
    try:
        image_data = generate_workflow_image(nodes, edges, edge_labels, highlight_nodes_indices, highlight_edges_indices, node_shape, directional, format)
        return wrap_image_in_html(image_data, height, format)
    except:
        return """
<div style="font-family: sans-serif; padding: 10px; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 5px; color: #721c24;">
    <p style="margin: 0 0 10px 0; line-height: 1.4;">⚠️ <strong>Error:</strong> Cocoon needs graphviz installed to generate visualizations.</p>
    <p style="margin: 0 0 10px 0; line-height: 1.4;">To install, visit the <a href="https://graphviz.org/download/" target="_blank">Graphviz website</a>.</p>
    <p style="margin: 0; line-height: 1.4;">Alternatively, run: <code>set_image_mode("mermaid")</code></p>
</div>
"""        

def generate_workflow_html_multiple(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, node_shape=None, directional=True, height=None, format='svg'):
    if _cocoon_global_values['IMAGE_MODE'] == 'graphviz':
        return generate_workflow_html_multiple_graphviz(nodes, edges, edge_labels, highlight_nodes_indices, highlight_edges_indices, node_shape, directional, height, format)
    else:
        return generate_workflow_html_multiple_mermaid(nodes, edges, edge_labels, highlight_nodes_indices, highlight_edges_indices, node_shape, directional, height)

def generate_node_id(index):
    """Generate a unique node ID for a given index."""
    if index < 26:
        return chr(65 + index)
    else:
        quotient, remainder = divmod(index, 26)
        return generate_node_id(quotient - 1) + chr(65 + remainder)
    
def generate_mermaid_code(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, node_shape=None, directional=True):
    mermaid_code = []
    mermaid_code.append("graph TD")

    shape_map = {
        "circle": "(({}))",
        "box": "[{}]",
        "diamond": "{{{}}}",
        "oval": "([{}])",
        "hexagon": "{{{{{}}}}}",
        "parallelogram": "[/{}/]",
        "trapezoid": "[\\{}/]"
    }

    for i, node in enumerate(nodes):
        shape = shape_map.get(node_shape[i] if node_shape else "box", "[{}]")
        mermaid_code.append(f"    {generate_node_id(i)}{shape.format(html.escape(node))}")

    for i, (start, end) in enumerate(edges):
        connector = "-->" if directional else "---"
        edge_label = ""
        if edge_labels and i < len(edge_labels):
            edge_label = f"|{html.escape(edge_labels[i])}|"
        edge_str = f"    {generate_node_id(start)}{connector}{edge_label}{generate_node_id(end)}"
        
        mermaid_code.append(edge_str)

    mermaid_code.append("    classDef default fill:#f9f9f9,stroke:#999,stroke-width:1px;")
     
    if highlight_nodes_indices or highlight_edges_indices:
        mermaid_code.append("    classDef highlight fill:#e1f5fe,stroke:#4fc3f7,stroke-width:2px;")
    
    if highlight_nodes_indices:
        highlight_nodes = ",".join([generate_node_id(i) for i in highlight_nodes_indices])
        mermaid_code.append(f"    class {highlight_nodes} highlight;")
    
    mermaid_code.append("    linkStyle default stroke:#999,stroke-width:1px;")
    if highlight_edges_indices:
        highlight_edges = ",".join(map(str, highlight_edges_indices))
        mermaid_code.append(f"    linkStyle {highlight_edges} stroke:#4fc3f7,stroke-width:2px;")
    
    return mermaid_code


def generate_workflow_html_multiple_mermaid(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, node_shape=None, directional=True, height=300):
    mermaid_code = generate_mermaid_code(nodes, edges, edge_labels, highlight_nodes_indices, highlight_edges_indices, node_shape, directional)
    html_content = f"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workflow Diagram</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mermaid/9.3.0/mermaid.min.js"></script>
</head>
<body>
    <div id="mermaid-diagram" style="height: {height}px;">
        <pre class="mermaid">
            %%{{init: {{'theme': 'neutral', 'themeVariables': {{ 'fontFamily': 'Segoe UI'}}}}}}%%
            {chr(10).join(mermaid_code)}
        </pre>
    </div>
    <script>
        mermaid.initialize({{ 
            startOnLoad: true,
            flowchart: {{
                curve: 'basis'
            }}
        }});
    </script>
</body>
</html>
"""
    if height is None:
        height = 300
    width = 500 + len(nodes) * 100
    return wrap_in_iframe(html_content, width=width, height=height+20)









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





border_style = """
<style>
.border-class {
    border: 1px solid black;
    padding: 10px;
    margin: 10px;
    font-size: 12px;
}
</style>
"""

def highlight_sql_only(sql_query):
    formatter = HtmlFormatter(style='monokai')
    return highlight(sql_query, SqlLexer(), formatter)

def highlight_sql(sql_query):
    formatter = HtmlFormatter(style='monokai')
    css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"
    combined_css = css_style + border_style
    highlighted_sql = wrap_in_scrollable_div(highlight(sql_query, SqlLexer(), formatter), height='600px')
    bordered_content = f'<div class="border-class">{highlighted_sql}</div>'
    combined_html = combined_css + bordered_content
    return combined_html



def highlight_yml_only(yml_content):
    formatter = HtmlFormatter(style='native')
    return highlight(yml_content, YamlLexer(), formatter)

def highlight_yml(yml_content):
    formatter = HtmlFormatter(style='native')
    css_style = f"<style>{formatter.get_style_defs('.highlight')}</style>"

    highlighted_yml = highlight(yml_content, YamlLexer(), formatter)

    bordered_content = f'<div class="border-class">{highlighted_yml}</div>'

    combined_html = css_style + border_style + bordered_content
    return combined_html

def wrap_in_scrollable_div(html_code, width='100%', height='200px'):
    scrollable_div = f'<div style="width: {width}; overflow: auto; max-height: {height};">{html_code}</div>'

    return scrollable_div

def visualize_table_mapping(table1_name, table1_cols, table2_name, table2_cols, mappings):
    dot = Digraph(format="svg")
    dot.attr(rankdir='LR')
    dot.attr(splines='ortho') 
    dot.attr('node', shape='rectangle', fontname='Segoe UI', fontsize='10')
    dot.attr('edge', penwidth='1')
    dot.attr(bgcolor='transparent')
    
    dot.graph_attr['nodesep'] = '0.1'
    dot.graph_attr['ranksep'] = '1.5'

    with dot.subgraph(name='cluster_0') as c:
        c.attr(style='filled')
        c.node_attr.update(height='0.3', width='1.5')
        c.attr(label=f'{table1_name}', fontname='Segoe UI', fontsize='14', margin='12')
        for col in table1_cols:
            c.node(f"{table1_name}_{col}", col, fontname='Segoe UI', color='#000000')

    with dot.subgraph(name='cluster_1') as c:
        c.attr(style='filled')
        c.node_attr.update(height='0.3', width='1.5')
        c.attr(label=f'{table2_name}', fontname='Segoe UI', fontsize='14', margin='12')
        for col in table2_cols:
            c.node(f"{table2_name}_{col}", col, fontname='Segoe UI', color='#000000')

    for t1_col, t2_col in mappings:
        dot.edge(f"{table1_name}_{t1_col}", f"{table2_name}_{t2_col}", arrowsize='0.6')

    image_data = dot.pipe()
    svg_content = image_data.decode('utf-8')
    scrollable_html = f"""
    <div style="overflow: auto; border: 1px solid #cccccc">
        {svg_content}
    </div>
    """
    return scrollable_html
    





def generate_workflow_image_d3(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, node_shape=None, directional=True, format='svg'):
    graph_data = {
        "nodes": [],
        "links": []
    }

    for i, node in enumerate(nodes):
        node_data = {"id": node}
        
        if node_shape and i < len(node_shape):
            node_data["shape"] = node_shape[i]
        else:
            node_data["shape"] = "rect"
        
        if highlight_nodes_indices and i in highlight_nodes_indices:
            node_data["borderColor"] = "#4fc3f7"
            node_data["fillColor"] = "#e1f5fe"
        else:
            node_data["borderColor"] = "#000000"
            node_data["fillColor"] = "#ffffff"
        
        graph_data["nodes"].append(node_data)

    for i, (tail, head) in enumerate(edges):
        edge_data = {
            "source": nodes[tail],
            "target": nodes[head]
        }
        
        if edge_labels and i < len(edge_labels):
            edge_data["label"] = edge_labels[i]
        
        if highlight_edges_indices and i in highlight_edges_indices:
            edge_data["color"] = "#4fc3f7"
        else:
            edge_data["color"] = "#000000"
        
        graph_data["links"].append(edge_data)

    html_content = generate_draggable_graph_html(graph_data)
    
    return html_content









def generate_workflow_image_networkx(nodes, edges, edge_labels=None, highlight_nodes_indices=None, highlight_edges_indices=None, node_shape=None, directional=True, format='svg'):
    if directional:
        G = nx.DiGraph()
    else:
        G = nx.Graph()

    G.add_nodes_from(range(len(nodes)))
    G.add_edges_from(edges)

    if highlight_nodes_indices is None:
        highlight_nodes_indices = []
    if highlight_edges_indices is None:
        highlight_edges_indices = []

    node_colors = ['#ffffff' if i not in highlight_nodes_indices else '#e1f5fe' for i in range(len(nodes))]

    if node_shape is None:
        node_shape = 'r'
    
    edge_colors = ['#000000' if i not in highlight_edges_indices else '#4fc3f7' for i in range(len(edges))]

    plt.figure(figsize=(5, 4))
    pos = nx.spring_layout(G, k=1, iterations=50)
    
    nx.draw_networkx_edges(G, pos, edge_color=edge_colors, arrows=directional, arrowsize=10, width=0.6)
    
    def get_text_dimensions(text, font_size):
        t = plt.text(0, 0, text, fontsize=font_size)
        bbox = t.get_window_extent(renderer=plt.gcf().canvas.get_renderer())
        t.remove()
        return bbox.width / plt.gcf().dpi, bbox.height / plt.gcf().dpi

    if node_shape == 'r':
        for n in G.nodes():
            label = nodes[n]
            width, height = get_text_dimensions(label, 8)
            width *= 1
            height *= 2
            x, y = pos[n]
            rect = mpatches.Rectangle((x-width/2, y-height/2), width, height, 
                                      fill=True, facecolor=node_colors[n], 
                                      edgecolor='#000000', zorder=2)
            plt.gca().add_patch(rect)
    else:
        nx.draw_networkx_nodes(G, pos, node_color=node_colors, node_size=1000, node_shape=node_shape, edgecolors='#000000')
    
    for n, label in enumerate(nodes):
        x, y = pos[n]
        plt.text(x, y, label, fontsize=8, ha='center', va='center', zorder=3)
    
    if edge_labels:
        edge_labels_dict = {edge: label for edge, label in zip(edges, edge_labels)}
        nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels_dict, font_size=8)

    plt.axis('off')
    plt.tight_layout()

    buf = io.BytesIO()
    plt.savefig(buf, format=format, dpi=300, bbox_inches='tight')
    buf.seek(0)
    image = buf.getvalue()
    plt.close()

    return image



def create_schema_graph(nodes, edges):
    dot = Digraph(format='svg')
    dot.attr(rankdir='LR')

    node_style = {
        'style': 'filled',
        'fillcolor': '#ffffff',
        'color': '#000000',
        'shape': 'none',
        'fontname': 'Helvetica',
        'fontsize': '8',
        'margin': '0',
        'fontcolor': '#2E4057',
    }

    edge_style = {
        'color': '#000000',
        'arrowsize': '0.6',
        'penwidth': '0.6',
        'fontname': 'Helvetica',
        'fontsize': '8',
        'fontcolor': '#2E4057',
    }

    dot.attr('node', **node_style)
    dot.attr('edge', **edge_style)

    table_style = 'BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4"'
    cell_style = 'ALIGN="LEFT" VALIGN="MIDDLE"'
    header_style = 'ALIGN="CENTER" VALIGN="MIDDLE" BGCOLOR="#E0E0E0"'

    for table_name, columns in nodes.items():
        node_html = f'''<<TABLE {table_style}>
                        <TR><TD PORT="header" {header_style}><FONT COLOR="#000000"><B>{table_name}</B></FONT></TD></TR>'''
        for i, column in enumerate(columns):
            node_html += f'<TR><TD PORT="f{i}" {cell_style}>{column}</TD></TR>'
        node_html += '</TABLE>>'
        dot.node(table_name, node_html)

    for parent_table, parent_column, child_table, child_column in edges:
        parent_port = f"{parent_table}:f{nodes[parent_table].index(parent_column)}"
        if child_column is None:
            child_port = f"{child_table}:header"
        else:
            child_port = f"{child_table}:f{nodes[child_table].index(child_column)}"
        dot.edge(parent_port, child_port)

    image = dot.pipe()
    return image

def generate_schema_graph_graphviz(nodes, edges, height=None, format="svg"):
    image_data = create_schema_graph(nodes, edges)
    return wrap_image_in_html(image_data, height=height, format=format)


