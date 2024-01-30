%% --------------------------------------
%% NSERC Alliance template class
%% (C) 2019 Sylvain Hallé
%% modified by C. Fuhrman (2024) for 2023 Alliance template
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
%% Christopher Fuhrman updated this class based on the Word template at https://www.nserc-crsng.gc.ca/_doc/alliance/Proposal_Template-Alliance_Grants2_e.docx (accessed 2024-01-30)
%% --------------------------------------

%% ------------------------
%% Declarations
%% ------------------------
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{nserc-alliance}
              [2024/01/30 v1.1 Classe Alliance CRSNG par Sylvain Hallé actualisée par Christopher Fuhrman]

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
  \LoadClass[letterpaper,onecolumn,12pt]{article}
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
\newenvironment{instructions}{
  \nointerlineskip
  \begin{list}{\labelitemi}{\leftmargin=1em \itemindent=0em}
  \setlength{\itemsep}{1pt}
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{0pt}
  \raggedright\color{instructioncl}}{\end{list}}
\ifthenelse{\equal{\@instbullets}{true}}{%
  \insttrue
}{%
  \instfalse
}

%% ------------------------
%% Microsoft Word-like bullets
%% ------------------------
\newenvironment{worditemize}{
  \begin{itemize}
  \renewcommand{\labelitemii}{\labelitemi}
  \renewcommand{\labelitemiii}{\labelitemi}
  \renewcommand{\labelitemiv}{\labelitemi}
}{
  \end{itemize}
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
\savebox{\nserclogo}{\includegraphics[width=2.46cm]{CRSNG.png}}
}{%
\savebox{\nserclogo}{\includegraphics[width=2.46cm]{NSERC.png}}
}

%% ------------------------
%% Page margins
%% ------------------------
\geometry{hmargin={0.75in,0.75in},vmargin={-0.25in,0.5in},headheight=0.5in,includehead,includefoot,heightrounded}

%% ------------------------
%% Page style
%% ------------------------
\fancyhead[L,R]{}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{plain}
\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\fancyhead[R]{{\color{white}$\oplus$}\color{gray}{~\@nname~$\cdot$~\@npin}}
\fancyfoot[R]{\color{gray}\thepage}
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
  \fancyfoot[L]{\fontsize{9}{9}\selectfont\pushright\textsf{\color{gray}{Date modified: December 2023  |  \emph{Ce formulaire est disponible en français}}}}
}{%
  \fancyfoot[L]{\fontsize{9}{9}\selectfont\pushright\textsf{\color{gray}{Date de modification: Décembre 2023  |  \emph{This form is available in English}}}}
}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\renewcommand{\maketitle}{%
\begin{titlepage}
\thispagestyle{firstpage}
\noindent\pushright\usebox{\nserclogo}
\ifthenelse{\equal{\@langdemande}{english}}%
{% English
\vskip 1in
\noindent{\fontsize{16}{24}\selectfont\pushright\textsf{\textbf{Alliance grants}}}
\vskip 0.207cm
\noindent{\hspace{-2pt}\fontsize{26}{30}\selectfont\pushright\textsf{\textbf{Proposal template}}}
\vskip 1in
\noindent{\fontsize{14}{24}\selectfont\pushright\textsf{\textbf{General instructions}}}\\
\noindent

{\fontsize{11}{11}\selectfont
\sffamily
\begin{worditemize}
% \def\labelenumi{\arabic{enumi}.}
\item The following template provides the proposal's section headings, each with bullet points that specify the information that must be provided in that section. Complete the proposal by entering text that addresses the bullet points in place of ``Insert your text here\ldots'' in each section.

  \begin{itemize}
    \item	A suggested number of pages for each section is provided in the \href{https://www.nserc-crsng.gc.ca/OnlineServices-ServicesEnLigne/instructions/101/alliance_eng.asp\#proposal}{Instructions for completing an application}. The total length of your proposal must not exceed the maximum page limit specified in the \href{https://www.nserc-crsng.gc.ca/OnlineServices-ServicesEnLigne/instructions/101/alliance_eng.asp\#proposal}{Instructions for completing an application}.
    \item When addressing consideration of equity, diversity and inclusion (EDI) in the research, the team composition and the training plan, refer to the \href{https://www.nserc-crsng.gc.ca/Innovate-Innover/alliance-alliance/EDI_training-EDI_formation_eng.asp}{Equity, diversity and inclusion in your training plan} web page and the \href{https://www.nserc-crsng.gc.ca/NSERC-CRSNG/Policies-Politiques/EDI_guidance-Conseils_EDI_eng.asp\#a1}{NSERC guide on integrating equity, diversity and inclusion considerations in research} for guidance.
    \item The merit of your application will be assessed using the Alliance \href{https://www.nserc-crsng.gc.ca/Innovate-Innover/alliance-alliance/instructions_external_reviewers-instructions_evaluatrices_evaluateurs_externes_eng.asp}{evaluation criteria} and the related \href{https://www.nserc-crsng.gc.ca/Innovate-Innover/alliance-alliance/instructions_external_reviewers-instructions_evaluatrices_evaluateurs_externes_eng.asp}{merit indicators}. If the assessment process includes external reviewers, they will be guided by the \href{https://www.nserc-crsng.gc.ca/Innovate-Innover/alliance-alliance/instructions_external_reviewers-instructions_evaluatrices_evaluateurs_externes_eng.asp}{Instructions for external reviewers}.
  \end{itemize}

\item For Alliance Society proposals only, complete the Public impact value proposition section (on the last page) using a maximum of three pages, including the template text. (For required characteristics of Alliance Society grants see \href{https://www.nserc-crsng.gc.ca/Innovate-Innover/alliance_society-alliance_societe/research_topics-sujets_de_recherche_eng.asp}{Alliance Society Research Topics}). This section will be shared only with the Public Impact Value Proposition Selection Committee. If your application is selected for the subsequent assessment step, external reviewers will not have access to this section. Make sure the rest of your application contains all the information that is relevant to the Alliance evaluation criteria.
  
\item For all other applications, delete the Public impact value proposition section.
\item Do not alter or remove template text (headings and bullet points) or modify the presentation format (font type and size, margins and line spacing).
\item Figures and tables are welcome; use a font type and size that are clearly legible.
\item Do not submit this cover page.
\item Consult the \href{https://www.nserc-crsng.gc.ca/_doc/alliance/ApplicationChecklist_e.pdf}{Alliance grant application checklist} to ensure your application is complete. 

\end{worditemize}
}
    
    
    
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