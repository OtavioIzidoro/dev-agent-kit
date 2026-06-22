# Checklist — Guardião de Padrões

Use antes de criar ou alterar código.

## Pastas

- [ ] Onde novos arquivos desta feature são criados no projeto?
- [ ] Feature-based (`features/users/`) ou layer-based (`components/`, `services/`)?
- [ ] Testes colocalizados (`*.test.ts` ao lado) ou em `__tests__/`?
- [ ] Naming de arquivos: kebab-case, PascalCase, sufixos (`.service.ts`, `.page.tsx`)?

## Componentes

- [ ] Onde ficam: `components/`, `ui/`, dentro da feature?
- [ ] Smart vs dumb / container vs presentational?
- [ ] Props tipadas inline ou arquivo separado?
- [ ] Default export ou named export?
- [ ] Componente de referência similar identificado?

## Hooks

- [ ] Pasta: `hooks/`, `features/x/hooks/`?
- [ ] Prefixo `use` obrigatório?
- [ ] Hook retorna objeto ou tupla?
- [ ] Lógica de fetch no hook ou no service?

## Services / API

- [ ] Camada dedicada (`services/`, `api/`, `repositories/`)?
- [ ] Cliente HTTP centralizado (axios instance, fetch wrapper)?
- [ ] Endpoints como constantes ou inline?
- [ ] Tratamento de erro: try/catch, interceptor, Result type?
- [ ] React Query / SWR / Redux thunk?

## Tipagem

- [ ] `type` vs `interface` — qual prevalece?
- [ ] Onde: `types/`, `@types/`, colocated `*.types.ts`?
- [ ] DTOs espelham backend ou frontend-specific?
- [ ] Enums vs union types?

## Formulários

- [ ] Biblioteca: React Hook Form, Formik, native?
- [ ] Controller/wrapper customizado?
- [ ] Default values e reset pattern?
- [ ] Submit handler: no componente ou hook?

## Validação

- [ ] Zod, Yup, Joi, class-validator (backend)?
- [ ] Schema colocated ou `schemas/`?
- [ ] Validação client + server?
- [ ] Mensagens de erro: i18n, constantes, inline?

## Estado / Context

- [ ] Global: Redux, Zustand, Jotai, Context?
- [ ] Server state: React Query, SWR, RTK Query?
- [ ] Quando usar `useState` local only?
- [ ] Provider hierarchy pattern?

## Estilização

- [ ] Tailwind, CSS Modules, styled-components, MUI sx?
- [ ] Design tokens / theme file?
- [ ] Responsividade: breakpoints do projeto?
- [ ] Componentes base (`Button`, `Input`) — reutilizar?

## Anti-refatoração

- [ ] Listei arquivos que **não** devem ser movidos/renomeados?
- [ ] Evitei "padronizar" código legado fora do escopo?
- [ ] Novo código segue o padrão **dominante**, não o ideal teórico?

## Saída

- [ ] Brief entregue com referências de arquivo reais
- [ ] 3–5 regras de ouro resumidas
- [ ] Inconsistências no projeto documentadas (qual padrão seguir)
