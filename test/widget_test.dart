import 'package:flutter_test/flutter_test.dart';
import 'package:opticalc_pro/app.dart';
import 'package:opticalc_pro/services/firebase_service.dart';

void main() {
  testWidgets('OptiCalc Pro abre dashboard e navega para refração', (
    tester,
  ) async {
    await tester.pumpWidget(
      const OptiCalcProApp(
        firebaseStatus: FirebaseStatus.unavailable('Firebase em modo local'),
      ),
    );

    expect(find.text('OptiCalc Pro'), findsWidgets);
    expect(find.textContaining('Calculadora clínica'), findsOneWidget);

    await tester.tap(find.text('Refração').last);
    await tester.pumpAndSettle();

    expect(find.text('Equivalente esférico'), findsOneWidget);
    expect(find.textContaining('-2.75 D'), findsOneWidget);
  });
}
