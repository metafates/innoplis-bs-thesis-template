#let images = figure.where(kind: image)
#let raws = figure.where(kind: raw)

#outline(
  title: [List of Figures],
  target: images.or(raws)
)