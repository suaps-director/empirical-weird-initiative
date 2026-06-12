// limina.typ — Limina: The Journal of UAP Studies
// Two-column A4 layout matching the published journal PDF format.
// ISSN 2995-0384 (online) · 2995-0376 (print)
// Chicago author-date citations

#let charcoal  = rgb("#1E1A16")
#let mid-gray  = rgb("#6B6560")
#let rule-gray = rgb("#C0BBB5")
#let amber     = rgb("#C4892A")
#let link-blue = rgb("#1155CC")

// ─────────────────────────────────────────────────────────────────
// limina-article — main template function
//
// authors: array of dicts; recognised keys:
//   name        (required)  display name
//   suffix      (optional)  credentials appended after name ("Ph.D.")
//   affiliation (optional)  institution line (italic)
//   email       (optional)  first match becomes correspondence address
//   orcid       (optional)  ORCID ID string (no URL prefix)
// ─────────────────────────────────────────────────────────────────
#let limina-article(
  title:      [],
  authors:    (),
  abstract:   [],
  keywords:   (),
  volume:     1,
  issue:      1,
  year:       2024,
  pages:      none,     // page range string, e.g. "40-54"
  doi:        none,
  received:   none,
  revised:    none,     // "received in revised form" date
  accepted:   none,
  online:     none,     // "available online" date
  page-start: 1,        // first page number of this article
  body,
) = {

  // Running header citation string
  let pages-str = if pages != none { " " + pages } else { "" }
  let vol-str = str(volume) + "(" + str(issue) + ") (" + str(year) + ")" + pages-str

  // ── Document metadata ─────────────────────────────────────────
  set document(title: title)
  counter(page).update(page-start)

  // ── Page geometry and running header ─────────────────────────
  set page(
    paper: "a4",
    margin: (top: 19mm, bottom: 20mm, left: 18mm, right: 18mm),
    header: {
      set par(first-line-indent: 0pt, spacing: 0pt, justify: false, leading: 0pt)
      v(-4pt)
      grid(
        columns: (1fr, auto),
        align(horizon + left)[
          #set text(font: "EB Garamond 12", size: 8.5pt, style: "italic")
          Limina \u{2014} The Journal of UAP Studies #vol-str
        ],
        align(horizon + right)[
          #set text(font: "EB Garamond 12", size: 8.5pt, style: "normal")
          #context counter(page).display()
        ],
      )
      v(2pt)
      line(length: 100%, stroke: 0.4pt + rule-gray)
    },
    footer: none,
  )

  // ── Base typography ───────────────────────────────────────────
  set text(font: "EB Garamond 12", size: 10pt, fill: charcoal,
           hyphenate: true, lang: "en")
  set par(justify: true, leading: 0.5em, spacing: 0.5em,
          first-line-indent: 1.2em)

  // ── Heading styles (numbered bold, same font as body) ─────────
  show heading.where(level: 1): it => {
    v(1.1em, weak: true)
    block(below: 0.55em)[
      #set text(size: 10pt, weight: "bold")
      #set par(first-line-indent: 0pt, spacing: 0pt, justify: false)
      #it.body
    ]
  }

  show heading.where(level: 2): it => {
    v(0.8em, weak: true)
    block(below: 0.4em)[
      #set text(size: 10pt, weight: "bold", style: "italic")
      #set par(first-line-indent: 0pt, spacing: 0pt, justify: false)
      #it.body
    ]
  }

  // Appendix-style heading: centered bold
  show heading.where(level: 3): it => {
    v(1em, weak: true)
    block(below: 0.55em)[
      #set text(size: 10pt, weight: "bold")
      #set par(first-line-indent: 0pt, spacing: 0pt, justify: false, leading: 0.6em)
      #align(center, it.body)
    ]
  }

  // ── Links ─────────────────────────────────────────────────────
  show link: it => text(fill: link-blue, it)

  // ── Block quotes ──────────────────────────────────────────────
  show quote.where(block: true): it => {
    set par(first-line-indent: 0pt)
    block(inset: (left: 1.5em, right: 1em), above: 0.8em, below: 0.8em)[
      #set text(size: 9.5pt, style: "italic")
      #it.body
    ]
  }

  // ── Figure captions ───────────────────────────────────────────
  show figure.caption: it => {
    set text(size: 9pt)
    set par(first-line-indent: 0pt, spacing: 0.3em, justify: true)
    [#strong[#it.supplement #context it.counter.display(it.numbering).]
    #it.body]
  }

  // ── Tables ────────────────────────────────────────────────────
  set table(
    stroke: 0.45pt + charcoal,
    inset: (x: 6pt, y: 4pt),
    align: left,
  )
  show table.header: set text(weight: "bold")
  show table:        set text(size: 9pt, font: "EB Garamond 12")
  show figure.where(kind: table): set figure(placement: auto)

  // ── Footnotes ─────────────────────────────────────────────────
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.4pt + rule-gray),
    indent: 0.5em,
    gap: 0.35em,
  )
  show footnote.entry: set text(size: 8.5pt)

  // ── Bibliography ──────────────────────────────────────────────
  show bibliography: it => {
    set text(size: 9pt)
    set par(
      first-line-indent: 0pt,
      hanging-indent: 1.5em,
      spacing: 0.5em,
      justify: false,
      leading: 0.5em,
    )
    it
  }

  // ════════════════════════════════════════════════════════════════
  // PAGE 1 FRONT MATTER (single-column width)
  // ════════════════════════════════════════════════════════════════

  // ── Masthead ──────────────────────────────────────────────────
  {
    set par(first-line-indent: 0pt, spacing: 0.25em, justify: false, leading: 0.5em)
    grid(
      columns: (46pt, 1fr, 46pt),
      gutter: 8pt,
      align: horizon,

      // Left: SUAPS logo
      image("../SUAPS redesigned logo.png", height: 46pt),

      // Center: journal name + URLs
      align(center + horizon)[
        #text(font: "Inter", size: 13.5pt, weight: "bold")[
          Limina \u{2014} The Journal of UAP Studies
        ]
        #v(3pt)
        #text(font: "Inter", size: 8pt, fill: mid-gray)[
          #link("http://limina.uapstudies.org/") |
          #link("https://limina.scholasticahq.com/")
        ]
      ],

      // Right: circular Limina badge
      align(center + horizon)[
        #box(
          width: 46pt, height: 46pt,
          radius: 23pt,
          fill: amber,
          clip: true,
        )[
          #align(center + horizon)[
            #pad(5pt)[
              #set text(font: "Inter", size: 5.5pt, fill: white, weight: "bold")
              #set par(leading: 0.4em)
              #align(center)[
                Limina \
                Journal of \
                UAP Studies
              ]
            ]
          ]
        ]
      ],
    )
  }

  v(6pt)
  line(length: 100%, stroke: 0.5pt + rule-gray)
  v(18pt)

  // ── Article title ─────────────────────────────────────────────
  {
    set text(font: "EB Garamond 12", size: 17pt, weight: "bold")
    set par(first-line-indent: 0pt, justify: false, leading: 0.65em, spacing: 0pt)
    title
  }

  v(10pt)

  // ── Author list ───────────────────────────────────────────────
  {
    set par(first-line-indent: 0pt, spacing: 0.22em, justify: false, leading: 0.5em)
    for (i, a) in authors.enumerate() {
      // Name + optional suffix
      text(size: 10pt)[
        #a.name#if "suffix" in a [, #a.suffix]
      ]
      linebreak()
      // Affiliation (italic)
      if "affiliation" in a {
        text(size: 9pt, style: "italic")[#a.affiliation]
        linebreak()
      }
      // ORCID badge + link
      if "orcid" in a {
        let orcid-url = "https://orcid.org/" + a.orcid
        box(
          width: 8pt, height: 8pt,
          radius: 4pt,
          fill: rgb("#A6CE39"),
          clip: true,
        )[
          #align(center + horizon)[
            #text(font: "Inter", size: 4.5pt, fill: white, weight: "bold")[iD]
          ]
        ]
        h(3pt)
        text(size: 8pt)[#link(orcid-url)[#orcid-url]]
        linebreak()
      }
      if i < authors.len() - 1 { v(5pt) }
    }
  }

  v(10pt)

  // ── ARTICLE INFO + ABSTRACT two-column panel ──────────────────
  {
    let corresp = authors.filter(a => "email" in a)
    let first-author = if authors.len() > 0 { authors.first().name } else { "The Author(s)" }

    grid(
      columns: (1fr, 2fr),
      gutter: 14pt,

      // Left column: ARTICLE INFO
      align(top)[
        #set par(first-line-indent: 0pt, spacing: 0.28em, justify: false, leading: 0.5em)
        #text(font: "Inter", size: 8pt, weight: "semibold")[ARTICLE INFO]
        #v(5pt)
        #set text(size: 8.5pt)
        #if received != none [Received: #received \ ]
        #if revised  != none [Received in revised form: #revised \ ]
        #if accepted != none [Accepted: #accepted \ ]
        #if online   != none [Available online: #online \ ]
        #v(7pt)
        #if corresp.len() > 0 {
          text(size: 8.5pt, style: "italic")[
            Author contact: #corresp.first().email
          ]
          linebreak()
        }
        #v(8pt)
        // Copyright + CC licence
        #set text(size: 7pt, fill: mid-gray)
        #set par(leading: 0.45em, spacing: 0pt)
        © #first-author. Published by the Society for UAP Studies.
        This is an open access article under the CC license.
        (#link("http://creativecommons.org/licenses/by/4.0/")[http://creativecommons.org/licenses/by/4.0/])
      ],

      // Right column: ABSTRACT
      align(top)[
        #set par(first-line-indent: 0pt, spacing: 0.28em, justify: true, leading: 0.5em)
        #text(font: "Inter", size: 8pt, weight: "semibold")[ABSTRACT]
        #v(5pt)
        #set text(size: 9.5pt)
        #set par(leading: 0.5em, first-line-indent: 0pt)
        #abstract
      ],
    )
  }

  v(8pt)
  line(length: 100%, stroke: 0.5pt + rule-gray)
  v(14pt)

  // ════════════════════════════════════════════════════════════════
  // TWO-COLUMN BODY
  // ════════════════════════════════════════════════════════════════
  columns(2, gutter: 8pt, body)
}
