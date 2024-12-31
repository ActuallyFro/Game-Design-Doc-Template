PlantUMLPath = ~/.local/plantuml/plantuml-1.2024.7.jar

OUT_DIR = ./output

TEMPLATE = ./resources/custom.docx

MD_FILES := $(wildcard ./*.md)

# PPTX_FILES := $(patsubst ./%.md,$(OUT_DIR)/%.pptx,$(MD_FILES))

# # Rule to convert markdown files to pptx
# $(OUT_DIR)/%.pptx: ./%.md
# 	mkdir -p $(OUT_DIR)
# 	pandoc -s -V slideNumber=true $< -o $@ --reference-doc=$(TEMPLATE)

DOCX_FILES := $(patsubst ./%.md,$(OUT_DIR)/%.docx,$(MD_FILES))

all: $(DOCX_FILES)

$(OUT_DIR)/%.docx: ./%.md
	mkdir -p $(OUT_DIR)
	pandoc $< --reference-doc=$(TEMPLATE) --lua-filter=./resources/pagebreak.lua -f markdown -o $@ 

#OTHER FILTERS: https://github.com/pandoc-ext/info (e.g., code and diagrams for plantuml)

clean:
	rm -rf $(OUT_DIR)/*.pptx $(OUT_DIR)/*.docx


