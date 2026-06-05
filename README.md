# OptiCalc Pro

Aplicativo Flutter profissional para Optometria e Otica.

## Recursos

- Material Design 3 com tema claro/escuro.
- Navegacao responsiva com drawer no mobile e rail em telas largas.
- Provider para tema, calculos e pacientes.
- Modulos de refracao, lente de contato, prismas, multifocal, terapia visual e pacientes.
- Firebase preparado com fallback local quando as chaves nao estiverem configuradas.

## Executar

```sh
flutter pub get
flutter run
```

Sem configuracao Firebase, o app roda em modo local em memoria.

## Ativar Firebase

Forneca as chaves em tempo de execucao:

```sh
flutter run \
  --dart-define=OPTICALC_FIREBASE_CONFIGURED=true \
  --dart-define=FIREBASE_API_KEY=... \
  --dart-define=FIREBASE_APP_ID=... \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=... \
  --dart-define=FIREBASE_PROJECT_ID=...
```

Opcionalmente inclua `FIREBASE_AUTH_DOMAIN`, `FIREBASE_STORAGE_BUCKET` e
`FIREBASE_IOS_BUNDLE_ID`.

## Validacao

```sh
flutter analyze
flutter test
flutter build web
```
