import '../entities/eye_prescription.dart';
import '../entities/refraction_result.dart';

class RefractionCalculator {
  const RefractionCalculator();

  RefractionResult calculate(RefractionPrescription prescription) {
    _validateEye(prescription.rightEye, 'OD');
    _validateEye(prescription.leftEye, 'OE');

    final rightEye = _calculateEye(prescription.rightEye);
    final leftEye = _calculateEye(prescription.leftEye);

    return RefractionResult(
      rightEye: rightEye,
      leftEye: leftEye,
      clinicalInterpretation: _interpret(rightEye, leftEye),
    );
  }

  EyePrescription transpose(EyePrescription prescription) {
    _validateEye(prescription, 'Olho');

    return EyePrescription(
      sphere: _roundToQuarter(prescription.sphere + prescription.cylinder),
      cylinder: _roundToQuarter(-prescription.cylinder),
      axis: _transposeAxis(prescription.axis),
      addition: _roundToQuarter(prescription.addition),
    );
  }

  double sphericalEquivalent(EyePrescription prescription) {
    _validateEye(prescription, 'Olho');
    return _roundToQuarter(prescription.sphere + (prescription.cylinder / 2));
  }

  String formatDiopter(double value) {
    final rounded = _roundToQuarter(value);
    final sign = rounded > 0 ? '+' : '';
    return '$sign${rounded.toStringAsFixed(2)}D';
  }

  String formatPrescription(EyePrescription prescription) {
    final sphere = formatDiopter(prescription.sphere);
    final cylinder = formatDiopter(prescription.cylinder);
    return '$sphere $cylinder x${prescription.axis}';
  }

  EyeRefractionResult _calculateEye(EyePrescription prescription) {
    return EyeRefractionResult(
      original: prescription,
      transposed: transpose(prescription),
      sphericalEquivalent: sphericalEquivalent(prescription),
    );
  }

  List<String> _interpret(
    EyeRefractionResult rightEye,
    EyeRefractionResult leftEye,
  ) {
    final insights = <String>[
      'OD: ${_ametropiaLabel(rightEye.sphericalEquivalent)}.',
      'OE: ${_ametropiaLabel(leftEye.sphericalEquivalent)}.',
    ];

    final maxCylinder = [
      rightEye.original.cylinder.abs(),
      leftEye.original.cylinder.abs(),
    ].reduce((value, element) => value > element ? value : element);
    if (maxCylinder >= 0.75) {
      insights.add(
        'Astigmatismo clinicamente relevante: conferir eixo e adaptação.',
      );
    }

    final maxAddition = [
      rightEye.original.addition,
      leftEye.original.addition,
    ].reduce((value, element) => value > element ? value : element);
    if (maxAddition > 0) {
      insights.add(
        'ADD presente: perfil compatível com demanda de perto ou presbiopia.',
      );
    }

    final anisometropia =
        (rightEye.sphericalEquivalent - leftEye.sphericalEquivalent).abs();
    if (anisometropia >= 1) {
      insights.add(
        'Anisometropia de ${formatDiopter(anisometropia)}: avaliar conforto binocular.',
      );
    }

    return insights;
  }

  String _ametropiaLabel(double sphericalEquivalent) {
    final magnitude = sphericalEquivalent.abs();
    if (magnitude <= 0.25) {
      return 'equivalente esférico próximo da emetropia';
    }

    final degree = switch (magnitude) {
      < 3 => 'leve',
      < 6 => 'moderada',
      _ => 'alta',
    };

    if (sphericalEquivalent < 0) {
      return 'miopia $degree pelo equivalente esférico';
    }

    return 'hipermetropia $degree pelo equivalente esférico';
  }

  void _validateEye(EyePrescription prescription, String label) {
    if (prescription.axis < 0 || prescription.axis > 180) {
      throw ArgumentError('$label: eixo deve estar entre 0 e 180 graus.');
    }
    if (prescription.sphere < -30 || prescription.sphere > 30) {
      throw ArgumentError('$label: ESF deve estar entre -30.00D e +30.00D.');
    }
    if (prescription.cylinder < -20 || prescription.cylinder > 20) {
      throw ArgumentError('$label: CIL deve estar entre -20.00D e +20.00D.');
    }
    if (prescription.addition < 0 || prescription.addition > 6) {
      throw ArgumentError('$label: ADD deve estar entre 0.00D e +6.00D.');
    }
  }

  int _transposeAxis(int axis) {
    final transposed = axis + 90;
    return transposed > 180 ? transposed - 180 : transposed;
  }

  double _roundToQuarter(double value) => (value * 4).round() / 4;
}
