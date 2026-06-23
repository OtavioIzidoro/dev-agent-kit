#!/usr/bin/env bash
# Instala skills e instruções deste repositório no OpenAI Codex.
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

echo "==> OpenAI Codex"
echo "    Repositório: $REPO_ROOT"
echo "    Alvo: $TARGET"
echo "    Escopo: $SCOPE"
echo

if [[ "$SCOPE" == "global" ]]; then
  SKILLS_DEST="${CODEX_SKILLS_DIR:-$HOME/.agents/skills}"
else
  SKILLS_DEST="$TARGET/.agents/skills"
fi

copy_skills_dir "$REPO_ROOT/skills" "$SKILLS_DEST" "skills"

if [[ "$SCOPE" != "global" ]]; then
  install_codex_agents_md "$TARGET" "$REPO_ROOT"
fi

echo
echo "Concluído (Codex)."
echo "Skills: \$guardiao-padroes ou /skills — também ativação implícita pelo description."
echo "Reinicie o Codex se as skills não aparecerem."
