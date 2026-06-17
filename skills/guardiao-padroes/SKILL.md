---
name: guardiao-padroes
description: Analisa padrões do projeto antes de alterar código — pastas, componentes, hooks, services, tipagem, formulários, validação, estado e estilização. Use antes de implementar feature, criar arquivos, refatorar, ou quando o usuário pedir seguir convenções do projeto e evitar refatoração desnecessária.
disable-model-invocation: true
---

# Guardião de Padrão do Projeto

**Execute antes de escrever ou alterar código.** Parte da filosofia de `/continuidade-projeto`: não melhorar o projeto — **continuar** como ele já é.

## Quando invocar

- Início de feature nova
- Criação de componente, hook, service ou página
- Antes de refatorar (para saber o que **não** refatorar)
- Quando entrar em projeto desconhecido
- Quando o usuário disser "siga o padrão do projeto"

## Entrada

Peça ou infira:

1. **Feature ou módulo** a implementar (ex.: "tela de usuários", "módulo de pedidos")
2. **Pastas prováveis** — ou descubra pela estrutura
3. **Stack** — se não for óbvio pelo repositório

## Passo a passo

### 1. Mapear estrutura

- Liste árvore relevante (`src/`, `app/`, `packages/`, etc.)
- Identifique onde vivem componentes, hooks, services, types, tests

### 2. Amostrar exemplos existentes

Para cada área, leia **2–4 arquivos** do mesmo tipo já no projeto:

| Área | Buscar por |
|------|------------|
| Pastas | Estrutura de feature similar |
| Componentes | Componente de listagem/form similar |
| Hooks | `use*.ts` na mesma feature |
| Services/API | `*Service*`, `*Api*`, `api/` |
| Tipagem | `types/`, `interfaces/`, DTOs |
| Formulários | telas com form existentes |
| Validação | `schema`, `zod`, `yup`, DTO validators |
| Estado | `store`, `context`, `useQuery` |
| Estilização | classes, modules, theme |

### 3. Extrair regras implícitas

Documente:

- Naming (PascalCase, kebab, sufixos `-page`, `.service.ts`)
- Ordem de imports
- Default export vs named export
- Colocation (test ao lado, styles junto)
- Error handling e loading patterns

### 4. Entregar Brief de Padrões

Use o template em [references/template-brief-padroes.md](references/template-brief-padroes.md).

Inclua seção **Não refatorar** — arquivos que não devem ser tocados.

### 5. Handoff para implementação

Ao final, resuma em **3–5 regras de ouro** que a implementação deve seguir.

Handoff: use `/front-implementador` ou subagente `front-implementador` para codar.

## Anti-padrões (evitar)

- Criar pasta `utils/` nova se o projeto usa `lib/` ou `helpers/`
- Introduzir Zod se o projeto usa Yup (ou vice-versa)
- Componente funcional com styled-components se o resto usa Tailwind
- "Melhorar" arquivos adjacentes sem escopo
- Copiar padrão de outro repo ou tutorial

## Relação com outros agentes

| Agente | Quando |
|--------|--------|
| **`/guardiao-padroes`** | **Antes** de codar — como fazer |
| `explorer` | Onde está X / como fluxo funciona |
| `code-reviewer` | **Depois** de codar — review |
| `/frontend-design` | UI criativa (ainda respeitando estilização do projeto) |
| `/replicacao-fiel-tela-por-print` | Copiar print (reutilizando componentes existentes) |

## Exemplo de invocação

```
/guardiao-padroes

Vou implementar a tela de listagem de usuários com filtro e modal de edição.
Analise os padrões do projeto antes de eu codar qualquer coisa.
Módulo provável: src/features/users ou similar.
```

```
/guardiao-padroes

Preciso adicionar endpoint de exportação CSV no backend NestJS deste repo.
Mapeie padrão de controllers, DTOs, services e validação.
Não refatore código existente.
```

Checklist completo: [references/checklist-padroes.md](references/checklist-padroes.md).
