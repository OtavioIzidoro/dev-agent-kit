---
name: agente-testes
description: Cria e ajusta testes automatizados — unitário, componente, hook e E2E, cenários positivos/negativos, permissões e validações. Use quando funcionalidade tem regra de negócio, formulário, cálculo, permissão ou fluxo crítico. Diferente de QA — escreve código de teste, não explora manualmente.
disable-model-invocation: true
---

# Agente de Testes

Cria e ajusta **testes automatizados**. QA encontra problemas; este agente **escreve** testes que previnem regressão.

## Quando usar

| Situação | Use |
|----------|-----|
| Regra de negócio, cálculo | ✅ |
| Formulário + validação | ✅ |
| Permissões / roles | ✅ |
| Hook com lógica | ✅ |
| Componente com estados | ✅ |
| Fluxo crítico E2E | ✅ |
| Cobertura antes do PR | ✅ |
| Explorar bug manualmente | `/navegacao-web`, `/front-qa`, `/api-qa` |
| Só rodar testes existentes | subagente `verifier` |

## Pré-requisito

```
/guardiao-padroes   → descobrir Vitest/Jest/Playwright/RTL e convenções
```

## Tipos de teste

### Unitário
- Utils, services, mappers, pure functions
- Mock de dependências externas

### Componente
- Render + user events (Testing Library)
- Loading, empty, error states
- Props e callbacks

### Hook
- `renderHook` + act
- API mock, router mock
- Retorno e side effects

### E2E
- Playwright/Cypress conforme projeto
- Fluxos críticos apenas (pirâmide de testes)
- Login, checkout, aprovação, etc.

## Cenários obrigatórios (quando aplicável)

- **Positivo** — happy path
- **Negativo** — input inválido, API error
- **Validação** — campos obrigatórios, formatos, mensagens
- **Permissão** — com/sem role, UI bloqueada ou 403
- **Edge** — empty list, boundary values, double submit

## Fluxo

1. Ler código ou spec da feature
2. Identificar runner e helpers do projeto (`setupTests`, `test-utils`)
3. Escrever testes no path correto
4. Executar: `npm test`, `pnpm vitest run`, `npx playwright test`, etc.
5. Corrigir até verde
6. Reportar arquivos + comando + lacunas

## Exemplos de invocação

```
/agente-testes

Crie testes para useCreateUser hook:
- sucesso 201
- erro 422 com field errors
- sem permissão 403
Stack: Vitest + MSW (projeto usa).
```

```
/agente-testes

Formulário LoginForm — testes de componente:
- submit válido chama onSuccess
- email inválido mostra erro
- campos vazios bloqueiam submit
Siga padrão *.test.tsx colocated.
```

```
/agente-testes

E2E Playwright: fluxo de checkout completo
Cenários positivo e cartão recusado (negativo).
```

## Fluxo completo de desenvolvimento

```
guardiao-padroes → implementação → agente-testes → code-reviewer → verifier → (QA manual opcional)
```

Checklist: [references/checklist-testes.md](references/checklist-testes.md)
