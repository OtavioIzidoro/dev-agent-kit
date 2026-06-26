# Catálogo de capacidades do agente

Repositório central de **skills**, **rules** e **subagentes** para **Cursor**, **Claude Code** e **Codex**.

> **Instalação:** [INSTALACAO.md](INSTALACAO.md) — um comando instala nas três ferramentas.

> **Agentes essenciais:** [`continuidade-projeto`](skills/continuidade-projeto/SKILL.md) — **continue o projeto como ele já é** (rule sempre ativa). Em projetos grandes: [`economia-contexto`](skills/economia-contexto/SKILL.md) — **escopo mínimo antes de codar**. [`guardiao-padroes`](skills/guardiao-padroes/SKILL.md) — padrões nos arquivos do escopo.

## Skills (`skills/`)

| Skill | Comando | Descrição |
|-------|---------|-----------|
| `frontend-design` | `/frontend-design` | Interfaces web com design distinto e produção |
| `api-contract-frontend` | `/api-contract-frontend` | Contrato de API para integração frontend |
| `replicacao-fiel-tela-por-print` | `/replicacao-fiel-tela-por-print` | Clonar tela a partir de screenshot |
| `sprint-status-report` | `/sprint-status-report` | Relatório executivo de sprint |
| `navegacao-web` | `/navegacao-web` | Executar cenários no browser |
| `front-qa` | `/front-qa` | Análise visual — responsividade, UX, a11y |
| `responsividade` | `/responsividade` | **Auditar e corrigir responsividade — PWA, navegador, mobile, tablet e desktop** |
| `api-qa` | `/api-qa` | Análise de requests/responses — REST, JSON, HTTP, segurança |
| `report-agent` | `/report-agent` | Relatório final de QA — bugs, priorização, veredito |
| `economia-contexto` | `/economia-contexto` | **Preparar contexto mínimo antes de codar (não codifica)** |
| `guardiao-padroes` | `/guardiao-padroes` | **Analisar padrões do projeto antes de codar** |
| `front-implementador` | `/front-implementador` | **Implementar telas, componentes e fluxos UI** |
| `code-reviewer` | `/code-reviewer` | **Revisar diff antes de PR** |
| `api-integracao` | `/api-integracao` | **Integração front/back — types, API, erros** |
| `agente-testes` | `/agente-testes` | **Criar/ajustar testes automatizados** |
| `documentacao-tarefa` | `/documentacao-tarefa` | **Registrar entrega — ticket, evidência, gestão** |
| `continuidade-projeto` | `/continuidade-projeto` | **Continuar projeto — padrão existente, diff mínimo** |
| `mobile-store-release` | `/mobile-store-release` | **Publicar mobile — App Store, Play Store, build release** |
| `chatbot-whatsapp` | `/chatbot-whatsapp` | **Chatbot WhatsApp via Z-API — webhook, fluxo, envio** |
| `verificacao-build` | `/verificacao-build` | **Build/compilação — .NET, Java, Node, React — evitar crash no deploy** |

## Rules (`rules/`)

| Rule | Escopo |
|------|--------|
| `continuidade-projeto` | **Sempre ativa** — continuar projeto, não reinventar |
| `verificacao-build` | **Sempre ativa** — build verde antes de finalizar (.NET, Java, Node, React) |
| `portugues-comunicacao` | Sempre ativa — PT-BR |
| `api-contratos` | Arquivos `*.{ts,tsx,js,jsx}` |
| `frontend-padroes` | Arquivos `*.{tsx,jsx,vue}` |
| `qa-executor` | QA manual, cenários E2E, smoke test |
| `front-qa` | Review visual, a11y, responsividade |
| `api-qa` | Review de endpoints, REST, segurança |
| `report-agent` | Relatório final, classificação de bugs |
| `economia-contexto` | **Escopo mínimo — projetos grandes ou legados** |
| `guardiao-padroes` | **Padrões do projeto antes de alterar código** |
| `front-implementador` | Implementação de telas e componentes UI |
| `code-reviewer` | Revisão de diff antes de PR |
| `api-integracao` | Integração API — tipagem, payload, paginação, erros |
| `agente-testes` | Criar testes automatizados (unit, component, E2E) |
| `documentacao-tarefa` | Registrar entrega de tarefa finalizada |
| `mobile-store-release` | Publicação mobile — assinatura, permissões, privacidade, build |

## Subagentes (`agents/`)

| Agente | Uso |
|--------|-----|
| `continuidade-projeto` | **Filosofia de continuidade** — padrão existente, diff mínimo |
| `economia-contexto` | **Economia de tokens** — escopo, arquivos essenciais, prompt enxuto (readonly) |
| `guardiao-padroes` | **Mapear padrões antes de implementar** (pastas, hooks, API, forms, estilo) |
| `front-implementador` | **Implementar** telas, forms, modais, tabelas, integração API |
| `code-reviewer` | **Revisar diff** antes de PR (bugs, padrão, tipagem, useEffect) |
| `api-integracao` | **Integração API** — types, service, hook, contrato, erros |
| `agente-testes` | **Testes automatizados** — unit, component, hook, E2E |
| `explorer` | Mapear e entender o codebase |
| `verifier` | **Executar** build + testes existentes (não cria testes) |
| `front-qa` | Análise de screenshots e DOM (UX, a11y, visual) |
| `api-qa` | Análise de requests e responses (REST, JSON, HTTP, segurança) |
| `report-agent` | Relatório final — documentação, bugs, priorização |
| `documentacao-tarefa` | **Entrega de tarefa** — Jira, Trello, ClickUp, evidência |
| `mobile-store-release` | **Publicação mobile** — App Store, Play Store, AAB/IPA, rejeições |

## Tutorial

- [Tutorial completo — como e quando usar](TUTORIAL.md)
- [Guia rápido — 1 página](GUIA-RAPIDO.md)

## Instalação

Ver [README.md](README.md).

<!-- dev-agent-kit:start -->
> Catálogo completo: skills em `.agents/skills/` (Codex) ou `.claude/skills/` (Claude) ou `.cursor/skills/` (Cursor).

## Sempre ativo

- **Continuidade:** projeto já em andamento — siga o padrão existente, diff mínimo, não refatore fora do escopo.
- **Build:** detecte stack (.NET, Java, Node, React), rode build antes de finalizar; não entregue com compilação quebrada.
- **Idioma:** responda em português do Brasil, salvo pedido explícito em outro idioma.

## Fluxo recomendado (feature)

1. `/guardiao-padroes` — mapear padrões do projeto
2. `/api-integracao` — contrato, types, service, erros
3. `/front-implementador` — tela, form, modal, integração
4. `/agente-testes` — testes automatizados
5. `/code-reviewer` — revisar diff antes do PR
6. `verifier` ou `/verificacao-build` — build + testes
7. `/documentacao-tarefa` — registrar entrega no ticket

## Projeto grande ou legado

Use `/economia-contexto` **antes** de codar (não codifica — só delimita escopo).

## Skills principais

| Preciso… | Skill |
|----------|-------|
| Mapear padrões | `guardiao-padroes` |
| Implementar UI | `front-implementador` |
| Integrar API | `api-integracao` |
| Escrever testes | `agente-testes` |
| Review de PR | `code-reviewer` |
| Validar build/compilação | `verificacao-build` |
| Rodar build + testes | `verifier` |
| QA visual | `front-qa` |
| Corrigir responsividade | `responsividade` |
| QA de API | `api-qa` |
| Fechar ticket | `documentacao-tarefa` |
<!-- dev-agent-kit:end -->
