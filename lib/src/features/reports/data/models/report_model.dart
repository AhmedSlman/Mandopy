class ReportModel {
  final int id;
  final int representativeId;
  final int? doctorId;
  final int? pharmacyId;
  final int medicationId;
  final String date;
  final String time;
  final String? notes;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Pharmacy? pharmacy;
  final Medication? medication;
  final DoctorModel? doctor;
  final Representative? representative;

  ReportModel({
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
    this.medication,
    this.doctor,
    this.representative,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
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
            ? Pharmacy.fromJson(json['pharmacy'])
            : null,
        medication: json['medication'] != null
            ? Medication.fromJson(json['medication'])
            : null,
        doctor: json['doctor'] != null
            ? DoctorModel.fromJson(json['doctor'])
            : null,
        representative: json['representative'] != null
            ? Representative.fromJson(json['representative'])
            : null);
  }
}

class Representative {
  final int id;
  final String name;
  final String email;

  Representative({required this.id, required this.name, required this.email});

  factory Representative.fromJson(Map<String, dynamic> json) {
    return Representative(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Pharmacy {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? details;
  final String? image;
  final double? latitude;
  final double? longitude;
  final String? createdAt;
  final String? updatedAt;

  Pharmacy({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.details,
    this.image,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      details: json['details'],
      image: json['image'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Medication {
  final int id;
  final String name;

  Medication({required this.id, required this.name});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
    );
  }
}


class DoctorModel {
  final int id;
  final String name;
  final String specialization;
  final String phone;
  final String address;
  final String details;
  final String? image;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.phone,
    required this.address,
    required this.details,
    this.image,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      phone: json['phone'],
      address: json['address'],
      details: json['details'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}