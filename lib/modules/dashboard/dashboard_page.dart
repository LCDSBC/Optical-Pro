import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';
import '../../widgets/premium_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseStatus = context.watch<AppState>().firebaseStatus;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return _PageSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OptiCalc Pro',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Calculadora clínica para optometria, óptica e lentes de contato.',
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 28),
          PremiumCard(
            child: Row(
              children: [
                Icon(
                  firebaseStatus.isConfigured
                      ? Icons.cloud_done_outlined
                      : Icons.cloud_off_outlined,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 14),
                Expanded(child: Text(firebaseStatus.message)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 980
                  ? 3
                  : constraints.maxWidth > 620
                  ? 2
                  : 1;
              return GridView.count(
                crossAxisCount: columns,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 1.32,
                children: const [
                  _FeatureCard(
                    title: 'Refração',
                    description:
                        'Transposição, equivalente esférico e leitura clínica.',
                    icon: Icons.visibility_outlined,
                  ),
                  _FeatureCard(
                    title: 'Lentes de Contato',
                    description:
                        'Conversão por vértice e apoio para adaptação tórica.',
                    icon: Icons.blur_circular_outlined,
                  ),
                  _FeatureCard(
                    title: 'Prismas',
                    description:
                        'Regra de Prentice para prismas horizontais e verticais.',
                    icon: Icons.change_history_outlined,
                  ),
                  _FeatureCard(
                    title: 'Multifocal',
                    description:
                        'Adição baseada em idade, reserva e distância de trabalho.',
                    icon: Icons.center_focus_strong_outlined,
                  ),
                  _FeatureCard(
                    title: 'Terapia Visual',
                    description: 'AC/A, NRA/PRA e flexibilidade acomodativa.',
                    icon: Icons.psychology_outlined,
                  ),
                  _FeatureCard(
                    title: 'Pacientes',
                    description:
                        'Cadastro rápido, histórico e observações clínicas.',
                    icon: Icons.group_outlined,
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

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 32),
          const Spacer(),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

class _PageSurface extends StatelessWidget {
  const _PageSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.1,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.16),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: child,
        ),
      ),
    );
  }
}
