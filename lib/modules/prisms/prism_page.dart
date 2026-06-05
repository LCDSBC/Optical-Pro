import 'package:flutter/material.dart';

import '../../core/optics/optical_math.dart';
import '../../widgets/calculation_result_card.dart';
import '../../widgets/clinical_number_field.dart';
import '../../widgets/module_surface.dart';
import '../../widgets/premium_card.dart';

class PrismPage extends StatefulWidget {
  const PrismPage({super.key});

  @override
  State<PrismPage> createState() => _PrismPageState();
}

class _PrismPageState extends State<PrismPage> {
  final _decentration = TextEditingController(text: '0.4');
  final _power = TextEditingController(text: '-5.00');
  String _orientation = 'Horizontal';

  @override
  void dispose() {
    _decentration.dispose();
    _power.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = _calculate();

    return ModuleSurface(
      title: 'Prismas',
      subtitle: 'Regra de Prentice para análise prismática de montagem.',
      child: Column(
        children: [
          PremiumCard(
            child: Column(
              children: [
                ClinicalNumberField(
                  controller: _decentration,
                  label: 'Descentração',
                  suffix: 'cm',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _power,
                  label: 'Potência da lente',
                  suffix: 'D',
                ),
                const SizedBox(height: 14),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'Horizontal',
                      label: Text('Horizontal'),
                      icon: Icon(Icons.swap_horiz),
                    ),
                    ButtonSegment(
                      value: 'Vertical',
                      label: Text('Vertical'),
                      icon: Icon(Icons.swap_vert),
                    ),
                  ],
                  selected: {_orientation},
                  onSelectionChanged: (value) {
                    setState(() => _orientation = value.first);
                  },
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.change_history_outlined),
                  label: const Text('Calcular prisma'),
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
              title: 'Efeito prismático $_orientation',
              value: '${result.prism!.abs().toStringAsFixed(2)} Δ',
              description:
                  'P = c x F. Sinal ${result.prism! >= 0 ? 'positivo' : 'negativo'} conforme direção da potência.',
              icon: Icons.architecture_outlined,
            ),
        ],
      ),
    );
  }

  _PrismCalculation _calculate() {
    try {
      return _PrismCalculation(
        prism: OpticalMath.prenticeRule(
          decentrationCm: _parse(_decentration.text),
          lensPower: _parse(_power.text),
        ),
      );
    } on OpticalCalculationException catch (error) {
      return _PrismCalculation(error: error.message);
    } catch (_) {
      return const _PrismCalculation(
        error: 'Use descentração e potência válidas.',
      );
    }
  }

  double _parse(String value) => double.parse(value.replaceAll(',', '.'));
}

class _PrismCalculation {
  const _PrismCalculation({this.prism, this.error});

  final double? prism;
  final String? error;
}
