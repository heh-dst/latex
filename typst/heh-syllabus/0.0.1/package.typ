#import "@preview/zebraw:0.6.3": *
#import "@preview/hydra:0.6.3": anchor, hydra
#import "@heh-dst/heh-style:0.0.1": *
#import "environments.typ": *
#import "front-pages.typ": *

#let heh-syllabus(
  academic-year: [ 2026~--~2027 ],
  bind-correction: 0.5cm,
  course: "Programmation",
  cursus: "Bachelier en techniques graphiques",
  subtitle: "Syllabus de théorie",
  body,
) = {
  show: heh-defaults

  heh-syllabus-cover-page(academic-year, bind-correction, course, cursus, subtitle)

  pagebreak(to: "odd")

  heh-syllabus-title-page(bind-correction, course, cursus, subtitle)

  set page(
    header: anchor(),
    footer: context {
      let chapter-heading = query(heading.where(level: 1).before(here())).last()
      line(length: 100%, stroke: (thickness: 0.5pt))
      v(-0.5em)
      if calc.odd(here().page()) {
        align(right, move(dy: -0.7em)[
          #if chapter-heading.location().page() != here().page() {
            box(inset: 0.5em, hydra(2))
          }
          #box(inset: 0.5em, stroke: (left: 0.5pt), counter(page).display("1"))
        ])
      } else {
        align(left, move(dy: -0.7em)[
          #box(inset: 0.5em, stroke: (right: 0.5pt), counter(page).display("1"))
          #box(inset: 0.5em, hydra(1))
        ])
      }
    },
    margin: (inside: 2.5cm + bind-correction, rest: 2.5cm),
    numbering: "1",
  )
  show heading.where(level: 1): set text(hyphenate: false)
  show heading.where(level: 2): set text(size: 1.777em)
  show heading.where(level: 2): set heading(supplement: "Section")
  show heading.where(level: 3): set text(size: 1.333em)
  show heading.where(level: 3): set heading(supplement: "Point")

  show figure.where(kind: table): set figure(supplement: [Tableau])

  show: zebraw.with(
    background-color: white.transparentize(100%),
    lang: false,
    numbering-font-args: (fill: luma(120), size: 0.8em),
    numbering-separator: true,
  )

  set outline(depth: 2)

  body
}

