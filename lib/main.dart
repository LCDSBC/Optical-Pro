import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'modules/refraction/domain/services/refraction_calculator.dart';
import 'modules/refraction/presentation/pages/new_prescription_page.dart';
import 'modules/refraction/presentation/providers/refraction_provider.dart';

void main() => runApp(const OptiCalcProApp());

class OptiCalcProApp extends StatelessWidget {
  const OptiCalcProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              RefractionProvider(calculator: const RefractionCalculator()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OptiCalc Pro',
        theme: AppTheme.dark,
        home: const NewPrescriptionPage(),
      ),
    );
  }
}
