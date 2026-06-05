import 'dart:math' as math;

import '../../models/prescription.dart';

class OpticalCalculationException implements Exception {
  const OpticalCalculationException(this.message);

  final String message;

  @override
  String toString() => message;
}

class OpticalMath {
  const OpticalMath._();

  /// Equivalente esférico: EE = ESF + (CIL / 2).
  static double sphericalEquivalent({
    required double sphere,
    required double cylinder,
  }) {
    _validateFinite('ESF', sphere);
    _validateFinite('CIL', cylinder);
    return roundToQuarter(sphere + (cylinder / 2));
  }

  /// Transposição: novo ESF = ESF + CIL, novo CIL = -CIL, eixo ± 90°.
  static Prescription transpose(Prescription prescription) {
    _validateFinite('ESF', prescription.sphere);
    _validateFinite('CIL', prescription.cylinder);
    _validateAxis(prescription.axis);

    return Prescription(
      sphere: roundToQuarter(prescription.sphere + prescription.cylinder),
      cylinder: roundToQuarter(-prescription.cylinder),
      axis: normalizeAxis(prescription.axis + 90),
    );
  }

  /// Regra de Prentice: P = c x F, com descentração em centímetros.
  static double prenticeRule({
    required double decentrationCm,
    required double lensPower,
  }) {
    _validateFinite('descentração', decentrationCm);
    _validateFinite('potência', lensPower);
    if (decentrationCm < 0) {
      throw const OpticalCalculationException(
        'A descentração deve ser maior ou igual a zero.',
      );
    }
    return _roundToDecimals(decentrationCm * lensPower, 2);
  }

  /// Conversão por vértice: FLC = F / (1 - dF), com d em metros.
  static double contactLensVertexConversion({
    required double spectaclePower,
    required double vertexDistanceMm,
  }) {
    _validateFinite('potência dos óculos', spectaclePower);
    _validateFinite('distância vértice', vertexDistanceMm);
    if (vertexDistanceMm < 0) {
      throw const OpticalCalculationException(
        'A distância vértice deve ser maior ou igual a zero.',
      );
    }

    final distanceMeters = vertexDistanceMm / 1000;
    final denominator = 1 - (distanceMeters * spectaclePower);
    if (denominator.abs() < 0.0001) {
      throw const OpticalCalculationException(
        'A combinação de potência e vértice gera divisão inválida.',
      );
    }

    return roundToQuarter(spectaclePower / denominator);
  }

  /// Demanda dióptrica da distância de trabalho: D = 1 / distância.
  static double workingDistanceDemand(double distanceMeters) {
    _validateFinite('distância de trabalho', distanceMeters);
    if (distanceMeters <= 0) {
      throw const OpticalCalculationException(
        'A distância de trabalho deve ser maior que zero.',
      );
    }
    return _roundToDecimals(1 / distanceMeters, 2);
  }

  /// Estimativa conservadora de adição multifocal combinando idade e reserva.
  static double multifocalAddition({
    required int age,
    required double residualAccommodation,
    required double workingDistanceMeters,
  }) {
    if (age <= 0 || age > 120) {
      throw const OpticalCalculationException('Idade inválida.');
    }
    _validateFinite('acomodação residual', residualAccommodation);
    if (residualAccommodation < 0) {
      throw const OpticalCalculationException(
        'A acomodação residual deve ser maior ou igual a zero.',
      );
    }

    final demand = workingDistanceDemand(workingDistanceMeters);
    final clinicalReserve = residualAccommodation / 2;
    final ageBaseline = switch (age) {
      < 40 => 0.0,
      < 46 => 0.75,
      < 51 => 1.25,
      < 56 => 1.75,
      _ => 2.25,
    };

    return roundToQuarter(math.max(ageBaseline, demand - clinicalReserve));
  }

  /// AC/A = convergência acomodativa / acomodação.
  static double acA({
    required double accommodativeConvergence,
    required double accommodation,
  }) {
    _validateFinite('convergência acomodativa', accommodativeConvergence);
    _validateFinite('acomodação', accommodation);
    if (accommodation == 0) {
      throw const OpticalCalculationException(
        'A acomodação deve ser diferente de zero.',
      );
    }
    return _roundToDecimals(accommodativeConvergence / accommodation, 2);
  }

  static int normalizeAxis(int axis) {
    var normalized = axis % 180;
    if (normalized <= 0) {
      normalized += 180;
    }
    return normalized;
  }

  static double roundToQuarter(double value) => (value * 4).roundToDouble() / 4;

  static void _validateFinite(String label, double value) {
    if (!value.isFinite) {
      throw OpticalCalculationException('$label deve ser um número válido.');
    }
  }

  static void _validateAxis(int axis) {
    if (axis < 0 || axis > 180) {
      throw const OpticalCalculationException(
        'O eixo deve estar entre 0° e 180°.',
      );
    }
  }

  static double _roundToDecimals(double value, int decimals) {
    final factor = math.pow(10, decimals).toDouble();
    return (value * factor).roundToDouble() / factor;
  }
}
