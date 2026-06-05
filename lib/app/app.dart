import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider_scope.dart';
import '../providers/theme_provider.dart';
import 'bootstrap.dart';
import 'routes/app_router.dart';
import 'routes/app_routes.dart';

class OptiCalcProApp extends StatelessWidget {
  const OptiCalcProApp({
    required this.dependencies,
    super.key,
  });

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return AppProviderScope(
      dependencies: dependencies,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'OptiCalc Pro',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: AppRoutes.dashboard,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
