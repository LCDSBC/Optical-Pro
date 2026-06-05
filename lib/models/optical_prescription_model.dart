import '../modules/refraction/domain/entities/optical_prescription.dart';

class OpticalPrescriptionModel extends OpticalPrescription {
  const OpticalPrescriptionModel({
    required super.sphere,
    required super.cylinder,
    required super.axis,
  });

  factory OpticalPrescriptionModel.fromEntity(OpticalPrescription entity) {
    return OpticalPrescriptionModel(
      sphere: entity.sphere,
      cylinder: entity.cylinder,
      axis: entity.axis,
    );
  }

  factory OpticalPrescriptionModel.fromMap(Map<String, dynamic> map) {
    return OpticalPrescriptionModel(
      sphere: (map['sphere'] as num? ?? 0).toDouble(),
      cylinder: (map['cylinder'] as num? ?? 0).toDouble(),
      axis: (map['axis'] as num? ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sphere': sphere,
      'cylinder': cylinder,
      'axis': axis,
    };
  }
}
