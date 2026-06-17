# Checklist — Revisor de Código (pré-PR)

## Diff

- [ ] Apenas arquivos relevantes ao escopo?
- [ ] Sem alterações acidentais (formatting massivo, lockfile)?
- [ ] Intenção de cada mudança compreensível?

## Duplicação

- [ ] Lógica já existe em hook/util/service?
- [ ] Copy-paste interno no diff?
- [ ] Componente similar que poderia ser reutilizado?

## Padrão do projeto

- [ ] Pastas e naming consistentes?
- [ ] Mesmas libs (form, validação, fetch)?
- [ ] Imports e exports no estilo do módulo?
- [ ] Alinhado ao brief de guardiao-padroes?

## Bugs prováveis

- [ ] Null/undefined tratados?
- [ ] Arrays/strings vazios?
- [ ] Async/await correto, erros capturados?
- [ ] Condições lógicas corretas?
- [ ] Keys estáveis em `.map()`?
- [ ] Mutations de state evitadas?

## Tipagem

- [ ] Sem tipos excessivamente amplos?
- [ ] Props e retornos tipados?
- [ ] `as` assertion justificada?
- [ ] Enums/unions em vez de strings mágicas?

## `any`

- [ ] Todo `any` é necessário?
- [ ] Substituível por unknown + narrow?
- [ ] Event types corretos?
- [ ] `@ts-ignore` documentado e mínimo?

## `useEffect`

- [ ] Effect necessário (não dá para derived state)?
- [ ] Cleanup em subscriptions/fetch?
- [ ] Deps array correto (exhaustive-deps)?
- [ ] Sem loop setState → effect → setState?
- [ ] Fetch inicial vs refetch no lugar certo?

## Dependências de hooks

- [ ] `useMemo`/`useCallback` deps corretas?
- [ ] Objetos/funções inline causando re-run?
- [ ] Hooks não condicionais?
- [ ] Ordem de hooks preservada?

## Regressão

- [ ] Rotas/telas irmãs afetadas?
- [ ] API contract breaking change?
- [ ] Testes existentes ainda passam?
- [ ] Estilos globais alterados?
- [ ] Comportamento default mudou?

## Segurança (rápido)

- [ ] Dados sensíveis não logados?
- [ ] User input sanitizado?
- [ ] Auth/authz nas rotas novas?

## Veredito

- [ ] Críticos listados e bloqueiam merge?
- [ ] Sugestões acionáveis com arquivo:linha?
- [ ] Pontos positivos mencionados?
