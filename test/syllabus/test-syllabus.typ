#set document(
  title: "Réseaux informatiques",
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

#let cover-page(
  academic-year: [ 2026~--~2027 ],
  course: "Programmation",
  cursus: "Bachelier en techniques graphiques",
) = {
  page(margin: (inside: 1cm + bind-correction, rest: 1cm))[
    #place(top + left)[
      #set text(size: 0.75em)
      #image("images/logo-heh-dst.png", height: 1.6cm, alt: "Logo HEH")
      #let link-content = text("www.heh.be", fill: white, weight: "black")
      #context {
        let link-width = measure(link-content).width + 1em
        rect(fill: heh-red, width: link-width, height: 0.1cm)
      }
      #let location-dot-icon = read("images/location-dot.svg").replace("currentColor", heh-red.to-hex())
      #pdf.artifact(kind: "layout", box(width: 1em, align(center, image(
        bytes(location-dot-icon),
        height: 1em,
      ))))
      #h(0.5em)
      #box[
        Avenue V. Maistriau 8a \
        7000 Mons
      ] \
      #let phone-icon = read("images/phone.svg").replace("currentColor", heh-red.to-hex())
      #pdf.artifact(kind: "layout", box(width: 1em, align(center, image(
        bytes(phone-icon),
        height: 1em,
      ))))
      #h(0.5em)
      #box[
        +32 65 31 81 54
      ] \
      #let magnifying-glass-icon = read("images/magnifying-glass.svg").replace("currentColor", heh-red.to-hex())
      #pdf.artifact(kind: "layout", box(width: 1em, align(center, image(
        bytes(magnifying-glass-icon),
        height: 1em,
      ))))
      #h(0.5em)
      #box[
        #link("mailto:scitech-mons@heh.be")
      ]
      #v(0.5em)
      #block(fill: heh-red, inset: 0.5em)[
        #link("https://www.heh.be", link-content)
      ]
    ]
    #place(top + right)[
      Année académique #text(fill: heh-red, weight: "bold", academic-year)
    ]

    #place(horizon + right, block(fill: heh-red, width: 15cm, inset: .5cm)[
      #set text(fill: white)
      #set align(left)
      #text(size: 1.777em, weight: "bold")[#text(fill: heh-red.lighten(80%))[UE~:] #course]
      #v(1.5em)
      #text(size: 1.333em, cursus)
    ])

    #place(bottom + left)[
      François Roland \
      #link("mailto:francois.roland@heh.be")
    ]
    #place(bottom + right)[
      #box(image("images/logo-wbe.jpg", height: 0.9cm, alt: "Logo Wallonie-Bruxelles Enseignement"))
      #h(1.5em)
      #box(image("images/logo-pole-hainuyer.jpg", height: 0.9cm, alt: "Logo Pôle Hainuyer"))
    ]
  ]
}

#cover-page()

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


