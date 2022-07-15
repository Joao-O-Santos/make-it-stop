include config.mk

.PHONY: $(PAGES)

all: it_stop

it_stop: clean
	mkdir $(WEB_DIR)
	cp -f $(TEMPLATES_DIR)/styles.css $(WEB_DIR)/styles.css
	make $(PAGES)

# See: https://www.gnu.org/software/make/manual/html_node/Static-Usage.html#Static-Usage
$(PAGES): %.md:
	@echo "Creating the $* page"
	cat $(TEMPLATES_DIR)/header.html > $(WEB_DIR)/$*.html
	$(MP) $(MFLAGS) $(PAGES_DIR)/$*.md >> $(WEB_DIR)/$*.html
	cat $(TEMPLATES_DIR)/footer.html >> $(WEB_DIR)/$*.html
	@echo "Marking the current page as selected in its menu/nav bar"
	sed -Ei 's/li(><a href="$*.html")/li class="selected"\1/g' $(WEB_DIR)/$*.html
	@printf "\n"

clean:
	@echo "Cleaning all auto-generated files"
	-rm -r $(WEB_DIR)
