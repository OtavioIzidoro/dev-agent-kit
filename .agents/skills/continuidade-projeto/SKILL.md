---
name: continuidade-projeto
description: Garante continuidade em projeto em andamento — seguir padrão existente, menor alteração segura, sem refatorar ou trocar biblioteca. Use ao entrar em projeto existente, antes/durante implementação, ou quando a prioridade for continuar o projeto como ele já é (não melhorá-lo).
disable-model-invocation: true
---

# Continuidade de Projeto

Não tente **melhorar** o projeto. Tente **continuar** o projeto como ele já é.

## Prompt de trabalho

Você está trabalhando em um projeto já em andamento.

A prioridade máxima é seguir o padrão existente.

Antes de alterar qualquer coisa:
1. Analise arquivos semelhantes.
2. Identifique o padrão de estrutura.
3. Identifique o padrão de nomenclatura.
4. Identifique como a aplicação faz chamadas de API.
5. Identifique como formulários são criados.
6. Identifique como erros e loading são tratados.
7. Identifique como componentes são estilizados.

Durante a implementação:
- Não crie padrão novo.
- Não troque biblioteca.
- Não mova arquivos sem necessidade.
- Não refatore código fora do escopo.
- Não reescreva componente inteiro se um ajuste pequeno resolver.
- Use os componentes, hooks e services já existentes.
- Preserve comportamento atual.
- Faça a menor alteração segura possível.

Antes de finalizar:
- Liste quais padrões do projeto foram seguidos.
- Liste arquivos alterados.
- Liste riscos de regressão.
- Liste o que precisa ser testado manualmente.

## Quando invocar

- Entrar em projeto existente desconhecido
- Início de qualquer tarefa em codebase legado
- Quando sentir risco de refatoração desnecessária
- **Antes** de implementar — combine com `/guardiao-padroes` (brief detalhado)
- **Depois** de implementar — checklist de finalização

## Relação com outros agentes

| Agente | Papel |
|--------|-------|
| **`/continuidade-projeto`** | **Filosofia + checklist** — continuar, não reinventar |
| `/guardiao-padroes` | Análise profunda **antes** de codar |
| `/front-implementador` | Implementar UI no padrão |
| `/api-integracao` | Integração API no padrão |
| `/code-reviewer` | Review diff antes do PR |

A rule `continuidade-projeto` está **sempre ativa** neste repositório instalado.

## Formato de finalização

Ao concluir uma tarefa, entregue:

```markdown
## Padrões seguidos
- [estrutura, naming, API, forms, errors, styling — com referência a arquivos exemplo]

## Arquivos alterados
- `path/arquivo` — o que mudou (1 linha)

## Riscos de regressão
- [área, motivo, como mitigar]

## Testes manuais pendentes
- [fluxo/tela a validar]
```

Depois: `/verificacao-build` → `/code-reviewer` → `/agente-testes` → `/documentacao-tarefa` (se aplicável).

Checklist: [references/checklist-continuidade.md](references/checklist-continuidade.md)
