#let template(body) = {
  set cite(style: "ieee.csl")
  set bibliography(style: "ieee.csl")
  set text(
    size: 14pt,
    lang: "en",
    region: "ru",
  )
  set page(
    "a4",
    margin: (left: 2.5cm, top: 2.5cm),
    header: context {
      let headings = query(
        selector(heading)
        .before(here())
      )

      if headings.len() == 0 {
        return
      }

      let current = headings.last()

      if counter(heading).get() == (0,) {
        return
      }

      let isChapterBegin = query(selector(heading.where(level: 1)))
        .filter(h1 => here().page() == h1.location().page()).len() > 0

      if isChapterBegin {
        return
      }
      
      strong(counter(heading).display() + " " + current.body)

      line(length: 100%)
    }
  )

  show heading.where(level: 2): it => {
    set text(size: 1.3em)
    
    it

    v(1em)
  }
  
  show heading.where(level: 1): it => {
    pagebreak(weak: true)

    set text(size: 1.5em)

    v(5em)

    if it.numbering != none {
      [
        Chapter #counter(heading).display()


        #text(size: 1.2em, it.body)
        
        #v(1em)
      ]
    } else { it }
  }
  
  set math.equation(numbering: "(1)")

  set ref(supplement: it => {
    if it.func() == heading {
      "Chapter"
    } else {
      it.supplement
    } 
  })
  
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      )
    } else {
      // Other references as usual.
      it
    }
  }

  show figure: it => {
    v(2em)
    it
    v(2em)
  }
  show figure.where(kind: table): it => {
    align(center)[
      TABLE #it.counter.display("I") \
      #it.caption.body
    ]

    align(center, it.body)
  }

  set table(
    stroke: (x, y) => (
      top: 1pt,
      bottom: 1pt,
      left: if x > 0 { 1pt }
    )
  )
  
  show figure.where(kind: image): set figure(supplement: "Fig.")
  show figure.where(kind: image): set figure.caption(separator: ". ")
  
  show figure.where(kind: "figure"): set figure(supplement: "Fig.")
  show figure.where(kind: "figure"): set figure.caption(separator: ". ")
  
  set outline(indent: auto)

  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  body
}

#let numbering(body) = {
  set page(numbering: "1")
  set heading(
    numbering: (..nums) => nums
      .pos()
      .map(str)
      .join(".")
  )

  body
}