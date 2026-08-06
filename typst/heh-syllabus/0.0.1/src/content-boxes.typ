#import "@preview/showybox:2.0.4": showybox
#import "colors.typ": *

#let content-box(
  accent-color: color-palette.black,
  breakable: false,
  body-align: left,
  title: none,
  title-color: color-palette.black,
  content,
) = {
  showybox(
    body-style: (
      align: body-align,
    ),
    breakable: breakable,
    footer-style: (
      align: center,
    ),
    frame: (
      border-color: accent-color,
      body-color: accent-color.lighten(95%),
      title-color: accent-color,
      thickness: 1pt,
    ),
    title: [*#title*],
    title-style: (
      boxed-style: (
        anchor: (x: left, y: horizon),
      ),
      color: title-color,
    ),
  )[
    #content
  ]
}

#let answers-box(content) = content-box(
  accent-color: color-palette.yellow,
  breakable: true,
  title: "Solutions",
  content,
)

#let code-box(content) = content-box(
  accent-color: color-palette.bluish-green,
  title: "Code",
  title-color: color-palette.white,
  content,
)

#let flowchart-box(content) = content-box(
  accent-color: color-palette.reddish-purple,
  body-align: center,
  title: "Ordinogramme",
  content,
)

#let pseudocode-box(content) = {
  content-box(
    accent-color: color-palette.blue,
    title: "Pseudocode",
    title-color: color-palette.white,
    content,
  )
}
