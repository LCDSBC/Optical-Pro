import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'modules/dashboard/presentation/dashboard_page.dart';

void main() {
  runApp(const OptiCalcProApp());
}

class OptiCalcProApp extends StatelessWidget {
  const OptiCalcProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OptiCalc Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.premiumDark,
      home: const DashboardPage(),
    );
  }
}
