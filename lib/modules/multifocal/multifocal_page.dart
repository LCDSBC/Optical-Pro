import 'package:flutter/material.dart';

import '../../core/optics/optical_math.dart';
import '../../widgets/calculation_result_card.dart';
import '../../widgets/clinical_number_field.dart';
import '../../widgets/module_surface.dart';
import '../../widgets/premium_card.dart';

class MultifocalPage extends StatefulWidget {
  const MultifocalPage({super.key});

  @override
  State<MultifocalPage> createState() => _MultifocalPageState();
}

class _MultifocalPageState extends State<MultifocalPage> {
  final _age = TextEditingController(text: '52');
  final _residualAccommodation = TextEditingController(text: '1.50');
  final _workingDistance = TextEditingController(text: '0.40');

  @override
  void dispose() {
    _age.dispose();
    _residualAccommodation.dispose();
    _workingDistance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = _calculate();

    return ModuleSurface(
      title: 'Multifocal',
      subtitle:
          'Adição por idade, acomodação residual e distância de trabalho.',
      child: Column(
        children: [
          PremiumCard(
            child: Column(
              children: [
                ClinicalNumberField(
                  controller: _age,
                  label: 'Idade',
                  suffix: 'anos',
                  allowDecimal: false,
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _residualAccommodation,
                  label: 'Acomodação residual',
                  suffix: 'D',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _workingDistance,
                  label: 'Distância de trabalho',
                  suffix: 'm',
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.center_focus_strong_outlined),
                  label: const Text('Calcular adição'),
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
              title: 'Adição sugerida',
              value: '+${result.addition!.toStringAsFixed(2)} D',
              description:
                  'Demanda de trabalho: ${result.demand!.toStringAsFixed(2)} D, com reserva clínica de acomodação.',
              icon: Icons.remove_red_eye_outlined,
            ),
        ],
      ),
    );
  }

  _MultifocalCalculation _calculate() {
    try {
      final distance = _parse(_workingDistance.text);
      return _MultifocalCalculation(
        addition: OpticalMath.multifocalAddition(
          age: int.parse(_age.text.trim()),
          residualAccommodation: _parse(_residualAccommodation.text),
          workingDistanceMeters: distance,
        ),
        demand: OpticalMath.workingDistanceDemand(distance),
      );
    } on OpticalCalculationException catch (error) {
      return _MultifocalCalculation(error: error.message);
    } catch (_) {
      return const _MultifocalCalculation(
        error: 'Use idade, acomodação e distância válidas.',
      );
    }
  }

  double _parse(String value) => double.parse(value.replaceAll(',', '.'));
}

class _MultifocalCalculation {
  const _MultifocalCalculation({this.addition, this.demand, this.error});

  final double? addition;
  final double? demand;
  final String? error;
}
