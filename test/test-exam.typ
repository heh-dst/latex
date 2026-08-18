#import "@heh-dst/heh-exam:0.0.1": *
#import "@preview/zero:0.7.0": num

#show: heh-exam.with(
  author: "François Roland",
  course: "Techniques numériques avancées",
  cursus: "Bachelier en informatique",
  title: "Examen théorique",
)

= 1re section

#question(points: 2)[
  Quelle est la couleur du cheval blanc d'Henri IV ?

  #solution[
    En vrai, c'est blanc. #lorem(30)
  ]
]

#question(points: 3)[Imitez son cri.]

#question(points: 2)[
  Quelle est la `couleur` du cheval blanc d'Henri IV ?

  Ce qu'on peut mettre après deux points : #lorem(27)

  Ce qu'on peut mettre après deux points~: #lorem(27)

  ```
  Une ponctuation haute : dans un code !
  ```

  / ToDo: Une liste de termes.
  / Et après: Vérifier comment les deux points sont gérés dans les listes.

  C'est une question avec une longue consigne. #lorem(30)
]

#question(points: 3)[Est-ce que les nombres comme #num(123456.789e-10) sont correctement affichés ?

  Même ceux en notation ingénieur comme #num("123456.789+1-2", exponent: "eng") ?]

#question(points: 2)[Quelle est la couleur du cheval blanc d'Henri IV ?]

#question(points: 3)[Imitez son cri.]

#question(points: 2)[Quelle est la couleur du cheval blanc d'Henri IV ?]

#question(points: 3)[Imitez son cri.]

= 2e section

#question[Quelle est la couleur du cheval blanc d'Henri IV ?

  #subquestion(points: 1)[En RGB ?]

  #subquestion(points: 1)[En HEX ?]

  #subquestion(points: 1)[
    En CMJN ? #lorem(30)

    #lorem(30)
  ]
]

#question(points: 3)[Imitez son cri.]

#question[Quelle est la couleur du cheval blanc d'Henri IV ?]

#question(points: 3)[Imitez son cri.]

#question[Quelle est la couleur du cheval blanc d'Henri IV ?]

#question(points: 3)[Imitez son cri.]

#question[Quelle est la couleur du cheval blanc d'Henri IV ?

  #subquestion(points: 1)[En RGB ?]

  #subquestion(points: 1)[En HEX ?]

  #subquestion(points: 1)[
    En CMJN ? #lorem(30)

    #lorem(30)
  ]
]

#question(points: 3)[Imitez son cri.]

#question[Quelle est la couleur du cheval blanc d'Henri IV ?

  ```ts
  function helloWorld(name: string): string {
    return `Hello, ${name}!`;
  }
  ```

]

#question(points: 3)[Imitez son cri.]

#question[Quelle est la couleur du cheval blanc d'Henri IV ?]

#question(points: 3)[Imitez son cri.]
