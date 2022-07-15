PAGES_DIR = pages
PAGES = $(shell ls $(PAGES_DIR))
WEB_DIR = public
TEMPLATES_DIR = templates

# Define markdown parser (mp) executable name or path to executable
MP = markdown

# Define flags (if any needed) to be passed to the markdown parser $(MP)
MFLAGS =
