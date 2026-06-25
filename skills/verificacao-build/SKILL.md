---
name: verificacao-build
description: Detecta stack (.NET, Java, Node, React), roda build/compilação e valida que o projeto compila antes de finalizar — evita crash no deploy. Use ao abrir repo, após implementar, antes de PR/deploy, ou quando build/typecheck falhar.
disable-model-invocation: true
---

# Verificação de Build

Garante que o projeto **compila** antes de entregar. Lint e testes não substituem build.

## Quando usar

- Ao **abrir** um repositório antes de codar (baseline)
- **Depois** de implementar ou corrigir bug
- Antes de PR, merge ou deploy
- Quando CI falhar por erro de compilação

## Fluxo

### 1. Detectar stack

| Stack | Arquivos-âncora | Onde rodar |
|-------|-----------------|------------|
| Node / React | `package.json` | Pasta do `package.json` do app |
| .NET | `*.sln`, `*.csproj` | Raiz da solution ou projeto |
| Java (Maven) | `pom.xml` | Módulo com `pom.xml` |
| Java (Gradle) | `build.gradle`, `build.gradle.kts` | Raiz do Gradle |
| Monorepo | `pnpm-workspace.yaml`, `lerna.json`, `nx.json`, `turbo.json` | Workspace do pacote alterado |

Ordem: arquivos alterados → scripts locais → CI → fallback abaixo.

### 2. Escolher comando

**Prioridade:** `package.json` scripts → workflow CI → tabela de fallback.

Leia `scripts` em `package.json`. Prefira, nesta ordem:

1. `build` (produção)
2. `typecheck` / `check` / `compile`
3. `lint` — **complementar**, não substitui build

### 3. Executar

- Rode no terminal real; não assuma sucesso.
- Monorepo: build do pacote tocado (`pnpm --filter`, `npm run build -w`, `nx build`, etc.).
- Build longo: avise o usuário e use timeout adequado.

### 4. Tratar falha

1. Mostre erro principal (primeiras linhas úteis).
2. Corrija causa (tipagem, import, config, dependência).
3. Rode build de novo até passar ou bloqueie entrega.

### 5. Reportar

```markdown
## Build
- Stack: [Node | .NET | Java Maven | Java Gradle | monorepo …]
- Comando: `[comando exato]`
- Resultado: ✅ passou | ❌ falhou (exit code N)
- Observação: [monorepo, módulo, workaround temporário]
```

## Fallback por stack

### Node / React

```bash
npm run build
# ou: yarn build | pnpm build | bun run build
npm run typecheck    # se existir
npx tsc --noEmit     # TS sem script typecheck
```

Frameworks comuns:

| Framework | Indício | Build típico |
|-----------|---------|--------------|
| Next.js | `next` em dependencies | `npm run build` |
| Vite | `vite` | `npm run build` |
| CRA | `react-scripts` | `npm run build` |
| Remix | `@remix-run/*` | `npm run build` |

### .NET

```bash
dotnet build
dotnet build --configuration Release
dotnet build Nome.sln
dotnet build --no-restore   # se restore já feito
```

ASP.NET / Web API: build da **solution** ou `.csproj` da API alterada.

### Java — Maven

```bash
mvn -q -DskipTests compile
mvn -q -DskipTests package
mvn -q verify                 # mais próximo do CI
```

### Java — Gradle

```bash
./gradlew build -x test
./gradlew assemble
./gradlew compileJava
```

## Integração com outros agentes

| Agente | Papel |
|--------|-------|
| **`/verificacao-build`** | Detectar stack, rodar build, corrigir compilação |
| `verifier` | Build + testes + lint existentes |
| `/code-reviewer` | Review do diff (não substitui build) |
| `/documentacao-tarefa` | Evidência de build verde na entrega |

A rule `verificacao-build` está **sempre ativa** quando este kit está instalado.

## O que não fazer

- Concluir tarefa só com lint ou formatter
- Ignorar erro de TypeScript “pequeno” que quebra `tsc`
- Rodar build só na raiz em monorepo sem checar o pacote certo
- Inventar comando sem ler `package.json` / CI do projeto

Detalhes: [comandos-build.md](references/comandos-build.md)
