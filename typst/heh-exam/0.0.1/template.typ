#import "@heh-dst/heh-style:0.0.1": heh-defaults, heh-dst-logo
#import "questions.typ": *

#let heh-exam(
  author: (),
  course: [],
  cursus: [],
  title: [],
  subtitle: [],
  it,
) = {
  set document(
    title: title,
    author: author,
  )

  show: heh-defaults

  set text(size: 12pt)

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

