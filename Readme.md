A LaTeX class for NSERC Alliance application templates
======================================================

This repository contains a LaTeX class and example document that faithfully
reproduces the Microsoft Word template for NSERC's Alliance proposal template.
Depending on the language specified when compiling, the title page reproduces
the English or the French version of the template.

Fill in the info in `application-config.tex` and write your text in
`alliance-example.tex` (which you can rename to whatever you like). The rest
should be self-explanatory.

Note that I made up this class for my own personal use; I don't
mind sharing it, but please don't contact me for support.

If you are writing an NSERC Discovery Grant, you might want to have a look
at this [other template](https://github.com/sylvainhalle/nserc-latex-template)
I made.

Usage notes
-----------

- All the lengthy instruction bullets can be hidden by compiling and passing
  the `nobullets` option to the document declaration.
- Don't use the `cite` package. The class already provides `natbib`, which is a
  reimplementation of it.

About the author
----------------

This class was designed by [Sylvain Hallé](https://leduotang.ca/sylvain),
Full Professor at [Université du Québec à Chicoutimi](https://www.uqac.ca),
Canada.
