# Adapt: https://www.gnu.org/software/make/manual/html_node/Static-Usage.html#Static-Usage

MD = $(shell ls pages)

# You can exclude markdown files you don't wish to render below
# MD := $(filter-out <fileX.md> <fileY.md>, $(MD))

.PHONY: $(MD)

all: clean mk_public $(MD) 
	cp -f templates/styles.css public/styles.css

$(MD): %.md:
	@echo "Creating the $* page"
	cat templates/header.html > public/$*.html
	markdown pages/$*.md >> public/$*.html
	cat templates/footer.html >> public/$*.html
	@echo "Marking the current page as selected in its menu/nav bar"
	sed -Ei 's/li(><a href="$*.html")/li class="selected"\1/g' public/$*.html
	@printf "\n"

clean:
	@echo "Cleaning all auto-generated files"
	-rm -r public
	
mk_public:
	mkdir public
