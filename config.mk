# make it_stop configuration
# SPDX-License-Identifier: CC0-1.0

# Pages and directories
PAGES_DIR = pages
PAGES = $(shell find $(PAGES_DIR) -type f)
WEB_DIR = public
TEMPLATES_DIR = templates
STATIC_DIR = static
TARGET = $(patsubst $(PAGES_DIR)/%.md,$(WEB_DIR)/%.html, $(PAGES))

# Site settings
WEBSITE_LANG = en
WEBSITE_TITLE = make it_stop

# Markdown renderer settings
# Define markdown renderer (MR) executable name or path to executable
MR ?= markdown
# Define flags (if any needed) to be passed to the markdown renderer
MRFLAGS ?=
