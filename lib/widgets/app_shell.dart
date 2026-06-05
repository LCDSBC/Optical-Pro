import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/app_routes.dart';
import '../providers/theme_provider.dart';
import '../services/firebase_bootstrap_service.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.title,
    required this.selectedRoute,
    required this.child,
    super.key,
  });

  final String title;
  final String selectedRoute;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final useRail = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [_FirebaseStatusChip(), _ThemeToggle()],
      ),
      drawer: useRail ? null : _NavigationDrawer(selectedRoute: selectedRoute),
      body: Row(
        children: [
          if (useRail) _NavigationRail(selectedRoute: selectedRoute),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _NavigationRail extends StatelessWidget {
  const _NavigationRail({required this.selectedRoute});

  final String selectedRoute;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = appDestinations.indexWhere(
      (destination) => destination.route == selectedRoute,
    );

    return NavigationRail(
      selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
      labelType: NavigationRailLabelType.all,
      destinations: [
        for (final destination in appDestinations)
          NavigationRailDestination(
            icon: Icon(destination.icon),
            label: Text(destination.label),
          ),
      ],
      onDestinationSelected: (index) {
        _goTo(context, appDestinations[index].route);
      },
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer({required this.selectedRoute});

  final String selectedRoute;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = appDestinations.indexWhere(
      (destination) => destination.route == selectedRoute,
    );

    return NavigationDrawer(
      selectedIndex: selectedIndex < 0 ? null : selectedIndex,
      onDestinationSelected: (index) {
        Navigator.pop(context);
        _goTo(context, appDestinations[index].route);
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 28, 16, 12),
          child: Text('OptiCalc Pro'),
        ),
        for (final destination in appDestinations)
          NavigationDrawerDestination(
            icon: Icon(destination.icon),
            label: Text(destination.label),
          ),
      ],
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return IconButton(
          tooltip: 'Alternar tema',
          onPressed: themeProvider.toggleDarkMode,
          icon: Icon(themeProvider.isDark ? Icons.light_mode : Icons.dark_mode),
        );
      },
    );
  }
}

class _FirebaseStatusChip extends StatelessWidget {
  const _FirebaseStatusChip();

  @override
  Widget build(BuildContext context) {
    final status = context.watch<FirebaseStatus>();
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Tooltip(
        message: status.message,
        child: Chip(
          visualDensity: VisualDensity.compact,
          avatar: Icon(
            status.isOnline ? Icons.cloud_done : Icons.cloud_off,
            size: 18,
          ),
          label: Text(status.isOnline ? 'Firebase' : 'Local'),
          backgroundColor: status.isOnline
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}

void _goTo(BuildContext context, String route) {
  if (ModalRoute.of(context)?.settings.name == route) {
    return;
  }
  Navigator.pushReplacementNamed(context, route);
}
