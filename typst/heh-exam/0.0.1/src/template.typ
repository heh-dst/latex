#import "@heh-dst/heh-style:0.0.1": *

#let question-counter = counter("question")
#let subquestion-counter = counter("subquestion")
#let total = state("total", 0)

#let heh-exam(
  course: [],
  cursus: [],
  subtitle: [],
  it,
) = {
  show: heh-defaults

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

  context {
    if (counter(page).get().first() == 1) {
      move(dy: -2em, {
        box(baseline: top, left-header)
        h(1fr)
        box(baseline: top, right-header)
      })
    } else {
      none
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

    align(center, strong(context question-counter.display("1."))), [#if (points != none) [ (#points points)] #it],
  )
}

#let subquestion(points: none, it) = {
  subquestion-counter.step()
  total.update(c => c + points)
  grid(
    columns: (2em, 1fr),
    column-gutter: 0.25em,

    align(center, strong(context subquestion-counter.display("(a)"))), [#if (points != none) [ (#points points)] #it],
  )
}
