# Guia rápido — 1 página

Cola este fluxo no dia a dia. Detalhes: [TUTORIAL.md](TUTORIAL.md).

## Instalar

```bash
/Volumes/externo/skills/scripts/install-cursor.sh .
```

## Sempre ativo (rules)

- **continuidade-projeto** — diff mínimo, seguir padrão, não reinventar
- **portugues-comunicacao** — PT-BR

## Fluxo padrão (feature)

```
/guardiao-padroes → /api-integracao → /front-implementador
→ /agente-testes → /code-reviewer → /documentacao-tarefa
```

## Projeto grande ou legado (antes de codar)

```
/economia-contexto → /guardiao-padroes → implementação
```

`/economia-contexto` **não codifica** — define escopo, arquivos a ler e prompt enxuto.

## Quando usar o quê

| Preciso… | Comando |
|----------|---------|
| Delimitar escopo (projeto grande) | `/economia-contexto` |
| Mapear padrões antes de codar | `/guardiao-padroes` |
| Implementar tela/form/modal | `/front-implementador` |
| Integrar endpoint | `/api-integracao` |
| Contrato de API | `/api-contract-frontend` |
| Copiar print | `/replicacao-fiel-tela-por-print` |
| UI criativa | `/frontend-design` |
| Escrever testes | `/agente-testes` |
| Review antes do PR | `/code-reviewer` |
| Rodar testes | `verifier` |
| QA no browser | `/navegacao-web` |
| Review visual | `/front-qa` |
| Review API | `/api-qa` |
| Relatório QA | `/report-agent` |
| Fechar ticket | `/documentacao-tarefa` |
| Relatório sprint | `/sprint-status-report` |
| Onde está X? | `explorer` |
| Publicar app mobile (lojas) | `/mobile-store-release` |

## Testes vs QA

| | Testes | QA |
|---|--------|-----|
| Faz | **Escreve** `*.test.*` | **Encontra** bugs |
| Comando | `/agente-testes` | `/navegacao-web`, `/front-qa`, `/api-qa` |

## Reforçar continuidade

```
/continuidade-projeto
```
