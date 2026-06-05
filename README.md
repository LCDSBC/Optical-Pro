# OptiCalc Pro

Sistema profissional para Optometria e Otica desenvolvido em Flutter.

## Objetivo

Criar uma plataforma moderna para automatizar calculos opticos, interpretar
receitas, converter oculos para lentes de contato, auxiliar montagem optica e
gerenciar pacientes.

## Stack

- Flutter e Dart
- Material Design 3
- Provider
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Cloud Functions
- Clean Architecture com modularizacao por feature

## Arquitetura

```text
lib/
|-- app/                 # bootstrap, rotas e widget raiz
|-- core/                # tema, erros, Firebase e utilitarios
|-- models/              # modelos serializaveis compartilhados
|-- modules/             # features com domain/data/presentation
|-- providers/           # providers globais
|-- services/            # servicos Firebase e formulas opticas
`-- widgets/             # componentes reutilizaveis
```

Cada modulo deve manter:

- `domain`: entidades, contratos e casos de uso
- `data`: implementacoes externas, como Firestore
- `presentation`: paginas e providers da interface

## Modulos iniciais

- Refracao: equivalente esferico e transposicao
- Lentes de Contato: conversao por distancia vertice
- Prismas: Regra de Prentice
- Pacientes: cadastro, historico e base Firestore

## Firebase

As opcoes em `lib/core/firebase/default_firebase_options.dart` sao placeholders.
Antes de publicar ou testar integracoes reais, configure o projeto com:

```bash
flutterfire configure --project=<firebase-project-id>
```

## Qualidade

As formulas obrigatorias possuem validacao e testes unitarios em `test/`.
Execute em um ambiente com Flutter instalado:

```bash
flutter pub get
flutter analyze
flutter test
```
