#import "@preview/showybox:2.0.4": showybox

#import "@preview/tablex:0.0.9": colspanx, rowspanx, tablex
#let document-title = "Memora"
#let submission-details = [
  A Project report submitted in partial fulfillment of the requirements for the award of degree in
  *BACHELOR OF TECHNOLOGY* \
  *(COMPUTER SCIENCE AND ENGINEERING)*

  *SUBMITTED BY* \
  #table(
    columns: (auto, auto),
    align: left,
    [Registration number], [Name of the Student],
    [A22126510134], [Bheesetti Harsith Veera Charan],
    [A22126510144], [D. Chaitanya],
    [A22126510163], [M. Sai Teja],
    [A22126510193], [Venkata Vishaal Tirupalli],
    [A22126510194], [Wuna Akhilesh],
  )

  *UNDER THE GUIDANCE OF* \
  Dr. D. Naga Teja \
  Associate professor

  #box(width: 2.4in, height: 2.4in)[
    #image("./anits_logo.png", width: 2.4in, height: 2.4in)
  ]

  *DEPARTMENT OF COMPUTER SCIENCE AND ENGINEERING* \
  *ANIL NEERUKONDA INSTITUTE OF TECHNOLOGY AND SCIENCES (A+)* \
  SANGIVALASA, VISAKHAPATNAM – 531162 \
  July - 2025
]

#set document(title: document-title)
#set page(
  margin: (x: 1in, y: 1in),
  numbering: "i",
)

#set text(font: "Times New Roman", size: 12pt)
#set heading(numbering: "1.")
#set par(justify: true, leading: 1em)

#align(center)[
  #text(size: 16pt, weight: "bold")[#document-title]
  #v(1em)
  #submission-details
]

#pagebreak()

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2cm),
  numbering: "1",
)

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "en",
)

#set heading(numbering: "1.1")

#set par(
  justify: true,
  leading: 0.65em,
)

#show heading.where(level: 1): it => [
  #pagebreak(weak: true)
  #v(1em)
  #block(fill: rgb("#1f2937"), inset: 1em, radius: 0.5em, text(fill: white, weight: "bold", size: 1.2em)[#it])
  #v(1em)
]

#show heading.where(level: 2): it => [
  #v(0.8em)
  #text(fill: rgb("#374151"), weight: "bold", size: 1.1em)[#it]
  #v(0.5em)
]

#show heading.where(level: 3): it => [
  #v(0.6em)
  #text(fill: rgb("#4b5563"), weight: "bold")[#it]
  #v(0.3em)
]

#show raw.where(block: true): it => block(fill: rgb("#f3f4f6"), inset: 1em, radius: 0.3em, width: 100%, text(
  font: "JetBrainsMono NF",
  size: 9pt,
)[#it])

#show raw.where(block: false): it => box(fill: rgb("#e5e7eb"), inset: (x: 0.3em, y: 0.1em), radius: 0.2em, text(
  font: "JetBrainsMono NF",
  size: 9pt,
)[#it])

#align(center)[
  #v(2cm)
  #text(text(document-title), size: 2.5em, weight: "bold")

  #v(1cm)
  #text(size: 1.5em, style: "italic")[
    For Spaced Repition Learning based on Ebinghuas Forgetting curve
  ]

  #v(2cm)
  #text(size: 1.2em)[
    Technical Documentation and Report
  ]

  #v(1cm)
  #text(size: 1em)[
    Version 1.0 • #datetime.today().display()
  ]

  #v(2cm)
  #text(size: 1em)[
    Learning Smarter • Retaining Longer • Performing Better
  ]
  #v(1em)
  #text(size: 1em)[
    Powered by Smart Repetition
  ]
]

#pagebreak()

#outline(depth: 2, indent: auto)

#pagebreak()

#heading(level: 1)[Introduction]
<todo></todo>

#heading(level: 2)[Motivation and Context]
<todo></todo>

#heading(level: 2)[Problem Statement]
<todo></todo>

#heading(level: 2)[Objectives]

The main objectives of this project are:
<todo></todo>

#pagebreak()

#heading(level: 1)[Literature Review]

<todo></todo>

#pagebreak()

#heading(level: 1)[System Design]

#heading(level: 2)[System Architecture]

<todo></todo>
// #image("./arch.svg")

#let Modules() = {
  box(width: 100%)[

    #align(center)[

      #text(16pt, weight: "bold")[Modules Division]
    ]
    #grid(
      columns: (1fr, 1fr, 1fr),
      rows: (auto, auto, auto),
      gutter: 10pt,
      align: center,
      // <todo></todo> - replace the comment too
    )
  ]
}
#Modules()

#heading(level: 2)[Class Diagram]
// #image("./class.svg", height: 460pt, width: auto, fit: "contain")

#heading(level: 2)[Data Flow]

// #image("./dfd.svg")

#heading(level: 2)[Use-Case Diagram]

The following use-case diagram illustrates the main interactions between a user (e.g., a researcher) and the forecasting system.

// #image("./use_case.svg", width: 100%, height: 630pt)

#heading(level: 1)[Methodology]

#let Methodology() = {
  box(width: 100%)[
    #align(center)[
      #text(16pt, weight: "bold")[Methodology]
    ]
    #grid(
      columns: (1fr, auto, 1fr),
      rows: (auto, auto, auto, auto),
      gutter: 10pt,
      align: center,
      // <todo></todo> - replace the comment too
    )
  ]
}
#Methodology()

<todo>Further explanation of the methodology steps illustrated above.</todo>

#pagebreak()

#heading(level: 1)[Implementation]

#heading(level: 2)[Project Structure]

The project is organized into the following directory structure:
```
<todo></todo>
```

#heading(level: 2)[Key Components]

The key components of the implementation are:
/<todo></todo>

// #image("./components.svg", width: 80%, height: 200pt)

The implementation uses several external libraries, including:
<todo></todo>

#pagebreak()

#pagebreak()

#heading(level: 1)[References]

- Amazon mechanical turk. https://www.mturk.com, 2005.
- Duolingo. https://www.duolingo.com, 2011.
- Spaced repetition. http://www.gwern.net/Spaced%20repetition, 2016.
- N. J. Cepeda, H. Pashler, E. Vul, J. T. Wixted, and
  D. Rohrer. Distributed practice in verbal recall tasks:
  A review and quantitative synthesis. Psychological
  bulletin, 132(3):354, 2006.

#pagebreak()


