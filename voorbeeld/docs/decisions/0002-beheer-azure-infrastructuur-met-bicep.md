---
status: geaccepteerd
date: 2025-09-15
decision-makers: platformteam
consulted: security officer, twee productteams
informed: alle productteams
---

# Beheer Azure-infrastructuur met Bicep

## Context en probleemstelling

Een deel van de infrastructuur is met de hand in de portal gemaakt, een deel met ARM-templates
en een deel met losse scripts. Omgevingen lopen uit elkaar en niemand kan precies zeggen
wat er in productie staat. We willen één manier om infrastructuur als code te beheren.

## Beslisfactoren

- We draaien alleen op Azure, en dat blijft de komende jaren zo
- Nieuwe Azure-resources moeten direct bruikbaar zijn, zonder te wachten op een provider
- Het team heeft geen ervaring met het beheren van state-bestanden
- De pipelines draaien al in Azure DevOps

## Overwogen opties

- Bicep
- Terraform met de AzureRM-provider
- ARM-templates blijven gebruiken

## Beslissing

Gekozen: **Bicep**, omdat we alleen op Azure draaien, het geen state-bestand nodig heeft
en nieuwe resource-types er meteen in beschikbaar zijn.

Zekerheid: middel. Gaan we multi-cloud, of willen productteams hun eigen niet-Azure-resources
in dezelfde code beheren, dan is deze beslissing het herzien waard.

### Gevolgen

- Goed, omdat Azure zelf de bron van waarheid is: geen state om kwijt te raken of te locken
- Goed, omdat het team de syntax binnen een week oppakte
- Slecht, omdat we vastzitten aan Azure: niets voor DNS bij een externe partij of voor GitHub-instellingen
- Slecht, omdat `what-if` minder betrouwbaar is dan een Terraform-plan
- Vervolg: modules delen we via een private Bicep-registry (ADR volgt)

### Bevestiging

Een Azure Policy weigert resources zonder de tag `managed-by: bicep` in de productie-subscriptions.

## Voor- en nadelen van de opties

### Bicep

- Goed, omdat het native Azure is, met support vanaf dag één voor nieuwe resources
- Goed, omdat er geen state-bestand is
- Slecht, omdat het alleen Azure ondersteunt

### Terraform met de AzureRM-provider

- Goed, omdat het multi-cloud is en een groot ecosysteem heeft
- Goed, omdat `terraform plan` een betrouwbare voorvertoning geeft
- Slecht, omdat we een state-bestand moeten beheren, beveiligen en locken
- Slecht, omdat de licentie sinds 2023 de BSL is; voor ons gebruik geen probleem, wel iets om te volgen

### ARM-templates blijven gebruiken

- Goed, omdat er niets hoeft te veranderen
- Slecht, omdat ARM-JSON slecht leesbaar is en niemand er graag in werkt

## Meer informatie

Aanvulling 2026-03-02: na een half jaar hebben alle zes de productteams hun infrastructuur
in Bicep staan. De `what-if`-problemen zijn in de praktijk kleiner dan verwacht.
De beslissing zelf blijft ongewijzigd.
