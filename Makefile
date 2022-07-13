# Adapt: https://www.gnu.org/software/make/manual/html_node/Static-Usage.html#Static-Usage

MD = $(wildcard *.md)
MD := $(filter-out README.md, $(MD))

.PHONY: $(MD)

all: $(MD)
	# Uncomment if you wish to remove any files
	#@echo "Remove sections that are not ready (yet) for publication"
	#-rm <file name/s>

$(MD): %.md:
	@echo "Creating the $* page"
	cat header.html > public/$*.html
	markdown $*.md >> public/$*.html
	cat footer.html >> public/$*.html
	sed -i 's/li><a href="$*.html"/li class="selected"><a href="$*.html"/g' public/$*.html
	@printf "\n"
