---
description: Verificação de build — detectar stack, validar compilação antes de finalizar e impedir entrega com erro de deploy (.NET, Java, Node, React).
alwaysApply: true
---

# Verificação de Build

Evite entregar código que quebra no deploy. **Build verde é requisito**, não opcional.

## Ao iniciar no repositório

1. Detecte a stack (arquivos-âncora na raiz ou subpastas):
   - **Node/React:** `package.json`
   - **.NET:** `*.sln`, `*.csproj`
   - **Java:** `pom.xml`, `build.gradle`, `build.gradle.kts`
2. Leia scripts/comandos oficiais do projeto (`package.json`, CI, README) **antes** de inventar comando.
3. Se for alterar código, rode **build baseline** uma vez. Se já falhar, informe antes de implementar.

## Após alterar código

1. Rode o **build de produção/compilação** do projeto (não só lint).
2. Corrija erros de compilação, tipagem e imports antes de concluir.
3. **Não declare tarefa concluída** com build falhando — exceto se o usuário pedir explicitamente para parar.

## Prioridade de comandos

1. Script do projeto (`npm run build`, `yarn build`, `pnpm build`, etc.)
2. CI (`.github/workflows`, `Dockerfile`, `Jenkinsfile`)
3. Fallback da stack — ver skill `/verificacao-build`

## Monorepo

Identifique o pacote/app afetado e rode build **no diretório correto** (workspace), não só na raiz.

## Evidência na resposta

Ao finalizar implementação, inclua:

- Comando executado
- Exit code (0 = ok)
- Se falhou: erro principal e correção aplicada

Para execução dedicada: subagente `verifier` ou skill `/verificacao-build`.
