---
name: front-qa
description: Analisa front-end via screenshots e DOM — responsividade, UX, acessibilidade e validação visual. Use quando o usuário enviar screenshot ou print, pedir auditoria de interface, review visual, checagem de a11y, validar responsividade ou comparar tela com referência de design.
disable-model-invocation: true
---

# Front QA — análise de screenshots e DOM

Analise interfaces web com foco em **responsividade**, **UX**, **acessibilidade** e **validação visual**.

## Entrada

O usuário pode fornecer:

1. **Screenshot(s)** — mobile, tablet, desktop ou estados (erro, empty, loading)
2. **URL** — para capturar DOM via browser MCP
3. **Arquivos de código** — `.tsx`, `.html`, `.css` da tela
4. **Referência de design** — Figma, print anterior, mock

Peça breakpoint ou viewport quando relevante e não estiver claro.

## Fluxo de análise

### 1. Coletar evidência

**Com screenshot anexado:**
- Analise layout, tipografia, cores, espaçamentos e estados visíveis
- Identifique viewport aparente (mobile vs desktop)

**Com URL e browser MCP:**
```
browser_navigate → browser_snapshot → browser_take_screenshot
```
Repita em viewports diferentes se o usuário pedir responsividade (resize via CDP ou peça screenshots por breakpoint).

**Com código:**
- Leia markup, componentes, CSS/Tailwind, media queries
- Cruze com snapshot quando ambos estiverem disponíveis

### 2. Executar checklist (4 domínios)

#### Responsividade
- Quebras de layout, overflow, elementos cortados
- Touch targets, legibilidade, adaptação de tabelas/cards
- Comportamento em breakpoints comuns (320, 768, 1024, 1440)

#### UX
- Hierarquia, clareza de ações, feedback (loading/erro/sucesso)
- Empty states, consistência de padrões, fricção no fluxo

#### Acessibilidade
- Contraste, foco, labels, aria, ordem de tab, headings semânticos
- Referência: WCAG 2.1 nível AA quando aplicável

#### Validação visual
- Alinhamento, grid, design system, estados de componentes
- Comparação com referência quando fornecida

### 3. Reportar

Use o formato abaixo. Cada achado precisa de **evidência** e **sugestão** acionável.

```markdown
# Front QA — [nome da tela]

**Escopo:** [URL / arquivo / viewport]
**Referência:** [sim/não — descrever]

## Resumo
- Crítico: N | Alto: N | Médio: N | Baixo: N

## Responsividade
| # | Sev. | Achado | Evidência | Sugestão |

## UX
| # | Sev. | Achado | Evidência | Sugestão |

## Acessibilidade
| # | Sev. | Achado | Evidência | Sugestão |

## Validação visual
| # | Sev. | Achado | Evidência | Sugestão |

## Veredito
[Aprovado | Aprovado com ressalvas | Reprovado]
```

## Severidade

| Nível | Exemplo |
|-------|---------|
| Crítico | Botão principal inacessível, layout ilegível no mobile |
| Alto | Contraste insuficiente, fluxo sem feedback de erro |
| Médio | Espaçamento inconsistente, empty state ausente |
| Baixo | Alinhamento de 2–4px, ícone levemente desalinhado |

## Exemplo de invocação

```
/front-qa

Analise este print da tela de login em mobile.
Foco: acessibilidade e responsividade.

[anexar screenshot]
```

```
/front-qa

URL: http://localhost:5173/dashboard
Compare com o print de referência anexo.
Validar: UX do menu lateral + contraste dos cards.
```

## Relação com outros agentes

| Tarefa | Use |
|--------|-----|
| Analisar screenshot/DOM (esta skill) | `/front-qa` |
| Executar cenários no browser | `/navegacao-web` |
| Reporte pass/fail de cenários | rule `qa-executor` |
| Review de código TypeScript | subagente `code-reviewer` |

Checklist detalhado: [references/checklist-front-qa.md](references/checklist-front-qa.md).
