import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/app_state.dart';
import 'providers/patient_provider.dart';
import 'services/firebase_service.dart';
import 'services/patient_repository.dart';
import 'widgets/app_shell.dart';

class OptiCalcProApp extends StatelessWidget {
  const OptiCalcProApp({super.key, required this.firebaseStatus});

  final FirebaseStatus firebaseStatus;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState(firebaseStatus)),
        Provider<PatientRepository>(
          create: (_) => firebaseStatus.isConfigured
              ? FirestorePatientRepository()
              : MemoryPatientRepository(),
        ),
        ChangeNotifierProxyProvider<PatientRepository, PatientProvider>(
          create: (_) => PatientProvider(MemoryPatientRepository()),
          update: (_, repository, previous) {
            final provider = previous ?? PatientProvider(repository);
            provider.updateRepository(repository);
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OptiCalc Pro',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        home: const AppShell(),
      ),
    );
  }
}
