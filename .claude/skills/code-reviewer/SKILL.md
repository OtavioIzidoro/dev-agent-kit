---
name: code-reviewer
description: Revisa diff antes de PR — bugs, duplicação, quebra de padrão, tipagem fraca, any desnecessário, useEffect problemático, dependências erradas e risco de regressão. Use após implementação, antes de commit ou abrir PR, ou quando o usuário pedir code review ou revisar alterações.
disable-model-invocation: true
---

# Revisor de Código

Review do **diff** antes de subir PR. Entra depois de `/front-implementador` ou qualquer implementação.

## Quando invocar

- Antes de `git commit` ou abrir PR
- Após feature implementada
- Quando quiser segunda opinião no diff
- Depois de correções pedidas em review anterior (re-review)

## Entrada

1. **Diff** — preferencialmente via git:
   ```bash
   git diff
   git diff --staged
   git diff main...HEAD
   ```
2. Ou arquivos/caminhos específicos indicados pelo usuário
3. **Contexto** — ticket, critérios de aceite, brief de `/guardiao-padroes` (opcional)

## Fluxo

### 1. Obter diff

- Rode git diff se estiver em repositório
- Foque nos arquivos alterados; ignore lockfiles a menos que relevantes

### 2. Revisar por responsabilidade

| # | Foco | O que procurar |
|---|------|----------------|
| 1 | **Diff** | Escopo, hunks não relacionados |
| 2 | **Duplicação** | Código copiado vs existente no repo |
| 3 | **Padrão** | Naming, pastas, libs, estilo do projeto |
| 4 | **Bugs** | Edge cases, async, state, condições |
| 5 | **Tipagem** | Tipos fracos, assertions, props |
| 6 | **`any`** | Substituível por tipo concreto |
| 7 | **`useEffect`** | Loops, cleanup, deps, derived state |
| 8 | **Dependências** | deps array, hooks rules, imports |
| 9 | **Regressão** | Telas/API/tests adjacentes |

Checklist completo: [references/checklist-review.md](references/checklist-review.md)

### 3. Classificar achados

Crítico → Alto → Médio → Baixo

### 4. Emitir veredito

| Veredito | Quando |
|----------|--------|
| **Aprovado** | Zero crítico/alto |
| **Aprovado com ressalvas** | Altos menores com plano claro |
| **Changes requested** | Crítico ou alto sem correção |

## Exemplo de invocação

```
/code-reviewer

Revise o diff desta branch contra main.
Foco: useEffect, tipagem e risco de regressão no módulo de usuários.
```

```
/code-reviewer

[após /front-implementador]

Revise as alterações antes do PR. Verifique duplicação e any desnecessário.
```

## Relação com outros agentes

| Momento | Agente |
|---------|--------|
| Antes de codar | `/guardiao-padroes` |
| Implementação | `/front-implementador` |
| **Antes do PR** | **`/code-reviewer`** |
| Review visual UI | `/front-qa` |
| Testes E2E | `/navegacao-web` |
| Relatório QA final | `/report-agent` |

## Fluxo completo front-end

```
guardiao-padroes → front-implementador → code-reviewer → front-qa → PR
```
