# Checklist — Agente de Testes

## Setup do projeto

- [ ] Runner identificado (Vitest, Jest, Playwright, Cypress)
- [ ] Padrão de arquivo (`*.test.ts`, `*.spec.ts`, `__tests__/`)
- [ ] Helpers (`renderWithProviders`, `createWrapper`)
- [ ] Mocks (MSW, vi.mock, jest.mock)
- [ ] Fixtures/factories existentes reutilizadas

## Unitário

- [ ] Happy path
- [ ] Input inválido / null / undefined
- [ ] Boundary values
- [ ] Erro de dependência mockada
- [ ] Funções puras sem side effect oculto

## Componente

- [ ] Renderiza sem crash
- [ ] Texto/role visível ao usuário
- [ ] Interação (click, type, select)
- [ ] Loading state
- [ ] Empty state
- [ ] Error state
- [ ] Callbacks chamados com args corretos
- [ ] Queries acessíveis (não testId excessivo)

## Hook

- [ ] Estado inicial
- [ ] Transição após action
- [ ] API success/error mockados
- [ ] Cleanup no unmount
- [ ] Dependências estáveis

## E2E

- [ ] Fluxo crítico documentado
- [ ] Selectors estáveis (role, label)
- [ ] Dados de teste isolados
- [ ] Sem sleep fixo — wait for condition
- [ ] Positivo + negativo principal

## Validação (forms)

- [ ] Campo obrigatório vazio → erro
- [ ] Formato inválido → mensagem
- [ ] Submit disabled ou erro inline
- [ ] Submit válido → API mock/real conforme projeto
- [ ] Erro 422 mapeado por campo

## Permissões

- [ ] Role autorizado → ação permitida
- [ ] Role negado → botão oculto ou disabled
- [ ] Rota protegida redirect/403
- [ ] Mock auth provider/token

## Qualidade

- [ ] Nomes descritivos (`should X when Y`)
- [ ] Arrange-Act-Assert claro
- [ ] Sem flakiness
- [ ] Suite executada e passando
- [ ] Comando documentado para CI

## QA vs automatizado

| Manual (QA) | Automatizado (este agente) |
|-------------|----------------------------|
| Exploratório | Regressão repetível |
| Reporte de bug | `expect(...)` |
| `/front-qa`, `/navegacao-web` | `/agente-testes` |
