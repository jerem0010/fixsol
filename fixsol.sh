#!/usr/bin/env bash
# ===============================================================
# 🚀 FixSol Pro Edition — by Jérémy 😎
# Ton "anchor doctor" moderne : check / fix / color / swag
# ===============================================================

set -e

# === Config ===
SOLANA_PATH="$HOME/.local/share/solana/install"
RELEASE_PATH="$SOLANA_PATH/releases/solana-release/bin"
ACTIVE_PATH="$SOLANA_PATH/active_release"
GOOD_SOLANA="1.18.21"
GOOD_ANCHOR="0.31.1"
MIN_RUST="1.81.0"

DOCTOR_MODE=false
DEEP_MODE=false

# === Couleurs ===
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BOLD=$(tput bold)
RESET=$(tput sgr0)
CHECK="${GREEN}✔${RESET}"
CROSS="${RED}✘${RESET}"
INFO="${YELLOW}⚙${RESET}"

# === Options ===
if [[ "$1" == "--doctor" ]]; then
  DOCTOR_MODE=true
elif [[ "$1" == "--deep" ]]; then
  DEEP_MODE=true
elif [[ "$1" == "--help" ]]; then
  echo "Usage: fixsol_pro.sh [--doctor | --deep]"
  echo "  --doctor : vérifie sans modifier"
  echo "  --deep   : vérifie aussi Node, Cargo et test-validator"
  exit 0
fi

# === Header ===
echo ""
echo "${BOLD}${BLUE}🧩 FixSol Pro Edition${RESET}"
echo "-------------------------------------------"
if [ "$DOCTOR_MODE" = true ]; then
  echo "🩺 ${YELLOW}Mode diagnostic uniquement (aucune modif)${RESET}"
fi
if [ "$DEEP_MODE" = true ]; then
  echo "🔍 ${YELLOW}Mode deep scan activé${RESET}"
fi
echo ""

# === Versions ===
SOLANA_VERSION=$(solana --version 2>/dev/null | awk '{print $2}' || echo "not_found")
ANCHOR_VERSION=$(anchor --version 2>/dev/null | awk '{print $2}' || echo "not_found")
RUST_VERSION=$(rustc --version 2>/dev/null | awk '{print $2}' || echo "not_found")

# === Vérifications ===
echo "${INFO} Vérification de ton environnement..."
echo ""

function check_version() {
  local name="$1"
  local current="$2"
  local expected="$3"

  if [[ "$current" == "$expected" ]]; then
    printf "  %b %-12s : %s%s%b\n" "$CHECK" "$name" "$GREEN" "$current" "$RESET"
  else
    printf "  %b %-12s : %s%s%b → attendu: %s%s%b\n" "$CROSS" "$name" "$RED" "$current" "$RESET" "$YELLOW" "$expected" "$RESET"
  fi
}

check_version "Solana" "$SOLANA_VERSION" "$GOOD_SOLANA"
check_version "Anchor" "$ANCHOR_VERSION" "$GOOD_ANCHOR"
printf "  %b %-12s : %s%s%b\n" "$CHECK" "Rust" "$GREEN" "$RUST_VERSION" "$RESET"

echo ""

# === Correction automatique si besoin ===
if [[ "$SOLANA_VERSION" != "$GOOD_SOLANA" && "$DOCTOR_MODE" = false ]]; then
  echo "${YELLOW}⚠️  Solana version incorrecte — correction automatique...${RESET}"
  rm -rf "$ACTIVE_PATH"
  ln -s "$SOLANA_PATH/releases/solana-release" "$ACTIVE_PATH"
  echo "${GREEN}✅ Solana corrigé vers $GOOD_SOLANA${RESET}"
  echo ""
fi

# === Anchor ===
if [[ "$ANCHOR_VERSION" != "$GOOD_ANCHOR" && "$DOCTOR_MODE" = false ]]; then
  echo "${YELLOW}⚠️  Anchor incorrect, mise à jour...${RESET}"
  avm use $GOOD_ANCHOR || avm install $GOOD_ANCHOR
  echo "${GREEN}✅ Anchor corrigé vers $GOOD_ANCHOR${RESET}"
  echo ""
fi

# === Mode deep ===
if [ "$DEEP_MODE" = true ]; then
  echo "${INFO} Scan supplémentaire..."
  echo ""

  NODE_VERSION=$(node -v 2>/dev/null || echo "not_found")
  NPM_VERSION=$(npm -v 2>/dev/null || echo "not_found")
  CARGO_VERSION=$(cargo --version 2>/dev/null || echo "not_found")

  [[ "$NODE_VERSION" != "not_found" ]] && echo "  ${CHECK} Node.js : ${GREEN}$NODE_VERSION${RESET}" || echo "  ${CROSS} Node.js non trouvé"
  [[ "$NPM_VERSION" != "not_found" ]] && echo "  ${CHECK} npm     : ${GREEN}$NPM_VERSION${RESET}" || echo "  ${CROSS} npm non trouvé"
  [[ "$CARGO_VERSION" != "not_found" ]] && echo "  ${CHECK} Cargo   : ${GREEN}$CARGO_VERSION${RESET}" || echo "  ${CROSS} Cargo non trouvé"

  echo ""
  echo "${INFO} Test du validator local..."
  solana-test-validator --version >/dev/null 2>&1 && echo "  ${CHECK} Validator prêt" || echo "  ${CROSS} Validator non dispo"
  echo ""
fi

# === Résumé final ===
echo "${BOLD}Résumé final :${RESET}"
solana --version
anchor --version
rustc --version
echo ""

if [ "$DOCTOR_MODE" = true ]; then
  echo "${GREEN}🩺 Diagnostic terminé — aucune modification faite.${RESET}"
else
  echo "${GREEN}✅ Environnement propre et prêt à builder ton projet Anchor 🚀${RESET}"
fi
echo ""
