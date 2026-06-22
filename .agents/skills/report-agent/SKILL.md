---
name: report-agent
description: Consolida achados de QA e gera relatório final em Markdown — documentação, classificação de bugs e priorização P0–P3. Use quando o usuário pedir relatório final de testes, consolidar resultados de QA, documentar bugs classificados, veredito de release, ou report técnico para PO/dev/gestão.
disable-model-invocation: true
---

# Report Agent — relatório final

Consolide resultados de testes e análises e gere o **relatório final** como Technical Writer.

## Quando usar vs sprint-status-report

| Situação | Use |
|----------|-----|
| Relatório **final de QA** (bugs, cenários, veredito de release) | `/report-agent` (esta skill) |
| Relatório **executivo de sprint** (planejado vs entregue, gestão) | `/sprint-status-report` |

## Entrada

Reúna ou peça:

1. Resultados de `/navegacao-web` e rule `qa-executor` (pass/fail)
2. Achados de `/front-qa` (UX, a11y, visual)
3. Achados de `/api-qa` (REST, JSON, HTTP, segurança)
4. Contexto: produto, feature, ambiente, período, versão

Se o usuário só tiver parte dos dados, gere o relatório com a seção **Escopo não verificado**.

## Fluxo

### 1. Inventariar evidências

- Liste todas as fontes recebidas
- Identifique duplicatas (mesmo bug reportado em front e E2E)
- Marque lacunas

### 2. Classificar achados

Para cada item:

| Campo | Opções |
|-------|--------|
| **Tipo** | Funcional, Visual/UI, API, A11y, Segurança, Performance, Regressão, Documentação |
| **Severidade** | Crítico, Alto, Médio, Baixo |
| **Prioridade** | P0, P1, P2, P3 |

**Severidade** = impacto. **Prioridade** = quando corrigir.

Exemplo: bug visual leve → Severidade Baixa, Prioridade P3.  
Falha de login → Severidade Crítica, Prioridade P0.

### 3. Consolidar bugs

- ID sequencial: `BUG-001`, `BUG-002`, ...
- Título curto e descritivo
- Passos para reproduzir ou evidência (curl, screenshot, cenário)
- Sugestão de correção ou owner (Front/API/Full-stack)

### 4. Gerar relatório

Use o template em [references/template-relatorio-final.md](references/template-relatorio-final.md).

Inclua sempre:

- Sumário executivo com **veredito** (Aprovado / Aprovado com ressalvas / Reprovado)
- Métricas consolidadas
- Matriz de priorização (P0 primeiro)
- Recomendações acionáveis
- Bloco Markdown completo para salvar
- Nome sugerido do arquivo

## Exemplo de invocação

```
/report-agent

Consolide os testes da feature Checkout:

- E2E: 8 pass, 2 fail (pagamento cartão, cupom inválido)
- Front QA: 3 achados a11y na tela de resumo
- API QA: POST /orders retorna 500 quando cupom expirado

Ambiente: staging | Branch: feature/checkout
Veredito de release necessário.
```

```
/report-agent

[cole outputs de front-qa, api-qa e navegacao-web]

Gere relatório final com bugs classificados e priorizados.
```

## Relação com outros agentes

| Agente/Skill | Papel no fluxo |
|--------------|----------------|
| `/navegacao-web` | Executa cenários → insumo |
| `/front-qa` | Análise visual → insumo |
| `/api-qa` | Análise API → insumo |
| `/report-agent` | **Consolida tudo → relatório final** |
| `/sprint-status-report` | Relatório de gestão de sprint (paralelo, não substituto) |

Classificação detalhada: [references/classificacao-bugs.md](references/classificacao-bugs.md).
