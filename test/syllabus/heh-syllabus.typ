#let heh-red = rgb(228, 21, 19)

#let cover-page(
  academic-year,
  bind-correction,
  course,
  cursus,
  subtitle,
) = context {
  set page(
    header: none,
    footer: none,
    margin: (inside: 1cm + bind-correction, rest: 1cm),
  )
  let left-header = {
    image("images/logo-heh-dst.png", height: 1.6cm, alt: "Logo HEH")
    set text(size: 0.75em)
    let heh-link = block(
      fill: heh-red,
      inset: 0.5em,
      link(
        "https://www.heh.be",
        text(
          "www.heh.be",
          fill: white,
          weight: "black",
        ),
      ),
    )
    context {
      let link-width = measure(heh-link).width
      rect(fill: heh-red, width: link-width, height: 0.1cm)
    }
    let location-dot-icon = read("images/location-dot.svg").replace("currentColor", heh-red.to-hex())
    pdf.artifact(kind: "layout", box(width: 1em, align(center, image(
      bytes(location-dot-icon),
      height: 1em,
    ))))
    h(0.5em)
    box[
      Avenue V. Maistriau 8a \
      7000 Mons
    ]
    linebreak()
    let phone-icon = read("images/phone.svg").replace("currentColor", heh-red.to-hex())
    pdf.artifact(kind: "layout", box(width: 1em, align(center, image(
      bytes(phone-icon),
      height: 1em,
    ))))
    h(0.5em)
    box[
      +32 65 31 81 54
    ]
    linebreak()
    let magnifying-glass-icon = read("images/magnifying-glass.svg").replace("currentColor", heh-red.to-hex())
    pdf.artifact(kind: "layout", box(width: 1em, align(center, image(
      bytes(magnifying-glass-icon),
      height: 1em,
    ))))
    h(0.5em)
    box[
      #link("mailto:scitech-mons@heh.be")
    ]
    v(0.5em)
    heh-link
  }
  let right-header = [
    Année académique #text(fill: heh-red, weight: "bold", academic-year)
  ]
  let header = {
    box(baseline: top, left-header)
    h(1fr)
    box(baseline: top, right-header)
  }
  let title-block = {
    block(fill: heh-red, width: 15cm, inset: .5cm)[
      #set text(fill: white)
      #set align(left)
      #text(size: 1.777em, weight: "bold")[#text(fill: heh-red.lighten(80%))[UE~:] #course]
      #v(-.5em)
      #set text(size: 1.333em)
      #subtitle
      #v(1.5em)
      #cursus
    ]
  }
  let footer = {
    box(baseline: bottom)[
      François Roland \
      #link("mailto:francois.roland@heh.be")
    ]
    h(1fr)
    box(baseline: bottom)[
      #box(image("images/logo-wbe.jpg", height: 0.9cm, alt: "Logo Wallonie-Bruxelles Enseignement"))
      #h(1.5em)
      #box(image("images/logo-pole-hainuyer.jpg", height: 0.9cm, alt: "Logo Pôle Hainuyer"))
    ]
  }

  stack(
    dir: ttb,
    header,
    v(2fr),
    align(right, title-block),
    v(3fr),
    footer,
  )
}

#let title-page(bind-correction, course, cursus, subtitle) = context {
  set page(
    margin: (inside: 1cm + bind-correction, rest: 1cm),
  )

  counter(page).update(1)

  box(baseline: top, image("images/logo-heh-dst.png", height: 1.6cm, alt: "Logo HEH"))
  h(1fr)
  box(
    baseline: top,
    cursus,
  )
  v(2fr)
  align(center, [

    #v(1.5em)
    #text(size: 1.777em, weight: "bold", course)
    #v(-0.5em)
    #text(size: 1.333em, subtitle)
    #v(2em)
    #text(size: 1em, document.author.join("\n"))
  ])
  v(3fr)
  par(justify: true)[
    #set text(size: 0.75em)
    _Cette version est destinée aux étudiants régulièrement inscrits à la Haute École en Hainaut au cours de #course.
    Ces étudiants peuvent la consulter et la télécharger gratuitement pour un usage personnel uniquement.
    Cette version ne doit pas être redistribuée, vendue ou utilisée dans des travaux dérivés._
  ]
}

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
  )

  cover-page(academic-year, bind-correction, course, cursus, subtitle)

  pagebreak(to: "odd")

  title-page(bind-correction, course, cursus, subtitle)

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
  show heading.where(level: 3): set text(size: 1.333em)

  set par(justify: true)

  outline(depth: 2)

  body
}

