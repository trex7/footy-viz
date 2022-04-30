document.addEventListener("DOMContentLoaded", function(event) { 
    // set the dimensions and margins of the graph
    var margin = {top: 10, right: 30, bottom: 90, left: 40},
        width = 860 - margin.left - margin.right,
        height = 850 - margin.top - margin.bottom;

    // append the svg object to the body of the page
    var svg = d3.select("#goal-numbers-container")
    .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
    .append("g")
        .attr("transform",
            "translate(" + margin.left + "," + margin.top + ")");

    // parse the data
    d3.csv("https://raw.githubusercontent.com/timschott/footy-viz/main/extra/top_scorers_df.csv", function(data) {

    // x axis
    var x = d3.scaleBand()
    .range([ 0, width ])
    .domain(data.map(function(d) { return d.Player; }))
    .padding(0.2);
    svg.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x))
    .selectAll("text")
        .attr("transform", "translate(-10,0)rotate(-45)")
        .style("text-anchor", "end");

    // y axis
    var y = d3.scaleLinear()
        .domain([0, 10])
        .range([ height, 0]);
    svg.append("g")
        .call(d3.axisLeft(y));

    // bars
    svg.selectAll("mybar")
    .data(data)
    .enter()
    .append("rect")
        .attr("x", function(d) { return x(d.Player); })
        .attr("width", x.bandwidth())
        // no bar at the beginning thus:
        .attr("height", function(d) { return height - y(0); }) // always equal to 0
        .attr("y", function(d) { return y(0); })
        .style("fill", function(d) {
            if (d.Player == "Kane") {
                return "#56B4E9"
            } else {
                return "#999999";
            }
       })

    // animation
    svg.selectAll("rect")
    .transition()
    .duration(800)
    .attr("y", function(d) { return y(d.Goals); })
    .attr("height", function(d) { return height - y(d.Goals); })
    .delay(function(d,i){return(i*100)})

    })

    // title
    svg.append("text")
        .attr("x", (width / 2))             
        .attr("y", 0 - (margin.top / 2))
        .attr("text-anchor", "middle")  
        .style("font-size", "16px") 
        .text("Top Goal Scorers, 2018 World Cup and 2020 Euro Cup");
})