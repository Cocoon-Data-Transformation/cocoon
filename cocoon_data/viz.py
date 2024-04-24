
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
  

