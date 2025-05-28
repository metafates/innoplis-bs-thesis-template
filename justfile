set export

TYPST_FONT_PATHS := "."
TYPST_ROOT := "."

compile:
	typst compile main.typ

watch:
	typst watch main.typ
