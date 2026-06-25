---
description: API/Integração — tipagens, payload, query params, paginação, filtros, erros HTTP e contrato front/back. Use quando endpoint, formulário com API, listagem, filtros ou integração front-end.
paths: "**/*.{ts,tsx,js,jsx}"
alwaysApply: false
---

# API / Integração

Tarefas com **endpoint, form, listagem ou filtros**:

1. Tipar request/response (sem `any`)
2. Validar payload antes de enviar
3. Query params, paginação e filtros no padrão do projeto
4. Tratar status HTTP e erros na UI
5. Alinhar com contrato back (`/api-contract-frontend` ou OpenAPI)

Implementação: `/api-integracao`. Validação pós-deploy: `/api-qa`.
