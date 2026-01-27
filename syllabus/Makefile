BUILD := ./out
SRCS := content.tex document.tex
WORK := ./aux
LATEXMK=latexmk
LATEXMKFLAGS=-auxdir=$(WORK) -file-line-error -interaction=batchmode -outdir=$(BUILD) --shell-escape -silent -synctex=1 -lualatex

.PHONY: all
all: $(BUILD)/document.pdf

$(BUILD)/document.pdf: $(SRCS)
	$(LATEXMK) $(LATEXMKFLAGS) document.tex

.PHONY: clean
clean:
	rm -rf $(BUILD) $(WORK)
