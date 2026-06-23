# Instalação — Cursor, Claude Code e Codex

Guia rápido para usar este catálogo de **skills**, **rules** e **subagentes** nas três ferramentas.

> **1 comando instala tudo:** veja [Instalação em 1 comando](#instalação-em-1-comando).

---

## Pré-requisitos

| Item | Obrigatório? | Para quê |
|------|--------------|----------|
| Git | Sim | clonar o repositório |
| Node.js + `npx` | Recomendado | instalar skills no Cursor via Skills CLI |
| Bash | Sim | rodar os scripts (`macOS` e `Linux`) |

---

## Instalação em 1 comando

### 1. Clone o repositório (uma vez)

```bash
git clone https://github.com/SEU-USUARIO/skills.git ~/dev-agent-kit
```

> Troque a URL pelo seu fork ou caminho local. Exemplo local: `/Volumes/externo/skills`.

### 2. Instale no seu projeto

```bash
cd /caminho/do/seu/projeto
~/dev-agent-kit/scripts/install.sh .
```

Isso instala **Cursor + Claude Code + Codex** de uma vez.

### 3. Abra um chat novo

Reinicie ou abra uma **nova sessão** na ferramenta que for usar.

---

## Só uma ferramenta?

```bash
# Apenas Cursor (skills + rules + subagentes)
~/dev-agent-kit/scripts/install.sh . cursor

# Apenas Claude Code (skills + rules + AGENTS.md)
~/dev-agent-kit/scripts/install.sh . claude

# Apenas Codex (skills + AGENTS.md)
~/dev-agent-kit/scripts/install.sh . codex
```

---

## Instalação global (todas as ferramentas)

Disponível em **qualquer projeto** da máquina:

```bash
SCOPE=global ~/dev-agent-kit/scripts/install.sh
```

---

## O que cada ferramenta recebe

| Recurso | Cursor | Claude Code | Codex |
|---------|--------|-------------|-------|
| Skills (18) | `.cursor/skills/` | `.claude/skills/` | `.agents/skills/` |
| Rules | `.cursor/rules/*.mdc` | `.claude/rules/*.md` | via `AGENTS.md` |
| Subagentes | `.cursor/agents/` | — | — |
| Instruções gerais | rules sempre ativas | `AGENTS.md` + `CLAUDE.md` | `AGENTS.md` |

### Skills incluídas

`guardiao-padroes`, `front-implementador`, `api-integracao`, `agente-testes`, `code-reviewer`, `continuidade-projeto`, `economia-contexto`, `front-qa`, `api-qa`, `report-agent`, `documentacao-tarefa`, `frontend-design`, `mobile-store-release`, `chatbot-whatsapp`, e mais.

Catálogo completo: [AGENTS.md](AGENTS.md).

---

## Como usar depois de instalar

### Cursor

- Digite `/` no chat e escolha a skill (ex.: `/guardiao-padroes`)
- Rules `continuidade-projeto` e `portugues-comunicacao` ficam **sempre ativas**
- Subagentes são delegados automaticamente pelo agente principal

### Claude Code

- No terminal: `claude` dentro do projeto
- Skills: `/guardiao-padroes`, `/front-implementador`, etc.
- Rules em `.claude/rules/` carregam automaticamente
- Se já existir `CLAUDE.md`, adicione `@AGENTS.md` para compartilhar instruções com Codex

### Codex

- Skills: digite `$guardiao-padroes` ou use `/skills`
- Também ativam **sozinhas** quando o prompt combina com o `description` da skill
- `AGENTS.md` na raiz do projeto traz o fluxo recomendado

---

## Fluxo do dia a dia

```
/guardiao-padroes → /api-integracao → /front-implementador
→ /agente-testes → /code-reviewer → /documentacao-tarefa
```

Projeto grande ou legado: comece com `/economia-contexto` (não codifica — só delimita escopo).

Cola de 1 página: [GUIA-RAPIDO.md](GUIA-RAPIDO.md).

---

## Estrutura após instalar (exemplo)

```
seu-projeto/
├── AGENTS.md                 # instruções compartilhadas (Codex + Claude)
├── CLAUDE.md                 # criado se não existir (importa AGENTS.md)
├── .cursor/
│   ├── skills/               # Cursor
│   ├── rules/
│   └── agents/               # subagentes (só Cursor)
├── .claude/
│   ├── skills/               # Claude Code
│   └── rules/
└── .agents/
    └── skills/               # Codex
```

---

## Instalação manual (sem script)

### Skills (qualquer ferramenta)

```bash
# Cursor
npx skills add ~/dev-agent-kit --skill '*' -y -a cursor

# Claude + Codex + Cursor de uma vez (quando suportado)
npx skills add ~/dev-agent-kit --skill '*' -y
```

### Copiar skills à mão

```bash
cp -R ~/dev-agent-kit/skills/* .claude/skills/
cp -R ~/dev-agent-kit/skills/* .agents/skills/
cp -R ~/dev-agent-kit/skills/* .cursor/skills/
```

---

## Publicar no GitHub e instalar em outra máquina

```bash
git clone https://github.com/SEU-USUARIO/skills.git ~/dev-agent-kit
cd /meu/projeto
~/dev-agent-kit/scripts/install.sh .
```

Ou só skills remotas:

```bash
npx skills add SEU-USUARIO/skills --skill '*' -y -a cursor
```

---

## Problemas comuns

| Problema | Solução |
|----------|---------|
| Skill não aparece | Abra um **chat novo** ou reinicie a ferramenta |
| `npx` não encontrado | Instale Node.js ou use cópia local (o script faz fallback) |
| Já tenho `AGENTS.md` | O script **anexa** um bloco `dev-agent-kit` sem apagar o seu |
| Já tenho rules/skills | Arquivos existentes são **preservados** (não sobrescreve) |
| Quero só atualizar uma skill | Copie a pasta da skill de `~/dev-agent-kit/skills/nome/` |

---

## Referências

- [Guia rápido — 1 página](GUIA-RAPIDO.md)
- [Tutorial completo](TUTORIAL.md)
- [Catálogo](AGENTS.md)
- [Agent Skills (Cursor)](https://cursor.com/docs/context/skills)
- [Skills (Claude Code)](https://code.claude.com/docs/en/skills)
- [Skills (Codex)](https://developers.openai.com/codex/skills)
- [AGENTS.md — formato aberto](https://agents.md/)
