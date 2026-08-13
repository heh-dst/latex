#import "@heh-dst/heh-style:0.0.1": color-palette
#let question-counter = counter("question")
#let subquestion-counter = counter("subquestion")
#let total = state("total", 0)

#let question(points: none, it) = {
  question-counter.step()
  subquestion-counter.update(0)
  total.update(c => c + points)
  grid(
    columns: (2em, 1fr),
    column-gutter: 0.25em,

    align(center, strong(context question-counter.display("1."))), [#if points != none [ (#points points)] #it],
  )
}

#let subquestion(points: none, it) = {
  subquestion-counter.step()
  total.update(c => c + points)
  grid(
    columns: (2em, 1fr),
    column-gutter: 0.25em,

    align(center, strong(context subquestion-counter.display("(a)"))), [#if points != none [ (#points points)] #it],
  )
}

#let solution = it => context {
  let show-solutions-arg = lower(sys.inputs.at("show-solutions", default: "no"))
  if show-solutions-arg in ("true", "yes", "oui", "1") {
    block(it, fill: color-palette.orange.lighten(50%), inset: 0.8em, radius: 0.25em)
  } else {
    return none
  }
}
