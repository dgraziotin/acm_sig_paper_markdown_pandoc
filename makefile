PANDOC = /usr/local/bin/pandoc
OUTPUT = build

FLAGS = \
	-F /usr/local/bin/pandoc-crossref \
	-f markdown \
	--pdf-engine=/usr/local/bin/pdflatex \
	--filter table-filter.py \
	--filter=/usr/local/bin/pandoc-citeproc \
	--bibliography=bibliography.bib \
	--csl=bibliography.csl \
	-s

FLAGS_TEX =
	--bibliography=bibliography.bib \
	--csl=bibliography.csl \
	-s \
	-F /usr/local/bin/pandoc-crossref

FLAGS_PDF = --template=template.latex

all: test1.pdf test2.pdf

mkdir:
	@if [ ! -e build ]; then mkdir build; fi

%.pdf : %.md | mkdir
	$(PANDOC) -o $(OUTPUT)/$@ $(FLAGS) $(FLAGS_PDF) metadata.yaml $<

%.tex : %.md | mkdir
	$(PANDOC) -o $(OUTPUT)/$@ $(FLAGS_TEX) $(FLAGS_PDF) metadata.yaml $<

clean:
	rm -f build/*
