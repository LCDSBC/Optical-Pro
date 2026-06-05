import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../app/bootstrap.dart';
import '../modules/contact_lens/domain/usecases/convert_vertex_power.dart';
import '../modules/contact_lens/presentation/providers/contact_lens_provider.dart';
import '../modules/patients/presentation/providers/patients_provider.dart';
import '../modules/prisms/domain/usecases/calculate_prentice.dart';
import '../modules/prisms/presentation/providers/prisms_provider.dart';
import '../modules/refraction/domain/usecases/calculate_refraction_metrics.dart';
import '../modules/refraction/presentation/providers/refraction_provider.dart';
import '../services/optical_formula_service.dart';
import 'firebase_status_provider.dart';
import 'theme_provider.dart';

class AppProviderScope extends StatelessWidget {
  const AppProviderScope({
    required this.dependencies,
    required this.child,
    super.key,
  });

  final AppDependencies dependencies;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDependencies>.value(value: dependencies),
        Provider<OpticalFormulaService>.value(
          value: dependencies.opticalFormulaService,
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseStatusProvider(dependencies.firebaseStatus),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => RefractionProvider(
            CalculateRefractionMetrics(dependencies.opticalFormulaService),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactLensProvider(
            ConvertVertexPower(dependencies.opticalFormulaService),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PrismsProvider(
            CalculatePrentice(dependencies.opticalFormulaService),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PatientsProvider(
            repository: dependencies.patientRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
