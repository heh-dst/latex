% heh-amc.cls — Classe LaTeX pour examens AMC au DST de la HEH
% Copyright (c) 2026 — François Roland
%
% Cette classe centralise le chargement des dépendances pour les examens
% Auto Multiple Choice (AMC) conformes à la charte graphique HEH.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{heh-amc}[2026/01/26 v0.1.1 Classe AMC pour la HEH]

% --- Vérification du moteur de compilation ---
% Le package requiert LuaLaTeX pour fontspec et les polices OpenType
\RequirePackage{ifluatex}
\ifluatex\else
  \ClassError{heh-amc}{%
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
% Booléens pour contrôler le comportement d'AMC
\newif\ifhehamc@catalog \hehamc@catalogfalse
\newif\ifhehamc@noshuffle \hehamc@noshufflefalse
\newif\ifhehamc@separateanswersheet \hehamc@separateanswersheetfalse

% Déclaration des options
\DeclareOption{catalog}{\hehamc@catalogtrue}
\DeclareOption{noshuffle}{\hehamc@noshuffletrue}
\DeclareOption{separateanswersheet}{\hehamc@separateanswersheettrue}

% Avertissement pour options inconnues
\DeclareOption*{%
  \ClassWarning{heh-amc}{Option inconnue~: '\CurrentOption'}%
}

% Traitement des options
\ProcessOptions\relax

% Charge la classe de base article
\LoadClass[12pt,a4paper]{article}

% --- Packages de base ---
% Formatage du document et langue
\RequirePackage{booktabs}  % Tableaux de meilleure qualité
\RequirePackage{enumitem}  % Listes personnalisables
\RequirePackage{graphicx}  % Gestion des images
\RequirePackage{multicol}  % Colonnes multiples
\RequirePackage{setspace}  % Espacement des lignes
\RequirePackage{tcolorbox} % Boîtes colorées

% --- HEH Common Resources ---
\RequirePackage{heh-common}  % Shared HEH branding (colors, logo)

% --- Formatage du texte ---
\onehalfspacing{}                  % Espacement 1,5 ligne
\setlength{\parindent}{0pt}        % Pas d'indentation de paragraphe

% --- Chargement d'Auto Multiple Choice ---
% Construction dynamique des options AMC
\newcommand{\hehamc@amcoptions}{box,lang=FR}

% Ajout conditionnel des options
\ifhehamc@catalog
  \edef\hehamc@amcoptions{\hehamc@amcoptions,catalog}
\fi
\ifhehamc@noshuffle
  \edef\hehamc@amcoptions{\hehamc@amcoptions,noshuffle,noshufflegroups}
\fi
\ifhehamc@separateanswersheet
  \edef{\hehamc@amcoptions}{\hehamc@amcoptions,asbox,separateanswersheet}
\fi

% Chargement du package AMC avec les options construites
\expandafter\RequirePackage\expandafter[\hehamc@amcoptions]{automultiplechoice}

% --- Configuration AMC par défaut ---
\AMCboxStyle{shape=square,size=2ex,down=.3ex}   % Taille des cases à cocher
\AMCsetFoot{\thepage{}}            % Numéro de page en pied de page
\AMCsetScoreZoneAnswerSheet{position=margins} % Position de la zone de score
\setdefaultgroupmode{withoutreplacement} % Mode de sélection des questions

% --- Formatage des questions ---
\newlength{\hehamc@questionnumberlength}
\settowidth{\hehamc@questionnumberlength}{\textbf{99. }}
\renewcommand{\AMCformQuestion}[1]{\makebox[\hehamc@questionnumberlength][r]{\textbf{#1.}}}
\ifhehamc@catalog
  \renewcommand{\AMCbeginQuestion}[2]{\noindent\textbf{#1}}
\else
  \renewcommand{\AMCbeginQuestion}[2]{\noindent\makebox[\hehamc@questionnumberlength][l]{\textbf{#1.}}}
\fi

% --- Commandes personnalisées ---

\newcommand{\hehamc@examtitle}{}
\newcommand{\ExamTitle}[1]{\renewcommand{\hehamc@examtitle}{#1}}

\newcommand{\hehamc@cohort}{}
\newcommand{\Cohort}[1]{\renewcommand{\hehamc@cohort}{#1}}

\newcommand{\hehamc@duration}{}
\newcommand{\Duration}[1]{\renewcommand{\hehamc@duration}{#1}}

\newcommand{\hehamc@durationextra}{}
\newcommand{\DurationExtra}[1]{\renewcommand{\hehamc@durationextra}{#1}}

% Page de couverture
% Colors and \HEHLogo now provided by heh-common package

% Backward compatibility: create aliases for old color names
\colorlet{hehamc@red1}{heh@red1}
\colorlet{hehamc@red2}{heh@red2}
\colorlet{hehamc@red3}{heh@red3}
\colorlet{hehamc@red4}{heh@red4}
\colorlet{hehamc@red5}{heh@red5}
\colorlet{hehamc@dark}{heh@dark}

\newcommand{\Instructions}{%
  \begin{itemize}[itemsep=0.5em]
    \item \textbf{Durée maximale}
          \begin{itemize}[noitemsep]
            \item \hehamc@duration{}
            \item Durée avec aménagement tiers temps~: \hehamc@durationextra{} % chktex 13
          \end{itemize}
    \item \textbf{Notation}
          \begin{itemize}[noitemsep]
            \item Chaque réponse correcte = \textbf{1~point}
            \item Question non répondue ou mal encodée = \textbf{0~point}
            \item Pas de point négatif pour les erreurs
            \item \textbf{Répondez à toutes les questions}, même en cas de doute
          \end{itemize}
    \item \textbf{Format des questions à choix multiples}
          \begin{itemize}[noitemsep]
            \item \textbf{Une seule} case à cocher par question
            \item 4 propositions spécifiques + 2 propositions générales~:
                  \begin{itemize}[noitemsep]
                    \item \textbf{aucune} = aucune proposition spécifique n'est correcte
                    \item \textbf{toutes} = toutes les propositions spécifiques sont correctes
                  \end{itemize}
                  \ifhehamc@separateanswersheet \else
            \item Utilisez un stylo-bille \textbf{bleu standard} ou \textbf{noir}, non-effaçable
            \item \textbf{Noircissez complètement} la case de votre choix.
            \item \textbf{Effacez} vos erreurs avec un \textbf{correcteur} liquide ou en ruban
            \item \textbf{Ne redessinez jamais} les cases
                  \fi
          \end{itemize}
    \item \textbf{Remise}
          \begin{itemize}[noitemsep]
            \ifhehamc@separateanswersheet
            \item Seule la \textbf{feuille de réponse} sera corrigée
                  \fi
            \item Utilisez le \textbf{verso} des feuilles de question comme \textbf{brouillon}
            \item \textbf{Toutes les feuilles} doivent être remises en fin d'examen
          \end{itemize}
  \end{itemize}
}

\newcommand{\CoverPage}{%
  \setcounter{figure}{0} % Remet à zéro le compteur de figures
  \HEHLogo{}

  \vspace{1em}

  \textbf{\hehamc@examtitle{} \hfill{} \hehamc@cohort{}}

  \vspace{1em}

  \section*{Consignes}

  \begin{tcolorbox}
    \textbf{Ne tournez pas cette page avant d'en avoir reçu l'autorisation.}
  \end{tcolorbox}

  \Instructions{}

  \clearpage{}
} % Fin de la commande \CoverPage

\ifhehamc@separateanswersheet
  \newcommand{\AnswerSheet}{%
    \AMCformBegin{}%
    \textbf{\hehamc@examtitle{} \hfill{} \hehamc@cohort{}}

    \vspace{1em}

    \begin{tabular*}{\linewidth}{@{\extracolsep{\fill}}@{}lr@{}}
      \namefield{\tcbox[colback=white,title=Nom et prénom,title filled]{\begin{minipage}{.50\linewidth}\vspace{1cm}\hfill\end{minipage}}} &
      \tcbox[bottomtitle=3pt,colback=white,title=Date,title filled]{\begin{minipage}{.325\linewidth}\vspace{1cm}\hfill\end{minipage}}
    \end{tabular*}

    \section*{Réponses}

    \begin{tcolorbox}
      \begin{itemize}[left=0pt,noitemsep]
        \item \textbf{Encodage des réponses pour faciliter la lecture optique~:}
              \begin{itemize}[nosep]
                \item Utilisez un stylo-bille \textbf{bleu} standard ou \textbf{noir}, non-effaçable.
                \item Noircissez complètement la case de votre choix.
              \end{itemize}
        \item \textbf{Modification de vos réponses~:}
              \begin{itemize}[nosep]
                \item Utilisez du correcteur liquide ou en ruban.
                \item Ne redessinez ni les cases ni les lettres.
              \end{itemize}
      \end{itemize}
    \end{tcolorbox}

    \begin{spacing}{1}
      \begin{multicols}{2}
        \AMCform{}
      \end{multicols}
    \end{spacing}
  } % Fin de la commande \AnswerSheet
\fi

\newcommand{\DraftPage}{\clearpage{}\section*{Feuille de brouillon}\clearpage{}} % Crée une page de brouillon
\newcommand{\FillIn}{\makebox[6em]{\hrulefill{}}} % Commande pour les espaces à remplir

