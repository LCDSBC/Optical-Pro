import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/diopter_formatter.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/formula_input_field.dart';
import '../../../../widgets/metric_tile.dart';
import '../../../../widgets/responsive_scaffold.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/status_banner.dart';
import '../providers/prisms_provider.dart';

class PrismsPage extends StatefulWidget {
  const PrismsPage({super.key});

  @override
  State<PrismsPage> createState() => _PrismsPageState();
}

class _PrismsPageState extends State<PrismsPage> {
  final _decentrationController = TextEditingController(text: '0.5');
  final _powerController = TextEditingController(text: '-4.00');

  @override
  void dispose() {
    _decentrationController.dispose();
    _powerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PrismsProvider>();
    final calculation = provider.calculation;

    return ResponsiveScaffold(
      title: 'Prismas',
      body: ListView(
        children: [
          const SectionHeader(
            title: 'Regra de Prentice',
            subtitle: 'P = c x F, com descentracao em centimetros.',
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              children: [
                FormulaInputField(
                  controller: _decentrationController,
                  label: 'Descentracao',
                  suffixText: 'cm',
                ),
                const SizedBox(height: 12),
                FormulaInputField(
                  controller: _powerController,
                  label: 'Potencia da lente',
                  suffixText: 'D',
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _calculate,
                  icon: const Icon(Icons.blur_linear_outlined),
                  label: const Text('Calcular prisma'),
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
            MetricTile(
              label: 'Resultado prismatico',
              value: DiopterFormatter.prism(calculation.prismDiopters),
              icon: Icons.straighten_outlined,
            ),
          ],
        ],
      ),
    );
  }

  void _calculate() {
    context.read<PrismsProvider>().calculate(
          decentrationCentimeters: _parseDouble(_decentrationController.text),
          lensPower: _parseDouble(_powerController.text),
        );
  }

  static double _parseDouble(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.')) ?? double.nan;
  }
}
