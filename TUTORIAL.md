# Tutorial — como usar e quando usar

Guia completo do catálogo de **skills**, **rules** e **subagentes** para o Cursor.

---

## Índice

1. [Instalação rápida](#1-instalação-rápida)
2. [O que é cada coisa](#2-o-que-é-cada-coisa)
3. [Mapa do ciclo de vida](#3-mapa-do-ciclo-de-vida)
4. [Rules automáticas](#4-rules-automáticas)
5. [Desenvolvimento](#5-desenvolvimento)
6. [Integração API](#6-integração-api)
7. [Interface e design](#7-interface-e-design)
8. [Qualidade: testes vs QA](#8-qualidade-testes-vs-qa)
9. [Documentação e entrega](#9-documentação-e-entrega)
10. [Subagentes auxiliares](#10-subagentes-auxiliares)
11. [Fluxos por cenário](#11-fluxos-por-cenário)
12. [Tabela "tenho X, uso Y"](#12-tabela-tenho-x-uso-y)
13. [Comandos rápidos](#13-comandos-rápidos)
14. [Erros comuns](#14-erros-comuns)

---

## 1. Instalação rápida

Guia completo (Cursor + Claude + Codex): **[INSTALACAO.md](INSTALACAO.md)**.

### Instalar tudo no seu projeto (3 ferramentas)

```bash
/caminho/para/skills/scripts/install.sh /caminho/do/seu/projeto
```

### Só Cursor

```bash
/caminho/para/skills/scripts/install-cursor.sh /caminho/do/seu/projeto
```

### Instalar globalmente (todas as pastas)

```bash
SCOPE=global /caminho/para/skills/scripts/install.sh
```

### Só skills (sem rules/subagentes)

```bash
npx skills add /Volumes/externo/skills --skill '*' -y -a cursor -g
```

### Verificar o que foi instalado

```bash
npx skills add /Volumes/externo/skills --list
```

Após instalar, **reinicie o chat** ou abra nova conversa no Cursor para carregar rules e subagentes.

---

## 2. O que é cada coisa

| Tipo | O que faz | Como ativa | Quando usar |
|------|-----------|------------|-------------|
| **Skill** | Workflow com passos e formato de saída | `/nome-da-skill` no chat | Tarefa específica com entrega definida |
| **Rule** | Comportamento contínuo | Automática (Cursor aplica) | Padrão que vale sempre ou em certos arquivos |
| **Subagente** | Especialista com contexto isolado | Agente delega ou você pede | Explorar, revisar, validar sem poluir o chat |

**Regra prática:**

- Resultado com **formato fixo** (relatório, contrato, brief) → **Skill**
- **Comportamento** que deve valer o tempo todo → **Rule**
- **Dividir** trabalho pesado → **Subagente**
- Ajuste trivial → agente normal, sem skill

---

## 3. Mapa do ciclo de vida

Fluxo padrão para **tarefa de desenvolvimento** em projeto existente:

```
┌─────────────────────────────────────────────────────────────────┐
│  SEMPRE ATIVO: rule continuidade-projeto                        │
│  (continuar o projeto — diff mínimo, sem reinventar)            │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│ 1. ANTES         │    │ 2. DURANTE       │    │ 3. DEPOIS        │
│ /economia-contexto│ → │ implementação    │ →  │ qualidade + doc  │
│ (escopo mínimo)  │    │ front / api      │    │                  │
│ /guardiao-padroes│    │                  │    │                  │
│ (brief padrões)  │    │                  │    │                  │
└──────────────────┘    └──────────────────┘    └──────────────────┘
                              │                        │
                    /front-implementador          /agente-testes
                    /api-integracao             /code-reviewer
                    /frontend-design            verifier
                    /replicacao-fiel...         /front-qa (opcional)
                                                /api-qa (opcional)
                                                /documentacao-tarefa
```

### Ordem recomendada (feature completa)

| # | Etapa | Comando / agente |
|---|--------|------------------|
| 0 | Continuidade (automático) | rule `continuidade-projeto` |
| 0a | Build (automático) | rule `verificacao-build` |
| 0b | Escopo mínimo (projeto grande) | `/economia-contexto` |
| 1 | Mapear padrões | `/guardiao-padroes` |
| 2 | Contrato API (se necessário) | `/api-contract-frontend` |
| 3 | Integração API | `/api-integracao` |
| 4 | Implementar UI | `/front-implementador` |
| 5 | Criar testes | `/agente-testes` |
| 6 | Review do diff | `/code-reviewer` |
| 7 | Validar build | `/verificacao-build` ou rule automática |
| 8 | Rodar suite | subagente `verifier` |
| 9 | QA manual (opcional) | `/navegacao-web`, `/front-qa`, `/api-qa` |
| 10 | Documentar entrega | `/documentacao-tarefa` |

---

## 4. Rules automáticas

Rules **não precisam ser invocadas** — entram no contexto sozinhas.

| Rule | Quando aplica | Efeito |
|------|---------------|--------|
| **`continuidade-projeto`** | **Sempre** | Diff mínimo, seguir padrão, não reinventar |
| **`verificacao-build`** | **Sempre** | Build/compilação verde antes de finalizar |
| **`portugues-comunicacao`** | **Sempre** | Respostas em PT-BR |
| **`economia-contexto`** | Projetos grandes/legados | Escopo mínimo, arquivos essenciais |
| `guardiao-padroes` | Ao implementar/alterar código | Lembra de analisar padrões antes |
| `front-implementador` | Arquivos `.tsx`, `.jsx`, `.vue` | Padrões de UI |
| `api-contratos` | Arquivos `.ts`, `.tsx`, `.js`, `.jsx` | REST, tipagem, contratos |
| `api-integracao` | Arquivos TS/JS | Integração front/back |
| `code-reviewer` | Arquivos TS/JS/etc. | Review antes de PR |
| `agente-testes` | Arquivos `*.test.*`, `*.spec.*` | Escrita de testes |
| `documentacao-tarefa` | Ao fechar tarefa | Registrar entrega |
| `qa-executor` | QA manual, E2E | Formato pass/fail |
| `front-qa` | UI / screenshots | Review visual |
| `api-qa` | Endpoints | Review de API |
| `report-agent` | Consolidar QA | Relatório final |

---

## 5. Desenvolvimento

### `/continuidade-projeto` ⭐ — sempre

| | |
|---|---|
| **Quando** | Projeto em andamento — **sempre** (rule ativa) |
| **O que faz** | Continua o projeto como ele já é; não melhora, não reinventa |
| **Invocar** | `/continuidade-projeto` para reforçar o prompt na sessão |
| **Ao finalizar** | Listar padrões seguidos, arquivos alterados, riscos, testes manuais |

---

### `/economia-contexto` ⭐ — projetos grandes (antes de codar)

| | |
|---|---|
| **Quando** | Projeto grande, legado, chat pesado, ou mesma correção repetida |
| **O que faz** | Delimita escopo, lista arquivos a ler (máx. ~8), o que ignorar, prompt enxuto |
| **Não faz** | **Não codifica** — só prepara contexto |
| **Depois** | `/guardiao-padroes` nos arquivos do brief → implementação |
| **Exemplo** | `/economia-contexto` + tarefa + módulo + o que não alterar |

---

### `/guardiao-padroes` ⭐ — antes de codar

| | |
|---|---|
| **Quando** | Antes de criar/alterar feature, componente, hook, service |
| **O que faz** | Brief de padrões: pastas, naming, API, forms, validação, estilo |
| **Não use** | Só para achar um arquivo → `explorer` |
| **Exemplo** | `/guardiao-padroes` + descreva a feature |

---

### `/front-implementador` — implementar UI

| | |
|---|---|
| **Quando** | Criar tela, form, modal, tabela, filtro, layout |
| **O que faz** | Codifica UI reutilizando padrões do projeto |
| **Pré-requisito** | Brief de `/economia-contexto` (projeto grande) ou `/guardiao-padroes` |
| **Combina com** | `/replicacao-fiel-tela-por-print` (print), `/frontend-design` (criativo) |
| **Depois** | `/code-reviewer`, `/agente-testes` |

---

## 6. Integração API

| Skill | Quando | Saída |
|-------|--------|-------|
| `/api-contract-frontend` | **Antes** — definir contrato | Documento de endpoints |
| `/api-integracao` | **Durante** — implementar integração | Types, service, hook, erros |
| `/api-qa` | **Depois** — validar chamadas (QA) | Reporte de achados |

### `/api-integracao`

**Use quando:** tela com endpoint, form POST, listagem + paginação + filtros.

**Cobre:** tipagens, payload, query params, paginação, filtros, status HTTP, tratamento de erro, contrato front/back.

**Exemplo:**

```
/api-integracao

GET /api/users?page&limit&name&status
Crie types, service e useUsers no padrão do projeto.
```

---

## 7. Interface e design

| Situação | Use |
|----------|-----|
| Tenho **print/mock** — copiar fiel | `/replicacao-fiel-tela-por-print` |
| UI **criativa**, sem referência | `/frontend-design` |
| UI no **padrão do projeto** | `/front-implementador` |
| Ajuste pequeno | agente normal |

---

## 8. Qualidade: testes vs QA

### Diferença importante

| | **Testes automatizados** | **QA manual** |
|---|--------------------------|---------------|
| **Objetivo** | Prevenir regressão | Encontrar bugs |
| **Quem** | `/agente-testes` | `/navegacao-web`, `/front-qa`, `/api-qa` |
| **Saída** | Arquivos `*.test.*` | Reporte pass/fail |
| **Quando** | Regra de negócio, form, permissão, fluxo crítico | Validar release, explorar, smoke test |

### Agentes de qualidade

| Agente | Função | Comando |
|--------|--------|---------|
| **`agente-testes`** | **Escreve** testes (unit, component, hook, E2E) | `/agente-testes` |
| **`code-reviewer`** | **Revisa diff** antes do PR | `/code-reviewer` |
| **`verifier`** | **Executa** suite existente | pedir "rode os testes" |
| **`navegacao-web`** | Executa cenários no browser | `/navegacao-web` |
| **`front-qa`** | Analisa screenshot/DOM (UX, a11y) | `/front-qa` |
| **`api-qa`** | Analisa request/response | `/api-qa` |
| **`report-agent`** | Consolida QA → relatório final | `/report-agent` |

### Ciclo QA (4 agentes)

```
/navegacao-web  →  /front-qa  →  /api-qa  →  /report-agent
   (E2E)          (visual)       (API)        (relatório)
```

---

## 9. Documentação e entrega

| Skill | Quando | Para quem |
|-------|--------|-----------|
| `/documentacao-tarefa` | **Tarefa finalizada** — fechar ticket | Jira, Trello, ClickUp, gestão |
| `/sprint-status-report` | **Fim de sprint** — planejado vs entregue | PO, gestor, liderança |
| `/report-agent` | **Ciclo de QA** — bugs e veredito de release | QA, tech lead |

### `/documentacao-tarefa`

Gera: título, descrição, evidência, o que foi corrigido, comentário para ticket, branch sugerida.

```
/documentacao-tarefa

Ticket 2172. Corrigi card de disponibilidade. Validei na tela. Comentário para Jira.
```

---

## 10. Subagentes auxiliares

Peça no chat ou deixe o agente delegar:

| Subagente | Quando pedir |
|-----------|--------------|
| `continuidade-projeto` | Reforçar diff mínimo e padrão existente |
| `economia-contexto` | Escopo mínimo antes de codar (readonly) |
| `guardiao-padroes` | Brief de padrões antes de codar |
| `front-implementador` | Implementar tela/fluxo UI |
| `api-integracao` | Camada HTTP/types/hooks |
| `agente-testes` | Escrever testes |
| `code-reviewer` | Review antes do PR |
| `explorer` | "Onde fica X?" / "Como funciona Y?" |
| `verifier` | Rodar testes existentes |
| `front-qa` | Review visual |
| `api-qa` | Review de API |
| `report-agent` | Relatório QA consolidado |
| `documentacao-tarefa` | Documentar entrega |

---

## 11. Fluxos por cenário

### Nova feature (front + API)

```
/economia-contexto            (projeto grande — opcional)
/guardiao-padroes
/api-contract-frontend      (se integração nova)
/api-integracao
/front-implementador
/agente-testes
/code-reviewer
/documentacao-tarefa
```

### Bug fix pequeno

```
/continuidade-projeto        (já ativo — diff mínimo)
[correção pontual]
/code-reviewer
/documentacao-tarefa
```

### Tela com print do Figma

```
/guardiao-padroes
/replicacao-fiel-tela-por-print
/front-qa                     (opcional)
/code-reviewer
/documentacao-tarefa
```

### Validar release (QA)

```
/navegacao-web
/front-qa
/api-qa
/report-agent
```

### Fechamento de sprint

```
/sprint-status-report         (gestão)
/report-agent                 (QA, se houve testes)
```

### Projeto desconhecido ou legado

```
/economia-contexto
/guardiao-padroes
explorer: "mapeie a estrutura do projeto"
```

---

## 12. Tabela "tenho X, uso Y"

| Situação | Use |
|----------|-----|
| Projeto em andamento | rule `continuidade-projeto` (automático) |
| Projeto grande / legado | `/economia-contexto` primeiro |
| Antes de implementar | `/guardiao-padroes` |
| Implementar tela/form/modal | `/front-implementador` |
| Integrar endpoint | `/api-integracao` |
| Gerar contrato de API | `/api-contract-frontend` |
| Copiar tela de print | `/replicacao-fiel-tela-por-print` |
| UI criativa | `/frontend-design` |
| Criar testes automatizados | `/agente-testes` |
| Rodar testes existentes | `verifier` |
| Review diff antes do PR | `/code-reviewer` |
| QA no browser (E2E manual) | `/navegacao-web` |
| Review visual (UX, a11y) | `/front-qa` |
| Review de API (curl/HAR) | `/api-qa` |
| Relatório QA consolidado | `/report-agent` |
| Relatório de sprint | `/sprint-status-report` |
| Fechar ticket / Jira | `/documentacao-tarefa` |
| Onde está X no código? | `explorer` |
| Bug fix trivial | agente normal + continuidade |

---

## 13. Comandos rápidos

### Skills — digite no chat do Cursor

```
/continuidade-projeto
/economia-contexto
/guardiao-padroes
/front-implementador
/api-integracao
/api-contract-frontend
/agente-testes
/code-reviewer
/documentacao-tarefa
/frontend-design
/replicacao-fiel-tela-por-print
/navegacao-web
/front-qa
/api-qa
/report-agent
/sprint-status-report
```

### Frases para subagentes

```
Analise padrões do projeto antes de implementar X
Implemente a tela Y seguindo o brief
Crie testes para este hook/form
Revise o diff contra main
Rode os testes e reporte falhas
Analise este print — UX e a11y
Analise este curl — REST e segurança
Gere comentário para Jira da tarefa finalizada
```

---

## 14. Erros comuns

| Erro | Use em vez disso |
|------|------------------|
| `/frontend-design` com print anexado | `/replicacao-fiel-tela-por-print` |
| `verifier` para **criar** testes | `/agente-testes` |
| `/api-qa` para **implementar** API | `/api-integracao` |
| `/report-agent` para **uma tarefa** | `/documentacao-tarefa` |
| `/sprint-status-report` para **bug fix** | `/documentacao-tarefa` |
| "Analise o projeto inteiro" | `/economia-contexto` — escopo mínimo |
| Refatorar "aproveitando" | rule `continuidade-projeto` — diff mínimo |
| Codar sem mapear padrões | `/guardiao-padroes` primeiro |
| Contexto pesado / retrabalho | `/economia-contexto` + nova conversa |
| QA manual quando precisa regressão | `/agente-testes` |
| Skill em tarefa trivial de 1 linha | agente normal |

---

## Catálogo completo

Índice detalhado de todos os arquivos: [AGENTS.md](AGENTS.md)

Instalação e estrutura do repo: [README.md](README.md)
