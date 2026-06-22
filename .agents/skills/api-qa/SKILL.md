---
name: api-qa
description: Analisa requests e responses de APIs — REST, JSON, HTTP e segurança. Use quando o usuário enviar curl, HAR, logs, payload JSON, pedir review de endpoint, validar status codes e headers, auditar segurança de rotas, ou comparar response real com contrato OpenAPI.
disable-model-invocation: true
---

# API QA — análise de requests e responses

Analise chamadas HTTP com foco em **REST**, **JSON**, **HTTP** e **segurança**.

## Entrada

O usuário pode fornecer:

1. **curl** ou comando HTTP reproduzível
2. **Request + response** (JSON, headers, status)
3. **HAR** ou export da aba Network
4. **Logs** de aplicação ou gateway
5. **Código** — controller, DTO, middleware, testes de integração
6. **Contrato** — OpenAPI, Swagger ou output de `/api-contract-frontend`

Peça ambiente (local/staging) e autenticação quando a análise depender disso.

## Fluxo de análise

### 1. Coletar evidência

- Identifique: método, URL, query, headers, body, status, response body, tempo
- Se só houver código, infira o contrato esperado e indique o que precisa ser executado para validar
- Se houver spec OpenAPI, use como baseline de comparação

### 2. Executar checklist (4 domínios)

#### REST
- Verbo, recurso, status code, semântica da operação
- Paginação (`page`, `limit`, `cursor`), filtros, ordenação
- Erros 4xx/5xx com significado correto

#### JSON
- Tipos, campos obrigatórios, enums, datas, IDs
- Consistência de naming e estrutura entre endpoints
- Formato de erros de validação (422)

#### HTTP
- Content-Type, Accept, Authorization, correlation IDs
- Cache headers quando aplicável
- Corpo ausente vs `{}` vs `null`

#### Segurança
- AuthN/AuthZ, exposição de dados, injection, CORS, rate limit
- Erros sem vazamento de stack/detalhes internos

### 3. Testes sugeridos (quando executável)

Se tiver acesso a terminal e URL:

```bash
curl -i -X GET "https://api.exemplo.com/recurso" \
  -H "Authorization: Bearer ..." \
  -H "Accept: application/json"
```

Varie cenários: payload inválido, sem auth, ID inexistente, conflito (409).

### 4. Reportar

```markdown
# API QA — [endpoint]

**Método:** GET | POST | ...
**Rota:** /api/...
**Ambiente:** ...

## Resumo
- Crítico: N | Alto: N | Médio: N | Baixo: N

## REST
| # | Sev. | Achado | Evidência | Sugestão |

## JSON
| # | Sev. | Achado | Evidência | Sugestão |

## HTTP
| # | Sev. | Achado | Evidência | Sugestão |

## Segurança
| # | Sev. | Achado | Evidência | Sugestão |

## Veredito
[Aprovado | Aprovado com ressalvas | Reprovado]
```

## Exemplo de invocação

```
/api-qa

Analise este request/response do endpoint de criação de usuário:

POST /api/users
Request: { "email": "a@b.com", "name": "Test" }
Response 201: { "id": "uuid", "email": "a@b.com" }

Foco: REST, validação JSON e se expõe dados desnecessários.
```

```
/api-qa

[cole curl ou HAR]

Compare com o contrato em docs/openapi.yaml.
```

## Relação com outros agentes

| Tarefa | Use |
|--------|-----|
| Analisar request/response (esta skill) | `/api-qa` |
| Gerar contrato para o frontend | `/api-contract-frontend` |
| Executar fluxo no browser | `/navegacao-web` |
| Review visual de tela | `/front-qa` |
| Reporte pass/fail de cenários | rule `qa-executor` |

Checklist detalhado: [references/checklist-api-qa.md](references/checklist-api-qa.md).
