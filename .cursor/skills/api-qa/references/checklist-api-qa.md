# Checklist API QA

## REST

- [ ] GET não altera estado (idempotente)
- [ ] POST retorna 201 + Location ou id do recurso criado
- [ ] PUT/PATCH retorna 200 ou 204 conforme spec
- [ ] DELETE retorna 204 ou 404 quando recurso não existe
- [ ] 404 para recurso inexistente (não 500 genérico)
- [ ] 409 para conflito (duplicidade, versão)
- [ ] 422 para erro de validação de negócio/campos
- [ ] URLs com substantivos (`/users`, não `/getUsers`)
- [ ] Paginação documentada e consistente
- [ ] Filtros via query string, não verbos na URL

## JSON

- [ ] Response é JSON válido
- [ ] Tipos corretos (string id vs number, boolean vs "true")
- [ ] Campos nullable documentados e consistentes
- [ ] Listagem retorna array ou envelope `{ data: [] }` padronizado
- [ ] Erro de validação lista campos afetados
- [ ] Datas em ISO 8601 (UTC ou offset explícito)
- [ ] Enums com valores estáveis (não magic numbers sem documentação)
- [ ] Naming consistente em todo o API (camelCase ou snake_case)

## HTTP

- [ ] `Content-Type: application/json` em requests com body
- [ ] Response `Content-Type` correto
- [ ] `Authorization` presente em rotas protegidas
- [ ] 401 (não autenticado) vs 403 (sem permissão) usados corretamente
- [ ] Correlation/request ID em logs ou header quando aplicável
- [ ] Sem body em 204
- [ ] Redirect 3xx apenas quando intencional
- [ ] Payload não excessivamente grande

## Segurança

- [ ] Rotas sensíveis exigem autenticação
- [ ] Senha, hash, token completo não aparecem no response
- [ ] PII mínima necessária exposta
- [ ] Input validado (tamanho, tipo, whitelist)
- [ ] Sem SQL/NoSQL/command injection em parâmetros
- [ ] Rate limiting em login e endpoints críticos
- [ ] CORS não usa `*` com credentials
- [ ] Erro 500 não expõe stack trace em produção
- [ ] Campos sensíveis não graváveis via mass assignment
- [ ] IDs previsíveis não permitem enumeração sem auth

## Cenários de teste sugeridos

| Cenário | Esperado típico |
|---------|-----------------|
| Request válido | 200/201 + body correto |
| Body malformado | 400 |
| Campo obrigatório ausente | 422 |
| Token ausente | 401 |
| Token válido, sem permissão | 403 |
| ID inexistente | 404 |
| Duplicidade | 409 |
| Payload oversized | 413 |

## Evidência mínima por achado

- Método + URL
- Request headers/body relevantes (redact secrets)
- Status code + response headers/body
- Trecho de spec ou código que contradiz o comportamento
