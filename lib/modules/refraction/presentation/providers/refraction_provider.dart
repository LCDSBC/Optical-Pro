import 'package:flutter/foundation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/optical_prescription.dart';
import '../../domain/entities/refraction_calculation.dart';
import '../../domain/usecases/calculate_refraction_metrics.dart';

class RefractionProvider extends ChangeNotifier {
  RefractionProvider(this._calculateRefractionMetrics);

  final CalculateRefractionMetrics _calculateRefractionMetrics;

  RefractionCalculation? _calculation;
  String? _errorMessage;

  RefractionCalculation? get calculation => _calculation;
  String? get errorMessage => _errorMessage;

  void calculate({
    required double sphere,
    required double cylinder,
    required int axis,
  }) {
    try {
      _calculation = _calculateRefractionMetrics(
        OpticalPrescription(
          sphere: sphere,
          cylinder: cylinder,
          axis: axis,
        ),
      );
      _errorMessage = null;
    } on AppException catch (error) {
      _errorMessage = error.message;
    } on Object {
      _errorMessage = 'Nao foi possivel calcular a refracao.';
    }

    notifyListeners();
  }
}
