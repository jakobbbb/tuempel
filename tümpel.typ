#let tümpel(doc) = {

  show heading: set block(above: 1.4em, below: 1em)

  set page(numbering: "—1—")

  let date = datetime.today()

  let authors_short = context[
    #if document.author.len() == 1 [
      #document.author.first()
    ] else [
      #document.author.map(name => name.split(" ").last()).join(", ")
    ]
  ]

  set page(header: {
    grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [#authors_short],
      context[#document.title],
      [#date.display("[month repr:long] [day], [year]")],
      "",
      grid.hline()
    )
    },
  )

  title[#context[#document.title]]

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
