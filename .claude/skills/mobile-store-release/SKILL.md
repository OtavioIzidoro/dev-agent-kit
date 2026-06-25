---
name: mobile-store-release
description: Prepara projetos mobile para publicação na Apple App Store e Google Play Store — stack, assinatura, permissões, privacidade, versionamento, build AAB/IPA e checklists de submissão. Use quando pedir publicar nas lojas, gerar build de produção, configurar EAS/keystore, resolver rejeição da Apple ou Google Play, ou deixar app pronto para submissão.
disable-model-invocation: true
---

# Mobile Store Release

Prepara o projeto mobile para publicação na **App Store** e **Google Play**, reduzindo risco de rejeição por build, assinatura, permissões, privacidade e metadata.

## Quando usar

| Tarefa | Use esta skill |
|--------|----------------|
| Publicar na App Store / Play Store | ✅ |
| Gerar AAB, IPA ou build release | ✅ |
| Configurar EAS, keystore, provisioning | ✅ |
| Revisar permissões e privacidade mobile | ✅ |
| Resolver rejeição da Apple ou Google | ✅ |
| Só implementar feature UI | `/front-implementador` |
| Só rodar testes | subagente `verifier` |
| Documentar entrega | `/documentacao-tarefa` |

## Fluxo recomendado

```
/guardiao-padroes → /mobile-store-release → /verifier (smoke) → /documentacao-tarefa
```

Em projeto grande ou legado, antes: `/economia-contexto`.

## Entrada esperada

Colete do projeto antes de alterar código:

1. **Stack** — Expo, RN CLI, Flutter, Capacitor, nativo
2. **Plataformas** — Android, iOS ou ambas
3. **Objetivo** — primeira publicação, nova versão ou corrigir rejeição
4. **CI/CD** — EAS, Fastlane, GitHub Actions, manual
5. **Credenciais** — keystore, provisioning (nunca commitar segredos)

## Fluxo de execução

### 1. Inspecionar

- [ ] Estrutura do projeto e stack identificada
- [ ] Plataformas presentes (`android/`, `ios/`)
- [ ] Scripts de build em `package.json` / `eas.json` / Gradle
- [ ] Variáveis de ambiente e flavors/schemes

### 2. Detectar stack

| Stack | Indicadores |
|-------|-------------|
| **Expo** | `app.json`, `app.config.*`, `eas.json`, dep `expo` |
| **React Native CLI** | `android/`, `ios/`, `react-native`, `metro.config.js` |
| **Flutter** | `pubspec.yaml`, `lib/main.dart` |
| **Capacitor** | `capacitor.config.*`, `ionic.config.json` |
| **Android nativo** | `settings.gradle`, `android/app/build.gradle` |
| **iOS nativo** | `.xcodeproj`, `.xcworkspace`, `Podfile` |

### 3. Validar técnico (por plataforma)

**Android:** `applicationId`, `namespace`, `versionCode`, `versionName`, `targetSdkVersion`, assinatura release, `.aab`, `AndroidManifest.xml`, ícone adaptativo, splash, ProGuard/R8.

**iOS:** Bundle ID, Display Name, Version, Build Number, Deployment Target, `Info.plist`, Privacy Manifest (`PrivacyInfo.xcprivacy`), signing, capabilities, ícone, launch screen.

### 4. Revisar permissões

Para cada permissão sensível:

- É necessária para funcionalidade real?
- Descrição clara no iOS (`NS*UsageDescription`)?
- Declarada no Data Safety (Google) e Privacy Nutrition Label (Apple)?
- Pode ser solicitada in-app no momento de uso?

### 5. Revisar privacidade e loja

- Política de privacidade acessível
- Data Safety alinhada ao comportamento real
- Conta de teste se login obrigatório
- Exclusão de conta se houver cadastro (quando exigido)
- Screenshots, descrições e classificação etária

### 6. Corrigir e gerar build

- Aplicar **somente** alterações necessárias para publicação
- Preservar regra de negócio e configs existentes
- Nunca commitar keystore, `.p12`, senhas ou service account keys
- Gerar comandos de build conforme stack

### 7. Entregar checklist final

Use o template de saída abaixo.

## Arquivos-chave por stack

| Stack | Arquivos |
|-------|----------|
| Expo | `app.json`, `app.config.*`, `eas.json` |
| RN CLI | `android/app/build.gradle`, `AndroidManifest.xml`, `ios/Podfile`, `Info.plist` |
| Flutter | `pubspec.yaml`, `android/app/build.gradle`, `ios/Runner/Info.plist` |
| Capacitor | `capacitor.config.*`, pastas `android/` e `ios/` |

## Comandos de build (referência)

### Expo / EAS

```bash
npm install
npx eas build --platform android --profile production
npx eas build --platform ios --profile production
npx eas submit --platform android
npx eas submit --platform ios
```

### React Native CLI

```bash
npm install
cd ios && pod install && cd ..
cd android && ./gradlew clean bundleRelease
# iOS: archive via Xcode ou xcodebuild
```

### Flutter

```bash
flutter pub get
flutter build appbundle --release
flutter build ipa --release
```

### Capacitor

```bash
npm install
npx cap sync
cd android && ./gradlew bundleRelease
# iOS: archive via Xcode após cap sync
```

## Template de saída

```markdown
# Diagnóstico — Mobile Store Release

## Stack e plataformas
- Stack: …
- Plataformas: Android / iOS

## Problemas encontrados
| # | Severidade | Item | Arquivo | Ação |
|---|------------|------|---------|------|

## Alterações feitas
- …

## Comandos de build
…

## Checklist Apple
- [ ] …

## Checklist Google Play
- [ ] …

## Pendências manuais (lojas)
- …

## Riscos de rejeição
- …
```

## Regras obrigatórias

- Diff mínimo — não refatorar fora do escopo de publicação
- Não remover código funcional sem necessidade
- Não alterar regra de negócio sem pedido explícito
- Validar Android e iOS separadamente
- Separar o que é código vs. o que é preenchimento manual no App Store Connect / Play Console

## Pós-preparação

```
/mobile-store-release → verifier (smoke em device/emulador) → /documentacao-tarefa
```

Checklists detalhados, causas de rejeição e validações de loja: [references/checklist-lojas.md](references/checklist-lojas.md)
