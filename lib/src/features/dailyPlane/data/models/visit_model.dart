class VisitModel {
  final int id;
  final int representativeId;
  final int? doctorId;
  final int pharmacyId;
  final int medicationId;
  final String date;
  final String time;
  final String? notes;
  final String status;
  final String createdAt;
  final String updatedAt;

  VisitModel({
    required this.id,
    required this.representativeId,
    this.doctorId,
    required this.pharmacyId,
    required this.medicationId,
    required this.date,
    required this.time,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'],
      representativeId: json['representative_id'],
      doctorId: json['doctor_id'],
      pharmacyId: json['pharmacy_id'],
      medicationId: json['medication_id'],
      date: json['date'],
      time: json['time'],
      notes: json['notes'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
