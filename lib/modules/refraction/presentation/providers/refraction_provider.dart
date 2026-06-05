import 'package:flutter/foundation.dart';

import '../../domain/entities/eye_prescription.dart';
import '../../domain/entities/refraction_result.dart';
import '../../domain/services/refraction_calculator.dart';

class RefractionProvider extends ChangeNotifier {
  RefractionProvider({required RefractionCalculator calculator})
    : _calculator = calculator;

  final RefractionCalculator _calculator;

  RefractionResult? _result;
  String? _errorMessage;

  RefractionResult? get result => _result;
  String? get errorMessage => _errorMessage;
  RefractionCalculator get calculator => _calculator;

  void calculate({
    required String rightSphere,
    required String rightCylinder,
    required String rightAxis,
    required String rightAddition,
    required String leftSphere,
    required String leftCylinder,
    required String leftAxis,
    required String leftAddition,
  }) {
    try {
      final prescription = RefractionPrescription(
        rightEye: EyePrescription(
          sphere: _parseDiopter(rightSphere, 'ESF OD'),
          cylinder: _parseDiopter(rightCylinder, 'CIL OD'),
          axis: _parseAxis(rightAxis, 'EIXO OD'),
          addition: _parseDiopter(rightAddition, 'ADD OD'),
        ),
        leftEye: EyePrescription(
          sphere: _parseDiopter(leftSphere, 'ESF OE'),
          cylinder: _parseDiopter(leftCylinder, 'CIL OE'),
          axis: _parseAxis(leftAxis, 'EIXO OE'),
          addition: _parseDiopter(leftAddition, 'ADD OE'),
        ),
      );

      _result = _calculator.calculate(prescription);
      _errorMessage = null;
    } on FormatException catch (error) {
      _result = null;
      _errorMessage = error.message;
    } on ArgumentError catch (error) {
      _result = null;
      _errorMessage = error.message;
    }

    notifyListeners();
  }

  double _parseDiopter(String value, String label) {
    final normalized = value.trim().replaceAll(',', '.');
    if (normalized.isEmpty) {
      throw FormatException('$label é obrigatório.');
    }

    final parsed = double.tryParse(normalized);
    if (parsed == null) {
      throw FormatException('$label deve ser numérico.');
    }

    return parsed;
  }

  int _parseAxis(String value, String label) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw FormatException('$label é obrigatório.');
    }

    final parsed = int.tryParse(normalized);
    if (parsed == null) {
      throw FormatException('$label deve ser um número inteiro.');
    }

    return parsed;
  }
}
