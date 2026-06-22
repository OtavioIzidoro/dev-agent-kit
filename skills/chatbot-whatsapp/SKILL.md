---
name: chatbot-whatsapp
description: Implementa chatbot completo no WhatsApp via Z-API — webhook HTTPS, recebimento e envio de mensagens, fluxo conversacional, estado de sessão, botões/listas, segurança e boas práticas anti-bloqueio. Use quando o usuário pedir bot WhatsApp, integração Z-API, webhook de mensagens, atendimento automatizado ou fluxo conversacional no WhatsApp.
disable-model-invocation: true
---

# Chatbot WhatsApp — Z-API

Implementa bot completo com [Z-API](https://developer.z-api.io/): webhook de recebimento, envio de mensagens, fluxo conversacional e tratamento de eventos.

## Quando usar

| Tarefa | Use esta skill |
|--------|----------------|
| Criar bot WhatsApp com Z-API | ✅ |
| Configurar webhook de recebimento/envio | ✅ |
| Fluxo conversacional (menu, etapas, FAQ) | ✅ |
| Enviar texto, botões, listas, mídia | ✅ |
| Tratar status/delivery da mensagem | ✅ |
| Meta Cloud API / Twilio / Evolution | ❌ — outro provedor |
| Só UI de painel admin | `/front-implementador` |
| Só tipagem de API REST genérica | `/api-integracao` |

## Fluxo recomendado

```
/guardiao-padroes → /chatbot-whatsapp → /agente-testes → /code-reviewer
```

Em projeto grande: `/economia-contexto` antes de mapear arquivos.

## Pré-requisitos

- Conta Z-API com **instância conectada** (QR Code ou telefone)
- `ZAPI_INSTANCE_ID`, `ZAPI_INSTANCE_TOKEN` e, se ativo, `ZAPI_CLIENT_TOKEN`
- Endpoint **HTTPS** público para webhooks (ngrok/Cloudflare Tunnel em dev)
- Doc oficial: https://developer.z-api.io/llms.txt

Nunca commite tokens. Use `.env` e variáveis de ambiente.

## Entrada esperada

Peça ou infira:

1. **Objetivo do bot** — atendimento, agendamento, FAQ, notificações, etc.
2. **Fluxo conversacional** — estados, menus, palavras-chave, handoff humano
3. **Stack** — Node, Python, Nest, Express, serverless, etc.
4. **Persistência** — Redis, Postgres, in-memory (só dev)
5. **Escopo** — só webhook, só envio, ou bot completo

Formato mínimo de fluxo:

```markdown
### Estado: menu_principal
**Gatilho:** primeira mensagem ou "menu"
**Resposta:** texto + botões [Agendar | Status | Falar com atendente]
**Próximo:** conforme clique ou texto
```

## Arquitetura mínima

```
WhatsApp → Z-API → POST /webhook (Receive)
                         ↓
                   normalizar evento
                         ↓
                   deduplicar (messageId)
                         ↓
                   carregar sessão (phone)
                         ↓
                   motor de fluxo
                         ↓
                   Z-API send-text / botões / lista
```

Componentes sugeridos (nomes conforme o projeto):

| Camada | Responsabilidade |
|--------|------------------|
| `webhook handler` | Receber POST, validar, responder 200 rápido |
| `normalizer` | Extrair `phone`, `text`, tipo, `fromMe`, `isGroup` |
| `session store` | Estado por `phone` + TTL |
| `flow engine` | Transições entre estados |
| `zapi client` | Chamadas à API de envio |

**Regra:** responda `200` ao webhook imediatamente; processe mensagem de forma assíncrona se o fluxo for pesado.

## Checklist de implementação

### Webhook
- [ ] URL **HTTPS** configurada (painel ou `PUT /update-every-webhooks`)
- [ ] Rota `POST` aceita JSON
- [ ] Ignora `fromMe: true` (salvo requisito explícito)
- [ ] Ignora grupos/canais se o bot for 1:1 (`isGroup`, `isNewsletter`)
- [ ] Deduplica por `messageId` (Z-API pode reenviar)
- [ ] Filtra `type === 'ReceivedCallback'` no receive

### Envio
- [ ] Base URL: `https://api.z-api.io/instances/{instanceId}/token/{token}/`
- [ ] Header `Content-Type: application/json`
- [ ] Header `Client-Token` quando segurança estiver ativa
- [ ] Telefone só com dígitos: `5511999999999` (DDI + DDD + número)
- [ ] Usa `delayTyping` / `delayMessage` para parecer humano (1–5s)

### Fluxo conversacional
- [ ] Estado inicial definido (ex.: `idle`, `menu`)
- [ ] Palavras reservadas: `menu`, `sair`, `atendente`
- [ ] Timeout de sessão (ex.: 30 min)
- [ ] Fallback para entrada não reconhecida
- [ ] Handoff humano quando necessário

### Segurança e compliance
- [ ] Tokens só em env
- [ ] Opção de descadastro ("responda SAIR")
- [ ] Sem spam — respeitar [boas práticas Z-API](https://developer.z-api.io/tips/best-practices.md)
- [ ] Mídia: URLs expiram em **30 dias** — baixar se precisar persistir

## Normalização do webhook (texto)

Campos úteis do `ReceivedCallback`:

| Campo | Uso |
|-------|-----|
| `phone` | Chave da sessão / destino da resposta |
| `messageId` | Deduplicação |
| `fromMe` | Ignorar eco de mensagens próprias |
| `isGroup` | Filtrar grupos |
| `text.message` | Conteúdo em mensagens de texto |
| `buttonsResponseMessage` / `listResponseMessage` | Resposta de botão/lista |
| `momment` | Timestamp do evento |

Extraia o texto do usuário conforme o tipo. Exemplos completos: [reference.md](reference.md).

## Envio de mensagens (padrão)

**Texto simples** — `POST .../send-text`

```json
{
  "phone": "5511999999999",
  "message": "Olá! Como posso ajudar?",
  "delayTyping": 2
}
```

**Botões** — `POST .../send-button-list` (até 3 opções rápidas)

**Lista de opções** — `POST .../send-option-list` (menus maiores)

**Responder em thread** — `POST .../reply-message` com `messageId` original

Detalhes de endpoints e payloads: [reference.md](reference.md).

## Padrão de motor de fluxo

```typescript
type Session = { state: string; data: Record<string, unknown> };

async function handleMessage(ctx: {
  phone: string;
  text: string;
  messageId: string;
}) {
  const session = await store.get(ctx.phone) ?? { state: 'menu', data: {} };

  if (isOptOut(ctx.text)) return sendGoodbye(ctx.phone);

  const handler = handlers[session.state] ?? handlers.fallback;
  const result = await handler(ctx, session);

  await store.set(ctx.phone, result.session);
  await sendResponses(ctx.phone, result.messages);
}
```

Mantenha handlers pequenos e testáveis. Prefira tabela de estados a `if/else` gigante.

## Webhooks auxiliares

| Webhook | `type` | Uso |
|---------|--------|-----|
| Delivery | `DeliveryCallback` | Confirmar envio à fila/WhatsApp |
| Status | `MessageStatusCallback` | `SENT`, `RECEIVED`, `READ`, `PLAYED` |
| Disconnected | — | Alertar desconexão da instância |

Configure URLs separadas ou use `update-every-webhooks` com roteamento interno por `type`.

## Testes locais

1. Subir servidor local na porta definida
2. Expor com `ngrok http 3000` (ou tunnel equivalente)
3. Registrar URL no painel Z-API ou via API
4. Enviar mensagem real para o número conectado
5. Validar receive → resposta → delivery/status nos logs

Testes automatizados: mock do payload de webhook + mock do client Z-API. Use `/agente-testes`.

## Boas práticas (resumo)

- Incentive **resposta do usuário** (perguntas, botões)
- Varie texto — não repita mensagem idêntica em massa
- Intervalo entre envios; evite rajadas
- Número novo: **maturar** antes de alto volume
- Separe número de **atendimento** e **disparo** quando possível

## Bloqueios e erros comuns

| Sintoma | Causa provável |
|---------|----------------|
| Webhook não chega | URL sem HTTPS, firewall, URL errada |
| `null not allowed` | `Client-Token` ausente com segurança ativa |
| Bot responde em loop | Não filtra `fromMe` ou não deduplica |
| Botões não aparecem | Limitação/conta; ver [status dos botões](https://developer.z-api.io/tips/button-status.md) |
| Instância parou | Desconexão — checar `/status` e webhook Disconnected |

## Exemplo de invocação

```
/chatbot-whatsapp

Stack: Node + Express + Redis
Objetivo: bot de agendamento

Fluxo:
1. Saudação + menu (Agendar | Meus agendamentos | Atendente)
2. Agendar: pedir data → horário → confirmar
3. "sair" encerra; "menu" volta ao início

Já tenho instância Z-API conectada. Preciso do webhook e do fluxo completo.
```

## Combinações úteis

- **Antes de codar:** `/guardiao-padroes` para achar padrão de routes/services no projeto
- **Client HTTP tipado:** `/api-integracao`
- **Testes:** `/agente-testes`
- **Entrega:** `/documentacao-tarefa`

Referência técnica Z-API: [reference.md](reference.md)
