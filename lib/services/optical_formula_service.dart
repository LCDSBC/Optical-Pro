import '../core/errors/app_exception.dart';
import '../core/utils/diopter_math.dart';
import '../modules/refraction/domain/entities/optical_prescription.dart';

class TransposedPrescription {
  const TransposedPrescription({
    required this.sphere,
    required this.cylinder,
    required this.axis,
  });

  final double sphere;
  final double cylinder;
  final int axis;
}

class OpticalFormulaService {
  const OpticalFormulaService();

  /// EE = ESF + (CIL / 2)
  double sphericalEquivalent({
    required double sphere,
    required double cylinder,
  }) {
    DiopterMath.validateFinite(sphere, label: 'esferico');
    DiopterMath.validateFinite(cylinder, label: 'cilindro');

    return DiopterMath.roundToQuarter(sphere + (cylinder / 2));
  }

  /// Novo ESF = ESF + CIL; Novo CIL = -CIL; Novo EIXO = eixo +/- 90.
  TransposedPrescription transpose(OpticalPrescription prescription) {
    DiopterMath.validateFinite(prescription.sphere, label: 'esferico');
    DiopterMath.validateFinite(prescription.cylinder, label: 'cilindro');
    DiopterMath.validateAxis(prescription.axis);

    final transposedAxis =
        prescription.axis <= 90 ? prescription.axis + 90 : prescription.axis - 90;

    return TransposedPrescription(
      sphere: DiopterMath.roundToQuarter(
        prescription.sphere + prescription.cylinder,
      ),
      cylinder: DiopterMath.roundToQuarter(-prescription.cylinder),
      axis: transposedAxis,
    );
  }

  /// P = c x F, where c is decentration in centimeters.
  double prenticeRule({
    required double decentrationCentimeters,
    required double lensPower,
  }) {
    DiopterMath.validateFinite(
      decentrationCentimeters,
      label: 'descentracao',
    );
    DiopterMath.validateFinite(lensPower, label: 'potencia da lente');

    return DiopterMath.roundToQuarter(decentrationCentimeters * lensPower);
  }

  /// FLC = F / (1 - dF), where d is vertex distance in meters.
  double vertexDistanceConversion({
    required double lensPower,
    required double vertexDistanceMeters,
  }) {
    DiopterMath.validateFinite(lensPower, label: 'potencia da lente');
    DiopterMath.validateNonZeroDistance(
      vertexDistanceMeters,
      label: 'distancia vertice',
    );

    final denominator = 1 - (vertexDistanceMeters * lensPower);
    if (DiopterMath.almostZero(denominator)) {
      throw const FormulaValidationException(
        'A combinacao de potencia e distancia vertice gera denominador zero.',
      );
    }

    return DiopterMath.roundToQuarter(lensPower / denominator);
  }

  /// D = 1 / distancia.
  double workingDistanceDiopters(double distanceMeters) {
    DiopterMath.validateNonZeroDistance(
      distanceMeters,
      label: 'distancia de trabalho',
    );

    return DiopterMath.roundToQuarter(1 / distanceMeters);
  }
}
