# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains LaTeX class files and templates adapted to the HEH Department of Sciences and Technologies (DST) graphic charter. It provides three main components:
- **amc**: Custom class for Auto Multiple Choice exams
- **beamer**: Presentation theme for slides with student handouts and teacher notes
- **syllabus**: Template for course syllabi documents
- **fonts**: Custom fonts (Luciole, IntoneMonoNerdFont) for HEH branding

## Architecture

### Beamer Structure

Content is separated from presentation format through a modular architecture:

1. **Configuration files** ([`beamer/config/`](beamer/config/)):
   - [`packages.tex`](beamer/config/packages.tex) - LaTeX packages (amsmath, tikz, pgfplots, siunitx, unicode-math)
   - [`preamble.tex`](beamer/config/preamble.tex) - Document metadata (title, author, theme)
   - [`header.tex`](beamer/config/header.tex) - Document start

2. **Theme files** ([`beamer/styles/`](beamer/styles/)):
   - [`beamerthemeheh.sty`](beamer/styles/beamerthemeheh.sty) - Main theme loader (imports color, font, inner, outer themes)
   - Modular theme components: `beamercolorthemeheh.sty`, `beamerfontthemeheh.sty`, `beamerinnerthemeheh.sty`, `beamerouterthemeheh.sty`
   - Graphic resources (logos, etc.)

3. **Content files** (`*_content.tex`):
   - Contains pedagogical content with `\section` and `\begin{frame}...\end{frame}` blocks
   - Includes `\note{}` commands for teacher annotations
   - Should use `% !TEX root = main_notes.tex` magic comment at top

4. **Generator files**:
   - [`main_notes.tex`](beamer/main_notes.tex) - Includes content and generates teacher version
   - [`main_handout.tex`](beamer/main_handout.tex) - Includes content and generates student handouts
   - Additional parts can be created (e.g., `part1_notes.tex`, `part1_handout.tex`)

### AMC Class

[`amc/heh-amc.cls`](amc/heh-amc.cls) is a LaTeX class for Auto Multiple Choice exams:
- **Base class**: `article` (12pt, a4paper)
- **Required engine**: LuaLaTeX (enforced with error on other engines)
- **Options**:
  - `catalog` - Enable catalog mode
  - `noshuffle` - Disable question shuffling
- **Dependencies**: Loads amsmath, babel[french], booktabs, fontspec, and more

### Syllabus Template

[`syllabus/document.tex`](syllabus/document.tex) is a standalone document:
- **Base class**: `scrartcl` (KOMA-Script article, 12pt, a4paper, French)
- **Main document**: [`document.tex`](syllabus/document.tex) contains preamble and includes [`content.tex`](syllabus/content.tex)
- **Fonts**: Roboto (sans-serif), Roboto Mono (monospace), Fira Math (mathematics)
- **Packages**: amsmath, tikz, pgfplots, siunitx, hyperref, polyglossia

## Installation

### Automated Installation (Recommended)

Run the Python installation script from the repository root:

```bash
python scripts/install.py
```

This script automatically:
1. Detects your TEXMFHOME directory
2. **Extracts and installs `automultiplechoice.sty`** if Auto Multiple Choice is not already available
   - Automatically processes the `.dtx.in` source file
   - Extracts version information from ChangeLog
   - Allows LaTeX compilation without AMC binaries (useful on Windows without devcontainer)
3. Installs the `heh-amc.cls` class
4. Installs custom fonts (Luciole, IntoneMonoNerdFont)
5. Installs required packages (`realscripts`) if not already present

The script is **cross-platform** (Linux, Windows, macOS) and only updates files that have changed (rsync-like behavior).

### AMC Package Extraction

The script intelligently handles the AMC package:
- **If AMC is installed** (via package manager): Uses the system version
- **If AMC is not found**: Extracts `automultiplechoice.sty` from [`auto-multiple-choice/tex/automultiplechoice.dtx.in`](auto-multiple-choice/tex/automultiplechoice.dtx.in)
  - This allows **LaTeX compilation** of AMC documents without the full AMC suite
  - Useful for **Windows environments** or when working outside devcontainers
  - Note: Full AMC features (scoring, analysis) still require the complete AMC installation

## Key Constraints

1. **LuaLaTeX is required** for all components due to fontspec and OpenType font usage
2. **French language** is the default (babel, polyglossia)
3. **Custom fonts** (Roboto, Roboto Mono, Fira Math, Luciole) are integral to the HEH branding
4. **Timezone**: Europe/Brussels for timestamps
