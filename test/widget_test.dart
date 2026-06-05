import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opticalc_pro/app.dart';
import 'package:opticalc_pro/core/routes/app_routes.dart';
import 'package:opticalc_pro/services/firebase_bootstrap_service.dart';
import 'package:opticalc_pro/services/patient_repository.dart';

void main() {
  testWidgets('renders dashboard and navigates to refraction', (tester) async {
    await tester.pumpWidget(
      OptiCalcProApp(
        firebaseStatus: const FirebaseStatus.offline('Modo teste'),
        patientRepository: PatientRepository.memory(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Suite clinica para Optometria e Otica'), findsOneWidget);

    await tester.tap(find.text('Comecar pela refracao'));
    await tester.pumpAndSettle();

    expect(find.text('Receita optica'), findsOneWidget);
    expect(find.text('Calcular refracao'), findsOneWidget);
  });

  testWidgets('saves a local patient through the form', (tester) async {
    await tester.pumpWidget(
      OptiCalcProApp(
        firebaseStatus: const FirebaseStatus.offline('Modo teste'),
        patientRepository: PatientRepository.memory(),
        initialRoute: AppRoutes.patients,
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Ana Souza');
    await tester.enterText(find.byType(TextFormField).at(1), '11999999999');
    await tester.enterText(find.byType(TextFormField).at(2), 'ana@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'Retorno anual');

    await tester.tap(find.text('Salvar paciente'));
    await tester.pumpAndSettle();

    expect(find.text('Paciente salvo com sucesso.'), findsOneWidget);
    expect(find.text('Ana Souza'), findsOneWidget);
  });
}
