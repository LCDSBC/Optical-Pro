import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../providers/firebase_status_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/responsive_scaffold.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/status_banner.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebase = context.watch<FirebaseStatusProvider>();

    return ResponsiveScaffold(
      title: AppConstants.appName,
      actions: [
        IconButton(
          tooltip: 'Alternar tema',
          onPressed: context.read<ThemeProvider>().toggleDarkMode,
          icon: const Icon(Icons.dark_mode_outlined),
        ),
      ],
      body: ListView(
        children: [
          SectionHeader(
            title: AppConstants.appName,
            subtitle:
                'Calculadora clinica modular para Optometria e Otica no Brasil.',
          ),
          const SizedBox(height: 20),
          StatusBanner(
            isSuccess: firebase.isInitialized,
            message: firebase.isInitialized
                ? 'Firebase conectado ao projeto ${firebase.projectId}.'
                : 'Firebase aguardando configuracao real via FlutterFire CLI.',
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width >= 900
                  ? 3
                  : width >= 620
                      ? 2
                      : 1;

              return GridView.count(
                crossAxisCount: columns,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: columns == 1 ? 2.3 : 1.45,
                children: const [
                  _ModuleCard(
                    title: 'Refracao',
                    description: 'Transposicao, equivalente esferico e analise.',
                    icon: Icons.visibility_outlined,
                    route: AppRoutes.refraction,
                  ),
                  _ModuleCard(
                    title: 'Lentes de Contato',
                    description: 'Conversao por vertice e base para calculo LC.',
                    icon: Icons.adjust_outlined,
                    route: AppRoutes.contactLens,
                  ),
                  _ModuleCard(
                    title: 'Prismas',
                    description: 'Regra de Prentice para montagem optica.',
                    icon: Icons.blur_linear_outlined,
                    route: AppRoutes.prisms,
                  ),
                  _ModuleCard(
                    title: 'Pacientes',
                    description: 'Cadastro, historico e notas clinicas.',
                    icon: Icons.group_outlined,
                    route: AppRoutes.patients,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });

  final String title;
  final String description;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppCard(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: colorScheme.onPrimaryContainer,
            child: Icon(icon),
          ),
          const Spacer(),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
