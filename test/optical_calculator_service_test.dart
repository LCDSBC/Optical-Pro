import 'package:flutter_test/flutter_test.dart';
import 'package:opticalc_pro/models/optical_prescription.dart';
import 'package:opticalc_pro/services/optical_calculator_service.dart';

void main() {
  late OpticalCalculatorService service;

  setUp(() {
    service = OpticalCalculatorService();
  });

  test('calculates spherical equivalent and transposition', () {
    const prescription = OpticalPrescription(
      sphere: -2,
      cylinder: -1,
      axis: 180,
    );

    final transposed = service.transpose(prescription);

    expect(service.sphericalEquivalent(prescription), -2.5);
    expect(transposed.sphere, -3);
    expect(transposed.cylinder, 1);
    expect(transposed.axis, 90);
  });

  test('converts spectacle power to contact lens power', () {
    final result = service.contactLensPower(
      spectaclePower: -8,
      vertexDistanceMm: 12,
    );

    expect(result, -7.25);
  });

  test('calculates prism with Prentice rule', () {
    final result = service.prenticeRule(decentrationMm: 4, lensPower: -3);

    expect(result, 1.2);
  });

  test('validates invalid axis', () {
    expect(
      () => service.sphericalEquivalent(
        const OpticalPrescription(sphere: 1, cylinder: -1, axis: 181),
      ),
      throwsArgumentError,
    );
  });
}
