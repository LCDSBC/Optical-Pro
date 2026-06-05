# OptiCalc Pro

Aplicativo Flutter profissional para Optometria e Ótica, criado a partir da documentação do repositório em `Nova pasta OptiCalcPro`.

## Stack

- Flutter e Dart
- Material Design 3
- Provider
- Firebase Core, Authentication, Firestore, Storage e Cloud Functions
- Clean Architecture com módulos por feature

## Estrutura

```text
lib/
  core/        Tema e domínio óptico
  models/      Entidades clínicas
  modules/     Features do produto
  providers/   Estado da aplicação
  services/    Firebase e repositórios
  widgets/     Componentes reutilizáveis
```

## Módulos implementados

- Dashboard premium com status do Firebase.
- Refração com equivalente esférico e transposição.
- Lentes de contato com conversão por vértice.
- Prismas com Regra de Prentice.
- Multifocal com estimativa de adição.
- Terapia visual com AC/A e flexibilidade acomodativa.
- Pacientes com cadastro rápido e histórico local/Firestore.

## Firebase

O app tenta inicializar o Firebase no boot. Sem arquivos `firebase_options.dart` ou configuração nativa, ele entra em modo local e mantém o fluxo funcional para desenvolvimento. Quando o projeto Firebase real for configurado, o repositório de pacientes usa Cloud Firestore automaticamente.

## Comandos

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```
