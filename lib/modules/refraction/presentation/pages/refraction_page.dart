import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/diopter_formatter.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/formula_input_field.dart';
import '../../../../widgets/metric_tile.dart';
import '../../../../widgets/responsive_scaffold.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/status_banner.dart';
import '../providers/refraction_provider.dart';

class RefractionPage extends StatefulWidget {
  const RefractionPage({super.key});

  @override
  State<RefractionPage> createState() => _RefractionPageState();
}

class _RefractionPageState extends State<RefractionPage> {
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
    final provider = context.watch<RefractionProvider>();
    final calculation = provider.calculation;

    return ResponsiveScaffold(
      title: 'Refracao',
      body: ListView(
        children: [
          const SectionHeader(
            title: 'Refracao',
            subtitle: 'Equivalente esferico e transposicao automatica.',
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              children: [
                FormulaInputField(
                  controller: _sphereController,
                  label: 'Esferico',
                  suffixText: 'D',
                ),
                const SizedBox(height: 12),
                FormulaInputField(
                  controller: _cylinderController,
                  label: 'Cilindro',
                  suffixText: 'D',
                ),
                const SizedBox(height: 12),
                FormulaInputField(
                  controller: _axisController,
                  label: 'Eixo',
                  suffixText: 'graus',
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _calculate,
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('Calcular refracao'),
                ),
              ],
            ),
          ),
          if (provider.errorMessage != null) ...[
            const SizedBox(height: 16),
            StatusBanner(message: provider.errorMessage!),
          ],
          if (calculation != null) ...[
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resultados',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  MetricTile(
                    label: 'Equivalente esferico',
                    value: DiopterFormatter.signed(
                      calculation.sphericalEquivalent,
                    ),
                    icon: Icons.analytics_outlined,
                  ),
                  const SizedBox(height: 12),
                  MetricTile(
                    label: 'Transposicao',
                    value:
                        '${DiopterFormatter.signed(calculation.transposed.sphere)} '
                        '${DiopterFormatter.signed(calculation.transposed.cylinder)} '
                        'x ${calculation.transposed.axis} graus',
                    icon: Icons.swap_horiz_outlined,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _calculate() {
    context.read<RefractionProvider>().calculate(
          sphere: _parseDouble(_sphereController.text),
          cylinder: _parseDouble(_cylinderController.text),
          axis: int.tryParse(_axisController.text.trim()) ?? -1,
        );
  }

  static double _parseDouble(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.')) ?? double.nan;
  }
}
