// ============================================================
//  FINAL YEAR PROJECT REPORT — TYPST TEMPLATE
//  Based on: Indian Engineering College (Tier 3) FYP Format
//  Derived from: ANITS B.Tech CSE Report Structure (March 2026)
//
//  HOW TO USE THIS TEMPLATE
//  ─────────────────────────
//  1. Fill every placeholder marked with  <<<  >>>
//  2. Replace section body text under each heading
//  3. Add your figures with #figure(image(...), caption: [...])
//  4. Add your tables with #figure(table(...), caption: [...])
//  5. Compile with: typst compile fyp_report_template.typ
//
//  AGENT INSTRUCTIONS
//  ──────────────────
//  When building this out from project context:
//  - Replace all <<< PLACEHOLDER >>> tokens with real content
//  - Keep all #pagebreak() calls intact
//  - Do NOT change page margins, fonts, or heading styles
//  - Preserve the front-matter page order exactly
// ============================================================


// ─────────────────────────────────────────
//  GLOBAL PAGE SETTINGS
// ─────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3.5cm, right: 2.5cm),
  numbering: "1",
  number-align: center,
)

#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "en",
)

#set par(
  justify: true,
  leading: 1.5em,
)

#set heading(numbering: "1.1")

// Suppress page numbers on front matter pages
// (handled per-page via #counter(page).update)


// ─────────────────────────────────────────
//  UTILITY FUNCTIONS
// ─────────────────────────────────────────

// Bold, centred block — used for title page labels
#let centred-bold(content) = align(center, strong(content))

// Section label in ALL CAPS for chapter titles
#let chapter-title(num, title) = [
  #align(center)[
    #text(size: 14pt, weight: "bold")[CHAPTER #num] \
    #text(size: 13pt, weight: "bold")[#title]
  ]
  #v(1em)
]

// Horizontal rule
#let hrule = line(length: 100%, stroke: 0.5pt)


// ═══════════════════════════════════════════════════════════
//  PAGE 1 — TITLE PAGE
// ═══════════════════════════════════════════════════════════
#set page(numbering: none)
#counter(page).update(0)

#align(center)[
  #v(0.5cm)
  #text(size: 16pt, weight: "bold")[
    <<< PROJECT TITLE IN ALL CAPS >>>
  ]

  #v(1cm)
  #text(size: 11pt, style: "italic")[
    A Project report submitted in partial fulfillment of the requirements for \
    the award of the degree of
  ]

  #v(0.8cm)
  #text(size: 13pt, weight: "bold")[BACHELOR OF TECHNOLOGY] \
  #text(size: 12pt, weight: "bold")[IN] \
  #text(size: 13pt, weight: "bold")[<<< BRANCH / SPECIALISATION >>>]

  #v(0.8cm)
  #text(size: 11pt, style: "italic")[Submitted by]

  #v(0.5cm)
  // ── Student table ──────────────────────────────────────
  // Format: Roll Number  Name  (two columns, up to 5 students)
  #grid(
    columns: (auto, auto),
    column-gutter: 2cm,
    row-gutter: 0.4em,
    align: (left, left),
    [<<< ROLL_1 >>>], strong[<<< Student Name 1 >>>],
    [<<< ROLL_2 >>>], strong[<<< Student Name 2 >>>],
    [<<< ROLL_3 >>>], strong[<<< Student Name 3 >>>],
    [<<< ROLL_4 >>>], strong[<<< Student Name 4 >>>],
    [<<< ROLL_5 >>>], strong[<<< Student Name 5 >>>],
  )

  #v(0.8cm)
  #text(size: 11pt, style: "italic")[Under the guidance of]

  #v(0.4cm)
  #text(size: 12pt, weight: "bold")[<<< Guide Name >>>] \
  #text(size: 11pt)[<<< Designation >>>]

  #v(1cm)
  // ── College logo ────────────────────────────────────────
  // Replace the path below with your college logo file
  // #image("logo.png", width: 3cm)

  #v(0.5cm)
  #text(size: 13pt, weight: "bold")[DEPARTMENT OF <<< DEPARTMENT NAME >>>]

  #text(size: 12pt, weight: "bold")[<<< COLLEGE FULL NAME (ALL CAPS) >>>] \
  #text(size: 11pt, style: "italic")[(<<< AUTONOMOUS STATUS, e.g. UGC AUTONOMOUS >>>)] \

  #text(size: 10pt, style: "italic")[
    (<<< Affiliation line, e.g. Permanently Affiliated to XYZ University, Approved by AICTE… >>>)
  ] \
  #text(size: 11pt)[<<< City, District, State >>>]

  #v(0.5cm)
  #text(size: 12pt, weight: "bold")[<<< MONTH – YEAR >>>]
]

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  PAGE 2 — CERTIFICATE
// ═══════════════════════════════════════════════════════════
#align(center)[
  // Repeat college header (standard in Indian FYP reports)
  #text(size: 13pt, weight: "bold")[DEPARTMENT OF <<< DEPARTMENT NAME >>>] \
  #text(size: 12pt, weight: "bold")[<<< COLLEGE FULL NAME >>>] \
  #text(size: 11pt)[(<<< AUTONOMOUS STATUS >>>)] \
  #text(size: 10pt, style: "italic")[(<<< Affiliation line >>>)] \
  #text(size: 11pt)[<<< City, District, State >>>]

  #v(1cm)
  #text(size: 14pt, weight: "bold")[CERTIFICATE]
]

#v(0.8cm)

This is to certify that the project report entitled *"<<< PROJECT TITLE >>>"* submitted by
*<<< Student Name 1 >>> (<<< ROLL_1 >>>)*,
*<<< Student Name 2 >>> (<<< ROLL_2 >>>)*,
*<<< Student Name 3 >>> (<<< ROLL_3 >>>)*,
*<<< Student Name 4 >>> (<<< ROLL_4 >>>)*,
*<<< Student Name 5 >>> (<<< ROLL_5 >>>)*
in partial fulfillment of the requirements for the award of the degree of
*Bachelor of Technology* in *<<< Branch >>>* of *<<< College Name >>>*, <<< City >>>
is a record of bonafide work carried out under my guidance and supervision.

#v(2cm)

#grid(
  columns: (1fr, 1fr),
  align: (left, left),
  column-gutter: 2cm,
  [
    *Project Guide* \
    \
    *<<< Guide Name >>>* \
    <<< Designation >>> \
    Department of <<< Dept >>> \
    <<< College Short Name >>>
  ],
  [
    *Head of the Department* \
    \
    Head of the Department \
    Department of <<< Dept >>> \
    <<< College Short Name >>>
  ],
)

#v(2cm)

Submitted for the Project Viva-Voce Examination held on \_\_\_\_\_\_\_\_\_\_\_\_\_\_

#v(1cm)

#grid(
  columns: (1fr, 1fr),
  align: (left, left),
  [*INTERNAL EXAMINER*],
  [*EXTERNAL EXAMINER*],
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  PAGE 3 — DECLARATION
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[DECLARATION]]

#v(0.8cm)

We, *<<< Student Name 1 >>>*, *<<< Student Name 2 >>>*, *<<< Student Name 3 >>>*,
*<<< Student Name 4 >>>*, *<<< Student Name 5 >>>*,
of final semester B.Tech., in the Department of <<< Department Name >>>
from <<< College Short Name >>>, <<< City >>>,
hereby declare that the project work entitled
*"<<< Project Title >>>"* is carried out by us and submitted in partial fulfillment
of the requirements for the award of Bachelor of Technology in <<< Branch >>>,
under <<< University / College Name >>> during the academic year <<< YYYY–YYYY >>>
and has not been submitted to any other university for the award of any kind of degree.

#v(2cm)

#grid(
  columns: (1fr, 1fr),
  align: (left, left),
  row-gutter: 0.6em,
  [<<< Student Name 1 >>>], [<<< ROLL_1 >>>],
  [<<< Student Name 2 >>>], [<<< ROLL_2 >>>],
  [<<< Student Name 3 >>>], [<<< ROLL_3 >>>],
  [<<< Student Name 4 >>>], [<<< ROLL_4 >>>],
  [<<< Student Name 5 >>>], [<<< ROLL_5 >>>],
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  PAGE 4 — ACKNOWLEDGEMENT
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[ACKNOWLEDGEMENT]]

#v(0.8cm)

We would like to express our deep gratitude to our project guide *<<< Guide Name >>>*,
<<< Designation >>>, Department of <<< Department Name >>>, <<< College Short Name >>>,
for <<< brief description of guide's contribution, e.g. "his/her invaluable guidance and immense encouragement" >>>.
We are grateful to the Head of the Department, Department of <<< Department Name >>>,
for providing us with the required facilities for the completion of the project work.

We are very much thankful to the Principal and Management, <<< College Short Name >>>, <<< City >>>,
for their encouragement and cooperation to carry out this work.

We thank all teaching faculty of the Department of <<< Dept Short >>>,
whose suggestions during reviews helped us in the accomplishment of our project.

We would like to thank our parents, friends, and classmates for their encouragement
throughout our project period.

#v(2cm)

*PROJECT STUDENTS*

#v(0.5cm)

<<< Student Name 1 >>> (<<< ROLL_1 >>>) \
<<< Student Name 2 >>> (<<< ROLL_2 >>>) \
<<< Student Name 3 >>> (<<< ROLL_3 >>>) \
<<< Student Name 4 >>> (<<< ROLL_4 >>>) \
<<< Student Name 5 >>> (<<< ROLL_5 >>>)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  PAGE 5 — ABSTRACT
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[ABSTRACT]]

#v(0.8cm)

// ── AGENT: Write 200–300 words. Cover: problem domain, proposed solution,
//    key methodology, dataset / benchmark used, quantitative results achieved.
//    End with a Keywords line.

<<<
Write a concise abstract of 200–300 words covering:
  1. The real-world problem being addressed and its scale/significance
  2. Limitations of existing approaches that motivate this work
  3. The proposed system / framework name and its core architecture
  4. Key technical components and algorithms used
  5. Dataset or benchmark used for evaluation
  6. Quantitative results (accuracy, precision, recall, F1, etc.)
  7. One sentence on the practical impact / deployment target
>>>

*Keywords:* <<< keyword1 >>>, <<< keyword2 >>>, <<< keyword3 >>>,
<<< keyword4 >>>, <<< keyword5 >>>, <<< keyword6 >>>

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  FRONT MATTER — TABLE OF CONTENTS
//  (Typst auto-generates this from headings)
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[CONTENTS]]

#v(0.5cm)

#outline(
  title: none,
  indent: 1.5em,
  depth: 2,
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  FRONT MATTER — LIST OF SYMBOLS
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[LIST OF SYMBOLS]]

#v(0.8cm)

// Replace with symbols relevant to your project
#table(
  columns: (auto, 1fr),
  stroke: none,
  row-gutter: 0.6em,
  [*Symbol*], [*Description*],
  [<<< Symbol 1 >>>], [<<< Description 1 >>>],
  [<<< Symbol 2 >>>], [<<< Description 2 >>>],
  [<<< Symbol 3 >>>], [<<< Description 3 >>>],
  [<<< Symbol 4 >>>], [<<< Description 4 >>>],
  [<<< Symbol 5 >>>], [<<< Description 5 >>>],
  // Add more rows as needed
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  FRONT MATTER — LIST OF FIGURES
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[LIST OF FIGURES]]

#v(0.8cm)

#outline(
  title: none,
  target: figure.where(kind: image),
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  FRONT MATTER — LIST OF TABLES
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[LIST OF TABLES]]

#v(0.8cm)

#outline(
  title: none,
  target: figure.where(kind: table),
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  FRONT MATTER — LIST OF ABBREVIATIONS
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[LIST OF ABBREVIATIONS]]

#v(0.8cm)

#table(
  columns: (auto, 1fr),
  stroke: none,
  row-gutter: 0.6em,
  [*Abbreviation*], [*Full Form*],
  [AI],  [Artificial Intelligence],
  [API], [Application Programming Interface],
  // ── AGENT: Add all project-specific abbreviations below ──
  [<<< ABBR_1 >>>], [<<< Full Form 1 >>>],
  [<<< ABBR_2 >>>], [<<< Full Form 2 >>>],
  [<<< ABBR_3 >>>], [<<< Full Form 3 >>>],
  [<<< ABBR_4 >>>], [<<< Full Form 4 >>>],
  [<<< ABBR_5 >>>], [<<< Full Form 5 >>>],
)

#pagebreak()


// ─────────────────────────────────────────
//  START MAIN BODY — ENABLE PAGE NUMBERS
// ─────────────────────────────────────────
#set page(numbering: "1")
#counter(page).update(1)


// ═══════════════════════════════════════════════════════════
//  CHAPTER 1 — INTRODUCTION
// ═══════════════════════════════════════════════════════════
= INTRODUCTION

== Background and Motivation

// ── AGENT: 3–4 paragraphs.
//    Para 1: Describe the broad domain (e.g. social media, healthcare, finance).
//    Para 2: Explain the specific problem and its real-world prevalence / statistics.
//    Para 3: Why existing approaches are inadequate.
//    Para 4: What gap this project addresses and why it matters now.

<<<
Background and motivation content (approx. 400–500 words).
Cite 2–3 relevant prior works or statistics inline using (Author, Year) format.
>>>

== Problem Statement

// ── AGENT: 1–2 paragraphs identifying 3 specific, concrete limitations
//    of current systems that this project directly addresses.

<<<
Clearly articulate the problem. Frame it around 3 distinct limitations
of the current state of the art. Each limitation should map to an objective below.
(Approx. 200–300 words)
>>>

== Objectives

// ── AGENT: Numbered list of 5–7 specific, measurable objectives.
//    Each objective should begin with "To ..."

+ To <<< objective 1, e.g. "design and implement a real-time system capable of…" >>>
+ To <<< objective 2 >>>
+ To <<< objective 3 >>>
+ To <<< objective 4 >>>
+ To <<< objective 5 >>>
+ To <<< objective 6 (optional) >>>

== Scope of the Project

// ── AGENT: Define clearly what IS and IS NOT within scope.
//    Mention: platform/domain, data type, language, scale, what future work handles.

<<<
Scope description (approx. 150–200 words).
Be explicit about boundaries: what the system handles, supported inputs/languages,
deployment target, and what is deferred to future work.
>>>

== Organisation of the Report

Chapter 2 presents the Literature Survey, reviewing <<< N >>> key research works and identifying <<< M >>> critical gaps. Chapter 3 covers System Analysis and Design. Chapter 4 details Implementation. Chapter 5 presents Results and Discussion. Chapter 6 concludes with a summary of contributions and directions for future work.

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  CHAPTER 2 — LITERATURE SURVEY
// ═══════════════════════════════════════════════════════════
= LITERATURE SURVEY

// Opening paragraph: describe the research landscape
<<<
One introductory paragraph (100–150 words) describing the primary research area,
the benchmark dataset(s) used in prior work, and the general methodological trend.
>>>

== Review of Related Works

// ── AGENT: Write 8–12 subsections, one per paper reviewed.
//    Each subsection: author(s), year, venue, method, dataset, key result, limitation.
//    Format: === Paper N — Author et al. (Year)

=== Paper 1 — <<< Authors >>> (<<< Year >>>)

<<<
Published in <<< Venue/Journal >>>.
Method: <<< what technique was used >>>.
Dataset: <<< dataset used >>>.
Result: <<< key quantitative result >>>.
Limitation: <<< what this work does NOT do that yours does >>>.
(Approx. 80–120 words)
>>>

=== Paper 2 — <<< Authors >>> (<<< Year >>>)

<<<  Same structure as Paper 1. >>>

=== Paper 3 — <<< Authors >>> (<<< Year >>>)

<<<  Same structure. >>>

=== Paper 4 — <<< Authors >>> (<<< Year >>>)

<<<  Same structure. >>>

=== Paper 5 — <<< Authors >>> (<<< Year >>>)

<<<  Same structure. >>>

=== Paper 6 — <<< Authors >>> (<<< Year >>>)

<<<  Same structure. >>>

=== Paper 7 — <<< Authors >>> (<<< Year >>>)

<<<  Same structure. >>>

=== Paper 8 — <<< Authors >>> (<<< Year >>>)

<<<  Same structure. >>>

// Add more === subsections as needed up to 12

== Research Gaps Identified

// ── AGENT: Identify 4 gaps labelled A–D, each directly tied to your objectives.

*A. <<< Gap Title (e.g. Latency and Scalability) >>>*

<<<
1–2 sentences describing the gap and citing which reviewed papers expose it.
>>>

*B. <<< Gap Title >>>*

<<<  Same. >>>

*C. <<< Gap Title >>>*

<<<  Same. >>>

*D. <<< Gap Title >>>*

<<<  Same. >>>

== Summary of Literature

// ── Comparative table of reviewed works
#figure(
  table(
    columns: (auto, 2fr, auto, 2fr),
    stroke: 0.5pt,
    align: center,
    inset: 6pt,
    [*Author (Year)*], [*Approach*], [*Dataset*], [*Limitation*],
    [<<< Author 1 (Year) >>>], [<<< Approach >>>], [<<< Dataset >>>], [<<< Limitation >>>],
    [<<< Author 2 (Year) >>>], [<<< Approach >>>], [<<< Dataset >>>], [<<< Limitation >>>],
    [<<< Author 3 (Year) >>>], [<<< Approach >>>], [<<< Dataset >>>], [<<< Limitation >>>],
    [<<< Author 4 (Year) >>>], [<<< Approach >>>], [<<< Dataset >>>], [<<< Limitation >>>],
    [*This Project (<<< Year >>>)*], [<<< Your approach >>>], [<<< Your dataset >>>], [<<< Your advancement >>>],
  ),
  caption: [Comparison of Existing Works],
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  CHAPTER 3 — SYSTEM ANALYSIS AND DESIGN
// ═══════════════════════════════════════════════════════════
= SYSTEM ANALYSIS AND DESIGN

== Existing System

// ── AGENT: Describe what current systems do and their concrete limitations.
//    This should directly echo the gaps from Chapter 2 but from a systems perspective.

<<<
Describe the existing approach or tool that is closest to your work.
Enumerate specific limitations: e.g. keyword-only, no real-time, no context window,
high false-positive rate, no moderator interface. (Approx. 200–250 words)
>>>

== Proposed System

// ── AGENT: Bullet list of the key proposed components / innovations.

- <<< Component / innovation 1 >>>
- <<< Component / innovation 2 >>>
- <<< Component / innovation 3 >>>
- <<< Component / innovation 4 >>>
- <<< Component / innovation 5 >>>

// Follow with a short paragraph summarising the overall approach.
<<<
One paragraph (100–150 words) tying the components together into a coherent system narrative.
>>>

== System Architecture

// ── AGENT: Describe the architecture pipeline phase by phase (typically 4–6 phases).
//    Then insert the architecture diagram figure.

<<<
Describe the overall architecture in prose — phases, data flow, decision points,
and enforcement/output path. (Approx. 200–250 words)
>>>

#figure(
  // Replace with actual architecture diagram:
  // image("figures/architecture.png", width: 14cm),
  rect(width: 14cm, height: 8cm, stroke: 1pt)[
    #align(center + horizon)[
      _[ Architecture Diagram Placeholder ]_ \
      Replace with: `image("figures/architecture.png", width: 14cm)`
    ]
  ],
  caption: [<<< System Architecture Diagram Title >>>],
)

== Component Design

=== <<< Component 1 Name (e.g. Main Dashboard / Control Interface) >>>

<<<
Describe this component: its role, UI elements, data it displays,
and how it interfaces with other components. (60–100 words)
>>>

=== <<< Component 2 Name >>>

<<<  Same structure. >>>

=== <<< Component 3 Name (e.g. Enforcement / Action Module) >>>

<<<  Same structure. >>>

== <<< Core Logic Element (e.g. Behavioural State Machine / Decision Model) >>>

// ── AGENT: Describe the domain-specific logic model that drives classification
//    or decision-making in your system. For example: state machines, ontologies,
//    rule engines, ML pipeline steps, etc.

<<<
Describe and enumerate the states/stages/rules your system maps input against.
Ground this in a cited prior theoretical framework where applicable.
(Approx. 150–200 words)

Then insert a diagram if applicable:
>>>

#figure(
  rect(width: 12cm, height: 7cm, stroke: 1pt)[
    #align(center + horizon)[
      _[ Logic / State Diagram Placeholder ]_ \
      Replace with: `image("figures/state_machine.png", width: 12cm)`
    ]
  ],
  caption: [<<< Diagram Title, e.g. "Behavioural State Machine — N Stages" >>>],
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  CHAPTER 4 — IMPLEMENTATION
// ═══════════════════════════════════════════════════════════
= IMPLEMENTATION

== Runtime and Environment

// ── Technology stack table
#figure(
  table(
    columns: (auto, auto, 1fr),
    stroke: 0.5pt,
    align: (left, center, left),
    inset: 6pt,
    [*Component*], [*Version*], [*Purpose*],
    [<<< Tech 1, e.g. Node.js >>>],   [<<< v?.?.? >>>], [<<< Purpose >>>],
    [<<< Tech 2, e.g. React.js >>>],  [<<< v?.?.? >>>], [<<< Purpose >>>],
    [<<< Tech 3, e.g. Python >>>],    [<<< v?.?.? >>>], [<<< Purpose >>>],
    [<<< Tech 4 >>>],                 [<<< v?.?.? >>>], [<<< Purpose >>>],
    [<<< Tech 5 >>>],                 [<<< v?.?.? >>>], [<<< Purpose >>>],
    [<<< Tech 6 >>>],                 [<<< v?.?.? >>>], [<<< Purpose >>>],
    // Add more rows as needed
  ),
  caption: [Technologies, Libraries and Versions Used],
)

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: 0.5pt,
    inset: 6pt,
    [*Hardware Component*], [*Minimum Specification*],
    [Processor], [<<< e.g. Intel Core i5 8th Gen / AMD Ryzen 5 or higher >>>],
    [RAM],       [<<< e.g. 8 GB minimum; 16 GB recommended >>>],
    [Storage],   [<<< e.g. 256 GB SSD >>>],
    [Network],   [<<< e.g. Stable broadband, minimum 10 Mbps >>>],
    [Display],   [<<< e.g. 1920×1080 Full HD >>>],
    [Browser],   [<<< e.g. Chrome v120+ or Firefox v120+ >>>],
  ),
  caption: [Hardware Requirements],
)

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: 0.5pt,
    inset: 6pt,
    [*Software Component*], [*Version / Details*],
    [Operating System], [<<< e.g. Windows 10/11, macOS 12+, Ubuntu 22.04+ >>>],
    [<<< SW 2 >>>],     [<<< version >>>],
    [<<< SW 3 >>>],     [<<< version >>>],
    [<<< SW 4 >>>],     [<<< version >>>],
  ),
  caption: [Software Requirements],
)

== Machine Learning Algorithms

// ── AGENT: Subsection for each major algorithm / model tier in your system.

=== <<< Algorithm / Model 1 (e.g. Primary Classifier / Tier 1 Engine) >>>

<<<
Describe the algorithm: what it does, why it was chosen, how it is configured,
what threshold or hyperparameters are used. (100–150 words)
>>>

=== <<< Algorithm / Model 2 (e.g. Secondary / Deep Analysis Engine) >>>

<<<
Same structure. Describe when it is triggered, what input it receives,
what it outputs. (100–150 words)
>>>

== Frontend Framework

// ── AGENT: Describe the UI library / framework and its role.

<<<
Describe the frontend framework (e.g. React, Vue, Flask templates, Android).
Explain how its component/module architecture maps to the system's interface panels.
Mention any state management or typing system used. (100–150 words)
>>>

== Data Visualisation and Forensic / Output Utilities

// ── AGENT: Libraries used for charts, graphs, exports, reports.

<<<
Describe visualisation libraries and how they represent system outputs
(e.g. risk trajectories, performance charts, confusion matrices).
Mention any export utilities (PDF generation, logging, etc.). (100–150 words)
>>>

== Simulation and Validation Modes

// ── AGENT: Describe how the system is tested — demo/fixed script vs. live/random.

=== <<< Mode 1 Name (e.g. Demo Mode / Deterministic Benchmarking) >>>

<<<
Describe this mode: what input it uses, why it is reproducible,
what it validates. (60–100 words)
>>>

=== <<< Mode 2 Name (e.g. Real Mode / Live Inference) >>>

<<<
Describe this mode: how it differs from Mode 1, what stochastic elements
it introduces, what it confirms. (60–100 words)
>>>

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  CHAPTER 5 — RESULTS AND DISCUSSION
// ═══════════════════════════════════════════════════════════
= RESULTS AND DISCUSSION

== Comparative Scenario Performance

// ── AGENT: One subsection per test scenario (typically 3 scenarios).
//    Scenario 1: Negative control (should NOT be flagged)
//    Scenario 2: Borderline / suspicious case (should warn but not ban)
//    Scenario 3: Critical / positive case (full lifecycle, should trigger enforcement)

=== Scenario 1 — <<< Scenario Name (e.g. Safe / Negative Control) >>>

<<<
Describe the scenario: what input was used, what the system's expected behaviour was,
what actually happened (quantitatively), and what this proves.
(100–150 words — emphasise zero false positives here)
>>>

=== Scenario 2 — <<< Scenario Name (e.g. Suspicious / Borderline) >>>

<<<
Describe the intermediate scenario: when was it flagged, what stage was identified,
what enforcement action (if any) was triggered, and what graduated response means.
(100–150 words)
>>>

=== Scenario 3 — <<< Scenario Name (e.g. Critical / Full Positive Lifecycle) >>>

<<<
Describe the end-to-end critical scenario: trace through key turns, when
the system escalated, what the final enforcement was, and why this validates
the system's core purpose. (100–150 words)
>>>

// Risk trajectory figure
#figure(
  rect(width: 14cm, height: 8cm, stroke: 1pt)[
    #align(center + horizon)[
      _[ Multi-Stream Risk Trajectory Graph Placeholder ]_ \
      Replace with: `image("figures/risk_trajectory.png", width: 14cm)`
    ]
  ],
  caption: [<<< e.g. "Multi-Stream Risk Trajectory: Three Concurrent Sessions" >>>],
)

== Automated Enforcement Outcomes

// ── AGENT: Bullet list mapping each scenario to its enforcement outcome.

- *Scenario 1 (<<< label >>>):* <<< enforcement outcome, e.g. "No action triggered. Zero false positives throughout all N turns." >>>
- *Scenario 2 (<<< label >>>):* <<< e.g. "Warning state activated at Turn X. No ban triggered — correct graduated response." >>>
- *Scenario 3 (<<< label >>>):* <<< e.g. "SYSTEM LOCK triggered at Turn Y with zero manual intervention. Forensic report auto-generated." >>>

== Quantitative Classification Metrics

#figure(
  table(
    columns: (auto, auto, 2fr),
    stroke: 0.5pt,
    align: (left, center, left),
    inset: 6pt,
    [*Metric*],   [*Score*],            [*Significance*],
    [Accuracy],   [<<< e.g. 94.2% >>>], [<<< interpretation >>>],
    [Precision],  [<<< e.g. 91.9% >>>], [<<< interpretation >>>],
    [Recall],     [<<< e.g. 88.7% >>>], [<<< interpretation >>>],
    [F1 Score],   [<<< e.g. 0.90 >>>],  [<<< interpretation >>>],
  ),
  caption: [Quantitative Classification Performance — <<< System Name >>>],
)

// Performance bar chart figure
#figure(
  rect(width: 12cm, height: 7cm, stroke: 1pt)[
    #align(center + horizon)[
      _[ Classification Performance Chart Placeholder ]_ \
      Replace with: `image("figures/performance_chart.png", width: 12cm)`
    ]
  ],
  caption: [<<< e.g. "Quantitative Classification Performance Chart" >>>],
)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  CHAPTER 6 — CONCLUSION AND FUTURE WORK
// ═══════════════════════════════════════════════════════════
= CONCLUSION AND FUTURE WORK

== Conclusion

// ── AGENT: 2–3 paragraphs.
//    Para 1: Restate the problem and how this project addressed it.
//    Para 2: Summarise key results and what they prove.
//    Para 3: Broader impact / why this matters.

<<<
Conclusion (approx. 200–300 words).
Reference quantitative results from Chapter 5.
Tie back to the objectives from Chapter 1.
Do NOT introduce new content here.
>>>

== Future Scope

// ── AGENT: 4–6 named future directions, each as a subsection with 2–3 sentences.

=== <<< Future Direction 1 (e.g. Multimodal Integration) >>>

<<<
Describe what this extension would involve and what problem it addresses.
(2–3 sentences)
>>>

=== <<< Future Direction 2 (e.g. Privacy-Preserving / On-Device Inference) >>>

<<<  Same structure. >>>

=== <<< Future Direction 3 (e.g. Legal-Grade Export / Evidentiary Standards) >>>

<<<  Same structure. >>>

=== <<< Future Direction 4 (e.g. Multilingual / Regional Language Support) >>>

<<<  Same structure. >>>

=== <<< Future Direction 5 (e.g. Platform API Integration / Live Deployment) >>>

<<<  Same structure. >>>

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  APPENDICES
// ═══════════════════════════════════════════════════════════
= APPENDICES <appendices>

== APPENDIX A — SYSTEM REQUIREMENTS

// ── Hardware and software requirements tables (mirrors Chapter 4 but standalone)

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: 0.5pt,
    inset: 6pt,
    [*Hardware Component*], [*Minimum Specification*],
    [Processor],  [<<< spec >>>],
    [RAM],        [<<< spec >>>],
    [Storage],    [<<< spec >>>],
    [Network],    [<<< spec >>>],
    [Display],    [<<< spec >>>],
    [Browser],    [<<< spec >>>],
  ),
  caption: [Hardware Requirements (Appendix)],
)

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: 0.5pt,
    inset: 6pt,
    [*Software Component*], [*Version / Details*],
    [Operating System], [<<< spec >>>],
    [<<< SW 2 >>>],     [<<< spec >>>],
    [<<< SW 3 >>>],     [<<< spec >>>],
  ),
  caption: [Software Requirements (Appendix)],
)

== APPENDIX B — <<< APPENDIX TITLE (e.g. Sample Inputs / Classification Examples) >>>

// ── AGENT: Provide annotated examples of system inputs and outputs.
//    For each example: label, input text/data, system classification, rationale.

*<<< Category/Stage 1 >>>:* "<<< Example input text or data sample >>>"

_Classification rationale:_ <<< Why the system classifies this as it does. >>>

*<<< Category/Stage 2 >>>:* "<<< Example input >>>"

_Classification rationale:_ <<< Rationale. >>>

*<<< Category/Stage 3 >>>:* "<<< Example input >>>"

_Classification rationale:_ <<< Rationale. >>>

// Add more examples as needed up to 6

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  REFERENCES
// ═══════════════════════════════════════════════════════════
= REFERENCES <references>

// ── Format: IEEE style (most common in Indian engineering colleges)
// ── AGENT: Replace each entry with real references from the project.
//    Minimum 10 references. Arrange in citation order [1], [2], …

#set par(hanging-indent: 1.5em)

\[1\] <<< A. Author, B. Author, "Title of Paper," in _Proc. Conference Name_, Year, pp. xxx–xxx. >>>

\[2\] <<< A. Author, B. Author, "Title of Journal Article," _Journal Name_, vol. X, no. Y, pp. xxx–xxx, Year. >>>

\[3\] <<< Reference 3 >>>

\[4\] <<< Reference 4 >>>

\[5\] <<< Reference 5 >>>

\[6\] <<< Reference 6 >>>

\[7\] <<< Reference 7 >>>

\[8\] <<< Reference 8 >>>

\[9\] <<< Reference 9 >>>

\[10\] <<< Reference 10 >>>

// Add more as needed. The source paper from the uploaded document
// had 11 references; aim for at least that many.

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  BACK MATTER — BASE PAPER STUB
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[BASE PAPER]]

#v(1cm)

(Attach a printed copy of the full base paper immediately after this page.)

#pagebreak()


// ═══════════════════════════════════════════════════════════
//  BACK MATTER — PUBLISHED PAPER / ACCEPTANCE LETTER STUB
// ═══════════════════════════════════════════════════════════
#align(center)[#text(size: 14pt, weight: "bold")[PUBLISHED PAPER / ACCEPTANCE LETTER]]

#v(1cm)

(Attach the relevant document — published paper, acceptance letter,
or submission confirmation — immediately after this page.)
