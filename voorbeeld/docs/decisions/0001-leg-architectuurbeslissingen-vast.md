# 1. Leg architectuurbeslissingen vast

Datum: 2025-09-01

## Status

Geaccepteerd

## Context

Het platformteam beheert de landing zones, de clusters en de pipelines voor zes productteams.
Bij elke nieuwe collega en bij elke audit komt dezelfde vraag terug: waarom is dit zo gebouwd?
Het antwoord zit in het hoofd van twee mensen, in oude Teams-threads en in tickets die niemand meer terugvindt.
Twee keer dit jaar is een discussie opnieuw gevoerd die al eens beslecht was.

## Beslissing

We leggen elke architectonisch significante beslissing vast als een Architecture Decision Record (ADR),
in de map `docs/decisions` van de repository waar de beslissing over gaat.

We gebruiken het MADR-template uit `templates/madr.md`. Een ADR komt binnen via een pull request
met status _voorgesteld_ en wordt _geaccepteerd_ als de pull request wordt gemerged.

Een beslissing is significant als ze de structuur raakt, een kwaliteitseigenschap
(beveiliging, kosten, beschikbaarheid, prestaties) beïnvloedt, of moeilijk terug te draaien is.

## Gevolgen

- Nieuwe collega's lezen het logboek als onderdeel van hun onboarding.
- Een beslissing die geaccepteerd is, passen we niet meer aan. Verandert de beslissing, dan schrijven we een nieuwe ADR die de oude vervangt.
- Aanvullingen die de beslissing zelf niet veranderen (een nieuwe prijs, een lesson learned) mogen erbij, met datum.
- Iedereen in het team mag een ADR voorstellen, ook juniors. Het platformteam reviewt binnen een week.
- Het kost tijd: reken op een uur voor een gemiddelde ADR. Dat is minder dan één heropende discussie.
