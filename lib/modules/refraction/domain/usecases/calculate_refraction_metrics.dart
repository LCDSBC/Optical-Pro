import '../../../../services/optical_formula_service.dart';
import '../entities/optical_prescription.dart';
import '../entities/refraction_calculation.dart';

class CalculateRefractionMetrics {
  const CalculateRefractionMetrics(this._formulaService);

  final OpticalFormulaService _formulaService;

  RefractionCalculation call(OpticalPrescription prescription) {
    final transposed = _formulaService.transpose(prescription);

    return RefractionCalculation(
      prescription: prescription,
      sphericalEquivalent: _formulaService.sphericalEquivalent(
        sphere: prescription.sphere,
        cylinder: prescription.cylinder,
      ),
      transposed: OpticalPrescription(
        sphere: transposed.sphere,
        cylinder: transposed.cylinder,
        axis: transposed.axis,
      ),
    );
  }
}
