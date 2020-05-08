%
% Email: hellckt@126.com
% Maintainer: hellckt
%
% Copyright (C) 2009-2017 by weijianwen <weijianwen@gmail.com>
%           (C) 2018-2019 by SJTUG
%           (C) 2020-2020 by hellckt <hellckt@126.com>
%
% This file may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%     https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%


% TODO: 明确 LaTeX2e 版本日期
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{shmtuthesis}[2020/01/22 0.0.1 Shanghai Maritime University Thesis Template]
\def\shmtuthesis{SHMTU\textsc{thesis}}
\def\version{0.0.1}

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=shmtu,
  prefix=shmtu@,
  setkeys=\kvsetkeys
}
% 学位论文类型，目前仅支持硕士论文
\DeclareStringOption[master]{degree}[master]
% 语言类型
\DeclareStringOption[chinese]{language}[chinese]
% 字号
\DeclareStringOption[-4]{zihao}[-4]
% 拉丁文设置
\DeclareStringOption[all]{setlatinfont}[all]
% 数学样式
\DeclareStringOption[GB]{mathstyle}[GB]
% 参考文献样式
\DeclareStringOption[gb7714-2015]{bibstyle}[gb7714-2015]
% 是否盲审，默认为：False
\DeclareBoolOption{review}
\DeclareDefaultOption{
  \PassOptionsToClass{\CurrentOption}{ctexbook}
}
\ProcessKeyvalOptions*

% 创建相应的逻辑变量并进行校验
\newcommand{\shmtu@validate@key}[1]{%
  \@ifundefined{shmtu@#1@\csname shmtu@#1\endcsname true}{%
    \ClassError{shmtuthesis}{Invalid value '\csname shmtu@#1\endcsname'}{}%
  }{%
    \csname shmtu@#1@\csname shmtu@#1\endcsname true\endcsname
  }%
}

\newif\ifshmtu@degree@master
\shmtu@validate@key{degree}

\newif\ifshmtu@language@chinese
\newif\ifshmtu@language@english
\shmtu@validate@key{language}

\newif\ifshmtu@setlatinfont@none
\newif\ifshmtu@setlatinfont@main
\newif\ifshmtu@setlatinfont@math
\newif\ifshmtu@setlatinfont@all
\shmtu@validate@key{setlatinfont}
\ifshmtu@setlatinfont@all
  \shmtu@setlatinfont@maintrue
  \shmtu@setlatinfont@mathtrue
\fi

\newif\ifshmtu@mathstyle@GB
\@ifundefined{shmtu@mathstyle@\csname shmtu@mathstyle\endcsname true}{}{%
  \shmtu@mathstyle@GBtrue
  \def\shmtu@mathstyle{ISO}
}%

\ifshmtu@language@english
  \PassOptionsToClass{scheme=plain}{ctexbook}
\fi

\PassOptionsToPackage{no-math}{fontspec}
\PassOptionsToPackage{math-style=\shmtu@mathstyle}{unicode-math}

\LoadClass[a4paper, zihao=\shmtu@zihao, linespread=1.3, UTF8]{ctexbook}

% 根据学位导入相应的.ltx文件，可在此处导入制定一的样式文件
\ifshmtu@degree@master
  \AtEndOfClass{\input{shmtuthesis-graduate.ltx}}
\fi

% 依赖库
\RequirePackage{etoolbox}
\RequirePackage{xparse}			% 提供\NewDocumentCommand命令
\RequirePackage{environ}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{pageslts}
\RequirePackage{amsmath}
\ifshmtu@setlatinfont@math
  \RequirePackage{unicode-math}
\fi
\RequirePackage{anyfontsize}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{caption}
\RequirePackage[list=off]{bicaption}
\RequirePackage{subcaption}
\RequirePackage[backend=biber, style=\shmtu@bibstyle]{biblatex}
\RequirePackage{titletoc}
\RequirePackage[titles]{tocloft}
\RequirePackage[inline]{enumitem}
\RequirePackage[perpage, bottom]{footmisc}
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\RequirePackage{hyperref}

% 定义全局中英文术语变量
\newcommand{\shmtu@def@term}[1]{%
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname shmtu@value@#1\endcsname{##1}}
  \csname #1\endcsname{}
  \define@key{shmtuvalue}{#1}{\csname #1\endcsname{##1}}}
\shmtu@def@term{degreecategory} 
\shmtu@def@term{title}
\shmtu@def@term{entitle}
\shmtu@def@term{author}
\shmtu@def@term{enauthor}
\shmtu@def@term{supervisor}
\shmtu@def@term{ensupervisor}
\shmtu@def@term{studentid}
\shmtu@def@term{finisheddate}
\shmtu@def@term{major}
\shmtu@def@term{enmajor}
\shmtu@def@term{keywords}
\shmtu@def@term{enkeywords}

\NewDocumentCommand\shmtuSetInfo{}{\setkeys{shmtuvalue}}

% 定义全局标签变量
\newcommand{\shmtu@def@label}[2]{%
  \expandafter\gdef\csname shmtu@label@#1\endcsname{#2}
  \define@key{shmtulabel}{#1}{%
    \expandafter\gdef\csname shmtu@label@#1\endcsname{##1}}}
\shmtu@def@label{schoolChi}{上海海事大学}
\shmtu@def@label{schoolEng}{Shanghai Maritime University}
\shmtu@def@label{originalityChi}{论文独创性声明}
\shmtu@def@label{originalityEng}{Declaration of Originality}
\shmtu@def@label{authorizationChi}{论文使用授权声明}
\shmtu@def@label{authorizationEng}{Declaration of Authorization}
\shmtu@def@label{origtitle}{\shmtu@label@originalityChi}
\shmtu@def@label{authtitle}{\shmtu@label@authorizationChi}
\shmtu@def@label{origbody}{%
  本论文是我个人在导师指导下进行的研究工作及取得的研究成果。
  论文中除了特别加以标注和致谢的地方外，不包含其他人或者其他机构
  已经发表或撰写过的研究成果。其他同志对本研究的启发和所做的贡献
  均已在论文中作了明确的声明并表示了感谢。}
\shmtu@def@label{authbody}{%
  本人同意上海海事大学有关保留、使用学位论文的规定，即：学校
  有权保留送交论文复印件，允许论文被查阅和借阅;学校可以上网公布
  论文的全部和部分内容，可以采用影印、缩印或者其他复制手段保存论
  文。保密的论文在解密后遵守此规定。}
\shmtu@def@label{abstractChi}{摘\quad 要}
\shmtu@def@label{abstractEng}{Abstract}
\shmtu@def@label{keywordsChi}{关键词：}
\shmtu@def@label{keywordsEng}{Key words:~}
\ifshmtu@language@english
  \shmtu@def@label{titlepage}{Title Page}
  \def\shmtu@label@originality{\shmtu@label@originalityEng}
  \def\shmtu@label@authorization{\shmtu@label@authorizationEng}
  \def\shmtu@label@abstract{\shmtu@label@abstractEng}
  \shmtu@def@label{contents}{Contents}
  \shmtu@def@label{figure}{Figure}
  \shmtu@def@label{listfigure}{List of Figures}
  \shmtu@def@label{table}{Table}
  \shmtu@def@label{listtable}{List of Tables}
  \shmtu@def@label{algorithm}{Algorithm}
  \shmtu@def@label{listalgorithm}{List of Algorithms}
  \shmtu@def@label{nomenclature}{Nomenclature}
  \shmtu@def@label{acknowledgements}{Acknowledgements}
  \shmtu@def@label{publications}{Publications}
  \shmtu@def@label{patents}{Patents}
  \shmtu@def@label{projects}{Projects}
  \shmtu@def@label{awards}{Awards}
\else
  \shmtu@def@label{titlepage}{扉页}
  \def\shmtu@label@originality{\shmtu@label@originalityChi}
  \def\shmtu@label@authorization{\shmtu@label@authorizationChi}
  \def\shmtu@label@abstract{\shmtu@label@abstractChi}
  \shmtu@def@label{contents}{目\quad 录}
  \shmtu@def@label{figure}{图}
  \shmtu@def@label{listfigure}{图目录}
  \shmtu@def@label{table}{表}
  \shmtu@def@label{listtable}{表目录}
  \shmtu@def@label{algorithm}{算法}
  \shmtu@def@label{listalgorithm}{算法目录}
  \shmtu@def@label{nomenclature}{主要符号对照表}
  \shmtu@def@label{acknowledgements}{致\quad 谢}
  \shmtu@def@label{publications}%
                 {攻读\shmtu@label@degreetypeChi 学位期间已发表或录用的论文}
  \shmtu@def@label{patents}%
                 {攻读\shmtu@label@degreetypeChi 学位期间申请的专利}
  \shmtu@def@label{projects}%
                 {攻读\shmtu@label@degreetypeChi 学位期间参与的项目}
  \shmtu@def@label{awards}%
  				 {攻读\shmtu@label@degreetypeChi 学位期间获奖情况}
\fi

\NewDocumentCommand\shmtuSetLabel{}{\setkeys{shmtulabel}}

\newif\ifshmtu@xitsnew
\@ifpackagelater{fontspec}{2017/01/20}{
  \IfFontExistsTF{XITSMath-Regular.otf}{
    \shmtu@xitsnewtrue
  }{}
}{}
\ifshmtu@setlatinfont@main
  \ifshmtu@xitsnew
    \setmainfont{XITS}[
      Extension          = .otf,
      UprightFont        = *-Regular,
      BoldFont           = *-Bold,
      ItalicFont         = *-Italic,
      BoldItalicFont     = *-BoldItalic,
      UprightFeatures    = { SmallCapsFont = texgyretermes-regular },
      BoldFeatures       = { SmallCapsFont = texgyretermes-bold },
      ItalicFeatures     = { SmallCapsFont = texgyretermes-italic },
      BoldItalicFeatures = { SmallCapsFont = texgyretermes-bolditalic },
      SmallCapsFeatures  = { Letters = SmallCaps }
    ]
  \else
    \setmainfont{xits}[
      Extension          = .otf,
      UprightFont        = *-regular,
      BoldFont           = *-bold,
      ItalicFont         = *-italic,
      BoldItalicFont     = *-bolditalic,
      UprightFeatures    = { SmallCapsFont = texgyretermes-regular },
      BoldFeatures       = { SmallCapsFont = texgyretermes-bold },
      ItalicFeatures     = { SmallCapsFont = texgyretermes-italic },
      BoldItalicFeatures = { SmallCapsFont = texgyretermes-bolditalic },
      SmallCapsFeatures  = { Letters = SmallCaps }
    ]
  \fi
  \RequirePackage[opentype, scaled=.9]{sourcesanspro}
  \RequirePackage[opentype, scaled=.9]{sourcecodepro}
\fi

\ifshmtu@setlatinfont@math
  \ifshmtu@xitsnew
    \setmathfont{XITSMath-Regular}[
      Extension    = .otf,
      BoldFont     = XITSMath-Bold,
      StylisticSet = 8
    ]
    \setmathfont{XITSMath-Regular.otf}[range={cal,bfcal},StylisticSet=1]
  \else
    \setmathfont{xits-math}[
      Extension    = .otf,
      BoldFont     = *bold,
      StylisticSet = 8
    ]
    \setmathfont{xits-math.otf}[range={cal, bfcal}, StylisticSet=1]
  \fi
\fi

\patchcmd\cleardoublepage%
  {\newpage}{\thispagestyle{empty}\newpage}
  {}{}
\patchcmd\chapter%
  {\thispagestyle{\CTEX@chapter@pagestyle}}{}
  {}{}
\AtBeginDocument{%
  \pagenumbering{Alph}
  \pagestyle{empty}}

% CTEX设置
\ctexset{%
  contentsname   = \shmtu@label@contents,
  listfigurename = \shmtu@label@listfigure,
  listtablename  = \shmtu@label@listtable}
  
\ctexset{%
  chapter={%
    format       = \zihao{3}\heiti\centering,
    nameformat   = {},
    titleformat  = {},
    aftername    = \quad,
    afterindent  = true,
    beforeskip   = 1ex,
    afterskip    = 2ex
  },
  section={%
    format       = \zihao{4}\heiti,
    afterindent  = true,
    afterskip    = 1ex \@plus .2ex
  },
  subsection={%
    format       = \zihao{-4}\heiti,
    afterindent  = true,
    afterskip    = 1ex \@plus .2ex
  },
  subsubsection={%
    format       = \zihao{-4}\normalfont,
    afterindent  = true,
    afterskip    = 1ex \@plus .2ex
  },
  paragraph/afterindent    = true,
  subparagraph/afterindent = true}

\ctexset{%
  punct          = quanjiao,
  space          = auto,
  autoindent     = true}

% 解决 MAC OS 中没有隶书、幼园的问题，需要先下载字体。
\ifdef{\lishu}{}{%
  \setCJKfamilyfont{zhli}{LiSu}
  \newcommand*{\lishu}{\CJKfamily{zhli}}
}
\ifdef{\youyuan}{}{%
  \setCJKfamilyfont{youyuan}{YouYuan}
  \newcommand*{\youyuan}{\CJKfamily{youyuan}}
}
  
\AtEndOfClass{\sloppy}

% 有序和无序列表设置
\setlist{nosep}
\setlist*{leftmargin=*}
\setlist[1]{labelindent=\parindent}

\setcounter{secnumdepth}{3}

% 目录样式设置
\let\origaddvspace\addvspace
\renewcommand{\addvspace}[1]{}  % 取消章与章之间目录的间隔
\setcounter{tocdepth}{2}
\renewcommand{\cftdotsep}{1} % 目录中间点的间隔因子，越小越密
\titlecontents{chapter}% <section-type>
  [0pt]% <left> 
  {}% <above-code>
  {\thecontentslabel}% <numbered-entry-format>
  {}% <numberless-entry-format>
  {~\cftdotfill{\cftdot}\contentspage}% <filler-page-format>
\titlecontents{section}% <section-type>
  [2em{}]% <left> 
  {}% <above-code>
  {\thecontentslabel\hspace{.5em}}% <numbered-entry-format>
  {}% <numberless-entry-format>
  {~\cftdotfill{\cftdot}\contentspage}% <filler-page-format>
\titlecontents{subsection}% <section-type>
  [4em{}]% <left> 
  {}% <above-code>
  {\thecontentslabel\hspace{.5em}}% <numbered-entry-format>
  {}% <numberless-entry-format>
  {~\cftdotfill{\cftdot}\contentspage}% <filler-page-format>
\titlecontents{subsubsection}% <section-type>
  [2em{}]% <left> 
  {}% <above-code>
  {\thecontentslabel\hspace{.5em}}% <numbered-entry-format>
  {}% <numberless-entry-format>
  {~\cftdotfill{\cftdot}\contentspage}% <filler-page-format>

% 目录
\renewcommand{\tableofcontents}{%
  \cleardoublepage%
  \chapter*{\contentsname}%
  \addcontentsline{toc}{chapter}{\contentsname}
  \@mkboth{\contentsname}{\contentsname}%
  \@starttoc{toc}
}

% 图片索引目录
\renewcommand{\listoffigures}{%
  \cleardoublepage%
  \chapter*{\listfigurename}%
  \addcontentsline{toc}{chapter}{\listfigurename}
  \@mkboth{\listfigurename}{\listfigurename}%
  \@starttoc{lof}
}

% 表格索引
\renewcommand{\listoftables}{%
  \cleardoublepage%
  \chapter*{\listtablename}%
  \addcontentsline{toc}{chapter}{\listtablename}
  \@mkboth{\listtablename}{\listtablename}%
  \@starttoc{lot}
}

% 图片、表格题注设置
\renewcommand{\cftfigpresnum}{\shmtu@label@figure~}
\renewcommand{\cfttabpresnum}{\shmtu@label@table~}

\AtEndPreamble{%
  \newlength{\shmtu@cftfignumwidth@tmp}
    \settowidth{\shmtu@cftfignumwidth@tmp}{\cftfigpresnum}
  \addtolength{\cftfignumwidth}{\shmtu@cftfignumwidth@tmp}
  \newlength{\shmtu@cfttabnumwidth@tmp}
    \settowidth{\shmtu@cfttabnumwidth@tmp}{\cfttabpresnum}
  \addtolength{\cfttabnumwidth}{\shmtu@cfttabnumwidth@tmp}
}

\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}

\AtBeginDocument{%
  \renewcommand{\theequation}{\thechapter--\arabic{equation}}
  \renewcommand{\thefigure}{\thechapter--\arabic{figure}}
  \renewcommand{\p@subfigure}{\thefigure}
  \renewcommand{\thetable}{\thechapter--\arabic{table}}
}

% 图表双题注
\newif\ifshmtu@setfloatfont
\renewcommand{\@floatboxreset}{%
  \reset@font
  \ifshmtu@setfloatfont
    \zihao{5}
  \else
    \normalsize
  \fi
  \@setminipage
}
\BeforeBeginEnvironment{longtable}
  {\begingroup\ifshmtu@setfloatfont\zihao{5}\fi}
\AfterEndEnvironment{longtable}
  {\endgroup}
\NewDocumentCommand{\shmtuSetFloatFontOn}{}{\shmtu@setfloatfonttrue}
\NewDocumentCommand{\shmtuSetFloatFontOff}{}{\shmtu@setfloatfontfalse}
\DeclareCaptionFont{shmtucaptionfont}{\zihao{5}\kaishu}
\DeclareCaptionFont{shmtusubcaptionfont}{\zihao{5}\normalfont}
\captionsetup{%
  format        = plain,
  labelformat   = simple,
  labelsep      = space,
  justification = centering,
  font          = shmtucaptionfont
}
\captionsetup[sub]{%
  format        = hang,
  labelformat   = parens,
  labelsep		= space,
  justification = justified,
  font          = shmtusubcaptionfont
}
\DeclareCaptionOption{bi-first}[]{%
  \def\tablename{\shmtu@label@table}
  \def\figurename{\shmtu@label@figure}}
\DeclareCaptionOption{bi-second}[]{%
  \def\tablename{Table}
  \def\figurename{Figure}}
\captionsetup[bi-first]{bi-first}
\captionsetup[bi-second]{bi-second}

% 数学符号样式设置
\ifshmtu@mathstyle@GB
  \let\mathellipsis\cdots
  \AtBeginDocument{%
    \renewcommand{\Re}{\operatorname{Re}}%
    \renewcommand{\Im}{\operatorname{Im}}%
  }
\fi
\newcommand\upe{\mathrm{e}}
\newcommand\upi{\mathrm{i}}
\newcommand\upj{\mathrm{j}}
\newcommand\dif{\mathop{}\!\mathrm{d}}

% 保密选项
\newcommand{\shmtu@square}{%
  \begingroup\CJKfamily+{zhsong}\symbol{"25A1}\endgroup
}
\newcommand{\shmtu@authconf}{%
  \par\hspace{7em}%
  {\heiti 保\quad 密}~\shmtu@square，在 \uline{\hspace{3em}}
  年解密后适用本授权书。\par
  本论文属于
  \par\hspace{7em}%
  {\heiti 不保密}~\shmtu@square。
  \vskip 1ex
  （请在以上方框内打“$\checkmark$”）
}

% 签名框
\newcommand{\shmtu@signbox}[2][作者]{%
  \makebox[\textwidth][r]{%
    #1 签名：\underline{\hbox to 4em{}}%
    \ifthenelse{\equal{#2}{作者}}%
      {}{#2 签名：\underline{\hbox to 4em{}}}%
    日期：\underline{\hbox to 4em{}}%
  }
}

% 原创性声明
\NewDocumentCommand{\makeDeclareOriginality}{o}{%
  \ifshmtu@review
  	\relax
  \else
    \pdfbookmark[0]{\shmtu@label@originality}{origtitle}
    \IfNoValueTF{#1}{%
      \thispagestyle{empty}
      \chapter*{\normalfont\zihao{3}\songti\shmtu@label@origtitle}
      \begingroup
        \zihao{4}
        \shmtu@label@origbody
        \vskip 10ex
        \noindent
        \shmtu@signbox{作者}
      \endgroup
    }
    {\includepdf[pagecommand={\thispagestyle{empty}}]{#1}}
  \fi
}

% 使用授权书
\NewDocumentCommand{\makeDeclareAuthorization}{o}{%
  \ifshmtu@review
  	\relax
  \else
    \pdfbookmark[0]{\shmtu@label@authorization}{authtitle}
    \IfNoValueTF{#1}{%
      \thispagestyle{empty}
      \vskip 16ex
      {\let\clearpage\relax\par\chapter*{\normalfont\zihao{3}\songti\shmtu@label@authtitle}}
      \begingroup
        \zihao{4}
        \shmtu@label@authbody
        %\vskip 1ex
        %\shmtu@authconf
        \vskip 10ex
        \noindent
        \shmtu@signbox{导师}
      \endgroup
    }
    {\includepdf[pagecommand={\thispagestyle{empty}}]{#1}}
  \fi
}

% 主要符号对照表
\NewDocumentEnvironment{nomenclature}{m}{%
  \cleardoublepage
  \pdfbookmark[0]{\shmtu@label@nomenclature}{nomenclature}
  \chapter*{\shmtu@label@nomenclature}
  \@mkboth{\shmtu@label@nomenclature}%
          {\shmtu@label@nomenclature}%
  \begin{longtable}{#1}
}{\end{longtable}}

% 致谢
\newcommand{\shmtu@acknowledgements}[1]{\long\gdef\shmtu@acknowledgements@body{#1}}
\NewDocumentEnvironment{acknowledgements}{}{%
  \Collect@Body\shmtu@acknowledgements
}{%
  \ifshmtu@review
  	\relax
  \else
    \cleardoublepage
    \chapter*{\shmtu@label@acknowledgements}
    \addcontentsline{toc}{chapter}{\shmtu@label@acknowledgements}%
    \@mkboth{\shmtu@label@acknowledgements}%
            {\shmtu@label@acknowledgements}%
    \shmtu@acknowledgements@body
  \fi
}

% 清单样式
\newenvironment{shmtu@bibliolist}[2]{%
  \cleardoublepage
  \chapter{#2}
  \@mkboth{#2}{#2}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr
    {\@latex@warning{Empty `bibliolist' environment}}%
  \endlist
}

% 攻读**学位期间已发表或录用的论文
\newcommand{\shmtu@publications}[1]{\long\gdef\shmtu@publications@body{#1}}
\NewDocumentEnvironment{publications}{O{99}}{%
  \Collect@Body\shmtu@publications
}{%
  \ifshmtu@review
  	\relax
  \else
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@publications}
      \shmtu@publications@body
    \end{shmtu@bibliolist}
  \fi
}
% 攻读**学位期间已发表或录用的论文【盲审】
\newcommand{\shmtu@@publications}[1]{\long\gdef\shmtu@@publications@body{#1}}
\NewDocumentEnvironment{publications*}{O{99}}{%
  \Collect@Body\shmtu@@publications
}{%
  \ifshmtu@review
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@publications}
      \shmtu@@publications@body
    \end{shmtu@bibliolist}
  \fi
}

% 攻读**学位期间参与的项目
\newcommand{\shmtu@projects}[1]{\long\gdef\shmtu@projects@body{#1}}
\NewDocumentEnvironment{projects}{O{99}}{%
  \Collect@Body\shmtu@projects
}{%
  \ifshmtu@review
  	\relax
  \else
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@projects}
      \shmtu@projects@body
    \end{shmtu@bibliolist}
  \fi
}
% 攻读**学位期间参与的项目【盲审】
\newcommand{\shmtu@@projects}[1]{\long\gdef\shmtu@@projects@body{#1}}
\NewDocumentEnvironment{projects*}{O{99}}{%
  \Collect@Body\shmtu@@projects
}{%
  \ifshmtu@review
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@projects}
      \shmtu@@projects@body
    \end{shmtu@bibliolist}
  \fi
}

% 攻读**学位期间申请的专利
\newcommand{\shmtu@patents}[1]{\long\gdef\shmtu@patents@body{#1}}
\NewDocumentEnvironment{patents}{O{99}}{%
  \Collect@Body\shmtu@patents
}{%
  \ifshmtu@review
  	\relax
  \else
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@patents}
      \shmtu@patents@body
    \end{shmtu@bibliolist}
  \fi
}
% 攻读**学位期间申请的专利【盲审】
\newcommand{\shmtu@@patents}[1]{\long\gdef\shmtu@@patents@body{#1}}
\NewDocumentEnvironment{patents*}{O{99}}{%
  \Collect@Body\shmtu@@patents
}{%
  \ifshmtu@review
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@patents}
      \shmtu@@patents@body
    \end{shmtu@bibliolist}
  \fi
}

% 攻读**学位期间申请的获奖情况
\newcommand{\shmtu@awards}[1]{\long\gdef\shmtu@awards@body{#1}}
\NewDocumentEnvironment{awards}{O{99}}{%
  \Collect@Body\shmtu@awards
}{%
  \ifshmtu@review
  	\relax
  \else
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@awards}
      \shmtu@awards@body
    \end{shmtu@bibliolist}
  \fi
}
% 攻读**学位期间申请的获奖情况【盲审】
\newcommand{\shmtu@@awards}[1]{\long\gdef\shmtu@@awards@body{#1}}
\NewDocumentEnvironment{awards*}{O{99}}{%
  \Collect@Body\shmtu@@awards
}{%
  \ifshmtu@review
    \begin{shmtu@bibliolist}{#1}{\shmtu@label@awards}
      \shmtu@@awards@body
    \end{shmtu@bibliolist}
  \fi
}

\AtBeginDocument{
  \ifshmtu@review%
    \shmtuSetInfo{%
      author={***},
      supervisor={***},
      enauthor={***},
      ensupervisor={***},
      studentid={************},
      finisheddate={****年**月},
    }
  \fi
  \hypersetup{%
    pdftitle    = \shmtu@value@title,
    pdfauthor   = \shmtu@value@author,
    pdfsubject  = \shmtu@label@subject,
    pdfkeywords = \shmtu@value@keywords,
    pdfcreator  = {LaTeX with SHMTUThesis \version}
  }%
}

% 加密
\NewDocumentCommand{\encrypt}{m O{***}}{%
  \ifshmtu@review
    {#2}
  \else
    {#1}
  \fi
}

% 自定义下划线
\newcommand{\shmtu@uline}[1]{%
  \begingroup
    \setbox0=\vbox{\strut #1\strut}%
    \dimen0=0pt
    \loop\ifdim\ht0>0pt
      \dimen1=\dimexpr\ht0 - \baselineskip\relax
      \setbox1=\vsplit0 to \ht\strutbox
      \advance\dimen1 by -\ht0
      \noindent\raisebox{-\dimen0}[\ht\strutbox][\dp\strutbox]{\box1}%
      \advance\dimen0 by \dimen1
      \vspace{-0.2ex}\hrule\vskip 0.2ex
    \repeat
  \endgroup
}

% 超链接设置
\hypersetup{
  linktoc            = all,
  bookmarksnumbered  = true,
  bookmarksopen      = true,
  bookmarksopenlevel = 1,
  unicode            = true,
  psdextra           = true,
  breaklinks         = true,
  plainpages         = false,
  hidelinks,
}
\pdfstringdefDisableCommands{%
  \let\\\@empty
  \let\quad\@empty
  \let\hspace\@gobble
}
\urlstyle{same}
\def\UrlBreaks{%
  \do\/%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l%
     \do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L%
     \do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z%
  \do0\do1\do2\do3\do4\do5\do6\do7\do8\do9\do=\do/\do.\do:%
  \do\*\do\-\do\~\do\'\do\"\do\-}
\Urlmuskip=0mu plus 0.1mu

\newcommand{\shmtu@atendpackage}{\csname ctex_at_end_package:nn\endcsname}
\shmtu@atendpackage{unicode-math}{
  \newcommand{\bm}{\symbf}
  \renewcommand{\boldsymbol}{\symbf}
  \newcommand{\square}{\mdlgwhtsquare}
  \@ifpackagelater{hyperref}{2019/04/27}{}{%
    \g@addto@macro\psdmapshortnames{\let\mu\textmugreek}%
  }
}
\shmtu@atendpackage{threeparttable}{
  \appto\TPTnoteSettings{\footnotesize}
}
\shmtu@atendpackage{siunitx}{
  \sisetup{
    detect-all,
    group-minimum-digits = 4,
    separate-uncertainty = true,
    inter-unit-product   = \ensuremath{{}\cdot{}},
  }
  \ifshmtu@language@chinese
    \sisetup{
      list-final-separator = { 和 },
      list-pair-separator  = { 和 },
      range-phrase         = {～},
    }
  \fi
}

% 数学定理设置
\PassOptionsToPackage{amsmath, thmmarks, hyperref}{ntheorem}
\shmtu@atendpackage{ntheorem}{
  \ifshmtu@language@chinese
    \def\shmtu@label@assertion{断言}
    \def\shmtu@label@assumption{假设}
    \def\shmtu@label@axiom{公理}
    \def\shmtu@label@corollary{推论}
    \def\shmtu@label@definition{定义}
    \def\shmtu@label@example{例}
    \def\shmtu@label@lemma{引理}
    \def\shmtu@label@proof{证明}
    \def\shmtu@label@proposition{命题}
    \def\shmtu@label@remark{注}
    \def\shmtu@label@theorem{定理}
  \else
    \def\shmtu@label@assertion{Assertion}
    \def\shmtu@label@assumption{Assumption}
    \def\shmtu@label@axiom{Axiom}
    \def\shmtu@label@corollary{Corollary}
    \def\shmtu@label@definition{Definition}
    \def\shmtu@label@example{Example}
    \def\shmtu@label@lemma{Lemma}
    \def\shmtu@label@proof{Proof}
    \def\shmtu@label@proposition{Proposition}
    \def\shmtu@label@remark{Remark}
    \def\shmtu@label@theorem{Theorem}
  \fi
  \theoremheaderfont{\bfseries\heiti}
  \theorembodyfont{\normalfont}
  \theoremseparator{\enskip}
  \theoremsymbol{\ensuremath{\square}}
  \newtheorem*{proof}{\shmtu@label@proof}
  \theoremstyle{plain}
  \theoremsymbol{}
  \newtheorem{theorem}             {\shmtu@label@theorem}    [chapter]
  \newtheorem{assertion}  [theorem]{\shmtu@label@assertion}
  \newtheorem{axiom}      [theorem]{\shmtu@label@axiom}
  \newtheorem{corollary}  [theorem]{\shmtu@label@corollary}
  \newtheorem{lemma}      [theorem]{\shmtu@label@lemma}
  \newtheorem{proposition}[theorem]{\shmtu@label@proposition}
  \newtheorem{assumption}          {\shmtu@label@assumption} [chapter]
  \newtheorem{definition}          {\shmtu@label@definition} [chapter]
  \newtheorem{example}             {\shmtu@label@example}    [chapter]
  \newtheorem*{remark}             {\shmtu@label@remark}
}
\shmtu@atendpackage{amsthm}{
  \ifshmtu@language@chinese
    \def\shmtu@label@assertion{断言}
    \def\shmtu@label@assumption{假设}
    \def\shmtu@label@axiom{公理}
    \def\shmtu@label@corollary{推论}
    \def\shmtu@label@definition{定义}
    \def\shmtu@label@example{例}
    \def\shmtu@label@lemma{引理}
    \def\shmtu@label@proof{证明}
    \def\shmtu@label@proposition{命题}
    \def\shmtu@label@remark{注}
    \def\shmtu@label@theorem{定理}
  \else
    \def\shmtu@label@assertion{Assertion}
    \def\shmtu@label@assumption{Assumption}
    \def\shmtu@label@axiom{Axiom}
    \def\shmtu@label@corollary{Corollary}
    \def\shmtu@label@definition{Definition}
    \def\shmtu@label@example{Example}
    \def\shmtu@label@lemma{Lemma}
    \def\shmtu@label@proof{Proof}
    \def\shmtu@label@proposition{Proposition}
    \def\shmtu@label@remark{Remark}
    \def\shmtu@label@theorem{Theorem}
  \fi
  \newtheoremstyle{shmtuplain}
    {}{}
    {\normalfont}{}
    {\bfseries\heiti}{}
    {\ccwd}{}
  \theoremstyle{shmtuplain}
  \newtheorem{theorem}             {\shmtu@label@theorem}    [chapter]
  \newtheorem{assertion}  [theorem]{\shmtu@label@assertion}
  \newtheorem{axiom}      [theorem]{\shmtu@label@axiom}
  \newtheorem{corollary}  [theorem]{\shmtu@label@corollary}
  \newtheorem{lemma}      [theorem]{\shmtu@label@lemma}
  \newtheorem{proposition}[theorem]{\shmtu@label@proposition}
  \newtheorem{assumption}          {\shmtu@label@assumption} [chapter]
  \newtheorem{definition}          {\shmtu@label@definition} [chapter]
  \newtheorem{example}             {\shmtu@label@example}    [chapter]
  \newtheorem*{remark}             {\shmtu@label@remark}
  \renewcommand\proofname\shmtu@label@proof
  \renewenvironment{proof}[1][\proofname]{\par
    \pushQED{\qed}%
    \normalfont \topsep6\p@\@plus6\p@\relax
    \trivlist
    \item\relax
      {\bfseries\heiti #1~}
      \hspace\labelsep\ignorespaces
  }{%
    \popQED\endtrivlist\@endpefalse
  }
}

% 算法设置
\PassOptionsToPackage{algochapter}{algorithm2e}
\shmtu@atendpackage{algorithm2e}{
  \SetAlgorithmName{\shmtu@label@algorithm}%
                   {\shmtu@label@algorithm}%
                   {\shmtu@label@listalgorithm}
  \SetAlgoCaptionSeparator{~}
  \newcommand{\cftalgpresnum}{\shmtu@label@algorithm~}
  \AtEndPreamble{%
    \newlength{\cftalgindent}
      \setlength{\cftalgindent}{1.5em}
    \newlength{\cftalgnumwidth}
      \setlength{\cftalgnumwidth}{2.3em}
    \newlength{\shmtu@cftalgnumwidth@tmp}
      \settowidth{\shmtu@cftalgnumwidth@tmp}{\cftalgpresnum}
    \addtolength{\cftalgnumwidth}{\shmtu@cftalgnumwidth@tmp}
  }
  \renewcommand*{\l@algocf}{%
    \let\@cftbsnum \cftalgpresnum
    \@dottedtocline{1}{\cftalgindent}{\cftalgnumwidth}
  }
  \renewcommand{\listofalgorithms}{%
    \cleardoublepage%
    \makeatletter
		\renewcommand{\@dotsep}{\cftdotsep}
	\makeatother
    \chapter*{\listalgorithmcfname}%
    \addcontentsline{toc}{chapter}{\listalgorithmcfname}
    \@mkboth{\listalgorithmcfname}{\listalgorithmcfname}%
    \@starttoc{loa}
  }
  \AtBeginDocument{%
   \renewcommand{\thealgocf}{\thechapter--\@arabic\c@algocf}
  }
}
\shmtu@atendpackage{algorithm}{
  \RequirePackage{algorithmicx, algpseudocode}
  \floatname{algorithm}{\shmtu@label@algorithm}
  \@addtoreset{algorithm}{chapter}
  \patchcmd\@chapter%
    {\if@twocolumn}
    {\addtocontents{loa}{\protect\addvspace{10\p@}}%
      \if@twocolumn}
    {}{}
  \renewcommand{\listalgorithmname}{\shmtu@label@listalgorithm}
  \newcommand{\cftalgpresnum}{\shmtu@label@algorithm~}
  \AtEndPreamble{%
    \newlength{\cftalgindent}
      \setlength{\cftalgindent}{1.5em}
    \newlength{\cftalgnumwidth}
      \setlength{\cftalgnumwidth}{2.3em}
    \newlength{\shmtu@cftalgnumwidth@tmp}
      \settowidth{\shmtu@cftalgnumwidth@tmp}{\cftalgpresnum}
    \addtolength{\cftalgnumwidth}{\shmtu@cftalgnumwidth@tmp}
  }
  \newcommand*{\l@algorithm}{%
    \let\@cftbsnum \cftalgpresnum
    \@dottedtocline{1}{\cftalgindent}{\cftalgnumwidth}
  }
  \renewcommand{\listofalgorithms}{%
    \cleardoublepage%
    \makeatletter
	\renewcommand{\@dotsep}{\cftdotsep}
	\makeatother
    \chapter*{\listalgorithmname}%
    \addcontentsline{toc}{chapter}{\listalgorithmname}
    \@mkboth{\listalgorithmname}{\listalgorithmname}%
    \@starttoc{loa}
  }
  \AtBeginDocument{%
    \renewcommand{\thealgorithm}{\thechapter--\arabic{algorithm}}
  }
}

% 代码样式设置
\shmtu@atendpackage{listings}{
  \lstdefinestyle{lstStyleCode}{
    aboveskip=\medskipamount,
    belowskip=\medskipamount,
    basicstyle=\linespread{1.25}\footnotesize\ttfamily,
    commentstyle=\slshape\color{black!60},
    stringstyle=\color{green!40!black!100},
    keywordstyle=\bfseries\color{orange!80!black},
    identifierstyle=,
    extendedchars=false,
    upquote=true,
    tabsize=2,
    showstringspaces=false,
    xleftmargin=1em,
    xrightmargin=1em,
    breaklines=true,
    breakindent=2em,
    framexleftmargin=1em,
    framexrightmargin=1em,
    backgroundcolor=\color{gray!10},
    columns=flexible,
    keepspaces=true,
    texcl=true,
    mathescape=true
  }
  \lstnewenvironment{codeblock}[1][]
    {\lstset{style=lstStyleCode, #1}}{}
}

% tikz 画图设置
\shmtu@atendpackage{tikz}{
  \usetikzlibrary{shapes.geometric, arrows}
  \tikzstyle{startstop} = [
    rectangle,
    rounded corners,
    minimum width=2cm,
    minimum height=1cm,
    text centered,
    draw=black
  ]
  \tikzstyle{io} = [
    trapezium,
    trapezium left angle=75,
    trapezium right angle=105,
    minimum width=1cm,
    minimum height=1cm,
    text centered,
    draw=black
  ]
  \tikzstyle{process} = [
    rectangle,
    minimum width=2cm,
    minimum height=1cm,
    text centered,
    draw=black
  ]
  \tikzstyle{decision} = [
    diamond,
    minimum width=2cm,
    minimum height=1cm,
    text centered,
    draw=black]
  \tikzstyle{arrow} = [thick, ->, >=stealth]
}
