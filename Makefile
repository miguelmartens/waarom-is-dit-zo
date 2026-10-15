# Workshop "Waarom is dit zo gebouwd?" - Architecture Decision Records.
# Draai alles vanuit de root van de repo. `make help` toont het overzicht.

NPX      := npx --no-install
MAP      ?= oefening/decisions
TEMPLATE ?= madr
VOORBEELD := voorbeeld/docs/decisions

.DEFAULT_GOAL := help

.PHONY: help slides build adr index voorbeeld format format-check lint-md hooks schoon

##@ Slides

slides: node_modules ## Live preview van de slides in je browser
	$(NPX) marp -s presentatie/

build: node_modules ## Exporteer de slides eenmalig naar dist/index.html
	$(NPX) marp presentatie/slides.md --html -o dist/index.html

##@ ADR's schrijven

adr: ## Nieuwe ADR: make adr TITEL="Beheer infra met Bicep" [TEMPLATE=nygard] [MAP=docs/decisions]
	@if [ -z "$(TITEL)" ]; then \
	  echo 'Geef een titel mee: make adr TITEL="Gebruik Key Vault per omgeving"'; exit 1; \
	fi
	@scripts/nieuwe-adr.sh "$(TITEL)" "$(MAP)" "$(TEMPLATE)"

index: ## Schrijf het overzicht van $(MAP) naar $(MAP)/README.md
	@mkdir -p "$(MAP)"
	scripts/adr-index.sh "$(MAP)" > "$(MAP)/README.md"

voorbeeld: ## Toon het voorbeeld-logboek uit de presentatie
	@scripts/adr-index.sh $(VOORBEELD)

##@ Overig

format: node_modules ## Formatteer Markdown en YAML met Prettier
	$(NPX) prettier --write . --ignore-unknown

format-check: node_modules ## Controleer de opmaak zonder iets te wijzigen
	$(NPX) prettier --check . --ignore-unknown

lint-md: node_modules ## Lint alle Markdown behalve de slides
	$(NPX) markdownlint-cli2

hooks: ## Installeer de pre-commit hooks
	pre-commit install

# Geen .PHONY: npm ci draait alleen als package.json of de lockfile nieuwer is
# dan de map zelf.
node_modules: package.json package-lock.json
	npm ci
	@touch node_modules

schoon: ## Verwijder de oefen-ADR's en de build
	rm -rf oefening/decisions dist

help: ## Toon dit overzicht
	@echo "Workshop: waarom is dit zo gebouwd?"
	@awk 'BEGIN {FS = ":.*?## "} \
	     /^##@ / {printf "\n\033[1m%s\033[0m\n", substr($$0, 5); next} \
	     /^[a-zA-Z0-9_-]+:.*?## / {printf "  %-14s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo
	@echo "Tijdens de oefening: make adr TITEL=\"...\""
