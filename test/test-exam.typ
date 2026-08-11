#import "@heh-dst/heh-exam:0.0.1": *

#set document(
  title: "Examen de techniques numériques avancées",
  author: "François Roland",
)

#show: heh-exam.with(
  course: "Techniques numériques avancées",
  cursus: "Bachelier en informatique",
  subtitle: "Examen théorique",
)

#question(points: 2)[Quelle est la couleur du cheval blanc d'Henri IV ?]

#question(points: 3)[Imitez son cri.]

#question(points: 2)[
  Quelle est la `couleur` du cheval blanc d'Henri IV ? #lorem(30)

  C'est une question avec une longue consigne. #lorem(30)
]

#question(points: 3)[Imitez son cri.]

#question(points: 2)[Quelle est la couleur du cheval blanc d'Henri IV ?]

#question(points: 3)[Imitez son cri.]

#question(points: 2)[Quelle est la couleur du cheval blanc d'Henri IV ?]

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
