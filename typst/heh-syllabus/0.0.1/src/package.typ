#import "@preview/zebraw:0.6.3": *
#import "colors.typ": *
#import "front-pages.typ": *

#let heh-syllabus(
  academic-year: [ 2026~--~2027 ],
  bind-correction: 0.5cm,
  course: "Programmation",
  cursus: "Bachelier en techniques graphiques",
  subtitle: "Syllabus de théorie",
  body,
) = {
  set page(
    paper: "a4",
  )
  set text(
    font: "IBM Plex Sans",
    lang: "fr",
    size: 11pt,
  )
  show math.equation: set text(font: "STIX Two Math", stylistic-set: 1)
  show raw: set text(font: "FiraCode Nerd Font")

  heh-syllabus-cover-page(academic-year, bind-correction, course, cursus, subtitle)

  pagebreak(to: "odd")

  heh-syllabus-title-page(bind-correction, course, cursus, subtitle)

  set heading(numbering: "1.1.")
  set page(
    footer: context {
      line(length: 100%, stroke: (thickness: 0.5pt))
      v(-0.5em)
      if calc.odd(here().page()) {
        align(right)[
          #move(dy: -0.7em, block(inset: 0.5em, stroke: (left: 0.5pt), counter(page).display("1")))
        ]
      } else {
        align(left)[
          #move(dy: -0.7em, block(inset: 0.5em, stroke: (right: 0.5pt), counter(page).display("1")))
        ]
      }
    },
    margin: (inside: 2.5cm + bind-correction, rest: 2.5cm),
    numbering: "1",
  )
  show heading: set par(justify: false)
  show heading.where(level: 1): set text(hyphenate: false)
  show heading.where(level: 1): it => {
    {
      set page(header: none, footer: none)
      pagebreak(to: "odd")
    }
    set align(right)

    v(1em)
    if it.numbering != none {
      [
        Chapitre #counter(heading).display("1")
        #v(-0.75em)
        #line(length: 100%, stroke: (thickness: 0.5pt))
        #v(-0.1em)
        #text(size: 2.369em)[ #it.body ]
      ]
    } else {
      text(size: 2.369em)[ #it.body ]
    }
    v(5em)
  }
  show heading.where(level: 2): set text(size: 1.777em)
  show heading.where(level: 2): set heading(supplement: "Section")
  show heading.where(level: 3): set text(size: 1.333em)
  show heading.where(level: 3): set heading(supplement: "Point")

  set par(justify: true)
  show table: set par(justify: false)

  set figure.caption(separator: [~--- ])

  show raw: set text(size: 1em / 0.8)

  show: zebraw.with(
    background-color: purple.transparentize(100%),
    lang: false,
    numbering-separator: true,
  )

  outline(depth: 2)

  body
}

