#import "@heh-dst/heh-style:0.0.1": *
#import "questions.typ": *

#let heh-exam(
  author: (),
  course: [],
  cursus: [],
  title: [],
  it,
) = {
  set document(
    title: [#title - #course],
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
    header: context {
      set text(fill: color-palette.gray, size: 10pt)
      if here().page() > 1 {
        table(
          align: left + top,
          columns: (1fr, 1fr),
          rows: 1cm,
          stroke: 0.5pt + color-palette.gray,
          [Nom :], [Prénom :],
        )
      }
    },
    numbering: "1",
  )

  show raw.where(block: false): box.with(inset: (x: 0.3em, y: 0pt), fill: luma(240), outset: (y: 0.3em), radius: 0.2em)

  show raw.where(block: true): block.with(inset: 0.5em, fill: luma(240), radius: 0.4em)

  show heading.where(level: 1): set block(above: 1.5em, below: 0.75em)
  show heading.where(level: 1): set text(fill: color-red-palette.at(0))
  show heading.where(level: 1): it => {
    place(
      dx: -0.5cm,
      dy: -0.2em,
      rect(width: 0.2cm, height: 1.2em, fill: color-red-palette.at(0)),
    )
    it
  }

  move(dy: -2em, {
    box(baseline: top, left-header)
    h(1fr)
    box(baseline: top, right-header)
  })

  {
    set text(fill: color-palette.gray, size: 10pt)
    table(
      align: left + top,
      columns: (1fr, 1fr),
      rows: 1cm,
      stroke: 0.5pt + color-palette.gray,
      [Nom :], [Prénom :],
      [Groupe :], [Date :],
    )
  }
  align(center, text(size: 1.777em, weight: "bold", block(above: 1em, below: 0.5em, title)))

  it
}

