#let authorblock(author, email) = [
    #text(size: 1em)[#author] \
    #if email != none [
      #show link: set text(font: "DejaVu Sans Mono", size: 0.7em)
      #link("mailto:" + email)[#email]
      #v(0.8em)
    ]
]

#let titleblock(title, authors, date, inst: none, emails: none) = {
  block(
    width: 100%,
  )[
    #set align(center)
    #text(size: 2em, weight: "bold")[#title]

    #let num_cols = calc.min(authors.len(), 2)
    #let cols = (..range(num_cols).map(_ => 1fr))

    #grid(
      columns: cols,
      ..authors.enumerate().map(((i, author)) => [
        #if i > 1 {
          v(1em)
        }
        #let email = if emails != none {emails.at(i)} else {none}
        #authorblock(author, email)
      ])
    )

    #if inst != none [
      #text(size: 1em)[#inst]
    ]

    #text(size: 1em)[#date]
  ]
}

#let tümpel(institute: none, email: none, date: none, shorttitle: none, shortauthor: none, internal: "", doc) = {

  show heading: set block(above: 1.4em, below: 1em)
  show link: underline
  show ref: underline

  set page(footer: context [
    #align(center, counter(page).display("— 1 —"))
  ])

  let today = datetime.today()

  let date_string = if date != none { date } else { today.display("[month repr:long] [day], [year]") }

  let authors_short = context[
    #if document.author.len() == 1 [
      #document.author.first()
    ] else [
      #document.author.map(name => name.split(" ").last()).join(", ")
    ]
  ]

  let header_title = context [#if shorttitle != none { shorttitle } else { document.title }]
  let header_author = [#if shortauthor != none { shortauthor } else { authors_short }]

  set page(header: context {
    if counter(page).get().first() > 1 [
      #let headertext = smallcaps
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        [#headertext(header_author)],
        context[#headertext(header_title)],
        [#headertext(date_string)],
        [#v(0.5em)],
      )
      #v(0pt, weak: true)
      #grid(
    columns: (1fr,1fr,1fr,1fr),
    box(fill: rgb("#ff2b2b"), width: 1fr, height: 5%)[#sym.space],
    box(fill: rgb("#ffbd2b"), width: 1fr, height: 5%)[#sym.space],
    box(fill: rgb("#6ba823"), width: 1fr, height: 5%)[#sym.space],
    box(fill: rgb("#2662b5"), width: 1fr, height: 5%)[#sym.space]
  )
    ]
  })


  set page(footer: context [
    #grid(
      columns: (1fr,1fr,1fr,1fr),
      box(fill: rgb("#ff2b2b"), width: 1fr, height: 10%)[#sym.space],
      box(fill: rgb("#ffbd2b"), width: 1fr, height: 10%)[#sym.space],
      box(fill: rgb("#6ba823"), width: 1fr, height: 10%)[#sym.space],
      box(fill: rgb("#2662b5"), width: 1fr, height: 10%)[#sym.space]
    )
    #align(center, counter(page).display("— 1 —"))
  ])

  set page(
    background: [
      #v(1em)
      #text(red, size: 14pt)[*#internal*]
      #v(1fr)
      #sys.inputs.at("ver", default: "")
      #v(1em)
    ],
  )

  context[
    #titleblock(
      document.title,
      document.author,
      date_string,
      inst: institute,
      emails: if type(email) == str { (email,) } else { email },
    )
  ]


  doc
}

#let thmcounter = counter("_thm")
#let thmnumber() = context thmcounter.display()
#let _thm(kind) = (what, ref: none, content) => {
  thmcounter.step()
  context block[
    *#kind #thmnumber() (#what).* #content
    #v(-1em)  // evil hax :3
    #figure([], kind: kind, supplement: kind)
    #label(kind + "_" + str(if ref != none {ref} else {what}))
  ]
}

#let defn = _thm("Definition")
#let thm = _thm("Theorem")
#let rmk = _thm("Remark")
#let proof = _thm("Proof")



