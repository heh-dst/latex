% heh-beamer.cls — Classe LaTeX pour slides au DST de la HEH
% Copyright (c) 2026 — François Roland
%
% Cette classe centralise le chargement des dépendances pour les slides
% conformes à la charte graphique du DST de la HEH.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{heh-beamer}[2026/01/28 v0.0.1 Classe beamer pour la HEH]

% --- Vérification du moteur de compilation ---
% Le package requiert LuaLaTeX pour fontspec et les polices OpenType
\RequirePackage{ifluatex}
\ifluatex\else
  \ClassError{heh-beamer}{%
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
% Booléens pour contrôler le comportement de la classe
\newif\ifhehbeamer@handout      \hehbeamer@handoutfalse

% Déclaration des options
\DeclareOption{handout}{\hehbeamer@handouttrue}

% Avertissement pour options inconnues
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{beamer}%
}

% Traitement des options
\ProcessOptions\relax

% --- Chargement de beamer ---
% Construction dynamique des options beamer
\newcommand{\hehbeamer@beameroptions}{aspectratio=1610,noamssymb}

% Ajout conditionnel des options
\ifhehbeamer@handout
  \edef\hehbeamer@beameroptions{\hehbeamer@beameroptions,handout}
\fi

% Charge la classe de base beamer
\LoadClass[\hehbeamer@beameroptions]{beamer}

% --- Packages de base ---
% Formatage du document et langue
\RequirePackage{amsmath}   % Capacités mathématiques étendues
\PassOptionsToPackage{silent}{fontspec} % Supprime les avertissements de fontspec
\RequirePackage{booktabs}  % Tableaux de meilleure qualité
\RequirePackage{multicol}  % Colonnes multiples
\RequirePackage{siunitx}   % Unités SI
\RequirePackage{tcolorbox} % Boîtes colorées

% --- HEH Common Resources ---
\RequirePackage{heh-common}  % Shared HEH branding (colors, logo)

% --- Configuration des unités SI ---
\sisetup{
  locale=FR,                     % Locale française (séparateur décimal virgule)
  per-mode=fraction              % Utiliser des fractions pour les unités
}


% --- Formatage du texte ---
\RequirePackage{setspace}  % Espacement des lignes
\onehalfspacing{}                  % Espacement 1,5 ligne
\setlength{\parindent}{0pt}        % Pas d'indentation de paragraphe

\ifhehbeamer@handout
  \RequirePackage{handoutWithNotes}
  \pgfpagesuselayout{1 on 1 with notes}[a4paper,border shrink=15mm]
  \setbeamercolor{normal text}{fg=black!85}
\else
  \setbeameroption{show notes}
\fi

% --- Configuration beamer spécifique HEH ---
\usecolortheme{heh}
\usefonttheme{heh}
\useinnertheme{heh}
\useoutertheme{heh}

\AddToHook{begindocument}{%
  % Any setup code to run at begin document can go here
  \AtBeginSection[]{
    \begin{frame}
      \frametitle{\insertpart{}}
      \tableofcontents[currentsection]
    \end{frame}
  }
}
