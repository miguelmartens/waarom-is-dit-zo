---
marp: true
theme: default
paginate: true
html: true
title: Waarom is dit zo gebouwd?
description: Een introductie tot Architecture Decision Records
author: Miguel Martens
---

<style>
:root {
  --ink: #1B2027;
  --ink2: #2B333D;
  --soft: #F1F3F5;
  --muted: #5C6672;
  --muted-d: #9AA6B2;
  --light: #D7DDE4;
  --green: #1FA97A;
  --amber: #D98C1F;
  --red: #C4364C;
  /* lichtere varianten, alleen voor tekst op een donkere achtergrond */
  --green-l: #6FD9AE;
  --amber-l: #F0B45C;
}

section {
  font-family: "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  font-size: 24px;
  color: var(--ink);
  background: #FFFFFF;
  padding: 60px 70px;
}

h1 {
  font-family: Georgia, "Times New Roman", serif;
  font-size: 52px;
  margin: 0 0 6px 0;
  color: var(--ink);
}

h2 {
  font-family: Georgia, "Times New Roman", serif;
  font-size: 30px;
  margin: 0 0 10px 0;
}

/* de ondertitel onder elke H1 */
h1 + p em {
  display: block;
  font-style: normal;
  font-weight: 600;
  font-size: 16px;
  letter-spacing: 2px;
  text-transform: uppercase;
  color: var(--muted);
  margin-bottom: 28px;
}

code { font-size: 0.85em; }

pre {
  background: var(--ink2);
  border-radius: 10px;
  padding: 20px 24px;
  font-size: 20px;
  line-height: 1.45;
}
pre code { color: var(--light); background: none; }

/* Syntaxkleuring. Marp levert de GitHub-kleuren voor een lichte achtergrond,
   en dat donkerblauw valt weg tegen het codeblok. Hieronder dezelfde
   rolverdeling in de kleuren van deze deck: wit voor de structuur, groen voor
   de waarde, amber voor het sleutelwoord. In markdown betekent dat: koppen
   wit, lijstjes amber, links groen. */
pre {
  --color-prettylights-syntax-storage-modifier-import: var(--light);
  --color-prettylights-syntax-comment: var(--muted-d);
  --color-prettylights-syntax-constant: #FFFFFF;
  --color-prettylights-syntax-entity: #FFFFFF;
  --color-prettylights-syntax-markup-heading: #FFFFFF;
  --color-prettylights-syntax-markup-bold: #FFFFFF;
  --color-prettylights-syntax-markup-italic: var(--light);
  --color-prettylights-syntax-string: var(--green-l);
  --color-prettylights-syntax-string-regexp: var(--green-l);
  --color-prettylights-syntax-entity-tag: var(--green-l);
  --color-prettylights-syntax-constant-other-reference-link: var(--green-l);
  --color-prettylights-syntax-keyword: var(--amber-l);
  --color-prettylights-syntax-variable: var(--amber-l);
  --color-prettylights-syntax-markup-list: var(--amber-l);
}

/* kolommen */
.cols  { display: grid; grid-template-columns: 1fr 1fr; gap: 26px; }
.cols3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 22px; }
.cols-wide { display: grid; grid-template-columns: 3fr 2fr; gap: 26px; }

.card {
  background: var(--soft);
  border-radius: 10px;
  padding: 24px 26px;
  font-size: 21px;
}
.card h2 { font-size: 26px; }
.card.dark { background: var(--ink2); color: var(--light); }
.card.dark h2 { color: #FFFFFF; }
.card ul, .card ol { margin: 0; padding-left: 22px; }
.card li { margin-bottom: 10px; }
.card p { color: var(--muted); }
.card.dark p, .card.dark li { color: var(--light); }
.card.dark strong { color: #FFFFFF; }

.badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px; height: 38px;
  border-radius: 50%;
  color: #fff; font-weight: 700; font-size: 19px;
  margin-right: 12px;
  vertical-align: middle;
}
/* De drie kleuren van deze deck: context, beslissing, gevolgen. */
.ctx { background: var(--amber); }
.bes { background: var(--green); }
.gev { background: var(--red); }
.n   { background: var(--ink); }

.note {
  font-style: italic;
  color: var(--muted);
  font-size: 21px;
  margin-top: 26px;
}

.rows { display: grid; gap: 12px; }
.row {
  background: var(--soft);
  border-radius: 10px;
  padding: 16px 22px;
  font-size: 21px;
  display: grid;
  grid-template-columns: 46px 1fr;
  align-items: center;
}
.row.wide { grid-template-columns: 46px 1fr 1fr; gap: 16px; }
.row .dim { color: var(--muted); font-size: 19px; }

/* een rij statussen met pijltjes ertussen */
.flow { display: flex; align-items: center; flex-wrap: wrap; gap: 10px; margin: 6px 0 14px 0; }
.pill {
  border-radius: 999px;
  padding: 6px 16px;
  font-size: 18px;
  font-weight: 600;
  color: #FFFFFF;
}
.pill.ctx { background: var(--amber); }
.pill.bes { background: var(--green); }
.pill.gev { background: var(--red); }
.pill.n   { background: var(--muted); }
.flow .arrow { color: var(--muted); font-size: 20px; }

/* donkere slides */
section.dark {
  background: var(--ink);
  color: #FFFFFF;
}
section.dark h1, section.dark h2 { color: #FFFFFF; }
section.dark h1 + p em { color: var(--amber); }
section.dark .note { color: var(--muted-d); }
section.dark .row { background: var(--ink2); color: var(--light); }
section.dark .row strong { color: #FFFFFF; }
section.dark .row .dim { color: var(--muted-d); }

/* titelslide */
section.title { background: var(--ink); color: #FFFFFF; justify-content: center; }
section.title h1 { color: #FFFFFF; font-size: 68px; }
section.title .sub { font-style: italic; font-size: 30px; color: var(--light); margin-top: 4px; }
section.title .legend { margin-top: 46px; font-size: 22px; color: var(--light); }
section.title .legend span.badge { margin-left: 34px; }
section.title .legend span.badge:first-child { margin-left: 0; }
section.title .who { margin-top: 70px; font-size: 19px; color: var(--muted-d); }

/* slotslide met de repo-link */
section.title .repo { margin-top: 46px; font-size: 26px; }
section.title .repo a {
  color: #FFFFFF;
  text-decoration: none;
  border-bottom: 2px solid var(--amber);
  padding-bottom: 4px;
}

/* De voorbeeld-ADR: twee kolommen markdown die doorlopen. Alleen op deze slide
   krimpt de code en levert de kop wat hoogte in, zodat de hele ADR in beeld
   blijft in plaats van onderaan af te lopen. */
section.manifest h1 { font-size: 42px; }
section.manifest h1 + p em { margin-bottom: 14px; }
section.manifest pre {
  font-size: 15px;
  line-height: 1.32;
  padding: 14px 18px;
  white-space: pre-wrap;
}

/* een codeblok direct onder kaarten krijgt lucht */
.cols + pre, .cols3 + pre { margin-top: 22px; }

/* vijf rijen met twee regels tekst: iets compacter */
section.tight .rows { gap: 9px; }
section.tight .row { padding: 12px 22px; }
section.tight h1 + p em { margin-bottom: 20px; }

/* links op de leeslijst */
section.links .row a { color: var(--ink); text-decoration: none; border-bottom: 2px solid var(--amber); }

section.title::after, section.dark::after { color: var(--muted-d); }
</style>

<!-- _class: title -->
<!-- _paginate: false -->

# Waarom is dit zo gebouwd?

<div class="sub">Een introductie tot Architecture Decision Records</div>

<div class="legend">
<span class="badge ctx">C</span> context
<span class="badge bes">B</span> beslissing
<span class="badge gev">G</span> gevolgen
</div>

<div class="who">Miguel Martens</div>

<!--
Openingsvraag: wie heeft ooit naar een stuk infrastructuur gekeken en gedacht
"waarom is dit zo gebouwd"? Alle handen omhoog. Tweede vraag: wie kon het antwoord
ook vinden? Bijna alle handen gaan weer omlaag. Daar gaat deze sessie over.

De drie kleuren lopen door de hele presentatie: amber is context, groen is de
beslissing, rood zijn de gevolgen - de prijs die je betaalt.
-->

---

# Wat je na deze sessie weet

*Voor wie net begint én voor wie al jaren beslissingen neemt*

<div class="rows">
<div class="row"><span class="badge bes">✓</span> Wat een ADR is, en welk probleem het oplost</div>
<div class="row"><span class="badge bes">✓</span> Welke beslissingen een ADR verdienen, en welke niet</div>
<div class="row"><span class="badge bes">✓</span> Hoe je er een schrijft die over twee jaar nog iets zegt</div>
<div class="row"><span class="badge bes">✓</span> Hoe het past in je repo, je pull requests en je team</div>
</div>

<div class="note">En daarna schrijven we er samen één. Dat is het leukste deel.</div>

<!--
Zet de verwachting: dit is een introductie. Geen voorkennis nodig.
Voor de senioren in de zaal: de laatste slides voor de oefening gaan over
afdwingen en afspraken in het team - daar zit voor jullie het meeste in.
-->

---

# De code vertelt wat, niet waarom

*Het probleem dat ADR's oplossen*

<div class="cols">
<div class="card">

## Wat je wel kunt terugvinden

Wie het veranderde, en wanneer. Meer niet.

```console
$ git blame network.bicep
a3f9c21 (Sanne 2024-03-11)
  publicNetworkAccess: 'Disabled'
```

</div>
<div class="card dark">

## Wat er ontbreekt

- Waarom is dit zo gekozen?
- Wat is er nog meer overwogen, en waarom viel dat af?
- Hoe zag de situatie er toen uit?
- Geldt dat nu nog steeds?

</div>
</div>

<div class="note">Het waarom zit in iemands hoofd, een Teams-thread of een vergaderverslag. En mensen wisselen van team.</div>

<!--
Dit is de kernboodschap van de hele sessie. Neem er de tijd voor;
een eigen praktijkverhaal werkt hier goed.

Commitberichten helpen een beetje, maar die gaan over een wijziging, niet over
een beslissing. Een beslissing raakt vaak tien commits in vijf repo's.
-->

---

# Wat kost een vergeten beslissing?

*Drie situaties die je vast herkent*

<div class="cols3">
<div class="card">
<span class="badge n">1</span>

## De discussie komt terug

Een half jaar later voert een ander team dezelfde discussie. Zelfde argumenten, misschien een andere uitkomst.

</div>
<div class="card">
<span class="badge n">2</span>

## Iemand draait het terug

Een collega ziet een vreemde instelling, ruimt hem op, en haalt zo de oplossing voor een oud incident weg.

</div>
<div class="card">
<span class="badge n">3</span>

## De auditor vraagt ernaar

"Waarom staat dit zo?" Iedereen kijkt naar de enige collega die er toen bij was.

</div>
</div>

<div class="note">Microsoft zegt het droog: een beslissing die niet is vastgelegd, wordt vergeten.</div>

<!--
Situatie 2 heet ook wel het hek van Chesterton: haal een hek pas weg als je weet
waarom het er staat. Een ADR is het bordje op het hek.

Bron: de Azure Well-Architected-pagina over ADR's noemt precies deze twee
gevolgen - herhaalde discussies, en wijzigingen die onbewust tegen de
oorspronkelijke bedoeling ingaan.
-->

---

# Wat is een ADR?

*Een Architecture Decision Record*

<div class="cols-wide">
<div>

Eén beslissing, met het **waarom** erbij, in één kort document dat naast je code staat.

Niet meer dan één of twee pagina's. Geen ontwerpdocument, geen wiki, geen formulier.

Alle ADR's samen vormen het **beslissingenlogboek** van je team: de geschiedenis van hoe je platform zijn vorm kreeg.

</div>
<div class="card">

## De woorden eromheen

- **AD** — de beslissing zelf
- **ADR** — het document dat één AD vastlegt
- **Logboek** (ADL) — alle ADR's van een project
- **ASR** — een eis die je architectuur meetbaar raakt
- **AKM** — het hele vakgebied

</div>
</div>

<div class="note">Onthoud er twee: ADR en logboek. De rest is voor als je verder gaat lezen.</div>

<!--
Microsoft noemt het ADR een van de belangrijkste deliverables van een architect:
de architectuur ís de optelsom van de beslissingen.

Sommige teams noemen de map gewoon "decisions" in plaats van "adr". Dat werkt:
het woord "architectuur" schrikt mensen soms af, en ook een niet-architect neemt
beslissingen die het opschrijven waard zijn.
-->

---

# Context, beslissing, gevolgen

*Het template van Michael Nygard uit 2011, nog steeds de basis*

<div class="cols3">
<div class="card">
<span class="badge ctx">C</span> <strong>Context</strong>

*"Wat speelt er?"*

De situatie zoals die nú is. Eisen, beperkingen, budget, het team. Neutraal opgeschreven: dit zijn de feiten.

</div>
<div class="card">
<span class="badge bes">B</span> <strong>Beslissing</strong>

*"Wat gaan we doen?"*

Actief en in volzinnen. "We gaan..." Eén beslissing, geen lijstje.

</div>
<div class="card">
<span class="badge gev">G</span> <strong>Gevolgen</strong>

*"Wat kost het ons?"*

Wat er makkelijker wordt, en wat er moeilijker wordt. Allebei. Ook wat je liever niet opschrijft.

</div>
</div>

<div class="note">Plus een titel en een status. Meer heb je niet nodig om te beginnen.</div>

<!--
Nygards blogpost "Documenting Architecture Decisions" uit 2011 is waar het
begon. Vijf koppen: titel, status, context, beslissing, gevolgen.

Benadruk de context: over twee jaar is de situatie anders. Dan moet je kunnen
lezen hoe het toen was, om te beoordelen of de beslissing nog klopt.
-->

---

# Wanneer schrijf je er een?

*Microsoft houdt het bij drie vragen*

<div class="cols3">
<div class="card dark">

## Raakt het...

1. de **structuur** van het systeem?
2. een **kwaliteit**: beveiliging, kosten, beschikbaarheid, prestaties?
3. iets wat **moeilijk terug te draaien** is?

</div>
<div class="card">

<h2><span class="badge bes">✓</span> Wel</h2>

- Bicep of Terraform
- AKS of Container Apps
- Hub-spoke of Virtual WAN
- Een Key Vault per omgeving of één centrale

</div>
<div class="card">

<h2><span class="badge gev">✕</span> Niet</h2>

- De naam van een resourcegroep
- Een proof of concept
- De noodfix van drie uur 's nachts
- Wat al in een standaard of policy staat

</div>
</div>

<div class="note">Vuistregel: als een nieuwe collega er over een jaar "waarom?" bij zou vragen, schrijf je hem.</div>

<!--
Eén ja is genoeg. Twijfel? Schrijf hem: een overbodige ADR kost een half uur,
een ontbrekende kost een heropende discussie.

De noodfix is een goede discussievraag: niet tijdens de storing, maar als de fix
blijft staan, is dat een beslissing geworden. Dan alsnog.
-->

---

<!-- _class: manifest -->

# Een ADR in het echt

*Uit het voorbeeld-logboek in de repo, in het MADR-formaat*

<div class="cols">
<div>

```markdown
---
status: geaccepteerd
date: 2025-09-15
decision-makers: platformteam
---

# Beheer Azure-infrastructuur met Bicep

## Context en probleemstelling

Infrastructuur komt uit de portal, uit ARM en uit
losse scripts. Omgevingen lopen uit elkaar.

## Beslisfactoren

- We draaien alleen op Azure
- Nieuwe resources direct bruikbaar
- Geen ervaring met state-bestanden

## Overwogen opties

- Bicep
- Terraform met de AzureRM-provider
- ARM-templates blijven gebruiken
```

</div>
<div>

```markdown
## Beslissing

Gekozen: **Bicep**, omdat we alleen op Azure
draaien, het geen state-bestand nodig heeft en
nieuwe resource-types er meteen in zitten.

Zekerheid: middel. Gaan we multi-cloud, dan is
deze beslissing het herzien waard.

### Gevolgen

- Goed, omdat Azure zelf de bron van waarheid is
- Goed, omdat het team het binnen een week oppakte
- Slecht, omdat we vastzitten aan Azure
- Slecht, omdat what-if minder betrouwbaar is
  dan een Terraform-plan

### Bevestiging

Een Azure Policy weigert resources zonder de tag
managed-by: bicep in productie.
```

</div>
</div>

<!--
Loop hem van boven naar beneden door en wijs de C, B en G aan: context en
beslisfactoren zijn amber, de beslissing groen, de gevolgen rood.

Let op twee dingen die in Nygard niet staan: de zekerheid, en de bevestiging.
Die komen op de volgende slides terug.

Niet besproken op de slide: de volledige versie in de repo heeft ook per optie
de voor- en nadelen en een gedateerde aanvulling van een half jaar later.
-->

---

# De opties die je níet koos

*Het halve verhaal, en het deel dat het eerst verdwijnt*

<div class="cols">
<div class="card">

## Waarom ze erin moeten

Over een jaar stelt iemand voor om naar Terraform te gaan.

Staat er al waarom dat toen afviel, dan duurt die discussie vijf minuten: is de situatie veranderd, ja of nee?

Staat er niets, dan begint hij opnieuw.

</div>
<div class="card dark">

## En schrijf je zekerheid op

Microsoft raadt aan om bij elke beslissing aan te geven hoe zeker je bent.

- **Hoog** — getest, gemeten, ervaring mee
- **Middel** — goed onderbouwd, maar aannames
- **Laag** — beste gok nu. Kijk er snel opnieuw naar

Bij laag: schrijf op wat je van gedachten zou laten veranderen.

</div>
</div>

<div class="note">Een ADR met maar één optie is geen beslissing. Het is een aankondiging.</div>

<!--
Dit is het verschil tussen een ADR en een mededeling. Vraag de zaal: wie heeft
een "beslissing" gezien waar maar één optie in stond?

Lage zekerheid opschrijven voelt als zwakte, maar het is precies andersom: het
geeft je opvolger toestemming om ernaar terug te kijken.
-->

---

# Wat maakt een ADR goed?

*Vier eigenschappen uit de ADR-repository*

<div class="rows">
<div class="row"><span class="badge ctx">1</span><div><strong>Onderbouwd</strong><br><span class="dim">Het waarom staat erin: de context, de opties, de voor- en nadelen. Zonder dat kan niemand later beoordelen of het nog klopt.</span></div></div>
<div class="row"><span class="badge bes">2</span><div><strong>Specifiek</strong><br><span class="dim">Eén beslissing per ADR. Gaat het over drie dingen, dan zijn het drie ADR's.</span></div></div>
<div class="row"><span class="badge n">3</span><div><strong>Gedateerd</strong><br><span class="dim">Vooral bij wat verandert: prijzen, planning, schaal. "Goedkoper" is waar tot de volgende prijswijziging.</span></div></div>
<div class="row"><span class="badge gev">4</span><div><strong>Onveranderlijk</strong><br><span class="dim">Een geaccepteerde beslissing pas je niet aan. Verandert ze, dan schrijf je een nieuwe.</span></div></div>
</div>

<div class="note">Microsoft voegt toe: kort, stellig, to the point. Een ADR is geen ontwerpdocument — link ernaar.</div>

<!--
Microsoft adviseert ook om beslissingen die in fases verlopen (kort, middellang,
lang) als losse ADR's vast te leggen. Dat is eigenschap 2 in de praktijk.

Eigenschap 4 zorgt voor de meeste discussie. Die gaan we nu voeren.
-->

---

# Een logboek, geen wiki

*Wat je doet als een beslissing verandert*

<div class="flow">
<span class="pill ctx">voorgesteld</span><span class="arrow">→</span>
<span class="pill bes">geaccepteerd</span><span class="arrow">→</span>
<span class="pill gev">vervangen door …</span>
<span class="arrow">&nbsp;&nbsp;of&nbsp;&nbsp;</span>
<span class="pill n">afgewezen</span>
<span class="pill n">afgeschaft</span>
</div>

<div class="cols">
<div>

```yaml
# 0003-draai-alle-workloads-op-een-gedeeld-aks-cluster.md
status: vervangen door ADR-0005

# 0005-draai-stateless-apis-op-azure-container-apps.md
status: geaccepteerd
# "Vervangt ADR-0003" bovenaan de tekst
```

</div>
<div class="card">

## Aanvullen mag wel

Een nieuwe prijs, een lesson learned, een update na een maand: zet het eronder, **met datum**.

De beslissing zelf verandert niet. Dan is het een nieuwe ADR.

</div>
</div>

<div class="note">Zo zie je niet alleen waar je staat, maar ook hoe je er gekomen bent.</div>

<!--
Microsoft is hier streng: append-only, nooit een geaccepteerde ADR aanpassen,
vervangen en de twee aan elkaar linken.

De ADR-repository is milder: in de praktijk werken "levende documenten" beter,
met gedateerde aanvullingen. Die twee bijten elkaar niet - de beslissing is
onveranderlijk, de aantekeningen eronder groeien. Seniors brengen dit bijna
altijd in; dit is het antwoord.

Kijk in het voorbeeld-logboek: 0003 is vervangen door 0005, en 0002 heeft een
gedateerde aanvulling.
-->

---

# Welk template?

*Er zijn er meer dan tien. Kies er één en blijf erbij.*

<div class="cols3">
<div class="card">

## Nygard

Vijf koppen: titel, status, context, beslissing, gevolgen.

Simpel en populair. Prima om mee te beginnen.

</div>
<div class="card dark">

## MADR 4.0

Opties en hun voor- en nadelen staan centraal. Frontmatter met status, datum en wie er besliste.

**Het template in deze repo.**

</div>
<div class="card">

## Y-statement

De hele beslissing in één zin:

*In de context van ..., geconfronteerd met ..., kozen we voor ... en niet voor ..., om ... te bereiken, en accepteren we ...*

</div>
</div>

<div class="note">Microsoft schrijft geen template voor, alleen dat je er consequent één gebruikt.</div>

<!--
MADR staat voor Markdown Architectural Decision Records - tegenwoordig ook
"Markdown Any Decision Records", omdat het ook voor niet-architectuurbeslissingen
werkt. Versie 4.0 is van september 2024.

Het Y-statement komt van Olaf Zimmermann. Handig voor kleinere beslissingen, of
als eerste versie die later uitgroeit tot een MADR.

Andere templates op de ADR-site: Tyree en Akerman (uitgebreid), arc42,
business case (met kosten en SWOT), Planguage. Voor een eerste keer niet nodig.
-->

---

# Waar laat je ze?

*Naast de code waar ze over gaan*

<div class="cols-wide">
<div>

```console
platform-landingzone/
├── infra/
│   └── main.bicep
├── pipelines/
└── docs/
    └── decisions/
        ├── README.md         ← het logboek
        ├── 0001-leg-architectuurbeslissingen-vast.md
        ├── 0002-beheer-azure-infrastructuur-met-bicep.md
        └── 0003-draai-alle-workloads-op-een-...md
```

</div>
<div class="card">

## Naamgeving

- Gebiedende wijs, net als je commits: *beheer*, *gebruik*, *bewaar*
- Kleine letters met streepjes, `.md`
- Een volgnummer ervoor houdt de volgorde vast
- In Azure DevOps: publiceer de map als wiki

</div>
</div>

<div class="note">Microsoft: bewaar het logboek open en bij de documentatie van de workload. Eén bron van waarheid.</div>

<!--
In de repo, niet in Confluence of SharePoint: dan reist het mee met de code,
wordt het gereviewd als code, en zit het in elke clone.

"Publish code as wiki" in Azure DevOps maakt van een map in een repo een
leesbare wiki, zonder dat je iets dubbel bijhoudt.

Het volgnummer is een MADR-conventie. De ADR-repository zelf gebruikt namen
zonder nummer (choose-database.md). Allebei prima - kies er één.
-->

---

# Een ADR is een pull request

*Het reviewproces heb je al*

<div class="cols3">
<div class="card"><span class="badge ctx">1</span>

**Voorstellen**
Een branch met de nieuwe ADR, status *voorgesteld*. Klein beginnen mag: een Y-statement is genoeg.

</div>
<div class="card"><span class="badge n">2</span>

**Bespreken**
Reviewers zijn wie beslist en wie je om advies vraagt. Koppel het work item uit Azure Boards. Spreek een termijn af, bijvoorbeeld een week.

</div>
<div class="card"><span class="badge bes">3</span>

**Besluiten**
Status naar *geaccepteerd* in de laatste commit, en mergen. Of *afgewezen* — ook dan mergen.

</div>
</div>

```console
$ make adr TITEL="Draai stateless API's op Azure Container Apps"
oefening/decisions/0001-draai-stateless-apis-op-azure-container-apps.md
```

<!--
De discussie in de pull request is het archief van hoe je tot de beslissing
kwam. De ADR is de samenvatting. Link vanuit de ADR naar de PR.

Een afgewezen voorstel ook mergen is niet raar: de volgende die hetzelfde wil
voorstellen, ziet waarom het toen niet doorging.
-->

---

# Van vastleggen naar bewaken

*Een beslissing legt vast, een controle dwingt af*

<div class="cols">
<div class="card">

## Je platform kan het al

- *Geen publieke endpoints* → een Azure Policy met `deny`
- *Alles via Bicep* → een policy die een tag verplicht
- *Centrale pipeline-templates* → een *required template*-check op je environments
- *Lagen in de code* → architectuurtests zoals ArchUnit of NetArchTest

</div>
<div class="card dark">

## Of laat de PR het vragen

**Decision Guardian** laat in een pull request zien welke ADR's horen bij de code die verandert.

**ADR Guard** laat een PR falen als bewaakte code verandert zonder dat er een ADR bij zit.

</div>
</div>

<div class="note">Dat heet een fitness function: een automatische controle dat een beslissing nog wordt nageleefd.</div>

<!--
Dit is de slide voor de senioren en architecten. In de korte versie overslaan.

Het MADR-template heeft hier een eigen kopje voor: "Bevestiging". Schrijf daar
op hoe je controleert dat de beslissing wordt nageleefd.

Waarschuw voor de valkuil: begin niet met de handhaving. Eerst moet het team
ADR's willen schrijven. Een guardrail op een leeg logboek beschermt niets.
-->

---

<!-- _class: dark tight -->

# Vijf valkuilen

*En de meeste zie je pas als het te laat is*

<div class="rows">
<div class="row"><span class="badge gev">✕</span><div><strong>Achteraf invullen om een vinkje te zetten</strong><br><span class="dim">Het waarom is dan al gereconstrueerd. Schrijf hem terwijl je beslist.</span></div></div>
<div class="row"><span class="badge gev">✕</span><div><strong>Maar één optie</strong><br><span class="dim">Dan is het een aankondiging. Wat viel er af, en waarom?</span></div></div>
<div class="row"><span class="badge gev">✕</span><div><strong>Alleen voordelen</strong><br><span class="dim">Gevolgen verstoppen, bewust of niet. Elke keuze heeft een prijs.</span></div></div>
<div class="row"><span class="badge gev">✕</span><div><strong>Een ontwerpdocument van tien pagina's</strong><br><span class="dim">Niemand leest het. Link naar het ontwerp; de ADR blijft één beslissing.</span></div></div>
<div class="row"><span class="badge gev">✕</span><div><strong>Een ADR die niet meer klopt</strong><br><span class="dim">De praktijk is veranderd, maar niemand schreef de vervanger. Dat is erger dan geen ADR.</span></div></div>
</div>

<!--
De eerste is de meest voorkomende, en de ADR-repository is er expliciet over:
ADR's als formaliteit achteraf hebben weinig waarde. Het gaat om het gesprek.

De laatste is de gevaarlijkste: een ADR die liegt, wordt gelezen en geloofd.
Daarom de terugblik na een maand - zie de volgende slide.
-->

---

# Spreek dit af met je team

*Vijf vragen. Leg de antwoorden vast in je allereerste ADR.*

<div class="rows">
<div class="row"><span class="badge n">1</span><div><strong>Wie mag een ADR schrijven?</strong> <span class="dim">— het beste antwoord: iedereen</span></div></div>
<div class="row"><span class="badge n">2</span><div><strong>Wanneer verdient iets een ADR, en wanneer niet?</strong></div></div>
<div class="row"><span class="badge n">3</span><div><strong>Wie beslist, en hoe?</strong> <span class="dim">— niemand, tenzij het in de ADR staat</span></div></div>
<div class="row"><span class="badge n">4</span><div><strong>Hoe lang staat een voorstel open?</strong></div></div>
<div class="row"><span class="badge n">5</span><div><strong>Wie kijkt er na een maand naar terug?</strong> <span class="dim">— klopte wat we verwachtten?</span></div></div>
</div>

<div class="note">In de repo staat zo'n eerste ADR als voorbeeld: 0001-leg-architectuurbeslissingen-vast.md</div>

<!--
Deze vragen komen uit de sectie "Teamwork questions" van de ADR-repository.

Vraag 3 is het belangrijkst voor platformteams: neemt het platformteam de
beslissing, de architect, of het productteam dat ermee moet leven? Geen goed
of fout antwoord, maar wel een antwoord.

De terugblik na een maand is wat een logboek levend houdt. Zet hem als taak op
het bord bij het accepteren van de ADR.
-->

---

# Wat kun jij morgen doen?

*Wat je ervaring ook is*

<div class="cols3">
<div class="card">

## Net begonnen

Lees het logboek van je team. Is er geen? Vraag bij de volgende "waarom" of er een ADR van is.

Jouw vraag is precies de reden dat ADR's bestaan.

</div>
<div class="card">

## Een paar jaar bezig

Schrijf de volgende beslissing op, in een pull request. Een Y-statement is genoeg om te beginnen.

Of leg er één vast die al genomen is.

</div>
<div class="card dark">

## Senior of architect

Maak het makkelijk: een template in de repo, snelle reviews, de eerste paar zelf schrijven.

Dwing het niet af met een formulier. Doe het voor.

</div>
</div>

<!--
Kijk de zaal rond en spreek de juniors direct aan: de vraag "waarom" stellen is
geen domme vraag, het is het begin van een ADR.

Voor de seniors: de grootste blokkade is niet het template, maar het gevoel dat
het extra werk is. Laat zien dat het een half uur kost.
-->

---

# Oefening: schrijf er samen één

*Twintig minuten, groepjes van twee of drie, de meest junior persoon typt*

<div class="rows">
<div class="row wide"><span class="badge ctx">1</span><strong>Waar gaan de logs heen?</strong><span class="dim">één Log Analytics-workspace of meer</span></div>
<div class="row wide"><span class="badge ctx">2</span><strong>Wie is de baas over de pipelines?</strong><span class="dim">verplichte templates of vrijheid</span></div>
<div class="row wide"><span class="badge ctx">3</span><strong>Mag een PaaS-dienst aan het internet?</strong><span class="dim">private endpoints of firewallregels</span></div>
<div class="row wide"><span class="badge ctx">4</span><strong>Eén registry of meer?</strong><span class="dim">per omgeving of één met rechten</span></div>
<div class="row wide"><span class="badge bes">5</span><strong>Achteraf vastleggen</strong><span class="dim">een echte beslissing uit je eigen team</span></div>
</div>

<div class="note">3 min kiezen, 12 schrijven, 5 reviewen bij een ander groepje. Alles staat in oefening/README.md.</div>

<!--
Scenario 5 is voor de senioren, en levert de meeste waarde op: je gaat naar
huis met de eerste echte ADR voor je eigen logboek.

Loop rond tijdens het schrijven. De vraag die het meest helpt: "en wat viel er af?"
-->

---

<!-- _class: dark -->

# Vier dingen om te onthouden

<div class="rows">
<div class="row"><span class="badge ctx">1</span> Een ADR legt het waarom vast. Het wat zie je al in de code.</div>
<div class="row"><span class="badge gev">2</span> Schrijf op wat je níet koos, en wat je keuze kost.</div>
<div class="row"><span class="badge bes">3</span> Verandert de beslissing? Schrijf een nieuwe, en verwijs naar de oude.</div>
<div class="row"><span class="badge n">4</span> Begin klein: een map, een template, een pull request.</div>
</div>

<div class="note">Vragen?</div>

<!--
Vraag welke beslissing ze deze week als eerste gaan opschrijven.
De leeslijst en de repo-link staan op de volgende twee slides.
-->

---

<!-- _class: links -->

# Verder lezen

*De bronnen achter deze presentatie*

<div class="rows">
<div class="row"><span class="badge n">1</span><div><a href="https://architecture-decision-record.github.io/nl-001/">architecture-decision-record.github.io/nl-001</a><br><span class="dim">De ADR-repository in het Nederlands: templates, voorbeelden en teamafspraken</span></div></div>
<div class="row"><span class="badge n">2</span><div><a href="https://learn.microsoft.com/nl-nl/azure/well-architected/architect-role/architecture-decision-record">learn.microsoft.com — Architecture Decision Record</a><br><span class="dim">Azure Well-Architected Framework: wat erin moet en wanneer je begint</span></div></div>
<div class="row"><span class="badge n">3</span><div><a href="https://adr.github.io/">adr.github.io</a><br><span class="dim">Begrippen, het MADR-template en een overzicht van tooling</span></div></div>
<div class="row"><span class="badge n">4</span><div><a href="https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions">Michael Nygard — Documenting Architecture Decisions</a><br><span class="dim">De blogpost uit 2011 waar het mee begon. Leest in vijf minuten.</span></div></div>
</div>

<!--
Als je één ding leest: de Nygard-post. Kort, en het hele idee staat erin.
Voor het team: de Nederlandse pagina van de ADR-repository.
-->

---

<!-- _class: title -->
<!-- _paginate: false -->

# Alles staat online

<div class="sub">Slides, templates, het voorbeeld-logboek en de oefening</div>

<div class="repo"><a href="https://github.com/miguelmartens/waarom-is-dit-zo">github.com/miguelmartens/waarom-is-dit-zo</a></div>

<div class="who">Miguel Martens</div>

<!--
Laat deze slide staan tijdens de vragen, zodat iedereen de link kan overtypen.
De templates en scripts/nieuwe-adr.sh kun je zo naar je eigen repo kopiëren.
-->
