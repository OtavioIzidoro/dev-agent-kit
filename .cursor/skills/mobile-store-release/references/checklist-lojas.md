# Checklist detalhado — App Store e Google Play

Referência para `/mobile-store-release`. Consulte apenas a seção da stack/plataforma em uso.

---

## Android técnico

- [ ] `applicationId` e `namespace` corretos e estáveis
- [ ] `versionCode` incrementado (inteiro, sempre maior que anterior)
- [ ] `versionName` semântico e coerente
- [ ] `minSdkVersion` adequado ao público
- [ ] `targetSdkVersion` conforme exigência atual da Google Play
- [ ] `compileSdkVersion` compatível com dependências
- [ ] Assinatura release configurada (keystore fora do repo)
- [ ] `.aab` gerado (Play Store não aceita APK para novos apps)
- [ ] Permissões no `AndroidManifest.xml` — remover não utilizadas
- [ ] Deep links e intent filters validados
- [ ] `google-services.json` no flavor correto (se Firebase)
- [ ] ProGuard/R8 sem quebrar reflexão de libs
- [ ] Ícone adaptativo (foreground + background)
- [ ] Splash screen configurada
- [ ] App label e orientação de tela
- [ ] `networkSecurityConfig` / cleartext apenas se justificado
- [ ] `POST_NOTIFICATIONS` (API 33+) se usa push

### Permissões Android críticas

Revisar com cuidado — cada uma exige justificativa na Play Console:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.READ_SMS" />
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

---

## iOS técnico

- [ ] Bundle Identifier correto e único
- [ ] Display Name adequado
- [ ] Version (marketing) e Build Number incrementados
- [ ] iOS Deployment Target compatível com dependências
- [ ] `Info.plist` — permissões com `NS*UsageDescription` claras
- [ ] `PrivacyInfo.xcprivacy` (Privacy Manifest) quando aplicável
- [ ] Third-party SDKs com manifest de privacidade
- [ ] Signing: Team, certificado, provisioning profile
- [ ] Capabilities: Push, Associated Domains, Sign in with Apple, Background Modes, etc.
- [ ] App Transport Security — sem exceções amplas desnecessárias
- [ ] Ícone sem transparência (1024×1024 para App Store)
- [ ] Launch screen / storyboard
- [ ] Archive release validado no Xcode ou CI
- [ ] Pods instalados e lockfile commitado

---

## Apple App Store Connect

- [ ] Nome, subtitle, categoria
- [ ] Classificação etária
- [ ] URL de política de privacidade
- [ ] URL de suporte
- [ ] Screenshots por tamanho de device exigido
- [ ] Descrição, palavras-chave, what's new
- [ ] Conta de teste + credenciais para revisor (se login)
- [ ] Notas para o revisor
- [ ] Privacy Nutrition Label alinhada ao app
- [ ] In-App Purchase para compras digitais (se aplicável)

### Causas comuns de rejeição Apple

- Login obrigatório sem conta demo
- App incompleto, placeholder ou crash no cold start
- Permissões sem descrição ou solicitadas cedo demais
- Política de privacidade ausente ou inacessível
- Funcionalidade anunciada inexistente
- Compra digital fora do IAP
- Falta de exclusão de conta (apps com cadastro)
- Links quebrados ou botões sem ação

---

## Google Play Console

- [ ] Nome, descrição curta e completa
- [ ] Categoria e classificação de conteúdo
- [ ] Política de privacidade (URL)
- [ ] Data Safety preenchida e coerente com o app
- [ ] Público-alvo e declaração de anúncios
- [ ] App access — conta de teste se login
- [ ] Permissões sensíveis declaradas e justificadas
- [ ] Screenshots, feature graphic, ícone 512×512
- [ ] Track: interno → fechado → produção
- [ ] Assinatura de app (Play App Signing)

### Causas comuns de rejeição Google

- Data Safety divergente do comportamento real
- Target SDK desatualizado
- Permissões sensíveis sem justificativa
- Localização em background sem necessidade clara
- Login sem conta de teste
- Crash em dispositivos reais
- Falta de exclusão de conta quando exigido
- App infantil sem conformidade Families Policy

---

## QA antes de submeter

- [ ] Cold start sem tela branca
- [ ] Funciona offline com feedback adequado
- [ ] Login/logout e fluxos críticos testados
- [ ] Push notification (se usado) em device real
- [ ] Deep link / universal link testados
- [ ] Build release (não debug) em device físico
- [ ] Sem dados de teste visíveis na UI de produção

---

## Segredos — nunca commitar

- Keystore (`.jks`, `.keystore`)
- `key.properties` com senhas
- Certificados `.p12`, `.mobileprovision`
- Service account JSON da Play Store
- API keys de produção em código fonte
- Arquivos em `.gitignore` — validar antes do push
