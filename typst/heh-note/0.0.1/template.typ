#import "@heh-dst/heh-style:0.0.1": *

#let heh-note(
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
  )[
    #heh-document-banner(course, cursus)
    #heh-document-title(title)
    #it
  ]
}
