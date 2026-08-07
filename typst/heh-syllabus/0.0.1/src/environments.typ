#let main-matter(body) = context {
  set heading(numbering: "1.1.")
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

  body
}

#let appendix(body) = context {
  set heading(numbering: "A.1.")
  show heading.where(level: 1): it => {
    {
      set page(header: none, footer: none)
      pagebreak(to: "odd")
    }
    set align(right)

    v(1em)
    if it.numbering != none {
      [
        Annexe #counter(heading).display("A")
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

  // Reset heading counter
  counter(heading.where(level: 1)).update(0)

  // Reset heading counter for the table of contents
  counter(heading).update(0)

  body
}
