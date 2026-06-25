---
description: Agente de Testes — criar e ajustar testes automatizados (unit, component, hook, E2E), cenários positivos/negativos, permissões e validações. Use para regra de negócio, formulário, cálculo, permissão ou fluxo crítico. Diferente de QA manual.
paths: "**/*.{test,spec}.{ts,tsx,js,jsx}"
alwaysApply: false
---

# Agente de Testes

**QA encontra problemas. Testes automatizados previnem regressão.**

Crie ou ajuste testes quando houver:
- Regra de negócio, formulário, cálculo
- Permissões ou fluxo crítico

Níveis: unitário → componente/hook → E2E (pirâmide).

Escrita de testes: `/agente-testes`. Execução de suite existente: subagente `verifier`. QA exploratório: `/navegacao-web`, `/front-qa`, `/api-qa`.
