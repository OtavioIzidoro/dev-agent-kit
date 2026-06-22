---
name: front-implementador
description: Implementa telas, componentes e fluxos front-end — formulários, hooks, integração API, modais, tabelas, filtros, select, checkbox e layout. Use quando o usuário pedir criar tela, ajustar componente, implementar UI, form, modal, tabela, consumir hook ou integrar API no frontend.
disable-model-invocation: true
---

# Front-end Implementador

Desenvolve telas, componentes e fluxos de interface. Código funcional, escopo focado, padrões do projeto.

## Quando usar

- Criar tela ou página nova
- Ajustar componente existente
- Implementar formulário, modal, tabela, filtro, select, checkbox
- Consumir ou criar hook
- Integrar front com API
- Ajustar layout e responsividade

## Pré-requisito: padrões do projeto

```
/guardiao-padroes   →   /front-implementador
```

Se o brief já existir na conversa, siga-o. Caso contrário, leia exemplos similares antes de codar.

## Entrada esperada

1. **O quê** — tela, componente ou fluxo
2. **Onde** — caminho ou módulo (`src/features/users/`)
3. **Referência** — print, Figma, ticket, contrato API
4. **Critérios** — campos, ações, estados, integrações

## Fluxo

### 1. Preparar

- [ ] Brief de padrões ou exemplos lidos
- [ ] Componentes/hooks/services reutilizáveis identificados
- [ ] Contrato API disponível (se integração)

### 2. Implementar por camada

| Camada | Ação |
|--------|------|
| Types | Tipos da feature, DTOs de form/list |
| Service/hook | API ou reutilizar existente — camada detalhada: `/api-integracao` |
| Componentes | UI com design system do projeto |
| Page | Compor layout, estados, rota |
| Validação | Schema no padrão do projeto |

### 3. Estados obrigatórios (telas com dados)

- **Loading** — skeleton ou spinner do projeto
- **Empty** — mensagem quando lista vazia
- **Error** — feedback claro, retry se aplicável
- **Success** — toast ou redirect conforme padrão

### 4. Checklist de entrega

- [ ] Arquivos no path correto
- [ ] Naming consistente
- [ ] Componentes base reutilizados
- [ ] Form + validação no padrão do projeto
- [ ] API integrada (não mock desnecessário)
- [ ] Responsivo como telas similares
- [ ] Sem alteração fora do escopo

## Referência visual

| Situação | Skill auxiliar |
|----------|----------------|
| Print para copiar fielmente | `/replicacao-fiel-tela-por-print` |
| Design criativo sem referência | `/frontend-design` |
| Contrato de API | `/api-contract-frontend` |
| Camada HTTP (types, hook, erros) | `/api-integracao` |

A implementação fica com **esta skill**; as auxiliares definem aparência ou contrato.

## Exemplos de invocação

```
/front-implementador

Crie a tela de listagem de usuários em src/features/users/
- Tabela com nome, email, status
- Filtro por nome e status
- Modal de edição
- Integrar GET/PUT conforme contrato anexo
Brief de padrões já foi feito com /guardiao-padroes.
```

```
/front-implementador

Ajuste o componente OrderFilter: adicionar select de status e checkbox "apenas ativos".
Reutilize hooks existentes. Não refatore outros arquivos.
```

## Pós-implementação

```
/front-implementador  →  /code-reviewer  →  /front-qa  →  PR
```

Checklist: [references/checklist-implementacao.md](references/checklist-implementacao.md).
