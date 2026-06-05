import 'package:flutter/material.dart';

import '../../core/optics/optical_math.dart';
import '../../widgets/calculation_result_card.dart';
import '../../widgets/clinical_number_field.dart';
import '../../widgets/module_surface.dart';
import '../../widgets/premium_card.dart';

class ContactLensPage extends StatefulWidget {
  const ContactLensPage({super.key});

  @override
  State<ContactLensPage> createState() => _ContactLensPageState();
}

class _ContactLensPageState extends State<ContactLensPage> {
  final _spectaclePower = TextEditingController(text: '-8.00');
  final _vertex = TextEditingController(text: '12');
  final _kReading = TextEditingController(text: '43.25');

  @override
  void dispose() {
    _spectaclePower.dispose();
    _vertex.dispose();
    _kReading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = _calculate();

    return ModuleSurface(
      title: 'Lentes de Contato',
      subtitle: 'Compensação por vértice e apoio inicial à adaptação.',
      child: Column(
        children: [
          PremiumCard(
            child: Column(
              children: [
                ClinicalNumberField(
                  controller: _spectaclePower,
                  label: 'Potência dos óculos',
                  suffix: 'D',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _vertex,
                  label: 'Distância vértice',
                  suffix: 'mm',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _kReading,
                  label: 'K médio',
                  suffix: 'D',
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.blur_circular_outlined),
                  label: const Text('Converter para LC'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (result.error != null)
            CalculationResultCard(
              title: 'Validação',
              value: 'Revisar dados',
              description: result.error!,
              icon: Icons.error_outline,
            )
          else
            CalculationResultCard(
              title: 'Potência estimada da LC',
              value: '${result.power!.toStringAsFixed(2)} D',
              description:
                  'FLC = F / (1 - dF). Curva base sugerida: ${result.baseCurve!.toStringAsFixed(2)} mm.',
              icon: Icons.radio_button_unchecked,
            ),
        ],
      ),
    );
  }

  _ContactLensCalculation _calculate() {
    try {
      final power = OpticalMath.contactLensVertexConversion(
        spectaclePower: _parse(_spectaclePower.text),
        vertexDistanceMm: _parse(_vertex.text),
      );
      final baseCurve = 337.5 / _parse(_kReading.text);
      return _ContactLensCalculation(power: power, baseCurve: baseCurve);
    } on OpticalCalculationException catch (error) {
      return _ContactLensCalculation(error: error.message);
    } catch (_) {
      return const _ContactLensCalculation(
        error: 'Use potência, vértice e K médio válidos.',
      );
    }
  }

  double _parse(String value) => double.parse(value.replaceAll(',', '.'));
}

class _ContactLensCalculation {
  const _ContactLensCalculation({this.power, this.baseCurve, this.error});

  final double? power;
  final double? baseCurve;
  final String? error;
}
