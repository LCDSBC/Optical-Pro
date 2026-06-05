import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:opti_calc_pro/main.dart';
import 'package:opti_calc_pro/providers/app_readiness_provider.dart';
import 'package:opti_calc_pro/services/firebase_bootstrap.dart';

void main() {
  testWidgets('shows final execution checklist', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppReadinessProvider(
          const FirebaseBootstrapResult(
            state: FirebaseBootstrapState.skipped,
            message: 'Firebase aguardando configuracao.',
          ),
        ),
        child: const OptiCalcProApp(),
      ),
    );

    expect(find.text('OptiCalc Pro'), findsOneWidget);
    expect(
      find.text('Projeto Flutter preparado para execucao final.'),
      findsOneWidget,
    );
    expect(find.text('Dependencias'), findsOneWidget);
    expect(find.text('Firebase'), findsOneWidget);
    expect(find.text('Android'), findsOneWidget);
    expect(find.text('Permissoes'), findsOneWidget);
    expect(find.text('Configurar'), findsOneWidget);
  });
}
