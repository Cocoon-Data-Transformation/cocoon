import json
import matplotlib.pyplot as plt
import numpy as np
from matplotlib_venn import venn2
import seaborn as sns
import base64
from graphviz import Digraph

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






