# Waarom is dit zo gebouwd?

Workshopmateriaal over Architecture Decision Records (ADR's), voor platform engineers en architecten
van junior tot senior. Een introductie: geen voorkennis nodig.
De repo bevat vier dingen:

- **`presentatie/slides.md`** — de presentatie (22 slides, [Marp](https://marp.app/))
- **`templates/`** — drie templates om mee te beginnen: MADR, Nygard en een Y-statement
- **`voorbeeld/docs/decisions/`** — een voorbeeld-logboek van vijf ADR's, waarvan er één is vervangen
- **`oefening/`** — vijf scenario's en een reviewchecklist voor het praktijkdeel

De slides staan online op **<https://miguelmartens.github.io/waarom-is-dit-zo/>**.
Het draaiboek voor de sessie staat in [`DRAAIBOEK.md`](DRAAIBOEK.md).

## Wat je nodig hebt

| Tool                                       | Waarvoor                                    |
| ------------------------------------------ | ------------------------------------------- |
| bash en make                               | `make adr` en `make index`                  |
| [Node](https://nodejs.org/) (zie `.nvmrc`) | alleen voor de slides en de opmaakcontroles |

Geen terminal? Dan kopieer je een template uit `templates/` en werkt alles net zo goed.

## Een ADR schrijven

```bash
make adr TITEL="Gebruik één Log Analytics-workspace per omgeving"
# -> oefening/decisions/0001-gebruik-een-log-analytics-workspace-per-omgeving.md
```

Het script pakt het volgende nummer, maakt van de titel een bestandsnaam en vult het template in.
Kies een ander template of een andere map:

```bash
make adr TITEL="..." TEMPLATE=nygard          # of y-statement; standaard madr
make adr TITEL="..." MAP=docs/decisions       # standaard oefening/decisions
make index MAP=docs/decisions                 # overzichtstabel naar docs/decisions/README.md
make voorbeeld                                # toon het voorbeeld-logboek
```

`make help` laat alle commando's zien. Opruimen doe je met `make schoon`.

### In je eigen repo

Kopieer `templates/` en `scripts/` naar je eigen repository en roep het script direct aan:

```bash
scripts/nieuwe-adr.sh "Beheer infrastructuur met Bicep" docs/decisions madr
```

Geen afhankelijkheden buiten bash, sed, awk en tr. Werkt op macOS, Linux en in een Azure DevOps-agent.
In Azure DevOps kun je de map `docs/decisions` publiceren als wiki (_Publish code as wiki_),
zodat het logboek leesbaar is zonder dat je het dubbel bijhoudt.

## De templates

| Bestand                    | Wanneer                                                              |
| -------------------------- | -------------------------------------------------------------------- |
| `templates/madr.md`        | de standaard: opties en voor- en nadelen staan centraal (MADR 4.0)   |
| `templates/nygard.md`      | het origineel uit 2011: context, beslissing, gevolgen                |
| `templates/y-statement.md` | de hele beslissing in één zin, voor kleine beslissingen of als begin |

De templates zijn Nederlandse bewerkingen. De sleutels in de frontmatter (`status`, `date`,
`decision-makers`, `consulted`, `informed`) zijn Engels gebleven, zodat tools die MADR lezen ermee overweg kunnen.

## Het voorbeeld-logboek

| ADR  | Laat zien                                                                   |
| ---- | --------------------------------------------------------------------------- |
| 0001 | de eerste ADR van een team: de afspraken over ADR's zelf                    |
| 0002 | een volledige MADR, met zekerheid, bevestiging en een gedateerde aanvulling |
| 0003 | een ADR met de status _vervangen_                                           |
| 0004 | een Y-statement                                                             |
| 0005 | de ADR die 0003 vervangt, met een link terug                                |

De beslissingen zijn verzonnen, maar herkenbaar voor een platformteam op Azure.

## De slides

Snelste weg: installeer de extensie **Marp for VS Code** en open `presentatie/slides.md`. Je krijgt live preview en presentatiemodus.

Zonder VS Code:

```bash
make slides           # live preview in je browser, haalt zelf npm ci op
make build            # eenmalig exporteren naar dist/index.html
```

Druk in de HTML op `p` voor de presenter view met sprekersnotities, de volgende
slide en een timer. De notities staan in het markdown-bestand als
HTML-commentaar onder elke slide.

Alle opmaak zit in een `<style>`-blok bovenin `slides.md`. De drie kleuren lopen door de hele presentatie:
amber voor context, groen voor de beslissing, rood voor de gevolgen.

### Publiceren

`.github/workflows/pages.yaml` bouwt de slides bij elke push naar `main` en zet
ze op GitHub Pages, met een PDF met notities als hand-out.
Zet daarvoor eenmalig **Settings → Pages → Source** op _GitHub Actions_.

## Meewerken aan de repo

```bash
make format       # Prettier
make format-check # dezelfde controle zonder te schrijven
make lint-md      # markdownlint over alle Markdown behalve de slides
make hooks        # pre-commit installeren (optioneel)
```

`presentatie/slides.md` blijft met de hand opgemaakt: dat bestand staat in `.prettierignore` en wordt door markdownlint overgeslagen.

## Bronvermelding

- [Architecture Decision Record](https://github.com/architecture-decision-record/architecture-decision-record) —
  de ADR-repository, ook [in het Nederlands](https://architecture-decision-record.github.io/nl-001/):
  begrippen, de eigenschappen van een goede ADR, bestandsnamen en de teamvragen
- [Architecture Decision Record](https://learn.microsoft.com/nl-nl/azure/well-architected/architect-role/architecture-decision-record)
  in het Azure Well-Architected Framework ([Engels](https://learn.microsoft.com/en-us/azure/well-architected/architect-role/architecture-decision-record)) —
  wanneer je een ADR schrijft, wat erin moet, zekerheid en append-only
- [adr.github.io](https://adr.github.io/) — definities, [MADR](https://adr.github.io/madr/) en een
  [overzicht van tooling](https://adr.github.io/adr-tooling/)
- Michael Nygard, [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) (2011)
