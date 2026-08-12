#import "@preview/lovelace:0.3.1": pseudocode-list
#import "content-boxes.typ": *

#let figure-kinds = (
  algorithm: "algorithm",
  code: "code",
  flowchart: "flowchart",
)

#let algorithm(caption: none, content) = figure(
  caption: caption,
  kind: figure-kinds.algorithm,
  supplement: [Algorithme],
  pseudocode-box(
    pseudocode-list(
      line-number-supplement: "Ligne",
      content,
    ),
  ),
)

#let code(caption: none, content) = figure(
  caption: caption,
  kind: figure-kinds.code,
  supplement: [Code],
  code-box(content),
)

#let flowchart(caption: none, content) = figure(
  caption: caption,
  kind: figure-kinds.flowchart,
  supplement: [Ordinogramme],
  flowchart-box(content),
)
