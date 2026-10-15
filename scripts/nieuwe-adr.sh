#!/usr/bin/env bash
# Maak een nieuwe ADR aan: volgend nummer, titel als bestandsnaam, template ingevuld.
#
#   scripts/nieuwe-adr.sh "Beheer infrastructuur met Bicep"
#   scripts/nieuwe-adr.sh "Beheer infrastructuur met Bicep" docs/decisions nygard
#
# Argumenten: titel (verplicht), map (standaard docs/decisions),
# template (madr, nygard of y-statement; standaard madr).
#
# Bewust zonder afhankelijkheden: bash, sed en tr. Kopieer dit bestand plus
# de map templates/ naar je eigen repo en het werkt daar ook.
set -euo pipefail

titel=${1:-}
map=${2:-docs/decisions}
template=${3:-madr}

if [ -z "$titel" ]; then
  echo "gebruik: $0 \"Titel in de gebiedende wijs\" [map] [madr|nygard|y-statement]" >&2
  exit 1
fi

hier=$(cd "$(dirname "$0")/.." && pwd)
bron="$hier/templates/$template.md"
if [ ! -f "$bron" ]; then
  echo "template '$template' bestaat niet. Kies uit: $(cd "$hier/templates" && ls -- *.md | sed 's/\.md$//' | tr '\n' ' ')" >&2
  exit 1
fi

mkdir -p "$map"

# Hoogste bestaande nummer + 1. Bestanden zonder nummer tellen niet mee.
laatste=$(find "$map" -maxdepth 1 -name '[0-9][0-9][0-9][0-9]-*.md' -exec basename {} \; |
  sort | tail -n 1 | cut -c1-4)
nummer=$(printf '%04d' $((10#${laatste:-0} + 1)))

# "Gebruik één AKS-cluster per team" -> "gebruik-een-aks-cluster-per-team"
# Accenten weg met losse s///-opdrachten: sed 'y' en [éè] tellen bytes in plaats
# van tekens zodra de locale geen UTF-8 is, en iconv//TRANSLIT doet op macOS
# iets anders dan op Linux.
slug=$(printf '%s' "$titel" |
  sed "s/'//g" |
  sed 's/á/a/g;s/à/a/g;s/ä/a/g;s/â/a/g;s/é/e/g;s/è/e/g;s/ë/e/g;s/ê/e/g;s/í/i/g;s/ì/i/g;s/ï/i/g;s/î/i/g;s/ó/o/g;s/ò/o/g;s/ö/o/g;s/ô/o/g;s/ú/u/g;s/ù/u/g;s/ü/u/g;s/û/u/g;s/ç/c/g;s/ñ/n/g;s/Á/A/g;s/À/A/g;s/Ä/A/g;s/Â/A/g;s/É/E/g;s/È/E/g;s/Ë/E/g;s/Ê/E/g;s/Í/I/g;s/Ì/I/g;s/Ï/I/g;s/Î/I/g;s/Ó/O/g;s/Ò/O/g;s/Ö/O/g;s/Ô/O/g;s/Ú/U/g;s/Ù/U/g;s/Ü/U/g;s/Û/U/g;s/Ç/C/g;s/Ñ/N/g' |
  tr '[:upper:]' '[:lower:]' |
  sed -e 's/[^a-z0-9]\{1,\}/-/g' -e 's/^-//' -e 's/-$//')

doel="$map/$nummer-$slug.md"
datum=$(date +%Y-%m-%d)

# Escapen voor sed: & en / en \ in de titel mogen de vervanging niet slopen.
titel_sed=$(printf '%s' "$titel" | sed -e 's/[\/&\\]/\\&/g')

sed -e "s/{{nummer}}/$nummer/g" \
  -e "s/{{titel}}/$titel_sed/g" \
  -e "s/{{datum}}/$datum/g" \
  "$bron" >"$doel"

echo "$doel"
