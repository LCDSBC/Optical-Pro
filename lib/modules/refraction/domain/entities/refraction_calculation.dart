import 'optical_prescription.dart';

class RefractionCalculation {
  const RefractionCalculation({
    required this.prescription,
    required this.sphericalEquivalent,
    required this.transposed,
  });

  final OpticalPrescription prescription;
  final double sphericalEquivalent;
  final OpticalPrescription transposed;
}
