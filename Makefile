# Adapt: https://www.gnu.org/software/make/manual/html_node/Static-Usage.html#Static-Usage

MD = $(wildcard *.md)
# You can add other markdown files you don't wish to render below
# MD := $(filter-out README.md TODO.md <file1.md> <fileX.md>, $(MD))
MD := $(filter-out README.md TODO.md, $(MD))

.PHONY: $(MD)

all: $(MD)

$(MD): %.md:
	@echo "Creating the $* page"
	cat header.html > public/$*.html
	markdown $*.md >> public/$*.html
	cat footer.html >> public/$*.html
	sed -i 's/li><a href="$*.html"/li class="selected"><a href="$*.html"/g' public/$*.html
	@printf "\n"
