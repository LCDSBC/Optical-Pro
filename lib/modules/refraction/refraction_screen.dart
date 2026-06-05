import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/form_parsers.dart';
import '../../models/optical_prescription.dart';
import '../../providers/calculator_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/form_field_grid.dart';
import '../../widgets/metric_card.dart';
import '../../widgets/number_field.dart';
import '../../widgets/responsive_page.dart';
import '../../widgets/section_card.dart';

class RefractionScreen extends StatefulWidget {
  const RefractionScreen({super.key});

  @override
  State<RefractionScreen> createState() => _RefractionScreenState();
}

class _RefractionScreenState extends State<RefractionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sphereController = TextEditingController(text: '-2.00');
  final _cylinderController = TextEditingController(text: '-1.00');
  final _axisController = TextEditingController(text: '180');

  @override
  void dispose() {
    _sphereController.dispose();
    _cylinderController.dispose();
    _axisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Refracao',
      selectedRoute: AppRoutes.refraction,
      child: ResponsivePage(
        children: [
          SectionCard(
            title: 'Receita optica',
            subtitle: 'Calcule equivalente esferico e transposicao.',
            icon: Icons.visibility,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormFieldGrid(
                    children: [
                      NumberField(
                        controller: _sphereController,
                        label: 'Esferico',
                        suffix: 'D',
                      ),
                      NumberField(
                        controller: _cylinderController,
                        label: 'Cilindrico',
                        suffix: 'D',
                      ),
                      NumberField(
                        controller: _axisController,
                        label: 'Eixo',
                        suffix: 'graus',
                        integerOnly: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: _calculate,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calcular refracao'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<CalculatorProvider>(
            builder: (context, provider, _) {
              final result = provider.lastResult;
              return SectionCard(
                title: 'Resultado',
                icon: Icons.analytics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (provider.errorMessage != null)
                      Text(
                        provider.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _ResultTile(
                          child: MetricCard(
                            label: 'Equivalente esferico',
                            value: formatDiopter(result['sphericalEquivalent']),
                            icon: Icons.lens,
                          ),
                        ),
                        _ResultTile(
                          child: MetricCard(
                            label: 'Transposta',
                            value:
                                '${formatDiopter(result['transposedSphere'])} / '
                                '${formatDiopter(result['transposedCylinder'])}',
                            icon: Icons.swap_horiz,
                            helper: 'Eixo ${result['transposedAxis'] ?? '--'}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<CalculatorProvider>().calculateRefraction(
      OpticalPrescription(
        sphere: parseDecimal(_sphereController.text),
        cylinder: parseDecimal(_cylinderController.text),
        axis: parseInteger(_axisController.text),
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 320, child: child);
  }
}
