import 'package:flutter/material.dart';

import '../../modules/contact_lens/presentation/pages/contact_lens_page.dart';
import '../../modules/dashboard/presentation/pages/dashboard_page.dart';
import '../../modules/patients/presentation/pages/patients_page.dart';
import '../../modules/prisms/presentation/pages/prisms_page.dart';
import '../../modules/refraction/presentation/pages/refraction_page.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (context) {
        return switch (settings.name) {
          AppRoutes.dashboard => const DashboardPage(),
          AppRoutes.refraction => const RefractionPage(),
          AppRoutes.contactLens => const ContactLensPage(),
          AppRoutes.prisms => const PrismsPage(),
          AppRoutes.patients => const PatientsPage(),
          _ => const DashboardPage(),
        };
      },
    );
  }
}
