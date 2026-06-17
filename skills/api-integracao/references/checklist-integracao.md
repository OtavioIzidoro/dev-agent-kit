# Checklist — API / Integração

## Tipagens

- [ ] `CreateXRequest` / `UpdateXRequest`
- [ ] `XResponse` / `XListItem`
- [ ] `PaginatedResponse<T>` ou meta do projeto
- [ ] `ApiError` / `ValidationError` com campos
- [ ] Query type: `ListXParams` (`page`, `limit`, filtros)
- [ ] Sem `any` em fronteira HTTP

## Payload (POST/PUT/PATCH)

- [ ] Schema valida antes do fetch
- [ ] Required fields enforced
- [ ] Transformações (trim, parse number) antes de enviar
- [ ] File upload no padrão do projeto (se aplicável)
- [ ] Content-Type correto

## Query params

- [ ] `URLSearchParams` ou helper do projeto
- [ ] Boolean: `true`/`false` ou `1`/`0` conforme API
- [ ] Array: `tags=a&tags=b` vs `tags=a,b`
- [ ] Sort/order params nomeados no contrato
- [ ] Undefined/null não vira string `"undefined"`

## Paginação

- [ ] Estado: page + pageSize ou cursor
- [ ] UI: next/prev ou infinite scroll conforme projeto
- [ ] Total count exibido se API retorna
- [ ] Loading entre páginas
- [ ] Empty na página sem itens

## Filtros

- [ ] Estado de filtro tipado
- [ ] Apply vs debounce (busca textual)
- [ ] Sync com URL searchParams (se padrão)
- [ ] Botão limpar filtros
- [ ] Filtro dispara refetch

## Status HTTP

| Status | Tratamento |
|--------|------------|
| 200/201 | Success path |
| 204 | Sem body, UI atualiza |
| 400 | Payload inválido genérico |
| 401 | Login/refresh token |
| 403 | Sem permissão — mensagem clara |
| 404 | Not found |
| 409 | Conflito — mensagem específica |
| 422 | Erros por campo → form |
| 500 | Erro genérico + log |

## Tratamento de erro na UI

- [ ] Toast ou inline conforme projeto
- [ ] Field errors mapeados para inputs
- [ ] Retry em falha de rede (se padrão)
- [ ] Não expor stack trace ao usuário

## Contrato front/back

- [ ] Campos response usados existem no type
- [ ] Campos request existem no backend
- [ ] Naming camelCase vs snake_case — transform se necessário
- [ ] Versionamento de API respeitado

## Arquivos típicos

```
types/user.types.ts
services/user.service.ts
hooks/useUsers.ts
schemas/user.schema.ts   # validação
```

Adaptar paths ao projeto (`/guardiao-padroes`).
