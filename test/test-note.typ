#import "@heh-dst/heh-note:0.0.1": *
#import "@preview/zero:0.7.0": num

#show: heh-note.with(
  author: "François Roland",
  course: "Techniques numériques avancées",
  cursus: "Bachelier en informatique",
  title: "Fiche d'exercices",
)

= 1re section

Quelle est la couleur du cheval blanc d'Henri IV ?

En vrai, c'est blanc. #lorem(30)

Ce qu'on peut mettre après deux points : #lorem(27)

Ce qu'on peut mettre après deux points~: #lorem(27)

```
Une ponctuation haute : dans un code !
```

/ ToDo: Une liste de termes.
/ Et après: Vérifier comment les deux points sont gérés dans les listes.

C'est un long paragraphe. #lorem(30)

Est-ce que les nombres comme #num(123456.789e-10) sont correctement affichés ?
Même ceux en notation ingénieur comme #num("123456.789+1-2", exponent: "eng") ?

= 2e section

Quelle est la couleur du cheval blanc d'Henri IV ?

- En RGB ?
- En HEX ?
- En CMJN ? #lorem(30)

  #lorem(30)

```ts
function helloWorld(name: string): string {
  return `Hello, ${name}!`;
}
```

#lorem(300)
