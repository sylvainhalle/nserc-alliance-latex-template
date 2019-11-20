%% --------------------------------------
%% NSERC Alliance template class
%% (C) 2019 Sylvain Hallé
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%% http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Sylvain Hallé.
%%
%% Usage notes
%% -----------
%% For instructions on how to use this class, see the file alliance-example.tex
%% provided with this package. Most of its content is self-explanatory.
%% --------------------------------------

%% ------------------------
%% Declarations
%% ------------------------
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{nserc-alliance}
              [2019/11/20 v1.0 Classe Alliance CRSNG par Sylvain Hallé]

%% ------------------------
%% Document class options and initialization
%% ------------------------
\def\@langdemande{english}
\def\@inlinerefs{false}
\def\@instbullets{true}
\def\@pdfFourteen{false}
\DeclareOption{french}{\def\@langdemande{french}}
\DeclareOption{english}{\def\@langdemande{english}}
\DeclareOption{inlinerefs}{\def\@inlinerefs{true}}
\DeclareOption{nobullets}{\def\@instbullets{false}}
\DeclareOption{pdf14}{\def\@pdfFourteen{true}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{book}%
}
\ProcessOptions
\ifx\pdfoutput\undefined
  \LoadClass[letterpaper,onecolumn,dvips,12pt]{article}
\else
  \LoadClass[letterpaper,onecolumn,pdftex,12pt]{article}
\fi

%% ------------------------
%% Required packages
%% ------------------------
\RequirePackage[sort,square,numbers]{natbib} %% Format bibliography
\RequirePackage[utf8]{inputenc}       %% Use UTF-8 in input files
\RequirePackage{lastpage}             %% To get number of last page
\RequirePackage[T1]{fontenc}          %% Type-1 font encoding
\RequirePackage{microtype}            %% Better handling of typo
\RequirePackage[scaled]{helvet}       %% Sans-serif heading font
\RequirePackage{mathptmx}             %% Serif text font
\RequirePackage{fancyhdr}             %% Define header/footer
\RequirePackage{geometry}             %% Change page margins
\RequirePackage{graphicx}             %% Required to evaluate conditions
\RequirePackage{ifthen}               %% Required to evaluate conditions
\RequirePackage[normalem]{ulem}       %% For non-ugly underlining
\RequirePackage[explicit]{titlesec}   %% Formatting of section titles
\RequirePackage{textcase}             %% Uppercase titles
\RequirePackage{comment}              %% Comment out parts of the text
\RequirePackage{xcolor}               %% To gray out the instructions

%% ------------------------
%% Experimental: since the template uses only Times and Helvetica,
%% and these are two of the PDF standard's 14 embedded fonts, the
%% "pdf14" option can instruct LaTeX not to embed any font in the PDF.
%% This results in a PDF that is really small: around 17 kb, compared to
%% 237 kb for the identical Word document (if you care). Don't use this
%% option if it causes display problems for you.
%% ------------------------
\ifthenelse{\equal{\@pdfFourteen}{true}}{
  \pdfmapfile{pdftex_ndl14.map}
}{%
}

%% ------------------------
%% Prevents heading and single lines to be split across pages
%% ------------------------
\widowpenalty=1000
\clubpenalty=1000

%% ------------------------
%% Set indent and paragraph spacing according to language
%% ------------------------
\ifthenelse{\equal{\@langdemande}{french}}{%
  \setlength{\parskip}{8pt}
  \setlength{\parindent}{0pt}
  \RequirePackage[french]{babel}
}{%
  \setlength{\parskip}{0pt}
  \RequirePackage[english]{babel}
}

%% ------------------------
%% Toggle bullets with instructions
%% ------------------------
\definecolor{instructioncl}{gray}{0}
\newif\ifinst
\newenvironment{instructions}{\begin{itemize}\raggedright\color{instructioncl}}{\end{itemize}}
\ifthenelse{\equal{\@instbullets}{true}}{%
  \insttrue
}{%
  \instfalse
}

%% ------------------------
%% Get parameters passed at package instantiation
%% ------------------------
\newcommand{\nsercname}[1]{\def\@nname{#1}}
\newcommand{\nsercpin}[1]{\def\@npin{#1}}

%% ------------------------
%% Use logo according to application language
%% ------------------------
\newsavebox{\nserclogo}
\ifthenelse{\equal{\@langdemande}{french}}{%
\savebox{\nserclogo}{\includegraphics[width=2.46cm]{logo-fr}}
}{%
\savebox{\nserclogo}{\includegraphics[width=2.46cm]{logo-en}}
}

%% ------------------------
%% Page margins
%% ------------------------
\geometry{hmargin={0.75in,0.75in},vmargin={-0.25in,0.5in},headheight=0.5in,includehead,includefoot,heightrounded}

%% ------------------------
%% Page style
%% ------------------------
\fancyhead[LO,RE]{}
\fancyhead[RO,LE]{}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{plain}
\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\fancyhead[R]{{\color{white}$\oplus$}~\@nname~$\cdot$~\@npin}
\fancyfoot[R]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
}

%% ------------------------
%% Section style
%% ------------------------
\titleformat{\section}
  {\normalfont\bfseries}%
  {\MakeTextUppercase{\thesection}}% Titre du chapitre
  {0.5cm}% Séparation d'avec le corps du chapitre
  {\MakeTextUppercase{#1}}% Code à exécuter avant le titre
  {}% Code à exécuter après le titre

%% -------------------------------
%% Title page
%% -------------------------------
\newcommand{\pushright}{\rule{0.25in}{0pt}} %% Hack to get different left margin on first page
\fancypagestyle{firstpage}{%
\fancyhf{} % clear all header and footer fields
\ifthenelse{\equal{\@langdemande}{english}}{%
  \fancyfoot[L]{\fontsize{9}{9}\selectfont\pushright\textsf{\color{gray}{Date modified: September 18, 2019  |  Ce formulaire est disponible en français}}}
}{%
  \fancyfoot[L]{\fontsize{9}{9}\selectfont\pushright\textsf{\color{gray}{Date de modification: 18 septembre 2019  |  This form is available in English}}}
}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\renewcommand{\maketitle}{%
\begin{titlepage}
\thispagestyle{firstpage}
\noindent\pushright\usebox{\nserclogo}
\ifthenelse{\equal{\@langdemande}{english}}%
{% English
\vskip 2in
\noindent{\fontsize{16}{24}\selectfont\pushright\textsf{\textbf{Alliance grants}}}
\vskip 0.207cm
\noindent{\hspace{-2pt}\fontsize{26}{30}\selectfont\pushright\textsf{\textbf{Proposal template}}}
\vskip 5in
\noindent{\fontsize{14}{24}\selectfont\pushright\textsf{\textbf{General instructions:}}}\\
\noindent
{\fontsize{10}{10}\selectfont
\pushright\textsf{Provide responses under INSERT YOUR TEXT using the suggested number of pages per section}\\
\pushright\textsf{(as per the NSERC online system instructions), and without altering the template text or margins.}\\
\pushright\textsf{Figures and tables are welcome.}}
}%
{% French
\vskip 2in
\noindent{\fontsize{16}{24}\selectfont\pushright\textsf{\textbf{Subventions Alliance}}}
\vskip 0.207cm
\noindent{\hspace{-2pt}\fontsize{26}{30}\selectfont\pushright\textsf{\textbf{Gabarit de la proposition}}}
\vskip 4.60in
\noindent{\fontsize{14}{24}\selectfont\pushright\textsf{\textbf{Instructions générales:}}}\\

{\noindent
{\fontsize{10}{10}\selectfont
\pushright\textsf{Insérez vos réponses dans les sections \og{}INSÉREZ ICI VOTRE TEXTE\fg{} en prenant soin de respecter le}\\
\pushright\textsf{nombre de pages suggéré (tel qu’il est indiqué dans les instructions du Système en ligne) pour chacune}\\
\pushright\textsf{des rubriques. Ne modifiez ni le texte du gabarit ni les marges. Vous pouvez aussi insérer des figures et}\\
\pushright\textsf{des tableaux.}\\
}
}
}
\end{titlepage}
\newgeometry{hmargin={0.75in,0.75in},vmargin={0.5in,0.5in},headheight=0.3in,includehead,includefoot,heightrounded}
\pagestyle{plain}
}

%% :mode=latex:wrap=none: