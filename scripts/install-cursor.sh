#!/usr/bin/env bash
# Instala skills, rules e subagentes deste repositório no Cursor.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"
SCOPE="${SCOPE:-project}"  # project | global

if [[ ! -d "$TARGET" ]]; then
  echo "Erro: diretório alvo não existe: $TARGET" >&2
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"

echo "==> Repositório: $REPO_ROOT"
echo "==> Alvo: $TARGET"
echo "==> Escopo skills: $SCOPE"
echo

# --- Skills (via Skills CLI) ---
echo "==> Instalando skills..."
if [[ "$SCOPE" == "global" ]]; then
  npx skills add "$REPO_ROOT" --skill '*' -y -a cursor -g
else
  npx skills add "$REPO_ROOT" --skill '*' -y -a cursor
fi

# --- Rules ---
RULES_SRC="$REPO_ROOT/rules"
if [[ -d "$RULES_SRC" ]] && compgen -G "$RULES_SRC/*.mdc" > /dev/null; then
  if [[ "$SCOPE" == "global" ]]; then
    RULES_DEST="${CURSOR_RULES_DIR:-$HOME/.cursor/rules}"
  else
    RULES_DEST="$TARGET/.cursor/rules"
  fi
  mkdir -p "$RULES_DEST"
  echo "==> Copiando rules para $RULES_DEST"
  for f in "$RULES_SRC"/*.mdc; do
    base="$(basename "$f")"
    if [[ -f "$RULES_DEST/$base" ]]; then
      echo "    (já existe, pulando) $base"
    else
      cp "$f" "$RULES_DEST/$base"
      echo "    + $base"
    fi
  done
fi

# --- Subagentes ---
AGENTS_SRC="$REPO_ROOT/agents"
if [[ -d "$AGENTS_SRC" ]] && compgen -G "$AGENTS_SRC/*.md" > /dev/null; then
  if [[ "$SCOPE" == "global" ]]; then
    AGENTS_DEST="${CURSOR_AGENTS_DIR:-$HOME/.cursor/agents}"
  else
    AGENTS_DEST="$TARGET/.cursor/agents"
  fi
  mkdir -p "$AGENTS_DEST"
  echo "==> Copiando subagentes para $AGENTS_DEST"
  for f in "$AGENTS_SRC"/*.md; do
    base="$(basename "$f")"
    if [[ -f "$AGENTS_DEST/$base" ]]; then
      echo "    (já existe, pulando) $base"
    else
      cp "$f" "$AGENTS_DEST/$base"
      echo "    + $base"
    fi
  done
fi

echo
echo "Concluído."
echo
echo "Skills disponíveis: /economia-contexto, /guardiao-padroes, /frontend-design, /api-contract-frontend,"
echo "  /replicacao-fiel-tela-por-print, /sprint-status-report, /navegacao-web,"
echo "  /agente-testes, /documentacao-tarefa, /continuidade-projeto"
echo
echo "Reinicie ou abra um novo chat no Cursor para carregar rules e subagentes."
