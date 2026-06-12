// article-template.typ
// Author template for Limina: The Journal of UAP Studies
//
// Instructions:
//   1. Copy this file and rename it for your article.
//   2. Fill in your metadata in the #show: limina-article.with(...) block below.
//   3. Write your article body using standard Typst markup.
//   4. Place your .bib file in the same folder and update the bibliography call.
//   5. Compile with:
//        typst compile your-article.typ your-article.pdf --root <repo-root>
//
// Heading convention:
//   = 1. Introduction          ← Level 1 (numbered section)
//   == 1.1 Background          ← Level 2 (numbered subsection)
//   === Appendix Title         ← Level 3 (appendix / unnumbered, centred bold)
//
// Citations: Chicago author-date, e.g. (Smith 2024) or Smith (2024).
// References: Add entries to your .bib file; call bibliography() at end of body.

#import "limina.typ": limina-article

#show: limina-article.with(
  // ── Required ────────────────────────────────────────────────────
  title: [Your Article Title Here],

  // Each author is a dictionary. Recognised keys:
  //   name        (required)
  //   suffix      e.g. "Ph.D." — appended after name
  //   affiliation italic institution line
  //   email       correspondence address (first match used)
  //   orcid       ORCID ID string, e.g. "0000-0001-2345-6789"
  authors: (
    (
      name:        "First Author",
      suffix:      "Ph.D.",
      affiliation: "Department of Example Studies, Example University",
      email:       "first.author@example.edu",
      orcid:       "0000-0000-0000-0001",
    ),
    (
      name:        "Second Author",
      suffix:      "Ph.D.",
      affiliation: "Another Institution",
    ),
  ),

  abstract: [
    Your abstract goes here. It should be a single paragraph of 150–250 words
    summarising the paper's aims, methods, main findings, and conclusions.
  ],

  // ── Optional metadata ────────────────────────────────────────────
  keywords: (
    "keyword one",
    "keyword two",
    "keyword three",
  ),
  volume:     1,
  issue:      1,
  year:       2026,
  pages:      none,         // set to "40-54" once page range is assigned
  doi:        none,         // set to "10.59661/001c.XXXXX" once assigned
  received:   none,         // e.g. "15 January 2026"
  revised:    none,
  accepted:   none,
  online:     none,
  page-start: 1,            // first page number for this article
)

// ════════════════════════════════════════════════════════════════════
// ARTICLE BODY
// ════════════════════════════════════════════════════════════════════

= 1. Introduction

Your introduction here. Begin each numbered section with `= N. Title`.
Paragraphs after the first in each section will be indented automatically.

Citations use Chicago author-date style: (Smith 2024) or Smith (2024) or
(Smith and Jones 2023; Brown 2022).

Footnotes are added inline with the `#footnote[Text here.]` command.#footnote[This is an example footnote.]

= 2. Second Section

== 2.1 A Subsection

Subsections use `==`. They are rendered in bold italic.

== 2.2 Another Subsection

Body text continues here. Use `_italics_` for emphasis and `*bold*` for
strong emphasis.

= 3. Conclusion

Your conclusion here.

// Replace "your-refs.bib" with your actual .bib filename.
#bibliography("your-refs.bib", title: "References", style: "chicago-author-date")
