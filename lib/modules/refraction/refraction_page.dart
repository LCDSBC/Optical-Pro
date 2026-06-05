import 'package:flutter/material.dart';

import '../../core/optics/optical_math.dart';
import '../../models/prescription.dart';
import '../../widgets/calculation_result_card.dart';
import '../../widgets/clinical_number_field.dart';
import '../../widgets/module_surface.dart';
import '../../widgets/premium_card.dart';

class RefractionPage extends StatefulWidget {
  const RefractionPage({super.key});

  @override
  State<RefractionPage> createState() => _RefractionPageState();
}

class _RefractionPageState extends State<RefractionPage> {
  final _sphere = TextEditingController(text: '-2.00');
  final _cylinder = TextEditingController(text: '-1.50');
  final _axis = TextEditingController(text: '20');

  @override
  void dispose() {
    _sphere.dispose();
    _cylinder.dispose();
    _axis.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calculation = _calculate();

    return ModuleSurface(
      title: 'Refração',
      subtitle: 'Equivalente esférico, transposição e interpretação clínica.',
      child: Column(
        children: [
          PremiumCard(
            child: Column(
              children: [
                ClinicalNumberField(
                  controller: _sphere,
                  label: 'ESF',
                  suffix: 'D',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _cylinder,
                  label: 'CIL',
                  suffix: 'D',
                ),
                const SizedBox(height: 14),
                ClinicalNumberField(
                  controller: _axis,
                  label: 'Eixo',
                  suffix: '°',
                  allowDecimal: false,
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('Calcular refração'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (calculation.error != null)
            CalculationResultCard(
              title: 'Validação',
              value: 'Revisar dados',
              description: calculation.error!,
              icon: Icons.error_outline,
            )
          else ...[
            CalculationResultCard(
              title: 'Equivalente esférico',
              value: '${calculation.equivalent!.toStringAsFixed(2)} D',
              description: 'EE = ESF + (CIL / 2), arredondado em 0.25D.',
              icon: Icons.functions_outlined,
            ),
            const SizedBox(height: 18),
            CalculationResultCard(
              title: 'Transposição',
              value:
                  '${_signed(calculation.transposed!.sphere)} / ${_signed(calculation.transposed!.cylinder)} x ${calculation.transposed!.axis}°',
              description: 'Novo ESF = ESF + CIL, novo CIL = -CIL, eixo ±90°.',
              icon: Icons.sync_alt_outlined,
            ),
          ],
        ],
      ),
    );
  }

  _RefractionCalculation _calculate() {
    try {
      final sphere = _parse(_sphere.text);
      final cylinder = _parse(_cylinder.text);
      final axis = int.parse(_axis.text.trim());
      final prescription = Prescription(
        sphere: sphere,
        cylinder: cylinder,
        axis: axis,
      );
      return _RefractionCalculation(
        equivalent: OpticalMath.sphericalEquivalent(
          sphere: sphere,
          cylinder: cylinder,
        ),
        transposed: OpticalMath.transpose(prescription),
      );
    } on OpticalCalculationException catch (error) {
      return _RefractionCalculation(error: error.message);
    } catch (_) {
      return const _RefractionCalculation(
        error: 'Use números válidos e eixo entre 0° e 180°.',
      );
    }
  }

  double _parse(String value) => double.parse(value.replaceAll(',', '.'));

  String _signed(double value) =>
      value >= 0 ? '+${value.toStringAsFixed(2)}' : value.toStringAsFixed(2);
}

class _RefractionCalculation {
  const _RefractionCalculation({this.equivalent, this.transposed, this.error});

  final double? equivalent;
  final Prescription? transposed;
  final String? error;
}
