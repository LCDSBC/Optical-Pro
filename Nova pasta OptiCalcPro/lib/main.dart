import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
import 'modules/home/home_page.dart';
import 'providers/app_readiness_provider.dart';
import 'services/firebase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseResult = await FirebaseBootstrap.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppReadinessProvider(firebaseResult),
      child: const OptiCalcProApp(),
    ),
  );
}

class OptiCalcProApp extends StatelessWidget {
  const OptiCalcProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OptiCalc Pro',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
