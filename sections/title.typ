#let info = yaml("/info.yaml")

#set text(size: 14pt)
#set table(
  gutter: 1em,
  row-gutter: 1em,
  stroke: (x, y) => {
    if x == 0 { return none } else { 0.3pt }
  },
)

#align(center + top, text(weight: "bold")[
  #text(lang: "ru")[
Автономная некоммерческая организация высшего образования \
«Университет Иннополис»

ВЫПУСКНАЯ КВАЛИФИКАЦИОННАЯ РАБОТА \
(БАКАЛАВРСКАЯ РАБОТА) \
по направлению подготовки \
09.03.01 - "Информатика и вычислительная техника"
  ]

  #text(lang: "en")[
GRADUATION THESIS \
(BACHELOR’S GRADUATION THESIS) \
Field of Study \
09.03.01 – "Computer Science"
  ]

  #text(lang: "ru")[
Направленность (профиль) образовательной программы \
"Информатика и вычислительная техника"
  ]

  #text(lang: "en")[
Area of Specialization / Academic Program Title: \
"Computer Science"
  ]
])


#let multilang(
  ru: none,
  en: none,
  sep: " / ",
) = {
  let e(t) = text(lang: "en", t)
  let r(t) = text(lang: "ru", t)

  if ru == none and en == none { return [] }
  if ru == none and en != none { return e(en) }
  if ru != none and en == none { return r(ru) }

  [#r(ru)#sep#e(en)]
}

#let field(
  placeholder: none,
  content: none,
  align: top + left
) = {
  table.cell(
    fill: rgb("#D9D9D9"),
    align: align,
  )[
    #if content != none {
      strong(content)
    } else if placeholder != none {
      set text(fill: rgb("#808080"), size: 0.7em)

      placeholder
    }
  ]
}

#let topic = table(
  columns: (1fr, 6fr),
  multilang(en: [Topic], ru: [Тема]),
  field(content: info.topic)
)

#let signature = field(
  placeholder: multilang(ru: [подпись], en: [signature]),
  align: center + bottom
)
#let signatures = table(
  columns: (4fr, 6fr, 3fr),
  multilang(ru: [Работу выполнил], en: [Thesis is executed by]),
  field(content: info.student),
  signature,
  multilang(
    ru: [
      Руководитель выпускной квалификационной работы
    ],
    en: [
      Supervisor of Graduation Thesis
    ],
  ),
  field(content: info.supervisor),
  signature,
  // multilang(ru: [Консультанты], en: [Consultants]),
  // field(),
  // signature
)

#align(center + horizon, topic)
#align(center + horizon, signatures)

#align(center + bottom)[
  Иннополис, Innopolis, #datetime.today().year()
]
