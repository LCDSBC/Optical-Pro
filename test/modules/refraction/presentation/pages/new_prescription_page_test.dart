import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opti_calc_pro/main.dart';

void main() {
  testWidgets('preenche nova receita e exibe resultados de refracao', (
    tester,
  ) async {
    await tester.pumpWidget(const OptiCalcProApp());

    expect(find.text('Nova Receita'), findsOneWidget);
    expect(find.text('ESF'), findsNWidgets(2));
    expect(find.text('CIL'), findsNWidgets(2));
    expect(find.text('EIXO'), findsNWidgets(2));
    expect(find.text('ADD'), findsNWidgets(2));

    await tester.enterText(find.byKey(const Key('rightSphere')), '-2.00');
    await tester.enterText(find.byKey(const Key('rightCylinder')), '-1.00');
    await tester.enterText(find.byKey(const Key('rightAxis')), '180');
    await tester.enterText(find.byKey(const Key('rightAddition')), '1.50');
    await tester.enterText(find.byKey(const Key('leftSphere')), '1.00');
    await tester.enterText(find.byKey(const Key('leftCylinder')), '-0.50');
    await tester.enterText(find.byKey(const Key('leftAxis')), '90');
    await tester.enterText(find.byKey(const Key('leftAddition')), '1.50');

    final button = find.byKey(const Key('calculateRefractionButton'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('Equivalente esférico'), findsOneWidget);
    expect(find.text('OD -2.50D'), findsOneWidget);
    expect(find.text('OE +0.75D'), findsOneWidget);
    expect(find.text('Transposição automática'), findsOneWidget);
    expect(find.text('OD -3.00D +1.00D x90'), findsOneWidget);
    expect(find.text('OE +0.50D +0.50D x180'), findsOneWidget);
    expect(find.text('Interpretação clínica'), findsOneWidget);
  });
}
