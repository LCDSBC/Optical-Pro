import 'package:flutter/material.dart';

import '../../modules/contact_lens/contact_lens_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/multifocal/multifocal_screen.dart';
import '../../modules/patients/patients_screen.dart';
import '../../modules/prism/prism_screen.dart';
import '../../modules/refraction/refraction_screen.dart';
import '../../modules/visual_therapy/visual_therapy_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String refraction = '/refraction';
  static const String contactLens = '/contact-lens';
  static const String prism = '/prism';
  static const String multifocal = '/multifocal';
  static const String visualTherapy = '/visual-therapy';
  static const String patients = '/patients';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (_) => const HomeScreen(),
      refraction: (_) => const RefractionScreen(),
      contactLens: (_) => const ContactLensScreen(),
      prism: (_) => const PrismScreen(),
      multifocal: (_) => const MultifocalScreen(),
      visualTherapy: (_) => const VisualTherapyScreen(),
      patients: (_) => const PatientsScreen(),
    };
  }
}

class AppDestination {
  const AppDestination({
    required this.route,
    required this.label,
    required this.icon,
  });

  final String route;
  final String label;
  final IconData icon;
}

const appDestinations = <AppDestination>[
  AppDestination(route: AppRoutes.home, label: 'Inicio', icon: Icons.dashboard),
  AppDestination(
    route: AppRoutes.refraction,
    label: 'Refracao',
    icon: Icons.visibility,
  ),
  AppDestination(
    route: AppRoutes.contactLens,
    label: 'Lente contato',
    icon: Icons.adjust,
  ),
  AppDestination(
    route: AppRoutes.prism,
    label: 'Prismas',
    icon: Icons.view_in_ar,
  ),
  AppDestination(
    route: AppRoutes.multifocal,
    label: 'Multifocal',
    icon: Icons.auto_awesome,
  ),
  AppDestination(
    route: AppRoutes.visualTherapy,
    label: 'Terapia',
    icon: Icons.psychology,
  ),
  AppDestination(
    route: AppRoutes.patients,
    label: 'Pacientes',
    icon: Icons.group,
  ),
];
