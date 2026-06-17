# Skills — repositório Cursor

Catálogo compartilhável de **skills**, **rules** e **subagentes** para o [Cursor](https://cursor.com).

**Novo aqui?** Leia o [Tutorial — quando usar cada coisa](TUTORIAL.md) para saber qual skill, rule ou subagente escolher por tipo de tarefa.

> **Antes de codar:** use `/guardiao-padroes` para mapear como o projeto já faz as coisas.

## Estrutura

```
skills/
├── skills/                    # Skills instaláveis (padrão Agent Skills)
│   ├── frontend-design/
│   ├── api-contract-frontend/
│   ├── replicacao-fiel-tela-por-print/
│   ├── sprint-status-report/
│   └── navegacao-web/
│   └── front-qa/
│   └── api-qa/
│   └── report-agent/
│   └── guardiao-padroes/
│   └── front-implementador/
├── rules/                     # Cursor rules (.mdc)
├── agents/                    # Subagentes (.md)
├── scripts/install-cursor.sh  # Instalação completa
├── AGENTS.md                  # Índice do catálogo
├── TUTORIAL.md                # Quando usar skill, rule ou subagente
└── README.md
```

## Conectar ao Cursor

### Opção 1 — Script completo (recomendado)

Instala skills, rules e subagentes de uma vez:

```bash
# No projeto onde você quer usar (escopo do projeto)
/Volumes/externo/skills/scripts/install-cursor.sh /caminho/do/seu/projeto

# Ou, estando na pasta do projeto:
/Volumes/externo/skills/scripts/install-cursor.sh .

# Global (disponível em todos os projetos)
SCOPE=global /Volumes/externo/skills/scripts/install-cursor.sh
```

### Opção 2 — Apenas skills (Skills CLI)

```bash
# Caminho local (antes de publicar no GitHub)
npx skills add /Volumes/externo/skills --skill '*' -y -a cursor

# Global
npx skills add /Volumes/externo/skills --skill '*' -y -a cursor -g

# Depois de publicar no GitHub (substitua owner/repo)
npx skills add seu-usuario/skills --skill '*' -y -a cursor
```

Listar skills disponíveis no repositório:

```bash
npx skills add /Volumes/externo/skills --list
```

### Opção 3 — Cursor Settings (rules remotas)

Para rules vindas de um repositório GitHub publicado:

1. **Cursor Settings** → **Rules**
2. **Add Rule** → **Remote Rule (Github)**
3. Informe a URL do repositório

> Rules locais em `rules/` são copiadas pelo script de instalação para `.cursor/rules/`.

## Onde o Cursor lê cada tipo

| Tipo | Origem neste repo | Destino após instalação |
|------|-------------------|-------------------------|
| Skills | `skills/*/SKILL.md` | `.cursor/skills/` ou `~/.cursor/skills/` |
| Rules | `rules/*.mdc` | `.cursor/rules/` |
| Subagentes | `agents/*.md` | `.cursor/agents/` |

## Skills incluídas

| Skill | Invocação | Quando usar |
|-------|-----------|-------------|
| `frontend-design` | `/frontend-design` | Criar UI com design de alta qualidade |
| `api-contract-frontend` | `/api-contract-frontend` | Gerar contrato de API para o frontend |
| `replicacao-fiel-tela-por-print` | `/replicacao-fiel-tela-por-print` | Replicar tela a partir de print |
| `sprint-status-report` | `/sprint-status-report` | Relatório executivo de sprint |
| `navegacao-web` | `/navegacao-web` | Abrir sistema e executar cenários no browser |
| `front-qa` | `/front-qa` | Analisar screenshots/DOM — UX, a11y, responsividade |
| `api-qa` | `/api-qa` | Analisar requests/responses — REST, JSON, HTTP, segurança |
| `report-agent` | `/report-agent` | Relatório final de QA — bugs e priorização |
| `guardiao-padroes` | `/guardiao-padroes` | **Padrões do projeto antes de codar** |
| `front-implementador` | `/front-implementador` | **Implementar telas, forms, modais, API** |

## Subagentes incluídos

| Agente | Função |
|--------|--------|
| `guardiao-padroes` | **Padrões do projeto — executar antes de implementar** |
| `front-implementador` | **Desenvolver telas e fluxos UI** |
| `code-reviewer` | Revisão de código (readonly) |
| `explorer` | Explorar e mapear o codebase |
| `verifier` | Validar entregas com testes |
| `front-qa` | Análise visual — screenshots e DOM |
| `api-qa` | Análise de APIs — requests e responses |
| `report-agent` | Relatório final — Technical Writer |

O agente principal delega subagentes automaticamente com base no campo `description` de cada arquivo.

## Adicionar novos itens

### Nova skill

```bash
npx skills init minha-skill --path skills/minha-skill
# Edite skills/minha-skill/SKILL.md (name e description obrigatórios)
```

O `name` no frontmatter deve ser igual ao nome da pasta.

### Nova rule

Crie `rules/minha-regra.mdc`:

```markdown
---
description: O que a rule faz
globs: "**/*.ts"
alwaysApply: false
---

# Título

Conteúdo da rule...
```

### Novo subagente

Crie `agents/meu-agente.md`:

```markdown
---
name: meu-agente
description: Quando o agente principal deve delegar para este subagente
model: inherit
readonly: false
---

Instruções do subagente...
```

## Publicar no GitHub

1. Crie o repositório remoto
2. Faça push deste diretório
3. Instale em qualquer máquina:

```bash
npx skills add seu-usuario/skills --skill '*' -y -a cursor -g
git clone https://github.com/seu-usuario/skills.git /tmp/skills
/tmp/skills/scripts/install-cursor.sh /caminho/do/projeto
```

## Referências

- [Agent Skills (Cursor)](https://cursor.com/docs/context/skills)
- [Subagentes (Cursor)](https://cursor.com/docs/subagents)
- [Skills CLI](https://github.com/vercel-labs/skills)
- [skills.sh](https://skills.sh/)
# dev-agent-kit
