#!/usr/bin/env bash
# Schrijf een overzichtstabel van alle ADR's in een map naar stdout.
#
#   scripts/adr-index.sh docs/decisions > docs/decisions/README.md
#
# Leest per bestand de eerste H1, de status en de datum. Werkt met de
# frontmatter van MADR (status:, date:) en met de Nygard-vorm (## Status,
# Datum:). Ontbreekt iets, dan blijft de cel leeg in plaats van dat het
# script faalt.
set -euo pipefail

map=${1:-docs/decisions}

echo "# Beslissingenlogboek"
echo
echo "Gegenereerd met \`make index\`. Niet met de hand aanpassen: pas de ADR zelf aan."
echo
echo "| Nr | Beslissing | Status | Datum |"
echo "| --- | --- | --- | --- |"

for bestand in "$map"/[0-9][0-9][0-9][0-9]-*.md; do
  [ -e "$bestand" ] || continue
  naam=$(basename "$bestand")
  nr=${naam:0:4}

  # De eerste H1 buiten de frontmatter: daarbinnen is '# ' een YAML-commentaar.
  titel=$(awk '
    NR == 1 && /^---$/ { fm = 1; next }
    fm && /^---$/      { fm = 0; next }
    !fm && /^# /       { sub(/^# /, ""); sub(/^[0-9]+[.:] */, ""); print; exit }
  ' "$bestand")

  status=$(awk '
    NR == 1 && /^---$/ { fm = 1; next }
    fm && /^---$/      { fm = 0; next }
    fm && /^status:/   { sub(/^status: */, ""); gsub(/"/, ""); print; exit }
    /^## Status/       { s = 1; next }
    s && NF            { print; exit }
  ' "$bestand" | awk '{ print tolower(substr($0, 1, 1)) substr($0, 2) }')

  datum=$(awk '
    /^date:/          { sub(/^date: */, ""); print; exit }
    /^Datum:/         { sub(/^Datum: */, ""); print; exit }
  ' "$bestand")

  echo "| $nr | [$titel]($naam) | $status | $datum |"
done
