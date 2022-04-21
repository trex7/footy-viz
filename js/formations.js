// helper functions
function dottype(d) {
    d.x = +d.x;
    d.y = +d.y;
    return d;
  }
  
function dragstarted(d) {
    d3.event.sourceEvent.stopPropagation();
    d3.select(this);
}
  
function dragged(d) {
    d3.select(this)
        .attr("cx", d.x = d3.event.x)
        .attr("cy", d.y = d3.event.y)
        .style("opacity", .5);
}

function dragended(d) {
    d3.select(this)
    .style("opacity", 1);
}

// setup the board - called after DOM loads
document.addEventListener("DOMContentLoaded", function(event) { 
    var holder = d3.select("#positions-board") // select the 'body' element
    .append("svg")           // append an SVG element to the body
    .attr("width", 1000)      
    .attr("height", 500);  

    // draw a rectangle - pitch
    holder.append("rect")        // attach a rectangle
        .attr("x", 0)         // position the left of the rectangle
        .attr("y", 0)          // position the top of the rectangle
        .attr("height", 500)    // set the height
        .attr("width", 1000)    // set the width
        .style("stroke-width", 5)    // set the stroke width
        .style("stroke", "#ffffff")    // set the line color
        .style("fill", "#9ed072");    // set the fill color
        
    // draw a rectangle - halves
    holder.append("rect")        // attach a rectangle
        .attr("x", 0)         // position the left of the rectangle
        .attr("y", 0)          // position the top of the rectangle
        .attr("height", 500)    // set the height
        .attr("width", 500)    // set the width
        .style("stroke-width", 5)    // set the stroke width
        .style("stroke", "#ffffff")    // set the line color
        .style("fill", "#9ed072");    // set the fill color 

    // draw a circle - center circle
    holder.append("circle")          // attach a circle
        .attr("cx", 500)             // position the x-center
        .attr("cy", 250)             // position the y-center
        .attr("r", 50)               // set the radius
        .style("stroke-width", 5)    // set the stroke width
        .style("stroke", "#ffffff")      // set the line color
        .style("fill", "none");      // set the fill color

    // draw a rectangle - penalty area 1
    holder.append("rect")        // attach a rectangle
        .attr("x", 0)         // position the left of the rectangle
        .attr("y", 105)          // position the top of the rectangle
        .attr("height", 290)    // set the height
        .attr("width", 170)    // set the width
        .style("stroke-width", 5)    // set the stroke width
        .style("stroke", "#ffffff")    // set the line color
        .style("fill", "#9ed072");    // set the fill color

    // draw a rectangle - penalty area 2
    holder.append("rect")        // attach a rectangle
        .attr("x", 830)         // position the left of the rectangle
        .attr("y", 105)          // position the top of the rectangle
        .attr("height", 290)    // set the height
        .attr("width", 170)    // set the width
        .style("stroke-width", 5)    // set the stroke width
        .style("stroke", "#ffffff")    // set the line color
        .style("fill", "#9ed072");    // set the fill color 

    // draw a rectangle - six yard box 1
    holder.append("rect")        // attach a rectangle
        .attr("x", 0)         // position the left of the rectangle
        .attr("y", 184)          // position the top of the rectangle
        .attr("height", 132)    // set the height
        .attr("width", 60)    // set the width
        .style("stroke-width", 5)    // set the stroke width
        .style("stroke", "#ffffff")    // set the line color
        .style("fill", "#9ed072");    // set the fill color

    // draw a rectangle - six yard box 2
    holder.append("rect")        // attach a rectangle
        .attr("x", 940)         // position the left of the rectangle
        .attr("y", 184)          // position the top of the rectangle
        .attr("height", 132)    // set the height
        .attr("width", 60)    // set the width
        .style("stroke-width", 5)    // set the stroke width
        .style("stroke", "#ffffff")    // set the line color
        .style("fill", "#9ed072");    // set the fill color
        
    // draw a circle - penalty spot 1
    holder.append("circle")        // attach a circle
        .attr("cx", 120)           // position the x-center
        .attr("cy", 250)           // position the y-center
        .attr("r", 5)             // set the radius
        .style("fill", "#ffffff");     // set the fill color

    // draw a circle - penalty spot 2
    holder.append("circle")        // attach a circle
        .attr("cx", 880)           // position the x-centre
        .attr("cy", 250)           // position the y-centre
        .attr("r", 5)             // set the radius
        .style("fill", "#ffffff");     // set the fill color

    // draw a circle - center spot
    holder.append("circle")        // attach a circle
        .attr("cx", 500)           // position the x-centre
        .attr("cy", 250)           // position the y-centre
        .attr("r", 5)             // set the radius
        .style("fill", "#ffffff");     // set the fill color

    // circles
    var arc = d3.arc()
        .innerRadius(70)
        .outerRadius(75)
        .startAngle(0.75) //radians
        .endAngle(2.4) //just radians
        
    var arc2 = d3.arc()
        .innerRadius(70)
        .outerRadius(75)
        .startAngle(-0.75) //radians
        .endAngle(-2.4) //just radians

    holder.append("path")
        .attr("d", arc)
        .attr("fill", "#ffffff")
        .attr("transform", "translate(120,250)");

    holder.append("path")
        .attr("d", arc2)
        .attr("fill", "#ffffff")
        .attr("transform", "translate(880,250)");

    var color = d3.scaleOrdinal().range(["#14293c", "pink"]);
    var color1 = d3.scaleOrdinal().range(["#14293c", "red"]);

    var drag = d3
        .drag()
        .on('start', dragstarted)
        .on('drag', dragged)
        .on('end', dragended)

    // initial setup
    function default_setup () {
            d3.csv("https://raw.githubusercontent.com/timschott/footy-viz/main/extra/3_4_2_1.csv", dottype, function(error, dots) {
            dot = holder.append("g")
            .selectAll(".circle_players")
            .data(dots)
            .enter()
            .append("circle")
            .attr("class", "circle_players")
                .attr("r", 14)
                .attr("cx", function(d) { return d.x; })
                .attr("cy", function(d) { return d.y; })
                .style("fill", function(d) { return color(d.team); })
                .style("stroke", function(d) { return color1(d.team); })
            .append("text")
            .attr("name", function(d) {return d.name})
            .attr("opacity", "1") 
            .style("fill", "white")
            .call(drag)

            });
        }
    // initializes the background
    default_setup();
});

//todo: add display for player names, especially defense.
//todo: add a title that injects the current graph setup so it's clear what's being displayed
//and a description of what is being shown
function default_lineup(){
    d3.csv("https://raw.githubusercontent.com/timschott/footy-viz/main/extra/3_4_2_1.csv", dottype, function(error, dots) {
      var dot = d3.selectAll(".circle_players").data(dots)
            .transition()
            .duration(1000)
            .attr("cx", function(d) { return d.x; })
            .attr("cy", function(d) { return d.y; });
    });

    document.getElementById('tactics-title').getElementsByTagName('span')[0].innerHTML = '3-4-2-1';
    document.getElementById('tactics-explainer').innerHTML = 'This formation is relatively conservative, especially given the personnel choices on defense. England scored a goal 2 minutes after kickoff, but managed just 1 shot on target the rest of the match. Trent-Alexander Arnold did not play, while Mason Mount and Harry Kane performed poorly.';
}

function new_lineup(){
    d3.csv("https://raw.githubusercontent.com/timschott/footy-viz/main/extra/4_2_3_1.csv", dottype, function(error, dots) {
      var dot = d3.selectAll(".circle_players").data(dots)
            .transition()
            .duration(1000)
            .attr("cx", function(d) { return d.x; })
            .attr("cy", function(d) { return d.y; });
    });

    document.getElementById('tactics-title').getElementsByTagName('span')[0].innerHTML = '4-2-3-1';
    document.getElementById('tactics-explainer').innerHTML = 'This formation would allow England to attack aggressively and maintain a higher average field position. It would also play to the strengths of Trent Alexander-Arnold, whose absence in the Euro 2020 Final was sorely missed; his passing ability can unlock oppositions, evidenced by his incredible assist record.';
}