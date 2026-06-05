import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opti_calc_pro/main.dart';

void main() {
  testWidgets('renders the premium dashboard modules and shortcuts', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1440, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const OptiCalcProApp());
    await tester.pumpAndSettle();

    expect(find.text('Dashboard Principal'), findsOneWidget);
    expect(find.text('Dark mode premium'), findsOneWidget);
    expect(find.text('Pacientes'), findsWidgets);
    expect(find.text('Refração'), findsWidgets);
    expect(find.text('Lente de Contato'), findsWidgets);
    expect(find.text('Prismas'), findsWidgets);
    expect(find.text('Multifocal'), findsWidgets);
    expect(find.text('Histórico'), findsWidgets);
    expect(find.text('Configurações'), findsWidgets);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -1200));
    await tester.pumpAndSettle();

    expect(find.text('Atalhos rápidos'), findsOneWidget);
    expect(find.text('Nova refração'), findsOneWidget);
    expect(find.text('Converter para LC'), findsOneWidget);
  });
}
