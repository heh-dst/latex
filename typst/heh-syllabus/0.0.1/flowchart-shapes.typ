#import "@preview/fletcher:0.5.8" as fletcher: diagram, node
#import fletcher.shapes: diamond, pill

#let flowchart-colors = (
  begin: green.lighten(75%),
  condition: yellow.lighten(75%),
  end: red.lighten(75%),
)

#let flowchart(..args) = diagram(
  node-fill: white,
  node-stroke: black,
  ..args,
)

#let begin(pos) = node(
  shape: pill,
  fill: flowchart-colors.begin,
  pos,
  "Début",
)

#let condition(..args) = node(
  shape: diamond,
  fill: flowchart-colors.condition,
  ..args,
)

#let end(pos) = node(
  shape: pill,
  fill: flowchart-colors.end,
  pos,
  "Fin",
)

