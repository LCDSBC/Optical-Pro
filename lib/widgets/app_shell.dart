import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/contact_lens/contact_lens_page.dart';
import '../modules/dashboard/dashboard_page.dart';
import '../modules/multifocal/multifocal_page.dart';
import '../modules/patients/patients_page.dart';
import '../modules/prisms/prism_page.dart';
import '../modules/refraction/refraction_page.dart';
import '../modules/vision_therapy/vision_therapy_page.dart';
import '../providers/app_state.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  static const _destinations = [
    _ModuleDestination('Início', Icons.monitor_heart_outlined),
    _ModuleDestination('Refração', Icons.visibility_outlined),
    _ModuleDestination('LC', Icons.blur_circular_outlined),
    _ModuleDestination('Prismas', Icons.change_history_outlined),
    _ModuleDestination('Multifocal', Icons.center_focus_strong_outlined),
    _ModuleDestination('Terapia', Icons.psychology_outlined),
    _ModuleDestination('Pacientes', Icons.group_outlined),
  ];

  static const _pages = [
    DashboardPage(),
    RefractionPage(),
    ContactLensPage(),
    PrismPage(),
    MultifocalPage(),
    VisionTherapyPage(),
    PatientsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final selected = state.selectedModuleIndex;

    return Scaffold(
      body: Row(
        children: [
          if (wide)
            NavigationRail(
              selectedIndex: selected,
              labelType: NavigationRailLabelType.all,
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: _BrandMark(),
              ),
              destinations: [
                for (final item in _destinations)
                  NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.icon, fill: 1),
                    label: Text(item.label),
                  ),
              ],
              onDestinationSelected: state.selectModule,
            ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              child: _pages[selected],
            ),
          ),
        ],
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: selected,
              onDestinationSelected: state.selectModule,
              destinations: [
                for (final item in _destinations)
                  NavigationDestination(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
              ],
            ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.remove_red_eye_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'OptiCalc\nPro',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _ModuleDestination {
  const _ModuleDestination(this.label, this.icon);

  final String label;
  final IconData icon;
}
