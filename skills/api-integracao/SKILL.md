---
name: api-integracao
description: Implementa integração front/back — tipagens request/response, validação de payload, query params, paginação, filtros, tratamento de erro, status HTTP e alinhamento de contrato. Use quando a tarefa envolve endpoint, formulário com API, listagem, filtros, paginação ou consumo de serviço no frontend.
disable-model-invocation: true
---

# API / Integração

Integração de telas com endpoints: tipagem, chamadas, validação e erros.

## Quando usar

| Tarefa | Use esta skill |
|--------|----------------|
| Tela consumindo endpoint | ✅ |
| Formulário POST/PUT/PATCH | ✅ |
| Listagem + paginação | ✅ |
| Filtros na query | ✅ |
| Criar hook/service de API | ✅ |
| Conferir contrato front/back | ✅ |
| Só gerar documento de contrato | `/api-contract-frontend` |
| Só analisar curl/HAR (QA) | `/api-qa` |
| Só UI sem lógica de API | `/front-implementador` |

## Fluxo recomendado

```
/guardiao-padroes → /api-contract-frontend (se necessário) → /api-integracao → /front-implementador → /code-reviewer
```

Pode implementar **só a camada de API** (types + service + hook) e depois a UI com `/front-implementador`.

## Entrada

1. **Endpoints** — método, rota, contrato ou OpenAPI
2. **Feature** — listagem, form, detalhe, ação
3. **Filtros/paginação** — campos e comportamento esperado
4. **Onde** — paths de service/hook/types no projeto

## Checklist de implementação

### Tipagens
- [ ] Request body tipado
- [ ] Query params tipados
- [ ] Path params tipados
- [ ] Response success tipada
- [ ] Response error tipada
- [ ] Paginação/meta tipada (`PaginatedResponse<T>`)

### Payload
- [ ] Validação antes do envio (schema do projeto)
- [ ] Campos opcionais/null tratados
- [ ] Datas e números no formato do backend
- [ ] Sem campos extras no body

### Query / filtros / paginação
- [ ] Params serializados como backend espera
- [ ] Filtros vazios omitidos ou enviados conforme contrato
- [ ] Paginação no padrão do projeto (page/limit ou cursor)
- [ ] Reset de page ao filtrar

### HTTP e erros
- [ ] Status 2xx tratados corretamente
- [ ] 400/422 → erros por campo na UI
- [ ] 401/403 → fluxo auth do projeto
- [ ] 404/409/500 → mensagens adequadas
- [ ] Network/timeout → feedback ao usuário
- [ ] Loading e error state no hook

### Contrato
- [ ] Types batem com OpenAPI/DTO/contrato
- [ ] Divergências documentadas se backend diferir

## Exemplos de invocação

```
/api-integracao

Implemente integração da listagem de usuários:
GET /api/users?page&limit&name&status
Tipos, service e useUsers no padrão do projeto.
Contrato: [colar ou referenciar openapi]
```

```
/api-integracao

Formulário de criação de pedido POST /api/orders
- Tipagem request/response
- Validação Zod (projeto usa Zod)
- useCreateOrder com tratamento de 422
Integrar com tela depois via /front-implementador.
```

## Pós-implementação

```
/api-integracao  →  /api-qa (validar chamadas)  →  /code-reviewer
```

Referência: [references/checklist-integracao.md](references/checklist-integracao.md)
