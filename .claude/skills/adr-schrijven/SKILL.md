---
name: adr-schrijven
description: Schrijf, review of vervang een Architecture Decision Record (ADR) in het MADR-formaat van dit team. Gebruik bij "schrijf een ADR", "leg deze beslissing vast", "maak hier een ADR van", "review deze ADR", "vervang ADR-0003", of als een wijziging ingaat tegen een geaccepteerde ADR. Stelt vragen over het waarom in plaats van het te verzinnen.
argument-hint: de beslissing in een paar woorden, of het nummer van een ADR om te reviewen
---

# ADR schrijven

Je helpt een team een Architecture Decision Record (ADR) te schrijven: één beslissing, met de
context, de overwogen opties en de gevolgen. Het team beslist. Jij schrijft het concept.

## De belangrijkste regel

**Verzin nooit het waarom.** De code laat zien wát er gebouwd is, niet waarom. Redenen,
afgewezen opties, wie er besliste en hoe zeker het team is, moeten van een mens komen of
uit een bron die je kunt aanwijzen (een pull request, een issue, een notitie die de gebruiker plakt).

Weet je iets niet, vraag het dan. Krijg je geen antwoord, schrijf dan `TODO: navragen — <wat>`
op die plek. Een ADR met drie eerlijke TODO's is beter dan een ADR met een geraden reden:
een geraden waarom wordt gelezen en geloofd.

## 1. Is dit een ADR waard?

Een ADR als de beslissing ten minste één van deze dingen doet:

- de **structuur** van het systeem raakt
- een **kwaliteit** raakt: beveiliging, kosten, beschikbaarheid, prestaties
- **moeilijk terug te draaien** is

Geen ADR voor een naamgevingskeuze, een proof of concept, een tijdelijke noodfix, of iets wat al
in een standaard of Azure Policy staat. Zeg dat dan in één zin en stop.

## 2. Verzamel de context

Lees eerst wat er al is:

- bestaande ADR's in de map (zie stap 3), zodat je niet tegen een geaccepteerde beslissing in schrijft
  en kunt verwijzen naar gerelateerde ADR's
- de code, pipelines of infrastructuur waar de beslissing over gaat
- wat de gebruiker meegeeft: een PR-discussie, een issue, notities uit een overleg

Stel daarna **in één keer** de vragen die je nog niet kunt beantwoorden. Meestal zijn dat:

1. Welk probleem lossen we op, en waarom nu?
2. Welke opties zijn er overwogen, en waarom vielen de andere af?
3. Wat gaf de doorslag (de beslisfactoren)?
4. Wat is de prijs: wat wordt er moeilijker?
5. Wie beslist, wie is geraadpleegd?
6. Hoe zeker is het team: hoog, middel of laag?

Je mag zelf extra opties of nadelen voorstellen die het team mogelijk vergat. Zet ze dan als
voorstel in je antwoord, niet stilletjes in de ADR, en laat de gebruiker kiezen.

## 3. Maak het bestand

Zoek de bestaande map: `docs/decisions/`, `decisions/`, `adr/` of (in de workshop-repo)
`oefening/decisions/`. Volg de nummering en naamgeving die er al is. Is er nog geen map,
gebruik dan `docs/decisions/`.

Bestaat `scripts/nieuwe-adr.sh`, gebruik dat. Het kiest het volgende nummer, maakt de
bestandsnaam en vult het template in:

```bash
scripts/nieuwe-adr.sh "Beheer Azure-infrastructuur met Bicep" docs/decisions madr
```

Zonder script: `NNNN-titel-met-streepjes.md`, het volgende vrije nummer met vier cijfers,
de titel in kleine letters, in de **gebiedende wijs** ("Beheer ...", "Gebruik ...", "Draai ...").
Neem de structuur over uit `templates/madr.md` als dat bestand bestaat.

## 4. Vul het in

Het MADR-formaat van dit team, in deze volgorde:

- frontmatter: `status`, `date`, `decision-makers`, `consulted`, `informed`
- `# Titel` in de gebiedende wijs
- `## Context en probleemstelling` — de situatie zoals die nú is, twee tot vijf zinnen
- `## Beslisfactoren`
- `## Overwogen opties` — minstens twee
- `## Beslissing` — "Gekozen: **optie**, omdat ...", plus een regel `Zekerheid: hoog | middel | laag`
- `### Gevolgen` — minstens één "Slecht, omdat ...". Elke keuze heeft een prijs
- `### Bevestiging` — hoe controleren we dat het wordt nageleefd (een review, een Azure Policy, een pipeline-check)
- `## Voor- en nadelen van de opties`
- `## Meer informatie` — links naar de PR, het onderzoek, gerelateerde ADR's

Schrijfregels:

- Eén beslissing per ADR. Gaat het over drie dingen, stel drie ADR's voor
- Kort, stellig en feitelijk. Geen ontwerpdocument: link ernaar
- Dateer alles wat verandert: prijzen, aantallen, planning
- Schrijf in de taal van de bestaande ADR's

**De status is altijd `voorgesteld`.** Zet nooit zelf `geaccepteerd`: dat gebeurt als het team
de pull request goedkeurt.

## 5. Een beslissing vervangen

Pas de inhoud van een geaccepteerde ADR nooit aan. Verandert de beslissing:

1. Schrijf een nieuwe ADR, met bovenaan `Vervangt [ADR-NNNN](NNNN-oude-titel.md).`
2. Verander in de oude ADR **alleen** de status naar `vervangen door [ADR-MMMM](MMMM-nieuwe-titel.md)`

Een aanvulling die de beslissing niet verandert (een nieuwe prijs, een ervaring na een maand)
mag onder `## Meer informatie`, met de datum ervoor.

## 6. Review voordat je oplevert

Loop deze zes vragen langs en noem in je antwoord wat nog niet klopt:

1. Is na één minuut lezen duidelijk **wat** er besloten is?
2. Staat er **waarom**, met de beslisfactoren?
3. Zijn er minstens **twee opties**, en is de afgewezen optie eerlijk beschreven?
4. Staat er minstens **één nadeel** bij de gevolgen?
5. Gaat het over **één beslissing**?
6. Staan er een **status**, **datum** en **zekerheid** in?

Met dezelfde zes vragen review je een ADR die iemand anders schreef.

Bestaat er een overzicht (`README.md` in de map, gemaakt met `scripts/adr-index.sh`),
werk het dan bij met `scripts/adr-index.sh <map> > <map>/README.md`.

## 7. Als een wijziging ingaat tegen een ADR

Vraagt de gebruiker iets wat botst met een geaccepteerde ADR (bijvoorbeeld Terraform terwijl
er een ADR voor Bicep ligt), zeg dat dan, met een link naar die ADR. Bouw het niet stilletjes
toch. Stel voor om een nieuwe ADR te schrijven die de oude vervangt, als de situatie veranderd is.
