# Checklist — Continuidade de Projeto

## Antes de alterar

- [ ] Li 2–4 arquivos similares ao que vou criar/alterar
- [ ] Sei onde criar arquivos (pasta correta)
- [ ] Sei naming do projeto
- [ ] Sei como API é chamada neste módulo
- [ ] Sei lib de form e validação
- [ ] Sei padrão de loading/erro
- [ ] Sei como estilizar (Tailwind/modules/etc.)

## Durante (proibido sem pedido explícito)

- [ ] Não introduzi biblioteca nova
- [ ] Não movi arquivos fora do escopo
- [ ] Não refatorei código adjacente
- [ ] Não reescrevi componente inteiro desnecessariamente
- [ ] Reutilizei componentes/hooks/services existentes
- [ ] Comportamento anterior preservado onde não era o escopo mudar
- [ ] Diff é o menor possível para resolver a tarefa

## Antes de finalizar (entregar ao usuário)

- [ ] Padrões seguidos listados (com referências)
- [ ] Arquivos alterados listados
- [ ] Riscos de regressão identificados
- [ ] Testes manuais pendentes listados

## Sinais de alerta (parar e repensar)

- "Vou aproveitar e padronizar..."
- "Vou migrar para X porque é melhor..."
- "Vou reorganizar a pasta..."
- Diff muito maior que o pedido
- Múltiplos arquivos não relacionados alterados

## Par com guardiao-padroes

| continuidade-projeto | guardiao-padroes |
|----------------------|------------------|
| Filosofia sempre ativa (rule) | Brief detalhado sob demanda |
| Checklist antes/durante/depois | Análise profunda pré-código |
| `/continuidade-projeto` | `/guardiao-padroes` |
