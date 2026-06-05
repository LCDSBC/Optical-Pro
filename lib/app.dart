import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'providers/calculator_provider.dart';
import 'providers/patient_provider.dart';
import 'providers/theme_provider.dart';
import 'services/firebase_bootstrap_service.dart';
import 'services/patient_repository.dart';

class OptiCalcProApp extends StatelessWidget {
  const OptiCalcProApp({
    required this.firebaseStatus,
    required this.patientRepository,
    this.initialRoute = AppRoutes.home,
    super.key,
  });

  final FirebaseStatus firebaseStatus;
  final PatientRepository patientRepository;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseStatus>.value(value: firebaseStatus),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              PatientProvider(repository: patientRepository)..loadPatients(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'OptiCalc Pro',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            initialRoute: initialRoute,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
