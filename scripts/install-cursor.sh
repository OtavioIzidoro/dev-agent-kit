#!/usr/bin/env bash
# Instala skills, rules e subagentes deste repositório no Cursor.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"
SCOPE="${SCOPE:-project}"  # project | global

# shellcheck source=lib/common.sh
source "$REPO_ROOT/scripts/lib/common.sh"

if [[ ! -d "$TARGET" ]]; then
  echo "Erro: diretório alvo não existe: $TARGET" >&2
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"

echo "==> Cursor"
echo "    Repositório: $REPO_ROOT"
echo "    Alvo: $TARGET"
echo "    Escopo: $SCOPE"
echo

# --- Skills (via Skills CLI, com cópia local garantida) ---
echo "==> Instalando skills..."
if command -v npx >/dev/null 2>&1; then
  if [[ "$SCOPE" == "global" ]]; then
    npx skills add "$REPO_ROOT" --skill '*' -y -a cursor -g 2>/dev/null || true
  else
    (cd "$TARGET" && npx skills add "$REPO_ROOT" --skill '*' -y -a cursor 2>/dev/null) || true
  fi
fi

if [[ "$SCOPE" == "global" ]]; then
  CURSOR_SKILLS_DEST="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"
else
  CURSOR_SKILLS_DEST="$TARGET/.cursor/skills"
fi
copy_skills_dir "$REPO_ROOT/skills" "$CURSOR_SKILLS_DEST" "skills (Cursor)"

# --- Rules ---
if [[ "$SCOPE" == "global" ]]; then
  RULES_DEST="${CURSOR_RULES_DIR:-$HOME/.cursor/rules}"
else
  RULES_DEST="$TARGET/.cursor/rules"
fi
copy_cursor_rules "$REPO_ROOT/rules" "$RULES_DEST"

# --- Subagentes ---
if [[ "$SCOPE" == "global" ]]; then
  AGENTS_DEST="${CURSOR_AGENTS_DIR:-$HOME/.cursor/agents}"
else
  AGENTS_DEST="$TARGET/.cursor/agents"
fi
copy_cursor_agents "$REPO_ROOT/agents" "$AGENTS_DEST"

echo
echo "Concluído (Cursor)."
echo
echo "Skills: /guardiao-padroes, /front-implementador, /api-integracao, /agente-testes, …"
echo "Reinicie ou abra um novo chat no Cursor para carregar rules e subagentes."
