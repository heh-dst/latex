# Template de présentation au format HEH-DST

## Structure du projet

```
├── config/           # Configuration LaTeX
│   ├── packages.tex  # Liste des packages LaTeX utilisés
│   ├── preamble.tex  # Configuration LaTeX (titre, auteur...)
│   └── header.tex    # Début du document
├── styles/           # Thème beamer et ressources graphiques
│   ├── beamerthemeheh.sty  # Thème principal
│   └── logo_*.pdf    # Logos et éléments graphiques
├── main_content.tex  # Contenu principal à modifier
├── main_handout.tex  # Générateur version étudiants
├── main_notes.tex    # Générateur version enseignant
├── build/           # Fichiers temporaires de compilation
└── out/             # PDFs générés
```

## Commandes disponibles

### Production
* `make` ou `make all` : Génère tous les supports (handouts + notes) dans `out/`
* `make handout` : Génère uniquement les versions étudiants
* `make notes` : Génère uniquement les versions enseignant

### Développement
* `make watch SRC=main_notes.tex` : Surveillance automatique et recompilation
* `make clean` : Nettoie les dossiers `build/` et `out/`

### Raccourci VS Code
Dans Visual Studio Code, `Ctrl+Shift+B` lance `make all`.

## Fichiers de travail

### Contenu principal
* **[`main_content.tex`](./main_content.tex)** : Contenu principal à modifier (slides + notes)
* [`part1_content.tex`](./part1_content.tex) : Exemple de contenu pour une partie spécifique

### Configuration
* [`config/packages.tex`](./config/packages.tex) : Liste des packages LaTeX utilisés
* [`config/preamble.tex`](./config/preamble.tex) : Configuration LaTeX (titre, auteur...)
* [`config/header.tex`](./config/header.tex) : Début du document

### Générateurs
* [`main_handout.tex`](./main_handout.tex) : Version étudiants (4 slides par page, sans notes)
* [`main_notes.tex`](./main_notes.tex) : Version enseignant (avec notes pour pympress)

## Organisation du contenu

### Fichiers de contenu (`*_content.tex`)
Contiennent le contenu pédagogique avec la structure :
```latex
\section{Titre de section}

\begin{frame}
  \frametitle{Titre du slide}
  Contenu pour projection
  \note{Notes détaillées pour l'enseignant}
\end{frame}
```

### Versions générées
* **Handouts** (`*_handout.pdf`) : 4 slides par page A4, pour les étudiants
* **Notes** (`*_notes.pdf`) : Slides + notes, optimisé pour pympress

## Ajout de nouvelles parties

Pour créer une nouvelle partie (ex: `part2`) :
1. Créer `part2_content.tex` avec le contenu
2. Créer `part2_handout.tex` et `part2_notes.tex` sur le modèle des fichiers `main_*`
3. Lancer `make all` pour générer automatiquement les PDFs

## Instructions pour GitHub Copilot

Le fichier [`.github/copilot-instructions.md`](./.github/copilot-instructions.md) contient des instructions spécifiques pour optimiser l'assistance de GitHub Copilot dans le contexte pédagogique de ce template.
