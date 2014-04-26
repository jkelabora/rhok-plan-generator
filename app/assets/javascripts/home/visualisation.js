// Collapsible Force Layout
// http://bl.ocks.org/mbostock/1093130
function force_directed(chart_width, chart_height) {

  d3.select("#chart").selectAll('svg').remove();

  var width = chart_width,
      height = chart_height,
      root;

  var force = d3.layout.force()
      .linkDistance(200)
      .charge(-670)
      .gravity(.05)
      .size([width, height])
      .on("tick", tick);

  var svg = d3.select("#chart").append("svg")
      .attr("width", width)
      .attr("height", height);

  var link = svg.selectAll(".link"),
      node = svg.selectAll(".node");

  d3.json("home/visualisation.json", function(error, json) {
    root = json;
    update();

    // Initialize the display to show a few nodes.
    // from: http://stackoverflow.com/questions/17504136/starting-d3-force-layout-collapsed-text-labels-duplicating
    function collapseAll(d) {
      if (d.children) {
        d.children.forEach(collapseAll);
        toggle(d);
      }
    }
    root.children.forEach(collapseAll);
    update(root);
  });

  function update() {
    var nodes = flatten(root),
    links = d3.layout.tree().links(nodes);

    // Restart the force layout.
    force
      .nodes(nodes)
      .linkDistance(200)
      .charge(-670)
      .gravity(.05)
      .links(links)
      .start();

    // Update nodes.
    node = node.data(nodes, function(d) { return d.id; });

    node.exit().remove();

    var nodeEnter = node.enter().append("g")
        .attr("class", node_class)
        .on("click", toggle)
        .call(force.drag);

    // use a proper link for viewing a plan
    nodeEnter.append("foreignObject")
        .attr("width", 80)
        .attr("height", 25)
        .append("xhtml:div")
        .html(function(d) {
          if (d.view_node == true) {
            uri = "/plans/" + d.guid + "/show"
            return "<a href='"+uri+"'>view!</a>";
          }
        });

    nodeEnter.append("circle")
        .attr("r", function(d) { return d.size * 3 });

    nodeEnter.append("text")
        .attr("dy", ".35em")
        .text(function(d) { return d.name; });

    node.select("circle")
        .style("fill", color);

    // Update links.
    link = link.data(links, function(d) { return d.target.id; });

    link.exit().remove();

    link.enter().insert("line", ".node")
        .attr("class", "link");

  }

  function tick() {

    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

  }

  function color(d) {
    if (d.root_node == true) {
      return "#C2DEFC";
    }
    if (d.view_node == true) {
      return "#fd8d3c";
    }
    if (d.postcode_node == true) {
      return d.children ? "#CB99FF" : "#DFC2FF";
    }
    var private_plan = "#E69B9B";
    var contracted = "#61B0E9";
    var expanded = "#c6dbef";
    return d._children ? expanded : d.children ? contracted : private_plan;
  }

  function node_class(d) {
    if (d.root_node == true) {
      return "node root_node";
    }
    if (d.view_node == true) {
      return "node view_node";
    }
    if (d.postcode_node == true) {
      return "node postcode_node";
    } else {
      return "node";
    }
  }

  // Toggle children on click.
  function toggle(d) {
    if (d.view_node == true) {
      d3.event.defaultPrevented;
      return;
    }
    if (d.children) {
      d._children = d.children;
      d.children = null;
    } else {
      d.children = d._children;
      d._children = null;
    }
    update();
  }

  // Returns a list of all nodes under the root.
  function flatten(root) {
    var nodes = [], i = 0;

    function recurse(node) {
      if (node.children) node.children.forEach(recurse);
      if (!node.id) node.id = ++i;
      nodes.push(node);
    }

    recurse(root);
    return nodes.reverse(); // to control the z-indexes (done in order of append)
  }

}

// this should be moved from here.. related to home/_summary_view.html.erb
function togglePublicPlans() {
  $('tr.public-plan-content').toggle();
}


$(function($) { // document ready
  var chart_width  = $('div#chart').width(),
      chart_height = 800;
  force_directed(chart_width, chart_height);

  togglePublicPlans(); // should be moved as well.. collapses home/_summary_view.html.erb content on load

});
