#import "@preview/fontawesome:0.6.2": *

#set document(
  title: "UE : Réseaux informatiques",
  author: "François Roland",
)

#set page(
  paper: "a4",
)

#set text(
  font: "IBM Plex Sans",
  lang: "fr",
)

#let bind-correction = 0.5cm
#let heh-red = rgb(228, 21, 19)

#set heading(numbering: "1.1.")
#show heading.where(level: 1): it => {
  pagebreak(to: "odd", weak: true)
  set align(right)

  if it.numbering != none {
    v(1em)
    [
      Chapitre #counter(heading).display("1")
      #v(-0.75em)
      #line(length: 100%, stroke: 0.5pt)
      #v(-0.1em)
      #text(size: 2.369em)[ #it.body ]
    ]
  } else {}
  v(5em)
}
#show heading.where(level: 2): set text(size: 1.777em)
#show heading.where(level: 3): set text(size: 1.333em)

#page(margin: (inside: 1cm + bind-correction, rest: 1cm))[
  #place(top + left)[
    #image("images/logo-heh-dst.png", height: 1.8cm)
    #context {
      let link-width = measure("www.heh.be").width + 1em
      rect(fill: heh-red, width: link-width, height: 0.1cm)
    }

    #box(baseline: horizon, fa-icon("location-dot", fill: heh-red))
    #h(0.5em)
    #box(baseline: horizon)[
      Avenue V. Maistriau 8a \
      7000 Mons
    ] \
    #box(baseline: horizon, fa-icon("phone", fill: heh-red))
    #h(0.5em)
    #box(baseline: horizon)[
      +32 65 31 81 54
    ] \
    #box(baseline: horizon, fa-icon("magnifying-glass", fill: heh-red))
    #h(0.5em)
    #box(baseline: horizon)[
      #link("mailto:scitech-mons@heh.be")
    ]
    #v(0.5em)
    #block(fill: heh-red, inset: 0.5em)[
      #link("https://www.heh.be", text("www.heh.be", fill: white))
    ]
  ]
  #place(top + right)[
    Année académique #text(fill: heh-red, weight: "bold")[2025--2026]
  ]

  #place(horizon + right)[
    #set text(fill: white, size: 1.777em)
    #block(fill: heh-red, width: 15cm, inset: 1em)[
      #set align(left)
      #text(weight: "bold")[#context document.title]
      #v(1.5em)
      Bachelier en informatique
    ]
  ]

  #place(bottom + left)[
    François Roland \
    #link("mailto:francois.roland@heh.be")
  ]
  #place(bottom + right)[
    #box(image("images/logo-wbe.jpg", height: 3em))
    #h(1.5em)
    #box(image("images/logo-pole-hainuyer.jpg", height: 3em))
  ]
]

#set page(
  footer: context {
    if calc.odd(here().page()) {
      align(right)[
        #counter(page).display("1")
      ]
    } else {
      align(left)[
        #counter(page).display("1")
      ]
    }
  },
  margin: (inside: 2.5cm + bind-correction, rest: 2.5cm),
  numbering: "1",
)

#set par(justify: true)

= Introduction

== Première section

#lorem(30)

== Deuxième section

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(300)

#lorem(300)

#lorem(300)

= Deuxième chapitre

#lorem(300)


