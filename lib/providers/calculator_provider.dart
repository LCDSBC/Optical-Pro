import 'package:flutter/foundation.dart';

import '../models/optical_prescription.dart';
import '../services/optical_calculator_service.dart';

class CalculatorProvider extends ChangeNotifier {
  CalculatorProvider({OpticalCalculatorService? service})
    : _service = service ?? OpticalCalculatorService();

  final OpticalCalculatorService _service;

  String? _errorMessage;
  Map<String, Object?> _lastResult = <String, Object?>{};

  String? get errorMessage => _errorMessage;
  Map<String, Object?> get lastResult => Map.unmodifiable(_lastResult);

  void calculateRefraction(OpticalPrescription prescription) {
    _run(() {
      final transposed = _service.transpose(prescription);
      _lastResult = {
        'sphericalEquivalent': _service.sphericalEquivalent(prescription),
        'transposedSphere': transposed.sphere,
        'transposedCylinder': transposed.cylinder,
        'transposedAxis': transposed.axis,
      };
    });
  }

  void calculateContactLens({
    required double spectaclePower,
    required double vertexDistanceMm,
  }) {
    _run(() {
      _lastResult = {
        'contactLensPower': _service.contactLensPower(
          spectaclePower: spectaclePower,
          vertexDistanceMm: vertexDistanceMm,
        ),
      };
    });
  }

  void calculatePrism({
    required double decentrationMm,
    required double lensPower,
  }) {
    _run(() {
      _lastResult = {
        'prismDiopters': _service.prenticeRule(
          decentrationMm: decentrationMm,
          lensPower: lensPower,
        ),
      };
    });
  }

  void calculateMultifocal({
    required int age,
    required double residualAccommodation,
    required double workingDistanceCm,
  }) {
    _run(() {
      _lastResult = {
        'nearAdd': _service.nearAdd(
          age: age,
          residualAccommodation: residualAccommodation,
          workingDistanceCm: workingDistanceCm,
        ),
      };
    });
  }

  void calculateAca({
    required double convergence,
    required double accommodation,
  }) {
    _run(() {
      _lastResult = {
        'acaRatio': _service.acaRatio(
          convergence: convergence,
          accommodation: accommodation,
        ),
      };
    });
  }

  void _run(VoidCallback calculation) {
    try {
      calculation();
      _errorMessage = null;
    } on ArgumentError catch (error) {
      _lastResult = <String, Object?>{};
      _errorMessage = error.message.toString();
    } on Object catch (error) {
      _lastResult = <String, Object?>{};
      _errorMessage = 'Nao foi possivel calcular: $error';
    }
    notifyListeners();
  }
}
