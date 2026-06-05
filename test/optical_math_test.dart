import 'package:flutter_test/flutter_test.dart';
import 'package:opticalc_pro/core/optics/optical_math.dart';
import 'package:opticalc_pro/models/prescription.dart';

void main() {
  group('OpticalMath', () {
    test('calcula equivalente esférico com valores negativos', () {
      final result = OpticalMath.sphericalEquivalent(
        sphere: -2,
        cylinder: -1.5,
      );

      expect(result, -2.75);
    });

    test('transpoe receita preservando eixo valido', () {
      final result = OpticalMath.transpose(
        const Prescription(sphere: -2, cylinder: -1.5, axis: 20),
      );

      expect(result.sphere, -3.5);
      expect(result.cylinder, 1.5);
      expect(result.axis, 110);
    });

    test('valida eixo fora do intervalo clinico', () {
      expect(
        () => OpticalMath.transpose(
          const Prescription(sphere: 1, cylinder: -0.5, axis: 181),
        ),
        throwsA(isA<OpticalCalculationException>()),
      );
    });

    test('aplica regra de Prentice', () {
      final result = OpticalMath.prenticeRule(
        decentrationCm: 0.4,
        lensPower: -5,
      );

      expect(result, -2);
    });

    test('converte potencia por vertice para lente de contato', () {
      final result = OpticalMath.contactLensVertexConversion(
        spectaclePower: -8,
        vertexDistanceMm: 12,
      );

      expect(result, -7.25);
    });

    test('estima adicao multifocal', () {
      final result = OpticalMath.multifocalAddition(
        age: 52,
        residualAccommodation: 1.5,
        workingDistanceMeters: 0.4,
      );

      expect(result, 1.75);
    });

    test('calcula relacao AC/A', () {
      final result = OpticalMath.acA(
        accommodativeConvergence: 18,
        accommodation: 3,
      );

      expect(result, 6);
    });
  });
}
