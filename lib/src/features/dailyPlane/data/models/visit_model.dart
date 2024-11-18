import 'doctor_model.dart';
import 'medecation_model.dart';
import 'pharmacy_model.dart';
import 'representative_model.dart';

class VisitModel {
  final int id;
  final int representativeId;
  final dynamic doctorId;
  final dynamic pharmacyId;
  final dynamic medicationId;
  final String? date;
  final String? time;
  final String? notes;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final PharmacyModel? pharmacy;
  final List<MedicationModel>? medications;
  final DoctorModel? doctor;
  final Representative? representative;

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
    this.pharmacy,
    this.medications,
    this.doctor,
    this.representative,
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
        pharmacy: json['pharmacy'] != null
            ? PharmacyModel.fromJson(json['pharmacy'])
            : null,
        medications: json['medications'] != null
            ? (json['medications'] as List<dynamic>)
                .map((e) => MedicationModel.fromJson(e))
                .toList()
            : null,
        doctor: json['doctor'] != null
            ? DoctorModel.fromJson(json['doctor'])
            : null,
        representative: json['representative'] != null
            ? Representative.fromJson(json['representative'])
            : null);
  }
}
