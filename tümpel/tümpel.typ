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

#let tümpel(institute: none, email: none, doc) = {

  show heading: set block(above: 1.4em, below: 1em)
  show link: underline
  show ref: underline

  set page(numbering: "—1—")

  let date = datetime.today()
  let date_string = date.display("[month repr:long] [day], [year]")

  let authors_short = context[
    #if document.author.len() == 1 [
      #document.author.first()
    ] else [
      #document.author.map(name => name.split(" ").last()).join(", ")
    ]
  ]

  set page(header: context {
    if counter(page).get().first() > 1 [
      #let headertext = smallcaps
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        [#headertext(authors_short)],
        context[#headertext(document.title)],
        [#headertext(date_string)],
        [#v(0.5em)],
        grid.hline()
      )
    ]
  })

  // title[#context[#document.title]]

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
