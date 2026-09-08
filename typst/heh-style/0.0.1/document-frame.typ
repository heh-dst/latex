#import "colors.typ": *
#import "defaults.typ": heh-defaults
#import "logos.typ": *

// Shared document setup for HEH "article-like" documents (heh-exam, heh-note, ...):
// metadata, base typography, numbered footer. Does not lay out any content —
// callers are expected to typeset their own title block (see heh-maketitle
// below) as part of `it`, so each template stays free to interleave whatever
// it needs (an identity table, instructions, ...) around it.
#let heh-document(
  author: (),
  course: [],
  title: [],
  header: none,
  it,
) = {
  set document(
    title: [#title - #course],
    author: author,
  )

  show: heh-defaults

  set text(size: 12pt)

  set page(
    header: header,
    numbering: "1",
  )

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

  it
}

// Logo + cursus/course banner, meant to sit at the top of a document's first page.
#let heh-document-banner(course, cursus) = {
  v(-1.5cm)
  box(baseline: top, heh-dst-logo())
  h(1fr)
  box(baseline: top, align(right)[
    #cursus \
    #course
  ])
}

// Centered, bold document title, typeset the same way across all HEH documents.
#let heh-document-title(title) = align(center, text(size: 1.777em, weight: "bold", block(
  above: 1em,
  below: 1em,
  title,
)))
