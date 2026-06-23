#!/usr/bin/env bash
# Funções compartilhadas pelos instaladores.

copy_skills_dir() {
  local src="$1"
  local dest="$2"
  local label="${3:-skills}"

  if [[ ! -d "$src" ]]; then
    echo "    (sem pasta de skills: $src)" >&2
    return 0
  fi

  mkdir -p "$dest"
  echo "==> Copiando $label para $dest"

  local skill_dir
  for skill_dir in "$src"/*/; do
    [[ -d "$skill_dir" ]] || continue
    local name
    name="$(basename "$skill_dir")"
    if [[ -d "$dest/$name" ]]; then
      echo "    (já existe, pulando) $name"
    else
      cp -R "$skill_dir" "$dest/$name"
      echo "    + $name"
    fi
  done
}

copy_cursor_rules() {
  local src="$1"
  local dest="$2"

  if [[ ! -d "$src" ]] || ! compgen -G "$src/*.mdc" > /dev/null; then
    return 0
  fi

  mkdir -p "$dest"
  echo "==> Copiando rules (Cursor) para $dest"

  local f base
  for f in "$src"/*.mdc; do
    base="$(basename "$f")"
    if [[ -f "$dest/$base" ]]; then
      echo "    (já existe, pulando) $base"
    else
      cp "$f" "$dest/$base"
      echo "    + $base"
    fi
  done
}

copy_claude_rules() {
  local src="$1"
  local dest="$2"

  if [[ ! -d "$src" ]] || ! compgen -G "$src/*.mdc" > /dev/null; then
    return 0
  fi

  mkdir -p "$dest"
  echo "==> Copiando rules (Claude) para $dest"

  local f base out
  for f in "$src"/*.mdc; do
    base="$(basename "$f" .mdc).md"
    out="$dest/$base"
    if [[ -f "$out" ]]; then
      echo "    (já existe, pulando) $base"
      continue
    fi

    # Converte frontmatter Cursor (globs) para Claude (paths).
    awk '
      BEGIN { in_front = 0; printed = 0 }
      /^---$/ {
        if (!printed) {
          print
          printed = 1
          in_front = 1
          next
        }
        in_front = 0
        print
        next
      }
      in_front && /^globs:/ {
        sub(/^globs:/, "paths:")
        print
        next
      }
      { print }
    ' "$f" > "$out"
    echo "    + $base"
  done
}

copy_cursor_agents() {
  local src="$1"
  local dest="$2"

  if [[ ! -d "$src" ]] || ! compgen -G "$src/*.md" > /dev/null; then
    return 0
  fi

  mkdir -p "$dest"
  echo "==> Copiando subagentes (Cursor) para $dest"

  local f base
  for f in "$src"/*.md; do
    base="$(basename "$f")"
    if [[ -f "$dest/$base" ]]; then
      echo "    (já existe, pulando) $base"
    else
      cp "$f" "$dest/$base"
      echo "    + $base"
    fi
  done
}

install_codex_agents_md() {
  local target="$1"
  local repo_root="$2"
  local snippet="$repo_root/scripts/templates/agents-snippet.md"
  local agents_file="$target/AGENTS.md"
  local marker_start="<!-- dev-agent-kit:start -->"
  local marker_end="<!-- dev-agent-kit:end -->"

  if [[ ! -f "$snippet" ]]; then
    echo "    (template AGENTS.md não encontrado)" >&2
    return 0
  fi

  mkdir -p "$target/.agents"

  if [[ ! -f "$agents_file" ]]; then
    echo "==> Criando AGENTS.md em $agents_file"
    cat "$snippet" > "$agents_file"
    return 0
  fi

  if grep -q "$marker_start" "$agents_file"; then
    echo "==> AGENTS.md já contém bloco dev-agent-kit (mantido)"
    return 0
  fi

  echo "==> Anexando bloco dev-agent-kit em $agents_file"
  {
    echo
    echo "$marker_start"
    sed '1,2d' "$snippet"
    echo "$marker_end"
  } >> "$agents_file"
}

install_claude_memory() {
  local target="$1"
  local repo_root="$2"
  local snippet="$repo_root/scripts/templates/agents-snippet.md"
  local claude_file="$target/CLAUDE.md"

  if [[ -f "$claude_file" ]]; then
    if grep -q "dev-agent-kit" "$claude_file"; then
      echo "==> CLAUDE.md já referencia dev-agent-kit (mantido)"
      return 0
    fi
    echo "==> CLAUDE.md existe — adicione manualmente: @AGENTS.md"
    return 0
  fi

  if [[ -f "$target/AGENTS.md" ]]; then
    echo "==> Criando CLAUDE.md com import de AGENTS.md"
    cat > "$claude_file" <<'EOF'
@AGENTS.md

# Claude Code — notas locais

- Skills em `.claude/skills/` (instaladas pelo dev-agent-kit)
- Rules em `.claude/rules/`
EOF
    return 0
  fi

  if [[ -f "$snippet" ]]; then
    echo "==> Criando CLAUDE.md a partir do template"
    cp "$snippet" "$claude_file"
  fi
}
