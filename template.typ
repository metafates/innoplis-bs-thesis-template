#let template(body) = {
  set cite(style: "ieee.csl")
  set bibliography(style: "ieee.csl")
  set text(
    size: 14pt,
    lang: "en",
    region: "ru",
    top-edge: 0.7em,
    bottom-edge: -0.3em,
    font:  "Tempora LGC Uni",
  )
  set par(
    leading: 0.75em,
    justify: true,
    first-line-indent: (
      amount: 1.25cm,
      all: true,
    ),
  )
  set page(
    "a4",
    margin: (
      left: 2.5cm,
      top: 1in + 2.2cm,
      right: 2.2cm,
      bottom: 2.2cm
    ),
    footer: context {},
    header: context {
      set par(
        first-line-indent: (
          amount: 0cm,
        ),
      )

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

      let is-chapter-begin = query(selector(heading.where(level: 1)))
        .filter(h1 => here().page() == h1.location().page()).len() > 0

      if is-chapter-begin {
        return
      }


      strong(counter(heading).display() + " " + current.body)
      h(1fr)
      strong[#here().page()]

      line(length: 100%)

    }
  )

  show heading.where(level: 2): it => {
    set text(size: 1.3em)

    it

    v(.5cm)
  }
  show heading.where(level: 3): it => {
    set text(size: 1.25em)

    it

    v(.2cm)
  }

  show heading.where(level: 1): it => {
    pagebreak(weak: true)

    set par(
      leading: 1em,
      first-line-indent: (
        amount: 0cm,
        all: false,
      ),
    )

    set text(size: 1.5em)

    v(2.5cm)
    if it.numbering != none {
      [
        Chapter #counter(heading).display()


        #text(size: 1.2em, it.body)
      ]
    } else { it }

    v(0.5cm)
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

  show figure: set block(breakable: true)
  show figure: it => {
    v(2em)
    it
    v(2em)
  }
  show figure.where(kind: table): it => {
    align(center)[
      TABLE #it.counter.display("1") \
      #it.caption.body
    ]

    align(center, it.body)
  }

  // show figure.where(kind: image): set figure(supplement: "Fig.")
  // show figure.where(kind: image): set figure.caption(separator: ". ")

  show figure.where(kind: "figure"): set figure(supplement: "Fig.")
  show figure.where(kind: "figure"): set figure.caption(separator: ". ")
  show figure.caption: it => {
    set align(left)
    it
  }

  set outline(indent: auto)

  show raw.where(block: true): block.with(
    fill: luma(249),
    inset: 10pt,
    radius: 2pt,
    stroke: 1pt,
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
