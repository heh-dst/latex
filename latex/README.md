# HEH-DST Common Resources

This directory contains shared branding resources for all HEH-DST LaTeX document types.

## Overview

The `heh-common.sty` package provides centralized HEH branding elements that are used consistently across all document types (AMC exams, Beamer presentations, syllabi, and future additions).

## Files

- **heh-common.sty** - Main LaTeX package providing colors, logo, and graphics path configuration
- **graphics/** - Shared PNG logo resources
  - `logo-heh-dst.png` - Main HEH Department logo
  - `logo-pole-hainuyer.png` - Pole Hainuyer partner logo
  - `logo-wbe.png` - WBE partner logo

## Usage

### Including the Package

Add to your document preamble or class file:

```latex
\RequirePackage{heh-common}  % For class files
% or
\usepackage{heh-common}      % For regular documents
```

### Available Colors

The package defines the following HEH brand colors:

#### Red Gradient (for depth/shadow effects)
- `heh@red1` - Darkest red (`#911a1a`)
- `heh@red2` - (`#aa1d1e`)
- `heh@red3` - (`#c5221f`)
- `heh@red4` - (`#de2226`)
- `heh@red5` - **Primary HEH red** (`#cf2223`) - **Use this for branding!**
- `heh@red` - Alias for `heh@red5` (backward compatibility)

#### Other Brand Colors
- `heh@blue` - Primary HEH blue (`RGB 40, 60, 143`)
- `heh@dark` - Dark gray for text (`#383838`)

### Using Colors

```latex
% Primary HEH red (most common usage)
\textcolor{heh@red5}{This text is HEH red}
\textcolor{heh@red}{This is also HEH red (alias)}

% HEH blue
\textcolor{heh@blue}{This text is HEH blue}

% Using in TikZ
\fill[heh@red5] (0,0) circle (1cm);

% Using with color mixing
\definecolor{mycolor}{RGB}{207, 34, 35}  % Or mix: heh@red5!50!white
```

### HEH Logo

The package provides a resolution-independent TikZ-based logo:

```latex
% Default size
\HEHLogo

% Scaled version
\HEHLogo[0.8]   % 80% of original size
\HEHLogo[1.5]   % 150% of original size
```

**Note:** The logo requires Roboto font to be installed for optimal rendering. If Roboto is unavailable, it falls back to a sans-serif font.

### Graphics (PNG Logos)

PNG logos are automatically accessible after installation. The graphics path is configured by `heh-common.sty`:

```latex
\includegraphics[height=3em]{logo-heh-dst.png}
\includegraphics[height=2em]{logo-pole-hainuyer.png}
\includegraphics[height=2em]{logo-wbe.png}
```

## Installation

The installation script automatically installs shared resources to TEXMFHOME:

```bash
python scripts/install.py
```

This installs:
- `heh-common.sty` → `TEXMFHOME/tex/latex/heh-dst/`
- Graphics → `TEXMFHOME/tex/latex/heh-dst/graphics/`

After installation, resources are globally accessible in any LaTeX document.

## Design Philosophy

### Color Naming Convention

- **`heh@red5`** is the **primary branding color** - use this for structure, alerts, and emphasis
- **`heh@red1-4`** create depth effects in the logo (gradient from darkest to lightest)
- **`heh@blue`** is the secondary accent color
- **`heh@dark`** is for dark gray text elements

### Logo Format

The TikZ-based logo is preferred over PNG because:
- ✅ Resolution-independent (scales perfectly at any size)
- ✅ No external file dependencies (pure code)
- ✅ Can be embedded directly in class files
- ✅ Consistent rendering across platforms

PNG logos are provided for compatibility with external tools and partners (Pole, WBE).

## Integration with Document Types

### AMC Exams ([amc/heh-amc.cls](../amc/heh-amc.cls))
- Uses `heh@red5` in the procedural logo
- Maintains backward compatibility with old color names (`hehamc@red*`)
- Logo appears on cover page via `\CoverPage`

### Beamer Presentations ([beamer/styles/](../beamer/styles/))
- Uses `heh@red` (alias for `heh@red5`) for structure and alerts
- Uses `heh@blue` for block titles
- PNG logos in header/footer (HEH, Pole, WBE)
- Decorative "hehballs" gradient in footer

### Syllabus ([syllabus/document.tex](../syllabus/document.tex))
- Uses `heh@blue` for hyperlinks
- Optional: `heh@red5` for section headings
- Can include `\HEHLogo` on title page

## Examples

### Example 1: Using Colors in a Custom Document

```latex
\documentclass{article}
\usepackage{heh-common}
\usepackage{xcolor}

\begin{document}

\section{\textcolor{heh@red5}{Introduction}}

This is a paragraph with \textcolor{heh@blue}{blue text}.

\HEHLogo[0.5]

\end{document}
```

### Example 2: Creating Custom Theme Colors

```latex
\RequirePackage{heh-common}

% Create tinted versions
\colorlet{lightred}{heh@red5!30!white}
\colorlet{darkblue}{heh@blue!75!black}

% Use in document
\setbeamercolor{block title}{bg=darkblue,fg=white}
```

### Example 3: TikZ Graphics with HEH Colors

```latex
\usepackage{heh-common}
\usepackage{tikz}

\begin{tikzpicture}
  \fill[heh@red5] (0,0) rectangle (2,1);
  \fill[heh@blue] (2,0) rectangle (4,1);
  \node at (1,0.5) {\HEHLogo[0.3]};
\end{tikzpicture}
```

## Backward Compatibility

The package maintains compatibility with existing documents:

- **Beamer:** `heh@red` continues to work (alias for `heh@red5`)
- **AMC:** Old color names `hehamc@red*` are aliased to `heh@red*`
- **Logo:** `\HEHLogo` command interface unchanged

No existing documents should break when upgrading to use `heh-common`.

## Troubleshooting

### "File heh-common.sty not found"
Run the installation script:
```bash
python scripts/install.py
```

### "Undefined control sequence \HEHLogo"
Ensure `heh-common` is loaded:
```latex
\usepackage{heh-common}
```

### "File logo-heh-dst.png not found"
The graphics are installed to TEXMFHOME. Verify installation:
```bash
kpsewhich logo-heh-dst.png
```

### Logo text appears in wrong font
Install Roboto font or load fontspec before using `\HEHLogo`:
```latex
\usepackage{fontspec}
\usepackage{heh-common}
```

## Contributing

When adding new shared resources:

1. Add definitions to `heh-common.sty`
2. Document usage in this README
3. Update installation script if adding files
4. Test across all document types (AMC, Beamer, Syllabus)
5. Update [CLAUDE.md](../CLAUDE.md) with architecture changes

## License

Internal use - HEH Department of Sciences and Technologies

## Version History

- **v1.0** (2026-01-28) - Initial release
  - Centralized color definitions
  - TikZ-based HEH logo
  - Shared graphics installation
  - Support for AMC, Beamer, and Syllabus
