import 'dart:math' as math;

import '../errors/app_exception.dart';

abstract final class DiopterMath {
  static double roundToQuarter(double value) {
    _validateFinite(value, label: 'valor');
    return (value * 4).roundToDouble() / 4;
  }

  static void validateFinite(double value, {required String label}) {
    _validateFinite(value, label: label);
  }

  static void validateAxis(int axis) {
    if (axis < 0 || axis > 180) {
      throw const FormulaValidationException(
        'O eixo deve estar entre 0 e 180 graus.',
      );
    }
  }

  static void validateNonZeroDistance(double distance, {required String label}) {
    _validateFinite(distance, label: label);
    if (distance <= 0) {
      throw FormulaValidationException('$label deve ser maior que zero.');
    }
  }

  static bool almostZero(double value) => value.abs() < math.pow(10, -9);

  static void _validateFinite(double value, {required String label}) {
    if (value.isNaN || value.isInfinite) {
      throw FormulaValidationException('$label deve ser um numero finito.');
    }
  }
}
