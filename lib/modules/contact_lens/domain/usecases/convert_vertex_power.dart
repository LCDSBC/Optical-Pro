import '../../../../services/optical_formula_service.dart';
import '../entities/contact_lens_conversion.dart';

class ConvertVertexPower {
  const ConvertVertexPower(this._formulaService);

  final OpticalFormulaService _formulaService;

  ContactLensConversion call({
    required double lensPower,
    required double vertexDistanceMeters,
  }) {
    return ContactLensConversion(
      lensPower: lensPower,
      vertexDistanceMeters: vertexDistanceMeters,
      convertedPower: _formulaService.vertexDistanceConversion(
        lensPower: lensPower,
        vertexDistanceMeters: vertexDistanceMeters,
      ),
    );
  }
}
