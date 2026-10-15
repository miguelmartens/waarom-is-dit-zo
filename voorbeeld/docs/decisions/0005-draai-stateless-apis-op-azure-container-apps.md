---
status: geaccepteerd
date: 2026-06-22
decision-makers: platformteam
consulted: productteams, FinOps
informed: alle productteams
---

# Draai stateless API's op Azure Container Apps

Vervangt [ADR-0003](0003-draai-alle-workloads-op-een-gedeeld-aks-cluster.md).

## Context en probleemstelling

Sinds [ADR-0003](0003-draai-alle-workloads-op-een-gedeeld-aks-cluster.md) draait alles op een
gedeeld AKS-cluster. Na acht maanden blijkt: vier van de zes teams draaien alleen stateless
HTTP-API's. Ze besteden meer tijd aan Kubernetes dan aan hun product, en de clusterupgrades
kosten het platformteam elk kwartaal een sprint. De twee teams met stateful workloads
en eigen operators hebben AKS wél nodig.

## Beslisfactoren

- Productteams zonder Kubernetes-kennis moeten zelfstandig kunnen uitrollen
- De stateful workloads moeten op AKS kunnen blijven
- Het platformteam wil minder clusteronderhoud

## Overwogen opties

- Stateless API's naar Azure Container Apps, de rest blijft op AKS
- Alles op AKS houden en het team een interne Helm-chart geven
- Alles naar Azure Container Apps

## Beslissing

Gekozen: **stateless API's naar Azure Container Apps, de rest blijft op AKS**,
omdat de meeste teams daarmee geen Kubernetes meer hoeven te kennen
en de workloads die het nodig hebben gewoon op AKS blijven.

Zekerheid: hoog. Twee teams hebben het drie maanden in een pilot gedraaid.

### Gevolgen

- Goed, omdat teams zelf uitrollen zonder Kubernetes-manifests
- Goed, omdat API's zonder verkeer naar nul schalen
- Slecht, omdat we nu twee hostingplatforms ondersteunen in plaats van één
- Slecht, omdat Container Apps minder controle geeft over netwerk en nodes
- Vervolg: een ADR over welke criteria bepalen of een workload naar AKS of Container Apps gaat

## Meer informatie

De pilotresultaten en de discussie staan in de pull request van deze ADR.
