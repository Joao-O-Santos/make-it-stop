# SPDX-License-Identifier: LGPL-2.1-or-later
# Copyright (c) 2022, João Oliveira Santos

include config.mk

.PHONY: $(PAGES)

all: it_stop

it_stop: clean menu
	@printf "Making $(WEB_DIR) to store generated pages\n"
	@mkdir $(WEB_DIR)
	@printf "Done!\n\n"
	@printf "Adding stylesheet\n"
	cp -f $(TEMPLATES_DIR)/styles.css $(WEB_DIR)/styles.css
	@printf "Done!\n\n"
	@printf "Rendering the pages/files\n\n"
	@make --no-print-directory $(PAGES)
	@printf "Done!\nAll pages are rendered and ready!\n"

# See: https://www.gnu.org/software/make/manual/html_node/Static-Usage.html#Static-Usage
$(PAGES): %.md:
	@echo "Rendering the $*.md file"
	cat $(TEMPLATES_DIR)/header.html > $(WEB_DIR)/$*.html
	cat $(TEMPLATES_DIR)/menu.html >> $(WEB_DIR)/$*.html
	cat $(TEMPLATES_DIR)/after_menu.html >> $(WEB_DIR)/$*.html
	$(MP) $(MFLAGS) $(PAGES_DIR)/$*.md >> $(WEB_DIR)/$*.html
	cat $(TEMPLATES_DIR)/footer.html >> $(WEB_DIR)/$*.html
	@echo "Marking the current page as selected in its menu/nav bar"
	sed -Ei 's/li(><a href="$*.html")/li class="selected"\1/g' $(WEB_DIR)/$*.html
	@printf "$*.md rendered\n\n"

clean:
	@echo "Cleaning all auto-generated files"
	-rm -rf $(TEMPLATES_DIR)/menu.html
	-rm -rf $(TEMPLATES_DIR)/tmp
	-rm -rf $(WEB_DIR)
	@printf "Done!\n\n"

# TODO: refactor with `awk` or something to be readable
menu:
	@echo "Automatically generating the menu"
	@-grep "<!-- .* MENU_ENTRY=.* -->" $(PAGES_DIR)/* > $(TEMPLATES_DIR)/menu.html
	@sed -Ei 's/$(PAGES_DIR)\/(.*).md:<!-- (.*) MENU_ENTRY=(.*) -->/\2<li><a href="\1.html">\3<\/a><\/li>/g' $(TEMPLATES_DIR)/menu.html
	@sort $(TEMPLATES_DIR)/menu.html -o $(TEMPLATES_DIR)/menu.html
	@sed -i 's/.*<li>/\t<li>/' $(TEMPLATES_DIR)/menu.html
	@cat $(TEMPLATES_DIR)/menu.html > $(TEMPLATES_DIR)/tmp
	@printf '<nav class="menu">\n<ul>\n' > $(TEMPLATES_DIR)/menu.html
	@cat $(TEMPLATES_DIR)/tmp >> $(TEMPLATES_DIR)/menu.html
	@rm $(TEMPLATES_DIR)/tmp
	@printf "</ul>\n</nav>\n" >> $(TEMPLATES_DIR)/menu.html
	@printf "Done!\n\n"
