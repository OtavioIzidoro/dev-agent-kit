# Classificação e priorização de bugs

## Severidade vs prioridade

| Conceito | Pergunta | Exemplo |
|----------|----------|---------|
| **Severidade** | Quão grave é o impacto? | Login quebrado = Crítico |
| **Prioridade** | Quando corrigir? | Typo em rodapé = P3, mesmo sendo Baixo |

Um bug **Crítico** quase sempre é **P0**. Um bug **Baixo** pode ser **P2** se afetar demo para cliente amanhã.

## Matriz tipo × severidade

| Tipo | Exemplos | Severidade típica |
|------|----------|-------------------|
| **Funcional** | Botão não salva, fluxo interrompido | Alto–Crítico |
| **Visual/UI** | Desalinhamento, overflow mobile | Baixo–Médio |
| **API** | Status 500, schema errado | Alto–Crítico |
| **A11y** | Sem label, contraste insuficiente | Médio–Alto |
| **Segurança** | Dados expostos, auth bypass | Crítico |
| **Performance** | Timeout > 30s, listagem lenta | Médio–Alto |
| **Regressão** | Feature que funcionava quebrou | Alto–Crítico |
| **Documentação** | OpenAPI desatualizada | Baixo–Médio |

## Priorização P0–P3

### P0 — Corrigir agora
- Produção down ou release bloqueado
- Vulnerabilidade crítica de segurança
- Perda ou corrupção de dados
- Fluxo crítico de negócio impossível

### P1 — Corrigir nesta sprint
- Fluxo principal com workaround ruim
- Bug afetando maioria dos usuários
- Falha de integração core sem contorno

### P2 — Próxima sprint
- Fluxo secundário
- Bug com workaround aceitável
- Débito técnico de QA relevante

### P3 — Backlog
- Cosmético
- Edge case raro
- Melhoria de polish

## Campos obrigatórios por bug

1. **ID** — BUG-001, BUG-002, ...
2. **Título** — uma linha, específico
3. **Tipo** — da tabela acima
4. **Severidade** — Crítico / Alto / Médio / Baixo
5. **Prioridade** — P0 / P1 / P2 / P3
6. **Passos para reproduzir** — ou evidência equivalente
7. **Esperado vs obtido**
8. **Evidência** — screenshot, curl, log, cenário ID
9. **Sugestão** — correção ou área responsável

## Veredito de release

| Veredito | Critério |
|----------|----------|
| **Aprovado** | Zero P0/P1 abertos; P2 aceitos pelo PO |
| **Aprovado com ressalvas** | P1 com workaround documentado; plano de correção |
| **Reprovado** | P0 aberto, ou P1 crítico sem contorno |

## Consolidar duplicatas

Ao mesclar achados de front-qa, api-qa e navegacao-web:

- Mesmo sintoma, mesma tela → **1 bug**
- Mesmo endpoint, request e response → **1 bug**
- Sintoma UI + causa API → **1 bug** com notas em Front e API
