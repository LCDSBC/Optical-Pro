import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/diopter_formatter.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/formula_input_field.dart';
import '../../../../widgets/metric_tile.dart';
import '../../../../widgets/responsive_scaffold.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/status_banner.dart';
import '../providers/contact_lens_provider.dart';

class ContactLensPage extends StatefulWidget {
  const ContactLensPage({super.key});

  @override
  State<ContactLensPage> createState() => _ContactLensPageState();
}

class _ContactLensPageState extends State<ContactLensPage> {
  final _lensPowerController = TextEditingController(text: '-6.00');
  final _vertexDistanceController = TextEditingController(
    text: AppConstants.defaultVertexDistanceMeters.toString(),
  );

  @override
  void dispose() {
    _lensPowerController.dispose();
    _vertexDistanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactLensProvider>();
    final conversion = provider.conversion;

    return ResponsiveScaffold(
      title: 'Lentes de Contato',
      body: ListView(
        children: [
          const SectionHeader(
            title: 'Conversao LC',
            subtitle: 'Compensacao por distancia vertice para lentes de contato.',
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              children: [
                FormulaInputField(
                  controller: _lensPowerController,
                  label: 'Potencia da lente',
                  suffixText: 'D',
                ),
                const SizedBox(height: 12),
                FormulaInputField(
                  controller: _vertexDistanceController,
                  label: 'Distancia vertice',
                  suffixText: 'm',
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _convert,
                  icon: const Icon(Icons.adjust_outlined),
                  label: const Text('Converter potencia'),
                ),
              ],
            ),
          ),
          if (provider.errorMessage != null) ...[
            const SizedBox(height: 16),
            StatusBanner(message: provider.errorMessage!),
          ],
          if (conversion != null) ...[
            const SizedBox(height: 16),
            MetricTile(
              label: 'Potencia LC compensada',
              value: DiopterFormatter.signed(conversion.convertedPower),
              icon: Icons.remove_red_eye_outlined,
            ),
          ],
        ],
      ),
    );
  }

  void _convert() {
    context.read<ContactLensProvider>().convert(
          lensPower: _parseDouble(_lensPowerController.text),
          vertexDistanceMeters: _parseDouble(_vertexDistanceController.text),
        );
  }

  static double _parseDouble(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.')) ?? double.nan;
  }
}
