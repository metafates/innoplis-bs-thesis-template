#import "template.typ": template, numbering

// See info.yaml file to edit title data
#include "sections/title.typ"

// Title has its own styles that differ from the template. Therefore, we apply template only after title
#show: template

// Start page counter from here
#counter(page).update(1)

#include "sections/contents.typ"
#include "sections/list/tables.typ"
#include "sections/list/figures.typ"
#include "sections/abstract.typ"

// Start numbering pages from the first chapter
#show: numbering

#include "sections/chapters/1.typ"
#include "sections/chapters/2.typ"
#include "sections/chapters/3.typ"
#include "sections/chapters/4.typ"

// Do the rest for other chapters:
// #include "sections/chapters/n.typ"

#include "sections/bibliography.typ"
