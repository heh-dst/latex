#import "@preview/fletcher:0.5.8" as fletcher: diagram, node
#import fletcher.shapes: diamond, pill
#import "package.typ": color-palette

#let flowchart-colors = (
  begin: color-palette.bluish-green.lighten(75%),
  condition: color-palette.orange.lighten(75%),
  end: color-palette.reddish-purple.lighten(75%),
)

#let flowchart(..args) = diagram(
  node-fill: color-palette.white,
  node-stroke: color-palette.black,
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

