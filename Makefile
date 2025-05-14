# SPDX-License-Identifier: BSD-3-Clause
# Copyright (c) 2025, João Oliveira Santos, Carlos Pinto Machado

include config.mk

all: it_stop

it_stop: sync-static $(TARGET)
	@printf "Done!\nAll pages are rendered and ready!\n"

$(WEB_DIR):
	@printf "Making $(WEB_DIR) to store generated pages\n"
	@mkdir -p $(WEB_DIR)
	@printf "Done!\n\n"

sync-static: | $(WEB_DIR)
	@printf "Sync static resources\n"
	@cp -ru static/* $(WEB_DIR)
	@printf "Done!\n\n"

$(WEB_DIR)/%.html: $(PAGES_DIR)/%.md $(TEMPLATES_DIR)/header.html | $(WEB_DIR) $(TEMPLATES_DIR)/menu.html
	@echo "Rendering the $< file"
	@cat $(TEMPLATES_DIR)/header.html $(TEMPLATES_DIR)/menu.html $(TEMPLATES_DIR)/after_menu.html > $@
	@$(MR) $(MRFLAGS) $< >> $@
	@cat $(TEMPLATES_DIR)/footer.html >> $@
	@#Marking the current page as selected in its menu/nav bar
	@sed -Ei 's/li(><a href="$*.html")/li class="selected"\1/g' $@
	@printf "$< rendered\n\n"

clean:
	@echo "Cleaning all auto-generated files"
	@rm -rf $(TEMPLATES_DIR)/menu.html
	@rm -rf $(TEMPLATES_DIR)/tmp
	@rm -rf $(WEB_DIR)
	@printf "Done!\n\n"

# TODO: refactor with `awk` or something to be readable
$(TEMPLATES_DIR)/menu.html:
	@# Find pages marked as menu entries, and create `menu.html`.
	@-grep "<!-- .* MENU_ENTRY=.* -->" $(PAGES) > $@
	@# Add pages marked as external menu entries to `menu.html`.
	# HERE BE DRAGONS: this returns error when no match is found
	@-grep "<!-- .* EXTERNAL_MENU_ENTRY=.* LINK=.* -->" $(PAGES) >> $@
	@# Get values from regular entries generating N_entry+html.
	@sed -Ei 's/$(PAGES_DIR)\/(.*).md:<!-- (.*) MENU_ENTRY=(.*) -->/\2<li><a href="\1.html">\3<\/a><\/li>/g' $@
	@# Get values from external entries generating N_entry+html.
	@sed -Ei 's/$(PAGES_DIR)\/(.*).md:<!-- (.*) EXTERNAL_MENU_ENTRY=(.*) LINK=(.*) -->/\2<li><a href="\4">\3<\/a><\/li>/g' $@
	@# Sort the entry list.
	@sort $@ -o $@
	@# Remove the N_entry from the N_entry+html.
	@sed -i 's/.*<li>/\t<li>/' $@
	@# Copy menu entries to a temporary file.
	@cat $@ > $(TEMPLATES_DIR)/tmp
	@# Add the required html opening tag, rewriting `menu.html`.
	@printf '<nav class="menu">\n<ul>\n' > $@
	@# Add the entries from the temp file back to `menu.html`.
	@cat $(TEMPLATES_DIR)/tmp >> $@
	@# Remove the temp file.
	@rm $(TEMPLATES_DIR)/tmp
	@# End by closing the html menu/list tags in `menu.html`.
	@printf "</ul>\n</nav>\n" >> $@

configure:
	@# Apply configuration options to the templates.
	@sed -i 's/<title>.*<\/title>/<title>$(WEBSITE_TITLE)<\/title>/g' $(TEMPLATES_DIR)/header.html
	@sed -i 's/<html lang=".*">/<html lang="$(WEBSITE_LANG)">/g' $(TEMPLATES_DIR)/header.html

options:
	@echo "PAGES_DIR:     $(PAGES_DIR)"
	@echo "PAGES:         $(PAGES)"
	@echo "WEB_DIR:       $(WEB_DIR)"
	@echo "TEMPLATES_DIR: $(TEMPLATES_DIR)"
	@echo "TARGET:        $(TARGET)"
	@echo "WEBSITE_LANG:  $(WEBSITE_LANG)"
	@echo "WEBSITE_TITLE: $(WEBSITE_TITLE)"
	@echo "MR:            $(MR)"
	@echo "MRFLAGS:       $(MRFLAGS)"
