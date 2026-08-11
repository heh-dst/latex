#import "@heh-dst/heh-style:0.0.1": *

#let question-counter = counter("question")
#let subquestion-counter = counter("subquestion")
#let total = state("total", 0)
#let show-solutions-state = state("show-solutions", false)

#let heh-exam(
  course: [],
  cursus: [],
  show-solutions: false,
  subtitle: [],
  it,
) = {
  show: heh-defaults

  show-solutions-state.update(show-solutions)

  set text(size: 10pt) if show-solutions
  set text(size: 12pt) if not show-solutions

  let left-header = {
    heh-dst-logo()
  }

  let right-header = align(right)[
    #cursus \
    #course
  ]

  set page(
    numbering: "1",
  )

  show raw.where(block: false): box.with(inset: (x: 0.3em, y: 0pt), fill: luma(240), outset: (y: 0.3em), radius: 0.2em)

  show raw.where(block: true): block.with(inset: 0.5em, fill: luma(240), radius: 0.4em)

  context {
    if counter(page).get().first() == 1 {
      move(dy: -2em, {
        box(baseline: top, left-header)
        h(1fr)
        box(baseline: top, right-header)
      })
    } else {
      return none
    }
  }

  align(center)[
    #text(size: 1.777em, weight: "bold", subtitle)
    #v(1em)
  ]

  it
}

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
  if show-solutions-state.get() {
    block(it, fill: color-palette.orange.lighten(50%), inset: 0.8em, radius: 0.25em)
  } else {
    return none
  }
}

