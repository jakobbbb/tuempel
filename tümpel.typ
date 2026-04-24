#let titleblock(title, author, date, inst: none, email: none) = {
  block(
    width: 100%,
  )[
    #set align(center)
    #text(size: 2em, weight: "bold")[#title]

    #text(size: 1em)[#author.first()] \
    #if email != none [
      #show link: set text(font: "DejaVu Sans Mono", size: 0.7em)
      #link("mailto:" + email)[#email]
    ]

    #if inst != none [
      #text(size: 1em)[#inst]
    ]

    #text(size: 1em)[#date]
  ]
}

#let tümpel(institute: none, email: none, doc) = {

  show heading: set block(above: 1.4em, below: 1em)
  show link: underline

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
      #grid(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        [#authors_short],
        context[#document.title],
        [#date_string],
        "",
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
      email: email,
    )
  ]

  doc
}

#let thmcounter = counter("_thm")
#let thmnumber() = context thmcounter.display()
#let _thm(kind) = (what, content) => {
  thmcounter.step()
  context block[
    *#kind #thmnumber() (#what).*
    #figure(content, kind: kind, supplement: kind)
    #label(kind + "_" + str(thmcounter.get().first()))
  ]
}

#let defn = _thm("Definition")
#let thm = _thm("Theorem")
#let rmk = _thm("Remark")
#let proof = _thm("Proof")
