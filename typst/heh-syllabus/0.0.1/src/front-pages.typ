#import "colors.typ": *

#let heh-syllabus-cover-page(
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

#let heh-syllabus-title-page(bind-correction, course, cursus, subtitle) = context {
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
