#!/usr/bin/env bash
# Instala skills e rules deste repositório no Claude Code.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"
SCOPE="${SCOPE:-project}"

# shellcheck source=lib/common.sh
source "$REPO_ROOT/scripts/lib/common.sh"

if [[ ! -d "$TARGET" ]]; then
  echo "Erro: diretório alvo não existe: $TARGET" >&2
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"

echo "==> Claude Code"
echo "    Repositório: $REPO_ROOT"
echo "    Alvo: $TARGET"
echo "    Escopo: $SCOPE"
echo

if [[ "$SCOPE" == "global" ]]; then
  SKILLS_DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
  RULES_DEST="${CLAUDE_RULES_DIR:-$HOME/.claude/rules}"
else
  SKILLS_DEST="$TARGET/.claude/skills"
  RULES_DEST="$TARGET/.claude/rules"
fi

copy_skills_dir "$REPO_ROOT/skills" "$SKILLS_DEST" "skills"
copy_claude_rules "$REPO_ROOT/rules" "$RULES_DEST"

if [[ "$SCOPE" != "global" ]]; then
  install_codex_agents_md "$TARGET" "$REPO_ROOT"
  install_claude_memory "$TARGET" "$REPO_ROOT"
fi

echo
echo "Concluído (Claude Code)."
echo "Skills: /guardiao-padroes, /front-implementador, /api-integracao, /agente-testes, …"
echo "Reinicie o Claude Code ou abra um novo chat para carregar rules e skills."
