# Waarom is dit zo gebouwd?

Workshopmateriaal over Architecture Decision Records (ADR's), voor platform engineers en architecten
van junior tot senior. Een introductie: geen voorkennis nodig.
De repo bevat vijf dingen:

- **`presentatie/slides.md`** — de presentatie (23 slides, [Marp](https://marp.app/))
- **`templates/`** — drie templates om mee te beginnen: MADR, Nygard en een Y-statement
- **`voorbeeld/docs/decisions/`** — een voorbeeld-logboek van vijf ADR's, waarvan er één is vervangen
- **`oefening/`** — vijf scenario's en een reviewchecklist voor het praktijkdeel
- **`.claude/skills/adr-schrijven/`** — een agent-skill die ADR's schrijft en reviewt in dit formaat

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

## Met een AI-agent

`.claude/skills/adr-schrijven/SKILL.md` is een [Agent Skill](https://agentskills.io/): instructies die een
agent laadt als je om een ADR vraagt, of als je hem aanroept met `/adr-schrijven`.
[GitHub Copilot in VS Code](https://code.visualstudio.com/docs/agent-customization/agent-skills) en
Claude Code lezen allebei de map `.claude/skills/`, dus één kopie werkt in beide.

```text
/adr-schrijven Bicep of Terraform voor de landing zone
/adr-schrijven review oefening/decisions/0001-gebruik-een-log-analytics-workspace-per-omgeving.md
```

De skill gebruikt `scripts/nieuwe-adr.sh` en `templates/madr.md` als die er zijn, en heeft één harde regel:
**verzin nooit het waarom.** Wat de agent niet weet, vraagt hij of zet hij neer als `TODO: navragen`.
De status blijft altijd _voorgesteld_: het team accepteert, in de pull request.

Naar je eigen repo: kopieer `.claude/skills/adr-schrijven/`, `scripts/` en `templates/`.
Wil je dat agents zich ook aan geaccepteerde ADR's houden, zet dan in `AGENTS.md` of
`.github/copilot-instructions.md` iets als: _lees `docs/decisions/` voordat je infrastructuur wijzigt,
en stel een nieuwe ADR voor als je van een geaccepteerde beslissing afwijkt._

De ADR-repository levert zelf twee skills in
[`skills/`](https://github.com/architecture-decision-record/architecture-decision-record/tree/main/skills):
`architecture-decision-record-skill` is algemeen (bepaalt of iets een ADR verdient, zet een `adr/`- of
`decisions/`-map op, kiest uit elf templates), en `architecture-decision-record-maintainer-skill` is alleen
voor wie aan die repository zelf werkt. Installeren gaat hetzelfde: kopieer de map naar `.claude/skills/` in
je repo, of naar `~/.claude/skills/` voor al je projecten. Kies per team één skill, anders krijg je twee formaten.

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
