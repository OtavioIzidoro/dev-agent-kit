---
name: documentacao-tarefa
description: Documenta entrega de tarefa finalizada — resumo, descrição técnica simples, evidência, o que foi corrigido, comentário para Jira/Trello/ClickUp e sugestão de branch. Use depois de finalizar a tarefa, ao fechar ticket, ou quando pedir registro de entrega, resumo para gestão ou documentação de correção.
disable-model-invocation: true
---

# Documentação de Tarefa

Registre a entrega **depois de finalizar** a tarefa — para ticket, gestão e histórico.

## Quando usar

| Situação | Use |
|----------|-----|
| Tarefa concluída, fechar ticket | ✅ |
| Comentário Jira/Trello/ClickUp | ✅ |
| Evidência para PO/gestor | ✅ |
| Resumo de correção ou feature | ✅ |
| Relatório de sprint inteira | `/sprint-status-report` |
| Relatório QA com bugs | `/report-agent` |

## Entrada

- Número do ticket (opcional)
- O que foi feito (ou inferir do diff/commits)
- Evidência: teste, print, validação manual
- Ferramenta destino: Jira, Trello, ClickUp (ajusta tom se informado)

## Coleta de contexto

1. Conversa e descrição do usuário
2. `git status`, `git diff`, `git log -3 --oneline`
3. Arquivos alterados — impacto funcional apenas

## Saída obrigatória

```markdown
## Título

[Título curto e objetivo]

## Descrição

[Problema ou necessidade — linguagem simples, para leigos]

## Descrição técnica (resumo)

[2–4 frases objetivas para dev/PO — o que mudou no sistema, sem listar arquivos]

## Evidência

[Como foi validado: teste, tela, print. Se incompleto, o que falta validar]

## O que foi corrigido

[O que mudou do ponto de vista do usuário ou operação]

## Comentário para ticket (Jira/Trello/ClickUp)

[Texto pronto para colar — parágrafo ou bullets curtos]

## Sugestão de branch

[type/numberTicket-titulo-curto]
```

## Regras de escrita

- PT-BR, frases curtas
- Resumo principal **sem jargão** (evite API, endpoint, refactor salvo pedido)
- **Não invente** testes ou evidências
- Máximo 2 perguntas se faltar contexto crítico
- Não cite nomes de classes/arquivos no bloco para gestão
- Sugestão de branch: `fix`, `feat`, `refactor`, `chore`, `docs`, `test` + ticket ou `sem-ticket`

## Exemplo

**Entrada:**

```
Ticket 2172. Corrigi o card de disponibilidade — tempo por equipamento não aparecia.
Testei na tela de análise.
```

**Saída (trecho):**

```markdown
## Título
Correção no tempo de indisponibilidade por equipamento

## Comentário para ticket (Jira/Trello/ClickUp)
Corrigida a exibição do tempo de indisponibilidade por equipamento no card de análise de disponibilidade. Validado na tela de análise, com os tempos exibidos corretamente para cada equipamento.

## Sugestão de branch
fix/2172-ajuste-indisponibilidade-equipamentos
```

## Fluxo recomendado

```
guardiao-padroes → implementação → code-reviewer → agente-testes → documentacao-tarefa → fechar ticket
```

Templates por ferramenta: [references/templates-ticket.md](references/templates-ticket.md)
