import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'widgets/dashboard_module_card.dart';
import 'widgets/dashboard_sidebar.dart';
import 'widgets/glass_panel.dart';
import 'widgets/quick_action_tile.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const List<DashboardSidebarItem> _sidebarItems = [
    DashboardSidebarItem(
      label: 'Dashboard',
      icon: Icons.space_dashboard_rounded,
    ),
    DashboardSidebarItem(label: 'Pacientes', icon: Icons.group_rounded),
    DashboardSidebarItem(label: 'Refração', icon: Icons.remove_red_eye_rounded),
    DashboardSidebarItem(
      label: 'Lente de Contato',
      icon: Icons.lens_blur_rounded,
    ),
    DashboardSidebarItem(label: 'Prismas', icon: Icons.change_history_rounded),
    DashboardSidebarItem(label: 'Multifocal', icon: Icons.blur_on_rounded),
    DashboardSidebarItem(label: 'Histórico', icon: Icons.history_rounded),
    DashboardSidebarItem(label: 'Configurações', icon: Icons.tune_rounded),
  ];

  static const List<_ModuleInfo> _modules = [
    _ModuleInfo(
      title: 'Pacientes',
      description:
          'Cadastro, evolução clínica e observações em um fluxo único.',
      metric: '128 ativos',
      icon: Icons.group_rounded,
      color: Color(0xFF2F8CFF),
    ),
    _ModuleInfo(
      title: 'Refração',
      description:
          'Receitas, transposição e equivalente esférico com precisão.',
      metric: '42 exames',
      icon: Icons.remove_red_eye_rounded,
      color: Color(0xFF52D8FF),
    ),
    _ModuleInfo(
      title: 'Lente de Contato',
      description: 'Conversão por vértice, adaptação e parâmetros de LC.',
      metric: '18 ajustes',
      icon: Icons.lens_blur_rounded,
      color: Color(0xFF6C7DFF),
    ),
    _ModuleInfo(
      title: 'Prismas',
      description: 'Regra de Prentice, prismas horizontais e verticais.',
      metric: '9 cálculos',
      icon: Icons.change_history_rounded,
      color: Color(0xFF8BE7C9),
    ),
    _ModuleInfo(
      title: 'Multifocal',
      description: 'Adição, corredor, profundidade de foco e apoio presbiopia.',
      metric: '24 planos',
      icon: Icons.blur_on_rounded,
      color: Color(0xFFB28CFF),
    ),
    _ModuleInfo(
      title: 'Histórico',
      description: 'Linha do tempo do paciente, prescrições e PDFs clínicos.',
      metric: '312 registros',
      icon: Icons.history_rounded,
      color: Color(0xFFFFB86B),
    ),
    _ModuleInfo(
      title: 'Configurações',
      description: 'Preferências, unidades, segurança e identidade da clínica.',
      metric: 'Premium',
      icon: Icons.tune_rounded,
      color: Color(0xFFFF6B9A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showSidebar = constraints.maxWidth >= 980;

        return Scaffold(
          drawer: showSidebar
              ? null
              : const Drawer(child: DashboardSidebar(items: _sidebarItems)),
          body: Stack(
            children: [
              const _DashboardBackground(),
              Row(
                children: [
                  if (showSidebar) const DashboardSidebar(items: _sidebarItems),
                  Expanded(
                    child: _DashboardContent(showMenuButton: !showSidebar),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.showMenuButton});

  final bool showMenuButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 10),
            sliver: SliverToBoxAdapter(
              child: _DashboardHero(showMenuButton: showMenuButton),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(28, 14, 28, 0),
            sliver: SliverToBoxAdapter(child: _SectionHeader(title: 'Módulos')),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(28, 18, 28, 28),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.crossAxisExtent;
                final columns = width >= 1120
                    ? 3
                    : width >= 720
                    ? 2
                    : 1;

                return SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final module = DashboardPage._modules[index];

                    return DashboardModuleCard(
                      title: module.title,
                      description: module.description,
                      metric: module.metric,
                      icon: module.icon,
                      accentColor: module.color,
                      delay: index * 80,
                    );
                  }, childCount: DashboardPage._modules.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: columns == 1 ? 1.35 : 1.08,
                  ),
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 36),
            sliver: SliverToBoxAdapter(child: const _QuickActionsPanel()),
          ),
        ],
      ),
    );
  }
}

class _DashboardHero extends StatelessWidget {
  const _DashboardHero({required this.showMenuButton});

  final bool showMenuButton;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 680),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 26 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: GlassPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showMenuButton) ...[
                  Builder(
                    builder: (context) => IconButton.filledTonal(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu_rounded),
                      tooltip: 'Abrir menu lateral',
                    ),
                  ),
                  const SizedBox(width: 14),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PremiumBadge(),
                      const SizedBox(height: 20),
                      Text(
                        'Dashboard Principal',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Controle clínico, cálculos ópticos e histórico do paciente em uma experiência dark premium inspirada em Apple e Tesla.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                const _PulseOrb(),
              ],
            ),
            const SizedBox(height: 28),
            const Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _MetricPill(label: 'Cálculos hoje', value: '76'),
                _MetricPill(label: 'Pacientes', value: '128'),
                _MetricPill(label: 'Precisão', value: '0.25D'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsPanel extends StatelessWidget {
  const _QuickActionsPanel();

  final List<_QuickActionInfo> _actions = const [
    _QuickActionInfo(
      title: 'Nova refração',
      subtitle: 'Criar receita e calcular EE',
      icon: Icons.add_circle_outline_rounded,
    ),
    _QuickActionInfo(
      title: 'Converter para LC',
      subtitle: 'Compensação por vértice',
      icon: Icons.sync_alt_rounded,
    ),
    _QuickActionInfo(
      title: 'Calcular prisma',
      subtitle: 'Regra de Prentice guiada',
      icon: Icons.architecture_rounded,
    ),
    _QuickActionInfo(
      title: 'Cadastrar paciente',
      subtitle: 'Abrir ficha clínica rápida',
      icon: Icons.person_add_alt_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Atalhos rápidos'),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final useColumns = constraints.maxWidth >= 760;

              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: _actions.map((action) {
                  return SizedBox(
                    width: useColumns
                        ? (constraints.maxWidth - 14) / 2
                        : constraints.maxWidth,
                    child: QuickActionTile(
                      title: action.title,
                      subtitle: action.subtitle,
                      icon: action.icon,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const Spacer(),
        Text(
          'OptiCalc Pro',
          style: TextStyle(
            color: AppTheme.cyanGlow.withValues(alpha: 0.82),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  const _PremiumBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppTheme.electricBlue.withValues(alpha: 0.16),
        border: Border.all(
          color: AppTheme.electricBlue.withValues(alpha: 0.34),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, color: AppTheme.cyanGlow, size: 16),
          SizedBox(width: 6),
          Text(
            'Dark mode premium',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseOrb extends StatelessWidget {
  const _PulseOrb();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.85, end: 1),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Container(
        width: 94,
        height: 94,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppTheme.cyanGlow.withValues(alpha: 0.82),
              AppTheme.electricBlue.withValues(alpha: 0.32),
              Colors.transparent,
            ],
          ),
        ),
        child: const Icon(
          Icons.auto_graph_rounded,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}

class _DashboardBackground extends StatelessWidget {
  const _DashboardBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.midnight, Color(0xFF04152A), Color(0xFF020510)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -160,
            right: -120,
            child: _GlowCircle(color: AppTheme.electricBlue, size: 420),
          ),
          Positioned(
            bottom: -150,
            left: 120,
            child: _GlowCircle(color: AppTheme.cyanGlow, size: 320),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.12),
      ),
    );
  }
}

class _ModuleInfo {
  const _ModuleInfo({
    required this.title,
    required this.description,
    required this.metric,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final String metric;
  final IconData icon;
  final Color color;
}

class _QuickActionInfo {
  const _QuickActionInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}
