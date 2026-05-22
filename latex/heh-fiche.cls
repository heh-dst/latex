% heh-fiche.cls — Classe LaTeX pour une fiche de travail au DST de la HEH
% Copyright (c) 2026 — François Roland
%
% Cette classe centralise le chargement des dépendances pour les fiches
% conformes à la charte graphique du DST de la HEH.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{heh-fiche}[2026/05/20 v0.0.1 Classe fiche pour la HEH]

% --- Vérification du moteur de compilation ---
% Le package requiert LuaLaTeX pour fontspec et les polices OpenType
\RequirePackage{ifluatex}
\ifluatex\else
  \ClassError{heh-fiche}{%
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
% Avertissement pour options inconnues
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{scrartcl}%
}

% Traitement des options
\ProcessOptions\relax

% --- Passe les options aux packages avant de charger quoi que ce soit ---
\PassOptionsToPackage{headheight=41pt}{typearea} % Ajuste la hauteur de l'en-tête pour éviter les avertissements
\PassOptionsToPackage{hyphens}{url}

% Charge la classe de base scrartcl
\LoadClass[DIV=12,parskip=full]{scrartcl}

% --- Packages de base ---
% Formatage du document et langue
\RequirePackage{booktabs}  % Tableaux de meilleure qualité
\RequirePackage{multicol}  % Colonnes multiples
\RequirePackage{tcolorbox} % Boîtes colorées

% --- HEH Common Resources ---
\RequirePackage{heh-common} % Shared HEH branding (colors, logo)

% --- Liens hypertextes et métadonnées PDF ---
\RequirePackage[pdfpagemode=UseNone,unicode]{hyperref}

% --- Configuration des en-têtes et pieds de page ---
\RequirePackage{scrlayer-scrpage}
\setkomafont{pagehead}{\normalfont\normalcolor}
\lohead{\scalebox{0.9}{\HEHLogo}}
\lofoot{\raisebox{-5pt}{\tikz[opacity=.3]{\pgfuseimage{logo-wbe}\hspace{1em}\pgfuseimage{logo-pole};}}}
\rofoot{\tikz[scale=.6]{\pic{hehballs};}}
\pagestyle{plain.scrheadings}
\RenewDocumentCommand{\titlepagestyle}{}{scrheadings}
