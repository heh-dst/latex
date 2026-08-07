#import "@heh-dst/heh-syllabus:0.0.1": *

#set document(
  title: "Réseaux informatiques",
  author: "François Roland",
)

#show: heh-syllabus

#show: main-matter

= Introduction

== Première section

#lorem(30)

J'ai envie de tester si ça fonctionne bien.

Ca a l'air de fonctionner correctement.

== Deuxième section

#lorem(30)

#answers-box(lorem(32))

#code-box(lorem(30))

#pseudocode-box[
  + step 1
  + step 2
  + *repeat* 3 times
    + step 2.1
    + step 2.2
  + step 3
]

#flowchart-box(lorem(30))

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(30)

#lorem(300)

= Deuxième chapitre

#lorem(300)

#math.equation($y = a x^2 + b x + c$, block: true, alt: "Equation quadratique")

```python
def hello_world():
    print("Hello, w0rld!")

hello_world()
```

```ts
function helloWorld() {
  console.log("Hello, w0rld!");
}

helloWorld();
```

= Chapitre avec titre énormément long

#show: appendix

= Première annexe

#lorem(100)
