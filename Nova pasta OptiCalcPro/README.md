# OptiCalc Pro

Sistema profissional para Optometria e Otica desenvolvido em Flutter.

## Ambiente verificado

- Flutter 3.44.1 stable
- Dart 3.12.1
- Android Gradle Plugin 9.0.1
- Gradle 9.1.0
- Android minSdk 23

## Dependencias principais

- `provider`
- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_storage`
- `cloud_functions`

## Execucao local

```bash
flutter pub get
flutter run
```

## Firebase

O app inicializa sem bloquear a execucao quando as credenciais Firebase ainda
nao estao presentes. Para habilitar Firebase, execute com os defines reais do
projeto:

```bash
flutter run \
  --dart-define=FIREBASE_API_KEY=... \
  --dart-define=FIREBASE_APP_ID=... \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=... \
  --dart-define=FIREBASE_PROJECT_ID=... \
  --dart-define=FIREBASE_AUTH_DOMAIN=... \
  --dart-define=FIREBASE_STORAGE_BUCKET=...
```

## Android

As permissoes declaradas no manifesto sao:

- `android.permission.INTERNET`
- `android.permission.ACCESS_NETWORK_STATE`

Essas permissoes cobrem Firebase e servicos online. Permissoes sensiveis, como
camera e armazenamento de midia, devem ser adicionadas somente quando as
funcionalidades de OCR ou upload forem implementadas.

## Validacao

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```
