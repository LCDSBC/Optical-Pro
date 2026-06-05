import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../providers/patient_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/metric_card.dart';
import '../../widgets/responsive_page.dart';
import '../../widgets/section_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'OptiCalc Pro',
      selectedRoute: AppRoutes.home,
      child: ResponsivePage(
        children: [
          _HeroPanel(),
          _FeatureGrid(),
          Consumer<PatientProvider>(
            builder: (context, provider, _) {
              return MetricCard(
                label: 'Pacientes cadastrados',
                value: provider.patients.length.toString(),
                icon: Icons.group,
                helper: provider.usesFirebase
                    ? 'Sincronizado com Cloud Firestore'
                    : 'Modo local ativo',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SectionCard(
      title: 'Suite clinica para Optometria e Otica',
      subtitle: 'Calculos validados, pacientes e UI responsiva em Material 3.',
      icon: Icons.health_and_safety,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Use os modulos para transpor receitas, converter lentes de '
            'contato, calcular prismas, estimar adicao multifocal e registrar '
            'pacientes.',
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.refraction),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Comecar pela refracao'),
          ),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final features = [
      _Feature('Refracao', 'EE e transposicao.', AppRoutes.refraction),
      _Feature(
        'Lentes de contato',
        'Conversao por vertice.',
        AppRoutes.contactLens,
      ),
      _Feature('Prismas', 'Regra de Prentice.', AppRoutes.prism),
      _Feature('Multifocal', 'Estimativa de adicao.', AppRoutes.multifocal),
      _Feature('Terapia visual', 'AC/A e vergencias.', AppRoutes.visualTherapy),
      _Feature('Pacientes', 'Cadastro e historico.', AppRoutes.patients),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 1000
            ? 3
            : constraints.maxWidth > 640
            ? 2
            : 1;

        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: columns == 1 ? 3.6 : 2.2,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            for (final feature in features)
              Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, feature.route),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          feature.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(feature.description),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Feature {
  const _Feature(this.title, this.description, this.route);

  final String title;
  final String description;
  final String route;
}
