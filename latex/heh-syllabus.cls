% heh-syllabus.cls — Classe LaTeX pour un syllabus au DST de la HEH
% Copyright (c) 2026 — François Roland
%
% Support de cours complet (au sens francophone du terme) : plusieurs
% dizaines de pages, destiné à l'impression reliée par la maison
% d'édition de l'école et/ou à la diffusion PDF.
%
% BROUILLON NON COMPILÉ — à tester avant usage en production.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{heh-syllabus}[2026/07/30 v0.0.1 Classe syllabus pour la HEH]

% --- Vérification du moteur de compilation ---
% Le package requiert LuaLaTeX pour fontspec et les polices OpenType
\RequirePackage{ifluatex}
\ifluatex\else
  \ClassError{heh-syllabus}{%
    Ce package nécessite LuaLaTeX.%
  }{%
    Vous utilisez un moteur LaTeX incompatible.^^J%
    Veuillez compiler votre document avec LuaLaTeX~:^^J%
    ^^J%
    \space\space lualatex votre-fichier.tex^^J%
    ^^J%
    Les moteurs pdfLaTeX et XeLaTeX ne sont pas supportés.%
  }
\fi

% --- Options du package ---
% Avertissement pour options inconnues : relayées vers scrbook, ce qui
% permet par exemple \documentclass[BCOR=12mm]{heh-syllabus} sans
% avoir à toucher à cette classe.
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{scrbook}%
}
\ProcessOptions\relax

% --- Passe les options aux packages avant de charger quoi que ce soit ---
\PassOptionsToPackage{unicode}{hyperref}
\PassOptionsToPackage{headheight=41pt}{typearea} % en-tête à deux lignes (logo)
\PassOptionsToPackage{hyphens}{url}

% --- Charge la classe de base scrbook ---
% BCOR : le syllabus est destiné à une impression reliée.
% BCOR=8mm est un point de départ raisonnable pour quelques dizaines
% de pages en reliure dos carré-collé ; à ajuster selon le nombre de
% pages réel et le mode de reliure retenu par la maison d'édition, via
% l'option de classe (voir ci-dessus), pas en modifiant ce fichier.
\LoadClass[BCOR=8mm,DIV=12,parskip=full,chapterprefix=true,headings=big,toc=bibliography]{scrbook}

% --- Packages de base ---
\RequirePackage{bookmark}
\RequirePackage{booktabs}  % Tableaux de meilleure qualité
\RequirePackage{tcolorbox} % Boîtes colorées (utilisé par heh-pedago)

% --- HEH Common Resources ---
% Fournit babel[french], les couleurs, les polices (IBM Plex Sans,
% FiraCode, STIX Two) et \HEHLogo. Ne pas recharger polyglossia,
% roboto ou unicode-math séparément : heh-common est l'unique source
% de vérité typographique, comme dans heh-fiche.cls et heh-beamer.cls.
\RequirePackage{heh-common}

% --- Environnements pédagogiques partagés ---
% definition, exemple, remarque, exercice — voir heh-pedago.sty
\RequirePackage{heh-pedago}

% --- Liens hypertextes et métadonnées PDF ---
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=heh@blue,
  citecolor=heh@blue,
  urlcolor=heh@blue,
}

% --- En-têtes et pieds de page (recto/verso) ---
% Contrairement à heh-fiche.cls (oneside), le syllabus est twoside :
% il faut distinguer pages paires (verso, "e") et impaires (recto, "o").
\RequirePackage{scrlayer-scrpage}
%\automark[chapter]{chapter}
%\setkomafont{pagehead}{\normalfont\normalcolor}

\defpagestyle{hehtitle}%
{{\scalebox{0.9}{\HEHLogo}\hfil}%
  {\scalebox{0.9}{\HEHLogo}\hfil}%
  {\scalebox{0.9}{\HEHLogo}\hfil}}%
{{\raisebox{-5pt}{\tikz[opacity=.3]{\pgfuseimage{logo-wbe}\hspace{1em}\pgfuseimage{logo-pole};}}\hfill\tikz[scale=.6]{\pic{hehballs};}}%
  {\raisebox{-5pt}{\tikz[opacity=.3]{\pgfuseimage{logo-wbe}\hspace{1em}\pgfuseimage{logo-pole};}}\hfill\tikz[scale=.6]{\pic{hehballs};}}%
  {\raisebox{-5pt}{\tikz[opacity=.3]{\pgfuseimage{logo-wbe}\hspace{1em}\pgfuseimage{logo-pole};}}\hfill\tikz[scale=.6]{\pic{hehballs};}}}
\RenewDocumentCommand{\titlepagestyle}{}{hehtitle}
