#import "@heh-dst/heh-style:0.0.1": *
#import "questions.typ": *

#let heh-exam-identity-table(with-group-and-date: false) = {
  set text(fill: color-palette.gray, size: 10pt)
  table(
    align: left + top,
    columns: (1fr, 1fr),
    rows: 1cm,
    stroke: 0.5pt + color-palette.gray,
    [Nom :], [Prénom :],
    ..if with-group-and-date { ([Groupe :], [Date :]) } else { () },
  )
}

#let heh-exam(
  author: (),
  course: [],
  cursus: [],
  title: [],
  it,
) = {
  heh-document(
    author: author,
    course: course,
    title: title,
    header: context {
      if here().page() != 1 {
        heh-exam-identity-table()
      }
    },
  )[
    #heh-document-banner(course, cursus)
    #heh-exam-identity-table(with-group-and-date: true)
    #heh-document-title(title)
    #it
  ]
}
