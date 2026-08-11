// Convert line-height to leading, taking into account the cap height of the font.
#let leading(line-height) = {
  let cap-height = measure("X").height
  let cap-em = cap-height / 1em.to-absolute()
  line-height - cap-em * 1em
}

#let heh-defaults(line-height: 1.5em, par-spacing: 1em, it) = {
  // Page settings
  set page(
    paper: "a4",
  )

  // Font settings
  set text(font: "IBM Plex Sans", lang: "fr", size: 11pt)
  show math.equation: set text(font: "STIX Two Math", stylistic-set: 1)
  show raw: set text(font: "FiraCode Nerd Font", features: (calt: 0), size: 1em / 0.85)

  // Paragraph settings
  set par(justify: false)

  // Figure settings
  set figure(supplement: "Figure")
  set figure.caption(separator: [. ])

  context {
    set par(
      leading: leading(line-height),
      spacing: leading(par-spacing + 1em),
    )

    it
  }
}
