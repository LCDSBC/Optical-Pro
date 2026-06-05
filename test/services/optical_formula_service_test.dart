import 'package:flutter_test/flutter_test.dart';
import 'package:opticalc_pro/core/errors/app_exception.dart';
import 'package:opticalc_pro/modules/refraction/domain/entities/optical_prescription.dart';
import 'package:opticalc_pro/services/optical_formula_service.dart';

void main() {
  const service = OpticalFormulaService();

  group('OpticalFormulaService', () {
    test('calcula equivalente esferico aceitando valores negativos', () {
      final result = service.sphericalEquivalent(
        sphere: -2,
        cylinder: -1,
      );

      expect(result, -2.5);
    });

    test('transpoe receita mantendo eixo entre 0 e 180 graus', () {
      final result = service.transpose(
        const OpticalPrescription(
          sphere: -2,
          cylinder: -1,
          axis: 180,
        ),
      );

      expect(result.sphere, -3);
      expect(result.cylinder, 1);
      expect(result.axis, 90);
    });

    test('valida eixo invalido na transposicao', () {
      expect(
        () => service.transpose(
          const OpticalPrescription(
            sphere: -2,
            cylinder: -1,
            axis: 181,
          ),
        ),
        throwsA(isA<FormulaValidationException>()),
      );
    });

    test('calcula regra de Prentice', () {
      final result = service.prenticeRule(
        decentrationCentimeters: 0.5,
        lensPower: -4,
      );

      expect(result, -2);
    });

    test('converte potencia por distancia vertice', () {
      final result = service.vertexDistanceConversion(
        lensPower: -6,
        vertexDistanceMeters: 0.012,
      );

      expect(result, -5.5);
    });

    test('rejeita distancia vertice igual a zero', () {
      expect(
        () => service.vertexDistanceConversion(
          lensPower: -6,
          vertexDistanceMeters: 0,
        ),
        throwsA(isA<FormulaValidationException>()),
      );
    });
  });
}
