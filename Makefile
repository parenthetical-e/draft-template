SHELL=/bin/bash -O expand_aliases
DOCNAME=template
BIBPATH=~/Documents/Papers/library.bib . 

# --
# Master recipes
.PHONY: all
all: bib clean tex 

.PHONY: clean
clean: clean_tex

# --
# Sync the bib file from Zotero w/ this
# directory
.PHONY: bib
bib:
	cp $(BIBPATH)

# Compile the paper into pdf
# or clean up a compilations
.PHONY: tex
tex:
	pdflatex $(DOCNAME).tex
	bibtex $(DOCNAME).aux
	pdflatex $(DOCNAME).tex
	pdflatex $(DOCNAME).tex

.PHONY: tex_nonstopmode
tex_nonstopmode:
	pdflatex -interaction=nonstopmode $(DOCNAME).tex
	bibtex $(DOCNAME).aux
	pdflatex -interaction=nonstopmode $(DOCNAME).tex
	pdflatex -interaction=nonstopmode $(DOCNAME).tex
	
.PHONY: clean_tex
clean_tex:
	# Spare the generate pdf...
	-mv $(DOCNAME).pdf tmp.pdf
	latexmk -C
	-mv tmp.pdf $(DOCNAME).pdf 
	-rm tmp.pdf
	# Other debris
	-rm *md5
	-rm *.log
	-rm *.aux
	-rm *.bbl
	-rm *dpth
	-rm *suppinfo
	-rm *.auxlock
	-rm __latexindent_temp.tex

# rm the pdf, just in case. 
# the normal clean_tex leaves the
# pdflatex output intact. 
# ...Sometimes this is not helpful.
.PHONY: clean_pdf
clean_pdf:
	-rm $(DOCNAME).pdf 
	