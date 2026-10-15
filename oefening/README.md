# Oefening: schrijf er samen één

Twintig minuten, in groepjes van twee of drie. Meng de niveaus: de meest junior persoon in het groepje typt.
Wie het meeste weet, stelt vragen in plaats van het antwoord te dicteren.

| Tijd   | Wat                                                               |
| ------ | ----------------------------------------------------------------- |
| 3 min  | Kies een scenario hieronder, of een echte beslissing uit je werk  |
| 12 min | Schrijf de ADR met `make adr TITEL="..."` of kopieer een template |
| 5 min  | Wissel met een ander groepje en review met de checklist onderaan  |

```bash
make adr TITEL="Gebruik één Log Analytics-workspace per omgeving"
# -> oefening/decisions/0001-gebruik-een-log-analytics-workspace-per-omgeving.md
```

Geen terminal bij de hand? Kopieer [`templates/madr.md`](../templates/madr.md) of, als je weinig tijd hebt,
[`templates/y-statement.md`](../templates/y-statement.md).

Er is geen goed antwoord. Een ADR voor de optie die jij níet zou kiezen is net zo goed, zolang het waarom erin staat.

---

## Scenario 1 — Waar gaan de logs heen?

Zes productteams sturen hun logs nu elk naar een eigen Log Analytics-workspace, aangemaakt wanneer het team dat nodig vond.
Bij een storing die over twee teams heen gaat, moet iemand in twee workspaces tegelijk zoeken.
De security officer wil alle sign-in- en auditlogs op één plek. FinOps wil per team kunnen zien wat logging kost.

Mogelijke opties: één centrale workspace, een workspace per team, een workspace per omgeving.

## Scenario 2 — Wie is de baas over de pipelines?

Elk team heeft eigen YAML-pipelines in Azure DevOps. Drie teams hebben de securityscan uitgezet omdat hij traag was.
Het platformteam wil een paar stappen verplicht maken, maar teams willen zelf kunnen blijven bouwen en testen zoals zij willen.

Mogelijke opties: centrale templates met `extends` die verplicht zijn, centrale templates die optioneel zijn,
een controle achteraf in plaats van vooraf.

## Scenario 3 — Mag een PaaS-dienst aan het internet?

Storage accounts, SQL-databases en Key Vaults hebben nu een publiek endpoint met firewallregels.
Een pentest heeft dat als risico gemeld. Private endpoints kosten geld per stuk en vragen om private DNS-zones,
en twee teams gebruiken een SaaS-tool die van buitenaf op hun storage moet kunnen.

Mogelijke opties: private endpoints overal verplicht, private endpoints alleen in productie,
service endpoints en firewallregels houden.

## Scenario 4 — Eén registry of meer?

Er is één Azure Container Registry voor ontwikkeling, test en productie. Elke pipeline kan erin pushen.
Een ontwikkelaar heeft per ongeluk een tag in productie overschreven.

Mogelijke opties: een registry per omgeving met promotie van images, één registry met
repository-permissies, productietags vergrendelen in de bestaande registry.

## Scenario 5 — Achteraf vastleggen (voor de senioren)

Kies een beslissing in je eigen team die al genomen is en waar niemand meer precies van weet waarom.
Schrijf de ADR alsof je hem toen had geschreven. Wat weet je niet meer? Zet dat er eerlijk bij,
en geef de beslissing de zekerheid die je er nu aan zou geven.

Dit is de oefening met de meeste waarde: je eindigt met de eerste echte ADR voor je eigen logboek.

---

## Reviewchecklist

Lees de ADR van het andere groepje en beantwoord deze zes vragen. Een "nee" is geen afkeuring, het is een vraag om te stellen.

1. Kun je na één minuut lezen zeggen **wat** er besloten is?
2. Staat er **waarom**, met de beslisfactoren die de doorslag gaven?
3. Zijn er minstens **twee opties**, en is de afgewezen optie eerlijk beschreven?
4. Staat er minstens **één nadeel** bij de gevolgen?
5. Gaat het over **één beslissing**, en niet over drie tegelijk?
6. Staan er een **status**, een **datum** en een **zekerheid** in?
