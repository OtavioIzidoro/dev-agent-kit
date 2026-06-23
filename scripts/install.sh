#!/usr/bin/env bash
# Instala skills, rules e subagentes para Cursor, Claude Code e/ou Codex.
#
# Uso:
#   ./scripts/install.sh [projeto] [plataforma]
#
# Plataformas: all (padrão) | cursor | claude | codex
# Escopo global: SCOPE=global ./scripts/install.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"
PLATFORM="${2:-all}"
SCOPE="${SCOPE:-project}"

usage() {
  cat <<EOF
Uso: $(basename "$0") [diretório-do-projeto] [plataforma]

Plataformas:
  all     Instala Cursor + Claude + Codex (padrão)
  cursor  Apenas Cursor (skills, rules, subagentes)
  claude  Apenas Claude Code (skills, rules, AGENTS.md)
  codex   Apenas Codex (skills, AGENTS.md)

Exemplos:
  $REPO_ROOT/scripts/install.sh .
  $REPO_ROOT/scripts/install.sh /meu/projeto cursor
  SCOPE=global $REPO_ROOT/scripts/install.sh

EOF
}

if [[ "$TARGET" == "-h" || "$TARGET" == "--help" ]]; then
  usage
  exit 0
fi

if [[ ! -d "$TARGET" ]]; then
  echo "Erro: diretório alvo não existe: $TARGET" >&2
  usage
  exit 1
fi

case "$PLATFORM" in
  all|cursor|claude|codex) ;;
  *)
    echo "Erro: plataforma inválida: $PLATFORM" >&2
    usage
    exit 1
    ;;
esac

echo "╔══════════════════════════════════════════╗"
echo "║  dev-agent-kit — instalação              ║"
echo "╚══════════════════════════════════════════╝"
echo

run() {
  local script="$1"
  bash "$REPO_ROOT/scripts/$script" "$TARGET"
  echo
}

if [[ "$PLATFORM" == "all" || "$PLATFORM" == "cursor" ]]; then
  run install-cursor.sh
fi

if [[ "$PLATFORM" == "all" || "$PLATFORM" == "claude" ]]; then
  run install-claude.sh
fi

if [[ "$PLATFORM" == "all" || "$PLATFORM" == "codex" ]]; then
  run install-codex.sh
fi

echo "✓ Instalação finalizada ($PLATFORM)."
echo
echo "Próximo passo: abra um novo chat na ferramenta escolhida."
echo "Guia completo: $REPO_ROOT/INSTALACAO.md"
