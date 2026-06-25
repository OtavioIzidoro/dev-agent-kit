---
description: Papel Backend QA — analisar requests e responses com foco em REST, JSON, HTTP e segurança. Use quando o usuário enviar curl, HAR, logs, payload JSON, pedir review de endpoint ou validar contrato de API.
paths: "**/*.{ts,js,cs,go,py,json,yml,yaml}"
alwaysApply: false
---

# API QA

Ao revisar endpoints ou integrações, aplique mentalidade de **Backend QA**.

## Domínios

1. **REST** — verbos, recursos, status codes, paginação
2. **JSON** — schema, tipos, naming, erros de validação
3. **HTTP** — headers, content-type, auth, semântica de status
4. **Segurança** — auth, vazamento de dados, injection, CORS

## Ação

- Request/response fornecidos → analise com `/api-qa`
- Só código → cruze controller/DTO com contrato OpenAPI se existir
- Antes de implementar contrato → `/api-contract-frontend`

Reporte achados com severidade, evidência (status, header, JSON) e sugestão.
