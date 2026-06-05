import '../models/optical_prescription.dart';

class OpticalCalculatorService {
  double sphericalEquivalent(OpticalPrescription prescription) {
    _validateAxis(prescription.axis);
    return _roundToQuarter(prescription.sphere + (prescription.cylinder / 2));
  }

  TransposedPrescription transpose(OpticalPrescription prescription) {
    _validateAxis(prescription.axis);
    final axis = prescription.axis + 90 > 180
        ? prescription.axis - 90
        : prescription.axis + 90;

    return TransposedPrescription(
      sphere: _roundToQuarter(prescription.sphere + prescription.cylinder),
      cylinder: _roundToQuarter(-prescription.cylinder),
      axis: axis == 0 ? 180 : axis,
    );
  }

  double contactLensPower({
    required double spectaclePower,
    required double vertexDistanceMm,
  }) {
    if (vertexDistanceMm < 0 || vertexDistanceMm > 30) {
      throw ArgumentError('A distancia vertice deve estar entre 0 e 30 mm.');
    }

    final vertexDistanceMeters = vertexDistanceMm / 1000;
    final denominator = 1 - (vertexDistanceMeters * spectaclePower);
    if (denominator.abs() < 0.0001) {
      throw ArgumentError('A combinacao de potencia e vertice e invalida.');
    }

    return _roundToQuarter(spectaclePower / denominator);
  }

  double prenticeRule({
    required double decentrationMm,
    required double lensPower,
  }) {
    if (decentrationMm < 0 || decentrationMm > 40) {
      throw ArgumentError('A descentralizacao deve estar entre 0 e 40 mm.');
    }

    return _roundToHundredth((decentrationMm / 10) * lensPower.abs());
  }

  double nearAdd({
    required int age,
    required double residualAccommodation,
    required double workingDistanceCm,
  }) {
    if (age < 35 || age > 95) {
      throw ArgumentError('A idade deve estar entre 35 e 95 anos.');
    }
    if (residualAccommodation < 0 || residualAccommodation > 10) {
      throw ArgumentError('A acomodacao residual deve estar entre 0 e 10 D.');
    }
    if (workingDistanceCm < 25 || workingDistanceCm > 100) {
      throw ArgumentError(
        'A distancia de trabalho deve estar entre 25 e 100 cm.',
      );
    }

    final demand = 100 / workingDistanceCm;
    final ageBaseline = age < 45
        ? 0.75
        : age < 55
        ? 1.5
        : 2.25;
    final calculated = demand - (residualAccommodation / 2);
    return _roundToQuarter(calculated > ageBaseline ? calculated : ageBaseline);
  }

  double acaRatio({
    required double convergence,
    required double accommodation,
  }) {
    if (accommodation <= 0 || accommodation > 20) {
      throw ArgumentError('A acomodacao deve estar entre 0 e 20 D.');
    }

    return _roundToHundredth(convergence / accommodation);
  }

  double _roundToQuarter(double value) => (value * 4).roundToDouble() / 4;

  double _roundToHundredth(double value) => (value * 100).roundToDouble() / 100;

  void _validateAxis(int axis) {
    if (axis < 0 || axis > 180) {
      throw ArgumentError('O eixo deve estar entre 0 e 180 graus.');
    }
  }
}
