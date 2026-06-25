---
name: navegacao-web
description: Abre o sistema web no browser integrado do Cursor e executa cenários de teste passo a passo — navegação, cliques, preenchimento de formulários, validações visuais e reporte pass/fail. Use quando o usuário pedir testar no browser, executar cenários E2E manuais, smoke test, validar fluxo no sistema, abrir URL e percorrer telas, ou QA com navegação web.
disable-model-invocation: true
---

# Navegação Web — execução de cenários

Abra o sistema e execute cenários de teste no browser do Cursor usando as ferramentas MCP `cursor-ide-browser`.

## Pré-requisitos

- MCP **cursor-ide-browser** habilitado no Cursor
- URL do sistema (ex.: `http://localhost:3000`)
- Cenários definidos ou pedido do usuário para inferir a partir de critérios de aceite

Se o browser MCP não estiver disponível, informe o usuário e **não simule** a execução.

## Entrada esperada

Peça ou infira:

1. **URL base** do ambiente
2. **Credenciais** (se login for necessário) — nunca invente; peça ao usuário
3. **Lista de cenários** com passos e resultado esperado
4. **Escopo** — smoke, regressão de um módulo, fluxo completo

Formato mínimo de cenário:

```markdown
### C1 — Login com credenciais válidas
**Pré-condição:** usuário não autenticado
**Passos:**
1. Acessar /login
2. Preencher email e senha
3. Clicar em Entrar
**Esperado:** redirecionar para /dashboard e exibir nome do usuário
```

## Fluxo de execução

### 1. Preparar

- Confirmar URL e cenários
- Listar abas abertas: `browser_tabs` (action: list)
- Se o usuário pediu para **ver** o browser, use `position: "active"` ou `"side"` em `browser_navigate`; caso contrário, omita `position` (automação em background)

### 2. Abrir o sistema

Ordem correta:

```
browser_navigate → browser_lock (lock) → interações → browser_lock (unlock)
```

Se já existir aba na URL alvo, faça `browser_lock` antes de interagir.

### 3. Executar cada cenário

Para cada cenário:

1. **Snapshot** — `browser_snapshot` (fonte principal da estrutura da página)
2. **Ação** — `browser_click`, `browser_fill`, `browser_type`, `browser_select_option`, `browser_press_key`, `browser_scroll`
3. **Espera inteligente** — após ações que mudam a página, novo snapshot ou polling curto; evite loops cegos
4. **Evidência** — `browser_take_screenshot` em pass, fail ou estado ambíguo
5. **Registro** — anote status imediatamente (Pass / Fail / Bloqueado)

### 4. Validar resultados

Compare **resultado obtido** vs **esperado**:

- URL, título, textos visíveis, toasts, modais, estados de botão (disabled/enabled)
- Mensagens de erro devem ser citadas literalmente quando relevante
- Se elemento não aparecer no snapshot, tente escopo menor (`selector`) ou screenshot antes de falhar

### 5. Reportar

Use o formato da rule **qa-executor** (resumo + tabela de cenários + bloqueios).

## Regras de interação

- **Refs do snapshot são voláteis** — após navegação ou reload, gere novo snapshot antes de clicar
- **Iframes não são acessíveis** — se o fluxo estiver dentro de iframe, marque cenário como **Bloqueado** e reporte
- **Máximo 4 tentativas** com a mesma ação sem nova evidência; depois disso, pare e reporte
- **Bloqueios comuns** — login/SSO manual, captcha, 2FA, confirmação destrutiva: pare e peça ao usuário
- **Não use CDP Input.*** — use as ferramentas dedicadas de browser para cliques e digitação

## Ferramentas MCP (referência)

| Objetivo | Ferramenta |
|----------|------------|
| Abrir URL | `browser_navigate` |
| Ver estrutura da página | `browser_snapshot` |
| Clicar | `browser_click` |
| Preencher campo | `browser_fill` ou `browser_type` |
| Select / dropdown | `browser_select_option` |
| Teclado | `browser_press_key` |
| Scroll | `browser_scroll` |
| Evidência visual | `browser_take_screenshot` |
| Travar aba para sequência longa | `browser_lock` |

## Exemplo de invocação

```
/navegacao-web

URL: http://localhost:5173
Login: vou informar quando chegar na tela

Cenários:
1. Acessar home sem login → deve mostrar botão "Entrar"
2. Ir para /login, preencher credenciais válidas → dashboard
3. Abrir menu Usuários → listagem com colunas Nome, Email, Status
```

## Combinações úteis

- **Antes de executar:** subagente `explorer` para achar rotas no código (opcional)
- **Depois de fails:** subagente `code-reviewer` ou implementação de correção
- **Padrão de reporte:** rule `qa-executor`

Para exemplos de cenários, veja [references/cenarios-exemplo.md](references/cenarios-exemplo.md).
