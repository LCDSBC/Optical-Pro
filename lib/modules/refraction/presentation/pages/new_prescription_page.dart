import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/refraction_provider.dart';
import '../widgets/clinical_metric_card.dart';
import '../widgets/premium_panel.dart';

class NewPrescriptionPage extends StatefulWidget {
  const NewPrescriptionPage({super.key});

  @override
  State<NewPrescriptionPage> createState() => _NewPrescriptionPageState();
}

class _NewPrescriptionPageState extends State<NewPrescriptionPage> {
  final _rightSphere = TextEditingController(text: '0.00');
  final _rightCylinder = TextEditingController(text: '0.00');
  final _rightAxis = TextEditingController(text: '0');
  final _rightAddition = TextEditingController(text: '0.00');
  final _leftSphere = TextEditingController(text: '0.00');
  final _leftCylinder = TextEditingController(text: '0.00');
  final _leftAxis = TextEditingController(text: '0');
  final _leftAddition = TextEditingController(text: '0.00');

  @override
  void dispose() {
    _rightSphere.dispose();
    _rightCylinder.dispose();
    _rightAxis.dispose();
    _rightAddition.dispose();
    _leftSphere.dispose();
    _leftCylinder.dispose();
    _leftAxis.dispose();
    _leftAddition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.midnight, AppTheme.navy, Color(0xFF03101F)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Header(),
                    const SizedBox(height: 28),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 920;
                        final form = _PrescriptionForm(
                          rightSphere: _rightSphere,
                          rightCylinder: _rightCylinder,
                          rightAxis: _rightAxis,
                          rightAddition: _rightAddition,
                          leftSphere: _leftSphere,
                          leftCylinder: _leftCylinder,
                          leftAxis: _leftAxis,
                          leftAddition: _leftAddition,
                        );
                        const results = _ResultsPanel();

                        if (isWide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 5, child: form),
                              const SizedBox(width: 22),
                              const Expanded(flex: 4, child: results),
                            ],
                          );
                        }

                        return Column(
                          children: [form, const SizedBox(height: 22), results],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return PremiumPanel(
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: AppTheme.medicalBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppTheme.clinicalCyan.withValues(alpha: 0.22),
              ),
            ),
            child: const Icon(
              Icons.visibility_rounded,
              color: AppTheme.clinicalCyan,
              size: 34,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OptiCalc Pro',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.clinicalCyan,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Nova Receita',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Refração clínica com transposição automática, equivalente esférico e interpretação assistida.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
          const _ModuleBadge(),
        ],
      ),
    );
  }
}

class _ModuleBadge extends StatelessWidget {
  const _ModuleBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.medicalBlue.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppTheme.clinicalCyan.withValues(alpha: 0.25),
        ),
      ),
      child: const Text(
        'Módulo Refração',
        style: TextStyle(
          color: AppTheme.clinicalCyan,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _PrescriptionForm extends StatelessWidget {
  const _PrescriptionForm({
    required this.rightSphere,
    required this.rightCylinder,
    required this.rightAxis,
    required this.rightAddition,
    required this.leftSphere,
    required this.leftCylinder,
    required this.leftAxis,
    required this.leftAddition,
  });

  final TextEditingController rightSphere;
  final TextEditingController rightCylinder;
  final TextEditingController rightAxis;
  final TextEditingController rightAddition;
  final TextEditingController leftSphere;
  final TextEditingController leftCylinder;
  final TextEditingController leftAxis;
  final TextEditingController leftAddition;

  @override
  Widget build(BuildContext context) {
    return PremiumPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.edit_note_rounded,
            title: 'Dados refracionais',
            subtitle: 'Informe ESF, CIL, EIXO e ADD para cada olho.',
          ),
          const SizedBox(height: 22),
          LayoutBuilder(
            builder: (context, constraints) {
              final rightEye = _EyeCard(
                title: 'OD',
                subtitle: 'Olho direito',
                sphere: rightSphere,
                cylinder: rightCylinder,
                axis: rightAxis,
                addition: rightAddition,
                keyPrefix: 'right',
              );
              final leftEye = _EyeCard(
                title: 'OE',
                subtitle: 'Olho esquerdo',
                sphere: leftSphere,
                cylinder: leftCylinder,
                axis: leftAxis,
                addition: leftAddition,
                keyPrefix: 'left',
              );

              if (constraints.maxWidth >= 640) {
                return Row(
                  children: [
                    Expanded(child: rightEye),
                    const SizedBox(width: 16),
                    Expanded(child: leftEye),
                  ],
                );
              }

              return Column(
                children: [rightEye, const SizedBox(height: 16), leftEye],
              );
            },
          ),
          const SizedBox(height: 22),
          Consumer<RefractionProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    key: const Key('calculateRefractionButton'),
                    onPressed: () => provider.calculate(
                      rightSphere: rightSphere.text,
                      rightCylinder: rightCylinder.text,
                      rightAxis: rightAxis.text,
                      rightAddition: rightAddition.text,
                      leftSphere: leftSphere.text,
                      leftCylinder: leftCylinder.text,
                      leftAxis: leftAxis.text,
                      leftAddition: leftAddition.text,
                    ),
                    icon: const Icon(Icons.auto_awesome_rounded),
                    label: const Text('Calcular refração'),
                  ),
                  if (provider.errorMessage != null) ...[
                    const SizedBox(height: 14),
                    Text(
                      provider.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EyeCard extends StatelessWidget {
  const _EyeCard({
    required this.title,
    required this.subtitle,
    required this.sphere,
    required this.cylinder,
    required this.axis,
    required this.addition,
    required this.keyPrefix,
  });

  final String title;
  final String subtitle;
  final TextEditingController sphere;
  final TextEditingController cylinder;
  final TextEditingController axis;
  final TextEditingController addition;
  final String keyPrefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.62)),
          ),
          const SizedBox(height: 18),
          _PrescriptionField(
            keyValue: '${keyPrefix}Sphere',
            label: 'ESF',
            controller: sphere,
            icon: Icons.remove_red_eye_outlined,
          ),
          const SizedBox(height: 12),
          _PrescriptionField(
            keyValue: '${keyPrefix}Cylinder',
            label: 'CIL',
            controller: cylinder,
            icon: Icons.blur_circular_rounded,
          ),
          const SizedBox(height: 12),
          _PrescriptionField(
            keyValue: '${keyPrefix}Axis',
            label: 'EIXO',
            controller: axis,
            icon: Icons.explore_outlined,
            signed: false,
            decimal: false,
          ),
          const SizedBox(height: 12),
          _PrescriptionField(
            keyValue: '${keyPrefix}Addition',
            label: 'ADD',
            controller: addition,
            icon: Icons.add_circle_outline_rounded,
            signed: false,
          ),
        ],
      ),
    );
  }
}

class _PrescriptionField extends StatelessWidget {
  const _PrescriptionField({
    required this.keyValue,
    required this.label,
    required this.controller,
    required this.icon,
    this.signed = true,
    this.decimal = true,
  });

  final String keyValue;
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool signed;
  final bool decimal;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(keyValue),
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(
        signed: signed,
        decimal: decimal,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixText: label == 'EIXO' ? '°' : 'D',
      ),
    );
  }
}

class _ResultsPanel extends StatelessWidget {
  const _ResultsPanel();

  @override
  Widget build(BuildContext context) {
    return Consumer<RefractionProvider>(
      builder: (context, provider, child) {
        final result = provider.result;
        final calculator = provider.calculator;

        return PremiumPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(
                icon: Icons.monitor_heart_rounded,
                title: 'Análise clínica',
                subtitle: 'Resultados calculados em tempo real após salvar.',
              ),
              const SizedBox(height: 22),
              if (result == null)
                const _EmptyResults()
              else ...[
                ClinicalMetricCard(
                  title: 'Equivalente esférico',
                  primaryValue:
                      'OD ${calculator.formatDiopter(result.rightEye.sphericalEquivalent)}',
                  secondaryValue:
                      'OE ${calculator.formatDiopter(result.leftEye.sphericalEquivalent)}',
                  icon: Icons.analytics_outlined,
                ),
                const SizedBox(height: 14),
                ClinicalMetricCard(
                  title: 'Transposição automática',
                  primaryValue:
                      'OD ${calculator.formatPrescription(result.rightEye.transposed)}',
                  secondaryValue:
                      'OE ${calculator.formatPrescription(result.leftEye.transposed)}',
                  icon: Icons.sync_alt_rounded,
                ),
                const SizedBox(height: 14),
                _ClinicalInterpretation(items: result.clinicalInterpretation),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.medicalBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.clinicalCyan.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.science_outlined, color: AppTheme.clinicalCyan),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Preencha a receita e calcule para visualizar equivalente esférico, transposição e interpretação clínica.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicalInterpretation extends StatelessWidget {
  const _ClinicalInterpretation({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interpretação clínica',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 18,
                        color: AppTheme.clinicalCyan,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.76),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.clinicalCyan),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.62)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
