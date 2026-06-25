# Instruções do agente (dev-agent-kit)

> Catálogo completo: skills em `.agents/skills/` (Codex) ou `.claude/skills/` (Claude) ou `.cursor/skills/` (Cursor).

## Sempre ativo

- **Continuidade:** projeto já em andamento — siga o padrão existente, diff mínimo, não refatore fora do escopo.
- **Build:** detecte stack (.NET, Java, Node, React), rode build antes de finalizar; não entregue com compilação quebrada.
- **Idioma:** responda em português do Brasil, salvo pedido explícito em outro idioma.

## Fluxo recomendado (feature)

1. `/guardiao-padroes` — mapear padrões do projeto
2. `/api-integracao` — contrato, types, service, erros
3. `/front-implementador` — tela, form, modal, integração
4. `/agente-testes` — testes automatizados
5. `/code-reviewer` — revisar diff antes do PR
6. `verifier` ou `/verificacao-build` — build + testes
7. `/documentacao-tarefa` — registrar entrega no ticket

## Projeto grande ou legado

Use `/economia-contexto` **antes** de codar (não codifica — só delimita escopo).

## Skills principais

| Preciso… | Skill |
|----------|-------|
| Mapear padrões | `guardiao-padroes` |
| Implementar UI | `front-implementador` |
| Integrar API | `api-integracao` |
| Escrever testes | `agente-testes` |
| Review de PR | `code-reviewer` |
| Validar build/compilação | `verificacao-build` |
| Rodar build + testes | `verifier` |
| QA visual | `front-qa` |
| QA de API | `api-qa` |
| Fechar ticket | `documentacao-tarefa` |
