import 'package:flutter/foundation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/prism_calculation.dart';
import '../../domain/usecases/calculate_prentice.dart';

class PrismsProvider extends ChangeNotifier {
  PrismsProvider(this._calculatePrentice);

  final CalculatePrentice _calculatePrentice;

  PrismCalculation? _calculation;
  String? _errorMessage;

  PrismCalculation? get calculation => _calculation;
  String? get errorMessage => _errorMessage;

  void calculate({
    required double decentrationCentimeters,
    required double lensPower,
  }) {
    try {
      _calculation = _calculatePrentice(
        decentrationCentimeters: decentrationCentimeters,
        lensPower: lensPower,
      );
      _errorMessage = null;
    } on AppException catch (error) {
      _errorMessage = error.message;
    } on Object {
      _errorMessage = 'Nao foi possivel calcular o prisma.';
    }

    notifyListeners();
  }
}
