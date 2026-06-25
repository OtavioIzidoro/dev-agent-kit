---
name: economia-contexto
description: Prepara contexto mínimo antes da implementação — escopo, arquivos essenciais, o que ignorar e prompt enxuto. Use em projetos grandes ou legados, antes de codar, ou quando quiser evitar leitura excessiva, respostas gigantes e retrabalho. Não codifica.
disable-model-invocation: true
---

# Economia de Contexto e Tokens

Prepara o **contexto certo** antes de pedir implementação. **Não codifica.**

## Problema

- Contexto demais · arquivos lidos sem necessidade · "analise tudo"
- Reescrita de arquivos grandes · respostas com código gigante
- Explicações repetidas · arquitetura nova · mesma correção várias vezes

## Objetivo

Menos contexto inútil · menos retrabalho · menos arquivos alterados · menos resposta gigante · **mais precisão**.

## Quando usar

| Situação | Use |
|----------|-----|
| Projeto grande ou legado | ✅ |
| Antes de implementar feature | ✅ |
| Chat longo / contexto pesado | ✅ |
| Já corrigiu a mesma coisa 2+ vezes | ✅ |
| Quer implementar agora | ❌ — use depois deste brief |

## Entrada

- Descrição da tarefa (1–3 frases)
- Ticket ou módulo afetado (se souber)
- O que **não** pode ser alterado

## Passo a passo

### 1. Delimitar escopo

- Uma frase: o que fazer
- Lista explícita: **fora de escopo**
- Proibir análise global do repositório

### 2. Encontrar arquivos mínimos

Busque só o necessário:

- 2–3 arquivos **referência** (mesmo tipo de tarefa)
- Arquivos a **criar/alterar** (lista fechada)
- 0–1 contrato/type se API

**Limite:** 5–8 arquivos no brief. Acima disso, priorize e marque resto como opcional.

### 3. Listar exclusões

- Pastas inteiras fora do módulo
- Arquivos grandes não relacionados
- Configs, lockfiles, generated

### 4. Montar prompt de implementação

Texto curto (5–10 linhas) copiável para o próximo passo — sem re-análise.

### 5. Regras para a sessão

Inclua no brief:

- Respostas concisas
- Código só do trecho alterado
- Não repetir análise
- Diff mínimo (`continuidade-projeto`)
- Padrão dos arquivos listados (`guardiao-padroes` no escopo)

## Formato de saída

```markdown
# Brief de contexto — [tarefa]

## Escopo
[1 frase]

## Fora de escopo
- ...

## Ler apenas (máx. 8)
| # | Arquivo | Por quê |
|---|---------|---------|

## Não ler / não alterar
- ...

## Prompt para implementação
[bloco copiável]

## Dica de sessão
[Nova conversa se contexto poluído? sim/não]
```

## Exemplo

```
/economia-contexto

Tarefa: adicionar filtro por status na listagem de usuários.
Módulo: src/features/users/
Não alterar: auth, layout global, outros módulos.
Projeto grande — preciso contexto mínimo antes de implementar.
```

## Fluxo recomendado

```
/economia-contexto
/guardiao-padroes          (só nos arquivos do brief)
/front-implementador       (ou /api-integracao)
/code-reviewer
```

Checklist: [references/checklist-economia.md](references/checklist-economia.md)
