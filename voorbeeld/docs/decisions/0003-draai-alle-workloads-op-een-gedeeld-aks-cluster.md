---
status: vervangen door [ADR-0005](0005-draai-stateless-apis-op-azure-container-apps.md)
date: 2025-10-06
decision-makers: platformteam
consulted: productteams
informed: alle productteams
---

# Draai alle workloads op een gedeeld AKS-cluster

## Context en probleemstelling

Zes productteams draaien containers op vier verschillende manieren: App Service, losse VM's
met Docker, een eigen AKS-cluster en Container Instances. Het platformteam kan dat niet
allemaal ondersteunen. We willen één hostingplatform voor containers.

## Beslisfactoren

- Eén platform dat het platformteam kan beheren en beveiligen
- Ruimte voor workloads met speciale eisen (stateful, eigen operators)
- Kosten: niet per team een eigen cluster

## Overwogen opties

- Eén gedeeld AKS-cluster per omgeving, met een namespace per team
- Een AKS-cluster per team
- Azure Container Apps

## Beslissing

Gekozen: **één gedeeld AKS-cluster per omgeving**, omdat het alle workloads aankan
en het platformteam maar drie clusters hoeft te beheren.

Zekerheid: middel. Container Apps was een serieuze kandidaat; we wisten niet zeker
of het genoeg controle gaf voor de stateful workloads.

### Gevolgen

- Goed, omdat er één plek is voor netwerk, monitoring en beveiliging
- Slecht, omdat elk team Kubernetes moet leren, ook voor een simpele API
- Slecht, omdat clusterupgrades alle teams tegelijk raken
