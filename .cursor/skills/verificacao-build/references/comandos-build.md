# Comandos de build — referência rápida

Use **sempre** o script do projeto primeiro. Esta tabela é fallback.

## Detecção rápida

| Se existir… | Stack provável | Comando inicial |
|-------------|----------------|-----------------|
| `package.json` + `react` | React (Node) | `npm run build` |
| `package.json` + `next` | Next.js | `npm run build` |
| `package.json` + `vite` | Vite | `npm run build` |
| `*.sln` ou `*.csproj` | .NET | `dotnet build` |
| `pom.xml` | Maven | `mvn -q -DskipTests compile` |
| `build.gradle*` | Gradle | `./gradlew build -x test` |
| `pnpm-workspace.yaml` | pnpm monorepo | `pnpm --filter <pkg> build` |
| `nx.json` | Nx | `npx nx build <app>` |

## Onde achar o comando “oficial”

1. `package.json` → `scripts.build`
2. `.github/workflows/*.yml` → job `build` / `ci`
3. `Dockerfile` → `RUN npm run build` / `dotnet publish`
4. `README.md` → seção install/build
5. `Makefile` → target `build`

## Node — scripts comuns

| Script | Uso |
|--------|-----|
| `build` | **Obrigatório** após mudanças |
| `typecheck` / `check` | TS sem emit |
| `lint` | Complementar |
| `test` | verifier (não substitui build) |

## .NET — flags úteis

```bash
dotnet restore
dotnet build --configuration Release
dotnet build --no-restore
dotnet publish -c Release --no-build   # validação pós-build
```

Projetos múltiplos: apontar para `.sln` ou `.csproj` alterado.

## Java — Maven vs Gradle

**Maven** — compilar sem testes:

```bash
mvn -q -DskipTests compile
mvn -q -DskipTests package
```

**Gradle**:

```bash
./gradlew classes
./gradlew build -x test
chmod +x gradlew   # se permission denied
```

## Monorepo

| Ferramenta | Exemplo |
|------------|---------|
| npm workspaces | `npm run build -w packages/app` |
| pnpm | `pnpm --filter @scope/app build` |
| yarn | `yarn workspace app build` |
| turbo | `npx turbo run build --filter=app` |
| nx | `npx nx run app:build` |

## CI falhou — checklist

- [ ] Build local reproduz o erro?
- [ ] Versão Node/Java/.NET compatível com CI?
- [ ] Lockfile commitado (`package-lock.json`, `pnpm-lock.yaml`)?
- [ ] Variável de ambiente exigida no build (`NEXT_PUBLIC_*`, etc.)?
- [ ] Módulo/pacote certo no monorepo?

## Evidência mínima

```
Comando: npm run build
Diretório: apps/web
Exit code: 0
```
