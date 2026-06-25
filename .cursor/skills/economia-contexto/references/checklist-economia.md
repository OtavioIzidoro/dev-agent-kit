# Checklist — Economia de Contexto

## Antes de preparar o brief

- [ ] Tarefa descrita em 1–3 frases
- [ ] Módulo/pasta alvo identificado
- [ ] Fora de escopo explícito
- [ ] Chat atual está poluído? (considerar nova conversa)

## Escopo

- [ ] Uma frase clara do que fazer
- [ ] Lista "não fazer" presente
- [ ] Proibido "analisar projeto inteiro" no prompt seguinte

## Arquivos (máx. 5–8)

- [ ] 2–3 referências de padrão (mesmo tipo)
- [ ] Só arquivos a alterar listados
- [ ] Nenhuma pasta inteira como "@src"
- [ ] Sem node_modules, lockfile, dist, build
- [ ] Se >8 arquivos, priorizados + opcionais marcados

## Exclusões

- [ ] Pastas fora do módulo listadas
- [ ] Arquivos grandes irrelevantes listados
- [ ] "Não refatorar" explícito

## Prompt de implementação

- [ ] 5–10 linhas, copiável
- [ ] Referência a arquivos concretos
- [ ] Pedido de diff mínimo
- [ ] Pedido de resposta concisa
- [ ] Sem pedir re-análise do projeto

## Sinais de waste (evitar na sessão seguinte)

- Colar arquivo inteiro na resposta
- Explicar arquitetura geral de novo
- Alterar >5 arquivos sem necessidade
- Ler grep de 200+ matches
- "Vou analisar toda a codebase"

## Par com outros agentes

| economia-contexto | guardiao-padroes | continuidade-projeto |
|-------------------|------------------|----------------------|
| **Quais** arquivos | **Como** codar neles | **Comportamento** mínimo |
| Antes de tudo | Depois do escopo | Sempre ativo |
