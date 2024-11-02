% TJUletter.cls
% Modified to remove header and footer definitions to allow custom letterhead and watermark

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TJUletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}

\DeclareGraphicsExtensions{.png}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter}

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\newboolean{logofound}
\IfFileExists{TJU_logo.png}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

% Remove header and footer definitions to allow custom settings from main tex file
\renewcommand{\ps@firstpage}{\pagestyle{fancy}}

% Keep the rest of the class definitions as they are
% (e.g., opening, closing commands, etc.)

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        %{\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            %\@date
            \end{tabular}\par
        }%
     \fi
     \vspace{-6\parskip}
     \@date \vspace{2\parskip}\\
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hspace*{0.6\textwidth}\parbox{0.4\textwidth}{\raggedright
    \ignorespaces #1\\[4\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}