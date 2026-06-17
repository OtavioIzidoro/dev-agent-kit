---
name: api-contract-frontend
description: Analyzes a described feature and returns only the API contract needed for frontend integration, using a fixed Portuguese template with endpoints, method, route, and request JSON. Use when the user asks for contrato da API, API contract for the frontend, integration contract from a functionality, or attaches or names this skill.
disable-model-invocation: true
---

# Contrato de API (frontend)

## Instruções para o agente

1. Obter a funcionalidade: texto do utilizador, ticket, ou inferência a partir do código quando o pedido for sobre o repositório atual.
2. Aplicar o comportamento e o formato definidos na secção seguinte (texto literal).
3. Na resposta ao utilizador, incluir **apenas** o contrato: a partir do cabeçalho `## Endpoints`, sem repetir o enunciado "Analise a funcionalidade...", sem introduções nem conclusões.
4. Repetir o bloco `### [Nome da ação]` para cada endpoint necessário, substituindo placeholders por valores concretos.
5. Se não houver corpo (ex.: GET sem body), usar `null` ou `{}` no JSON quando fizer sentido para o frontend; path/query relevantes podem aparecer como campos no JSON de **Request** ou na **Rota** (`:id`, query string), sem secções extra além do modelo.

## Comportamento e formato (texto literal)

Especificação a seguir, palavra por palavra e na mesma ordem:

````text
Analise a funcionalidade abaixo e retorne apenas o contrato da API necessário para integrar com o frontend.

Funcionalidade:
[DESCREVA AQUI A FUNCIONALIDADE]

Retorne de forma direta, no seguinte formato:

## Endpoints

### [Nome da ação]

**Método:** GET | POST | PUT | PATCH | DELETE  
**Rota:** `/api/...`

**Request:**
```json
{
  "campo": "valor"
}
```
````
