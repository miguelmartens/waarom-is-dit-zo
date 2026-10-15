# Draaiboek

Voor mij tijdens de sessie. Scanbaar, niet om voor te lezen.
De sprekersnotities per slide staan in `presentatie/slides.md`; druk `p` in de HTML voor de presenter view.

---

## Twee versies

| Versie   | Duur    | Slides                   | Oefening                       |
| -------- | ------- | ------------------------ | ------------------------------ |
| Volledig | ~55 min | alle 22                  | 20 min, MADR, met review       |
| Kort     | ~30 min | sla 4, 10, 15 en 21 over | 10 min, alleen een Y-statement |

In de korte versie verwijs je voor het bewaken van beslissingen en de leeslijst naar de repo.

## Opzetten (voor de zaal binnenkomt)

```bash
make build            # dist/index.html, of: make slides voor live preview
make voorbeeld        # check dat het voorbeeld-logboek er staat
make schoon           # lege oefen-map
```

- Open `voorbeeld/docs/decisions/` in een tweede venster: bij slide 8 en 11 laat je de echte bestanden zien
- Zet de link naar de repo of `oefening/README.md` klaar in de chat van de meeting
- Weet hoeveel juniors en seniors er zitten: daar stem je de groepjes op af

---

## Blok 1 — Het probleem (slides 1–4, 5 min)

**Doel:** iedereen herkent het probleem voordat je het woord ADR uitlegt.

**Opening:** _"Wie heeft ooit gedacht: waarom is dit zo gebouwd? En wie kon het antwoord vinden?"_

Wacht op een praktijkverhaal uit de zaal. Heb je er een van jezelf, vertel dat bij slide 3.

## Blok 2 — Wat is het (slides 5–8, 10 min)

**Doel:** de drie delen context, beslissing, gevolgen zitten erin.

- Slide 5: houd de afkortingen kort. Twee onthouden: ADR en logboek
- Slide 7: vraag de zaal om een eigen voorbeeld voor "wel" en voor "niet"
- Slide 8: open `0002-beheer-azure-infrastructuur-met-bicep.md` en scroll naar de voor- en nadelen per optie en de gedateerde aanvulling

## Blok 3 — Goed schrijven (slides 9–12, 10 min)

**Doel:** het verschil tussen een ADR en een aankondiging.

- Slide 9: _"Wie heeft een beslissing gezien waar maar één optie in stond?"_
- Slide 11: hier komt de discussie onveranderlijk versus levend document. Antwoord: de beslissing verandert niet, aantekeningen met datum mogen erbij. Laat 0003 en 0005 naast elkaar zien
- Slide 12: niet blijven hangen bij de templates. Kies er één en ga door

## Blok 4 — In de praktijk (slides 13–15, 8 min)

- Slide 14: draai `make adr TITEL="..."` live, en laat het gemaakte bestand zien. Daarna `make schoon`
- Slide 15 is voor de senioren. Bij een jonge zaal of in de korte versie: overslaan

## Blok 5 — Het team (slides 16–18, 5 min)

- Slide 17: laat `0001-leg-architectuurbeslissingen-vast.md` zien. Dat is precies zo'n eerste ADR met de teamafspraken
- Slide 18: spreek de juniors direct aan. Hun "waarom" is de reden dat ADR's bestaan

---

## Blok 6 — De oefening (slide 19, 20 min)

**Doel:** iedereen heeft er één geschreven en er één gereviewd.

**Groepjes:** twee of drie, gemengd. De meest junior persoon typt, de meest senior stelt alleen vragen.

| Tijd   | Wat                                                      |
| ------ | -------------------------------------------------------- |
| 3 min  | scenario kiezen uit `oefening/README.md`                 |
| 12 min | schrijven, met `make adr` of een gekopieerd template     |
| 5 min  | wisselen, en reviewen met de zes vragen van de checklist |

**Rondlopen.** De vragen die het meest helpen:

- _"En wat viel er af?"_ — bijna elk groepje vergeet de afgewezen opties
- _"Wat is de prijs?"_ — de gevolgen zijn vaak alleen voordelen
- _"Is dit één beslissing?"_ — scenario 3 wordt snel drie ADR's

**Nabespreking (als er tijd is):** één groepje leest hun ADR voor, het reviewende groepje zegt wat er goed aan was en één vraag die overbleef.

**Remote of online:** maak breakout rooms, en laat groepjes hun ADR in de chat plakken of als pull request openen.

## Blok 7 — Afsluiten (slides 20–22, 3 min)

- Slide 20: _"Welke beslissing ga je deze week als eerste opschrijven?"_
- Laat slide 22 staan tijdens de vragen

---

## Vragen die vaak komen

| Vraag                                              | Antwoord in het kort                                                                       |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| "Is dit niet gewoon documentatie?"                 | Documentatie beschrijft hoe het nu is. Een ADR waarom, en wat er niet gekozen werd.        |
| "Wie heeft hier tijd voor?"                        | Een uur per ADR. Een heropende discussie kost meer.                                        |
| "Wiki of repo?"                                    | Repo: wordt gereviewd en reist mee met de code. Publiceer als wiki in Azure DevOps.        |
| "Mag ik een geaccepteerde ADR aanpassen?"          | De beslissing niet. Een aanvulling met datum wel. Anders: nieuwe ADR die de oude vervangt. |
| "Moeten we alle oude beslissingen nog vastleggen?" | Nee. Begin bij de nieuwe, en leg alleen oude vast als er een "waarom" over komt.           |
| "Wat als het team het niet eens wordt?"            | Leg vast wie beslist (slide 17). Schrijf de afwijkende mening bij de gevolgen.             |
