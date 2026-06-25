# Z-API — referência técnica

Índice completo: https://developer.z-api.io/llms.txt

## Base URL

```
https://api.z-api.io/instances/{instanceId}/token/{token}/{endpoint}
```

## Headers

| Header | Obrigatório | Valor |
|--------|-------------|-------|
| `Content-Type` | Sim | `application/json` |
| `Client-Token` | Se ativo no painel | Token de segurança da conta |

## Variáveis de ambiente sugeridas

```env
ZAPI_INSTANCE_ID=
ZAPI_INSTANCE_TOKEN=
ZAPI_CLIENT_TOKEN=
ZAPI_WEBHOOK_BASE_URL=https://seu-dominio.com/webhook
```

## Endpoints de envio frequentes

| Ação | Método | Endpoint |
|------|--------|----------|
| Texto | POST | `/send-text` |
| Imagem | POST | `/send-message-image` |
| Áudio | POST | `/send-message-audio` |
| Documento | POST | `/send-message-document` |
| Botões (até 3) | POST | `/send-button-list` |
| Lista de opções | POST | `/send-option-list` |
| Responder mensagem | POST | `/reply-message` |
| Marcar como lida | POST | `/read-message` |

### send-text — body

```json
{
  "phone": "5511999999999",
  "message": "Texto com *negrito*",
  "delayMessage": 1,
  "delayTyping": 3
}
```

### send-text — response 200

```json
{
  "zaapId": "...",
  "messageId": "...",
  "id": "..."
}
```

## Configurar webhooks

**Todos de uma vez:**

```
PUT /update-every-webhooks
```

```json
{
  "value": "https://seu-dominio.com/webhook",
  "notifySentByMe": false
}
```

**Individual (receive):**

```
PUT /update-webhook-receive
```

```json
{
  "value": "https://seu-dominio.com/webhook/receive"
}
```

Z-API **não aceita** webhook sem HTTPS.

## Webhook Receive — texto

`type: "ReceivedCallback"`

```json
{
  "phone": "5511999999999",
  "messageId": "ABC123",
  "fromMe": false,
  "isGroup": false,
  "isNewsletter": false,
  "instanceId": "...",
  "momment": 1632228638000,
  "status": "RECEIVED",
  "chatName": "João",
  "senderName": "João",
  "type": "ReceivedCallback",
  "text": {
    "message": "oi"
  }
}
```

## Extrair texto do usuário

| Tipo | Campo |
|------|-------|
| Texto | `text.message` |
| Botão clicado | `buttonsResponseMessage.message` |
| Lista | `listResponseMessage.title` ou `listResponseMessage.selectedRowId` |
| Imagem com legenda | `image.caption` |
| Áudio | transcrever ou responder pedindo texto |

Exemplos por tipo: https://developer.z-api.io/webhooks/on-message-received-examples.md

## Webhook Delivery

`type: "DeliveryCallback"`

```json
{
  "phone": "5511999999999",
  "zaapId": "...",
  "messageId": "...",
  "instanceId": "...",
  "momment": 1777494009341,
  "type": "DeliveryCallback"
}
```

## Webhook Status

`type: "MessageStatusCallback"`

Status: `SENT`, `RECEIVED`, `READ`, `READ_BY_ME`, `PLAYED`

```json
{
  "instanceId": "...",
  "status": "READ",
  "ids": ["..."],
  "momment": 1632234645000,
  "phone": "5511999999999",
  "type": "MessageStatusCallback",
  "isGroup": false
}
```

## Instância

| Ação | Endpoint |
|------|----------|
| Status conexão | GET `/status` |
| QR Code | GET `/qr-code/image` |
| Desconectar | GET `/disconnect` |

## Filtros recomendados no handler

```typescript
function shouldProcess(payload: ReceivedCallback): boolean {
  if (payload.type !== 'ReceivedCallback') return false;
  if (payload.fromMe) return false;
  if (payload.isGroup) return false;
  if (payload.isNewsletter) return false;
  return true;
}
```

## Formato de telefone

- Apenas dígitos: `5511999999999`
- Brasil: DDI `55` + DDD + número (9 dígitos celular)
- Grupos: usar ID do grupo no campo `phone` conforme doc

## Links úteis

- [Introdução webhooks](https://developer.z-api.io/webhooks/introduction.md)
- [Boas práticas](https://developer.z-api.io/tips/best-practices.md)
- [Bloqueios e banimentos](https://developer.z-api.io/tips/blockednumbernew.md)
- [Status dos botões](https://developer.z-api.io/tips/button-status.md)
- [Coleção Postman](https://www.postman.com/docs-z-api/z-api-s-public-workspace/collection/gwri249/z-api-collection)
