# Exemplos de cenários para navegação web

## Smoke test — aplicação web

```markdown
### C1 — Home carrega
**Passos:** Acessar URL base
**Esperado:** Página carrega sem erro 500; título ou logo visível

### C2 — Login válido
**Pré-condição:** credenciais de teste fornecidas
**Passos:**
1. Ir para /login
2. Preencher email e senha
3. Clicar Entrar
**Esperado:** Redireciona para área autenticada; menu principal visível

### C3 — Login inválido
**Passos:**
1. Ir para /login
2. Preencher credenciais incorretas
3. Clicar Entrar
**Esperado:** Mensagem de erro; permanece em /login
```

## CRUD — cadastro de entidade

```markdown
### C1 — Listagem vazia
**Passos:** Acessar /produtos
**Esperado:** Tabela ou empty state "Nenhum produto"

### C2 — Criar registro
**Passos:**
1. Clicar "Novo produto"
2. Preencher nome e preço
3. Salvar
**Esperado:** Toast de sucesso; item aparece na listagem

### C3 — Validação obrigatória
**Passos:**
1. Clicar "Novo produto"
2. Salvar sem preencher campos
**Esperado:** Mensagens de validação nos campos obrigatory
```

## Fluxo com filtros e paginação

```markdown
### C1 — Filtro por status
**Passos:**
1. Acessar listagem
2. Selecionar filtro "Ativo"
3. Aplicar
**Esperado:** Apenas registros ativos; contador ou URL reflete filtro

### C2 — Paginação
**Passos:**
1. Clicar página 2
**Esperado:** Novos itens carregam; indicador de página atual = 2
```

## Template em branco

Copie e preencha:

```markdown
### C[N] — [nome curto]
**Pré-condição:** [estado inicial]
**Passos:**
1. ...
2. ...
**Esperado:** [comportamento observável]
**Dados de teste:** [opcional]
```
