import 'package:flutter/foundation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/contact_lens_conversion.dart';
import '../../domain/usecases/convert_vertex_power.dart';

class ContactLensProvider extends ChangeNotifier {
  ContactLensProvider(this._convertVertexPower);

  final ConvertVertexPower _convertVertexPower;

  ContactLensConversion? _conversion;
  String? _errorMessage;

  ContactLensConversion? get conversion => _conversion;
  String? get errorMessage => _errorMessage;

  void convert({
    required double lensPower,
    required double vertexDistanceMeters,
  }) {
    try {
      _conversion = _convertVertexPower(
        lensPower: lensPower,
        vertexDistanceMeters: vertexDistanceMeters,
      );
      _errorMessage = null;
    } on AppException catch (error) {
      _errorMessage = error.message;
    } on Object {
      _errorMessage = 'Nao foi possivel converter para lente de contato.';
    }

    notifyListeners();
  }
}
