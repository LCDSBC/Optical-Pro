import 'package:flutter/material.dart';

import '../../core/optics/optical_math.dart';
import '../../widgets/calculation_result_card.dart';
import '../../widgets/clinical_number_field.dart';
import '../../widgets/module_surface.dart';
import '../../widgets/premium_card.dart';

class VisionTherapyPage extends StatefulWidget {
  const VisionTherapyPage({super.key});

  @override
  State<VisionTherapyPage> createState() => _VisionTherapyPageState();
}

class _VisionTherapyPageState extends State<VisionTherapyPage> {
  final _convergence = TextEditingController(text: '18');
  final _accommodation = TextEditingController(text: '3');
  final _cycles = TextEditingController(text: '12');

  @override
  void dispose() {
    _convergence.dispose();
    _accommodation.dispose();
    _cycles.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = _calculate();

    return ModuleSurface(
      title: 'Terapia Visual',
      subtitle: 'AC/A, flexibilidade acomodativa e triagem NRA/PRA.',
      child: Column(
        children: [
          PremiumCard(
            child: Column(
              children: [
                ClinicalNumberField(
                  controller: _convergence,
                  label: 'Convergência acomodativa',
                  suffix: 'Δ',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _accommodation,
                  label: 'Acomodação',
                  suffix: 'D',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _cycles,
                  label: 'Flexibilidade acomodativa',
                  suffix: 'CPM',
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.psychology_outlined),
                  label: const Text('Avaliar terapia'),
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
              title: 'Relação AC/A',
              value: result.aca!.toStringAsFixed(2),
              description:
                  'Flexibilidade: ${result.flexibilityLabel}. Use NRA/PRA para complementar a conduta clínica.',
              icon: Icons.insights_outlined,
            ),
        ],
      ),
    );
  }

  _VisionTherapyCalculation _calculate() {
    try {
      final cycles = _parse(_cycles.text);
      return _VisionTherapyCalculation(
        aca: OpticalMath.acA(
          accommodativeConvergence: _parse(_convergence.text),
          accommodation: _parse(_accommodation.text),
        ),
        flexibilityLabel: cycles >= 11
            ? 'dentro do esperado'
            : 'abaixo do esperado, considerar treino',
      );
    } on OpticalCalculationException catch (error) {
      return _VisionTherapyCalculation(error: error.message);
    } catch (_) {
      return const _VisionTherapyCalculation(
        error: 'Use convergência, acomodação e CPM válidos.',
      );
    }
  }

  double _parse(String value) => double.parse(value.replaceAll(',', '.'));
}

class _VisionTherapyCalculation {
  const _VisionTherapyCalculation({
    this.aca,
    this.flexibilityLabel,
    this.error,
  });

  final double? aca;
  final String? flexibilityLabel;
  final String? error;
}
