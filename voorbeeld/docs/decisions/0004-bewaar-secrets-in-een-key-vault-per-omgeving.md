---
status: geaccepteerd
date: 2025-11-10
---

# Bewaar secrets in een Key Vault per omgeving

In de context van **secrets voor applicaties en pipelines**,
geconfronteerd met **wachtwoorden in variabelegroepen en een gedeelde Key Vault voor alle omgevingen**,
kozen we voor **één Azure Key Vault per omgeving per team, met toegang via managed identities**
en niet voor **één centrale Key Vault of secrets in Azure DevOps-variabelegroepen**,
om **te voorkomen dat een test-identiteit bij productiesecrets kan**,
en accepteren we **meer Key Vaults om te beheren en een extra stap bij het aanmaken van een omgeving**.
