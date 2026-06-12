// limina.typ
// Template for Limina: Journal of Consciousness and Anomalous Phenomena
// Society for UAP Studies (SUAPS) · Chicago author-date citations

// ── Colour palette (matches SUAPS brand) ────────────────────────────
#let amber     = rgb("#C4892A")
#let charcoal  = rgb("#1E1A16")
#let teal      = rgb("#3A7A72")
#let mid-gray  = rgb("#6B6560")
#let rule-gray = rgb("#D4CFC9")

// ── Font names ───────────────────────────────────────────────────────
#let serif-font = "EB Garamond 12"
#let sans-font  = "Inter"

// ─────────────────────────────────────────────────────────────────────
// limina-article: main template function
//
// authors: array of dictionaries with keys:
//   name        (required)  full name
//   mark        (optional)  superscript affiliation marker, e.g. "1"
//   affiliation (optional)  institution string
//   email       (optional)  contact email (first match becomes correspondence)
// ─────────────────────────────────────────────────────────────────────
#let limina-article(
  title:       [],
  short-title: none,
  authors:     (),
  abstract:    [],
  keywords:    (),
  volume:      1,
  issue:       1,
  year:        2026,
  page-start:  none,
  doi:         none,
  received:    none,
  accepted:    none,
  body,
) = {

  let run-title = if short-title != none { short-title } else { title }

  // ── Document metadata ────────────────────────────────────────────
  set document(
    title:  title,
    author: authors.map(a => a.name).join(", "),
  )

  // ── Page layout ──────────────────────────────────────────────────
  set page(
    paper:  "a4",
    margin: (top: 24mm, bottom: 28mm, left: 35mm, right: 25mm),

    header: context {
      let pg = counter(page).get().first()
      if pg <= 1 { return [] }
      set text(font: sans-font, size: 8.5pt, fill: mid-gray)
      set par(justify: false, first-line-indent: 0pt, spacing: 0pt)
      if calc.odd(pg) {
        grid(
          columns: (1fr, auto),
          align(left)[*LIMINA* #h(4pt) #sym.bar.v #h(4pt) Vol. #volume, No. #issue (#year)],
          align(right)[#pg],
        )
      } else {
        grid(
          columns: (auto, 1fr),
          align(left)[#pg],
          align(right)[#run-title],
        )
      }
      v(3pt)
      line(length: 100%, stroke: 0.4pt + rule-gray)
    },

    footer: context {
      let pg = counter(page).get().first()
      if pg != 1 { return [] }
      line(length: 100%, stroke: 0.4pt + rule-gray)
      v(3pt)
      set text(font: sans-font, size: 8pt, fill: mid-gray)
      set par(justify: false, first-line-indent: 0pt, spacing: 0pt)
      let doi-text = if doi != none [
        DOI: #link("https://doi.org/" + doi)[#doi]
      ] else []
      grid(
        columns: (1fr, auto),
        align(left, doi-text),
        align(right)[© #year The Author(s). Published by SUAPS.],
      )
    },
  )

  // ── Base typography ──────────────────────────────────────────────
  set text(
    font:     serif-font,
    size:     11.5pt,
    fill:     charcoal,
    hyphenate: true,
    lang:     "en",
  )

  set par(
    justify:           true,
    leading:           0.5em,
    spacing:           0.5em,
    first-line-indent: 1.5em,
  )

  // ── Heading styles ────────────────────────────────────────────────
  show heading.where(level: 1): it => {
    v(1.6em, weak: true)
    block(below: 0.65em)[
      #set text(font: sans-font, size: 10pt, weight: "semibold", fill: charcoal)
      #set par(justify: false, first-line-indent: 0pt, spacing: 0pt)
      #it.body
    ]
  }

  show heading.where(level: 2): it => {
    v(1.1em, weak: true)
    block(below: 0.55em)[
      #set text(font: sans-font, size: 10pt, weight: "regular", style: "italic", fill: charcoal)
      #set par(justify: false, first-line-indent: 0pt, spacing: 0pt)
      #it.body
    ]
  }

  show heading.where(level: 3): it => {
    v(0.9em, weak: true)
    block(below: 0.4em)[
      #set text(font: serif-font, size: 11.5pt, style: "italic", fill: charcoal)
      #set par(justify: false, first-line-indent: 0pt, spacing: 0pt)
      #it.body
    ]
  }

  // ── Links ────────────────────────────────────────────────────────
  show link: it => {
    set text(fill: teal)
    it
  }

  // ── Block quotations ─────────────────────────────────────────────
  show quote.where(block: true): it => {
    set par(first-line-indent: 0pt)
    block(
      inset: (left: 2em, right: 2em),
      below: 0.8em,
      above: 0.8em,
    )[
      #set text(size: 10.5pt)
      #it.body
    ]
  }

  // ── Figure captions ──────────────────────────────────────────────
  show figure.caption: it => {
    set text(font: sans-font, size: 9pt, fill: mid-gray)
    set par(justify: true, first-line-indent: 0pt)
    it
  }

  // ── Tables ───────────────────────────────────────────────────────
  set table(
    stroke: (_, y) => (
      top:    if y == 0  { 1pt  + charcoal } else if y == 1 { 0.5pt + charcoal } else { none },
      bottom: if y == 0  { 0.5pt + charcoal } else { none },
    ),
    inset: (x: 8pt, y: 5pt),
  )
  show table.header: set text(font: sans-font, size: 9.5pt, weight: "semibold")
  show table:        set text(font: sans-font, size: 9.5pt)

  // ── Footnotes ────────────────────────────────────────────────────
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.4pt + rule-gray),
    indent:    0.5em,
    gap:       0.4em,
  )
  show footnote.entry: set text(size: 9.5pt)

  // ── Bibliography ────────────────────────────────────────────────
  show bibliography: it => {
    set text(size: 10pt)
    set par(justify: false, first-line-indent: 0pt, hanging-indent: 1.5em, spacing: 0.6em)
    it
  }

  // ════════════════════════════════════════════════════════════════
  // PAGE 1 FRONT MATTER
  // ════════════════════════════════════════════════════════════════

  // Masthead amber rule
  block(width: 100%, height: 3pt, fill: amber)
  v(8pt)

  // Journal header row
  grid(
    columns: (1fr, auto),
    align(horizon)[
      #set par(justify: false, first-line-indent: 0pt, spacing: 0.25em)
      #text(font: sans-font, size: 19pt, weight: "bold", fill: amber)[LIMINA]
      #v(2pt)
      #text(font: sans-font, size: 8.5pt, fill: mid-gray)[
        Journal of Consciousness and Anomalous Phenomena \
        Society for UAP Studies (SUAPS)
      ]
    ],
    align(horizon + right)[
      #set text(font: sans-font, size: 9pt, fill: mid-gray)
      #set par(justify: false, first-line-indent: 0pt, spacing: 0.2em)
      Vol. #volume, No. #issue (#year)
      #if page-start != none [ \ p. #page-start ]
    ],
  )

  v(8pt)
  line(length: 100%, stroke: 0.5pt + rule-gray)
  v(22pt)

  // Article title
  {
    set text(font: serif-font, size: 22pt, weight: "regular")
    set par(justify: false, leading: 0.75em, spacing: 0pt, first-line-indent: 0pt)
    title
  }

  v(14pt)

  // Author names
  {
    set text(font: sans-font, size: 10.5pt, fill: charcoal)
    set par(justify: false, first-line-indent: 0pt, spacing: 0.2em)
    let names = authors.enumerate().map(((i, a)) => {
      if "mark" in a {
        [#a.name#super(text(font: sans-font, size: 7pt)[#a.mark])]
      } else {
        a.name
      }
    })
    names.join([,#h(4pt)])
  }

  v(7pt)

  // Affiliations
  {
    set text(font: sans-font, size: 8.5pt, fill: mid-gray, style: "italic")
    set par(justify: false, first-line-indent: 0pt, spacing: 0.2em)
    for a in authors {
      if "affiliation" in a {
        if "mark" in a [ #super(text(font: sans-font, size: 7pt)[#a.mark]) ]
        [#a.affiliation \ ]
      }
    }
  }

  // Correspondence + dates
  {
    set text(font: sans-font, size: 8.5pt, fill: mid-gray)
    set par(justify: false, first-line-indent: 0pt, spacing: 0.25em)
    let corresp = authors.filter(a => "email" in a)
    if corresp.len() > 0 {
      v(3pt)
      [Correspondence: #link("mailto:" + corresp.first().email)[#corresp.first().email]]
    }
    if received != none or accepted != none {
      v(3pt)
      let parts = ()
      if received != none { parts.push([Received: #received]) }
      if accepted != none { parts.push([Accepted: #accepted]) }
      parts.join([#h(8pt) · #h(8pt)])
    }
  }

  v(20pt)

  // Abstract block
  line(length: 100%, stroke: 0.6pt + amber)
  v(10pt)

  {
    set par(justify: false, first-line-indent: 0pt, spacing: 0.3em)
    text(font: sans-font, size: 8.5pt, weight: "semibold", fill: amber)[ABSTRACT]
  }

  v(5pt)

  {
    set text(font: serif-font, size: 10.5pt, fill: charcoal)
    set par(justify: true, leading: 0.5em, spacing: 0.5em, first-line-indent: 0pt)
    abstract
  }

  if keywords.len() > 0 {
    v(9pt)
    set par(justify: false, first-line-indent: 0pt)
    [
      #text(font: sans-font, size: 8.5pt, weight: "semibold", fill: amber)[KEYWORDS]
      #h(6pt)
      #text(font: serif-font, size: 10.5pt, style: "italic", fill: mid-gray)[#keywords.join(" · ")]
    ]
  }

  v(8pt)
  line(length: 100%, stroke: 0.6pt + amber)
  v(26pt)

  // ── Article body ─────────────────────────────────────────────────
  body
}
