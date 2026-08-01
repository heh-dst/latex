#import "@preview/bookly:4.1.3": *
// #import "custom-theme.typ": custom

#let config-colors = (
  primary: rgb("#1d90d0"),
  secondary: rgb("#dddddd").darken(15%),
)

#show: bookly.with(
  author: "François Roland",
  fonts: (
    // size: 9pt,
    body: "IBM Plex Sans",
    math: "STIX Two Math",
    raw: "FiraCode Nerd Font",
  ),
  // theme: custom,
  // theme: classic,
  // theme: fancy,
  // theme: modern,
  // theme: obook,
  // theme: orly,
  // theme: pretty,
  // tufte: true,
  lang: "fr",
  colors: config-colors,
  title: "Mon cours",
  title-page: book-title-page(
    series: "Typst book series",
    subtitle: "Syllabus de théorie",
    institution: "Typst community",
    logo: image("images/typst-logo.svg"),
    cover: image("images/book-cover.jpg", width: 45%),
    show-cover-author: true,
  ),
)

#show: front-matter

#include "front_matter/front_main.typ"

#show: main-matter

#tableofcontents

#listoffigures

#listoftables

#part([First part])

#include "chapters/ch_main.typ"

#part("Second part")

#show: appendix

#include "appendix/app_main.typ"

// // #bibliography("bibliography/sample.yml")
#bibliography("bibliography/sample.bib")

#let abstracts-fr-en = (
  (
    title: [#set text(lang: "fr"); Résumé :],
    text: [#lorem(100)],
  ),
  (
    title: [#set text(lang: "en", region: "gb"); Abstract:],
    text: [#lorem(100)],
  ),
)

#let logos = (
  image("images/typst-logo.svg", width: 75%),
  image("images/typst-logo.svg", width: 75%),
)

#back-cover(abstracts: abstracts-fr-en, logo: logos)
