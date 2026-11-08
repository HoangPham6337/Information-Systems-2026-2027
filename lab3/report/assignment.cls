\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignment}[2026/11/06 v1.1 USTH assignment / labwork report]

% Any option not handled here (12pt, twoside, ...) goes to article.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{article}

% ---- Page and fonts -------------------------------------------------------
\RequirePackage[left=2cm,right=2cm,top=1.5cm,bottom=2cm]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[varqu]{zi4}      % Inconsolata: monospace with a real bold

% ---- General packages -----------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{amsmath,amssymb}
\RequirePackage{booktabs}
\RequirePackage{listings}
\RequirePackage{tcolorbox}
\RequirePackage{hyperref}        % load last
\hypersetup{colorlinks=true, linkcolor=blue, urlcolor=blue}

% ---- Highlighted word box: \hword{text} or \hword[color]{text} ------------
\newtcbox{\hword}[1][orange]{on line, arc=0.3mm, auto outer arc,
    colback=#1!12!, colframe=#1!60!, colupper=black, boxsep=0mm,
    left=0.3mm, right=0.3mm, top=0.4mm, bottom=0.4mm,
    boxrule=0.2mm, bottomrule=0.2mm, toprule=0.2mm}

% ---- Relational algebra ---------------------------------------------------
% \sigma \pi \rho \cup \cap \times \bowtie are built in; outer joins are not.
\newcommand*{\ojoin}{\setbox0=\hbox{$\bowtie$}%
  \rule[-.02ex]{.25em}{.4pt}\llap{\rule[\ht0]{.25em}{.4pt}}}
\newcommand*{\leftouterjoin}{\mathbin{\ojoin\mkern-5.8mu\bowtie}}
\newcommand*{\rightouterjoin}{\mathbin{\bowtie\mkern-5.8mu\ojoin}}
\newcommand*{\fullouterjoin}{\mathbin{\ojoin\mkern-5.8mu\bowtie\mkern-5.8mu\ojoin}}
\newcommand*{\attr}[1]{\textit{#1}}   % \attr{first\_name}, \attr{employees}

% ---- Code listings --------------------------------------------------------
% language=cli : shell commands (# comments)
% language=sql : SQL with MariaDB/MySQL extras
% style=output : plain console output (no highlighting)
\lstdefinelanguage{cli}{
    keywords={},
    morecomment=[l]{\#},
    sensitive=false
}

\lstset{
    framerule=1pt,
    frame=tb,
    emphstyle={\small\ttfamily\bfseries\color{Orange}},
    numbers=left,
    numberstyle=\tiny\color{black},
    basicstyle=\small\ttfamily,
    keywordstyle=\bfseries\color{BrickRed},
    identifierstyle=\color{black},
    stringstyle=\color{ForestGreen},
    commentstyle=\color{Violet},
    breaklines=true,
    columns=fixed,
    basewidth=.5em,
    backgroundcolor=\color{Gray!5},
    tabsize=2,
    showspaces=false,
    showstringspaces=false,
    upquote=true
}

\lstdefinestyle{output}{
    language={},
    keywordstyle={},
    commentstyle={},
    stringstyle={},
    numbers=none
}

% Extra keywords for SQL listings
\lstset{language=sql, morekeywords={IF, EXISTS, SHOW, DESCRIBE, USE,
    IDENTIFIED, GRANT, PRIVILEGES, FLUSH, LIMIT, ENGINE, AUTO_INCREMENT}}
\lstset{language={}}   % default: no language unless asked

% ---- Title block -----------------------------------------------------------
% \assignmentTitle{Name}{Student ID}{logo path}{Course}{Labwork N}
\newcommand{\assignmentTitle}[5]{%
    \vspace*{5mm}%
    \par\noindent
    \begin{minipage}[c]{0.7\linewidth}%
        Student Name: #1\par
        Student ID: #2%
    \end{minipage}%
    \begin{minipage}[c]{0.3\linewidth}%
        \raggedleft
        \includegraphics[height=2cm]{#3}%
    \end{minipage}%
    \par\vspace{2mm}%
    \begin{center}
        \textbf{\large #4}\\
        \textbf{#5}
    \end{center}
    \noindent\rule{\linewidth}{.6pt}\par
}
