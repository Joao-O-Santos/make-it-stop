# SPDX-License-Identifier: BSD-3-Clause
# Copyright (c) 2023, João Oliveira Santos

include config.mk

.PHONY: $(PAGES)

all: it_stop

it_stop: clean configure menu
	@printf "Making $(WEB_DIR) to store generated pages\n"
	@mkdir $(WEB_DIR)
	@printf "Done!\n\n"
	@printf "Adding stylesheet\n"
	cp -f $(TEMPLATES_DIR)/styles.css $(WEB_DIR)/styles.css
	@printf "Copying images dir and its contensts.\n"
	-cp -r $(TEMPLATES_DIR)/images -t $(WEB_DIR)
	@printf "Done!\n\n"
	@printf "Rendering the pages/files\n\n"
	@make --no-print-directory $(PAGES)
	@printf "Done!\nAll pages are rendered and ready!\n"

# Refactor for simplicity (e.g., $(WEB_DIR)/%.html: $(PAGES_DIR):%.md: )
# See: https://www.gnu.org/software/make/manual/html_node/Static-Usage.html#Static-Usage
$(PAGES): %.md:
	@echo "Rendering the $*.md file"
	cat $(TEMPLATES_DIR)/header.html > $(WEB_DIR)/$*.html
	cat $(TEMPLATES_DIR)/menu.html >> $(WEB_DIR)/$*.html
	cat $(TEMPLATES_DIR)/after_menu.html >> $(WEB_DIR)/$*.html
	$(MR) $(MRFLAGS) $(PAGES_DIR)/$*.md >> $(WEB_DIR)/$*.html
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
	@# Find pages marked as menu entries, and create `menu.html`.
	@-grep "<!-- .* MENU_ENTRY=.* -->" $(PAGES_DIR)/* > $(TEMPLATES_DIR)/menu.html
	@# Add pages marked as external menu entries to `menu.html`.
	@-grep "<!-- .* EXTERNAL_MENU_ENTRY=.* LINK=.* -->" $(PAGES_DIR)/* >> $(TEMPLATES_DIR)/menu.html
	@# Get values from regular entries generating N_entry+html.
	@sed -Ei 's/$(PAGES_DIR)\/(.*).md:<!-- (.*) MENU_ENTRY=(.*) -->/\2<li><a href="\1.html">\3<\/a><\/li>/g' $(TEMPLATES_DIR)/menu.html
	@# Get values from external entries generating N_entry+html.
	@sed -Ei 's/$(PAGES_DIR)\/(.*).md:<!-- (.*) EXTERNAL_MENU_ENTRY=(.*) LINK=(.*) -->/\2<li><a href="\4">\3<\/a><\/li>/g' $(TEMPLATES_DIR)/menu.html
	@# Sort the entry list.
	@sort $(TEMPLATES_DIR)/menu.html -o $(TEMPLATES_DIR)/menu.html
	@# Remove the N_entry from the N_entry+html.
	@sed -i 's/.*<li>/\t<li>/' $(TEMPLATES_DIR)/menu.html
	@# Copy menu entries to a temporary file.
	@cat $(TEMPLATES_DIR)/menu.html > $(TEMPLATES_DIR)/tmp
	@# Add the required html opening tag, rewriting `menu.html`.
	@printf '<nav class="menu">\n<ul>\n' > $(TEMPLATES_DIR)/menu.html
	@# Add the entries from the temp file back to `menu.html`.
	@cat $(TEMPLATES_DIR)/tmp >> $(TEMPLATES_DIR)/menu.html
	@# Remove the temp file.
	@rm $(TEMPLATES_DIR)/tmp
	@# End by closing the html menu/list tags in `menu.html`.
	@printf "</ul>\n</nav>\n" >> $(TEMPLATES_DIR)/menu.html
	@printf "Done!\n\n"

configure:
	@# Apply configuration options to the templates.
	@sed -i 's/<title>.*<\/title>/<title>$(WEBSITE_TITLE)<\/title>/g' $(TEMPLATES_DIR)/header.html
	@sed -i 's/<html lang=".*">/<html lang="$(WEBSITE_LANG)" \/>/g' $(TEMPLATES_DIR)/header.html
