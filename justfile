set export

TYPST_FONT_PATHS := "."
TYPST_ROOT := "."

compile:
	typst compile main.typ --open

watch:
	typst watch main.typ
