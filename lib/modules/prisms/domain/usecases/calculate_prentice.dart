import '../../../../services/optical_formula_service.dart';
import '../entities/prism_calculation.dart';

class CalculatePrentice {
  const CalculatePrentice(this._formulaService);

  final OpticalFormulaService _formulaService;

  PrismCalculation call({
    required double decentrationCentimeters,
    required double lensPower,
  }) {
    return PrismCalculation(
      decentrationCentimeters: decentrationCentimeters,
      lensPower: lensPower,
      prismDiopters: _formulaService.prenticeRule(
        decentrationCentimeters: decentrationCentimeters,
        lensPower: lensPower,
      ),
    );
  }
}
