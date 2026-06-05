import 'package:flutter_test/flutter_test.dart';
import 'package:opti_calc_pro/modules/refraction/domain/entities/eye_prescription.dart';
import 'package:opti_calc_pro/modules/refraction/domain/services/refraction_calculator.dart';

void main() {
  const calculator = RefractionCalculator();

  group('RefractionCalculator', () {
    test('calcula equivalente esferico com arredondamento em 0.25D', () {
      const prescription = EyePrescription(
        sphere: -2,
        cylinder: -1,
        axis: 180,
        addition: 1.5,
      );

      expect(calculator.sphericalEquivalent(prescription), -2.5);
    });

    test('transpoe ESF, CIL e EIXO automaticamente', () {
      const prescription = EyePrescription(
        sphere: -2,
        cylinder: -1,
        axis: 180,
        addition: 1.5,
      );

      final transposed = calculator.transpose(prescription);

      expect(transposed.sphere, -3);
      expect(transposed.cylinder, 1);
      expect(transposed.axis, 90);
      expect(transposed.addition, 1.5);
    });

    test('interpreta ametropias e achados clinicos principais', () {
      final result = calculator.calculate(
        const RefractionPrescription(
          rightEye: EyePrescription(
            sphere: -2,
            cylinder: -1,
            axis: 180,
            addition: 1.5,
          ),
          leftEye: EyePrescription(
            sphere: 1,
            cylinder: -0.5,
            axis: 90,
            addition: 1.5,
          ),
        ),
      );

      expect(result.rightEye.sphericalEquivalent, -2.5);
      expect(result.leftEye.sphericalEquivalent, 0.75);
      expect(
        result.clinicalInterpretation,
        contains(
          'Astigmatismo clinicamente relevante: conferir eixo e adaptação.',
        ),
      );
      expect(
        result.clinicalInterpretation,
        contains(
          'ADD presente: perfil compatível com demanda de perto ou presbiopia.',
        ),
      );
      expect(
        result.clinicalInterpretation.any(
          (item) => item.contains('Anisometropia'),
        ),
        isTrue,
      );
    });

    test('valida eixo entre 0 e 180 graus', () {
      const prescription = EyePrescription(
        sphere: 0,
        cylinder: 0,
        axis: 181,
        addition: 0,
      );

      expect(
        () => calculator.sphericalEquivalent(prescription),
        throwsArgumentError,
      );
    });
  });
}
