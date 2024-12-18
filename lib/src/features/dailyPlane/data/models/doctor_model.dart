class DoctorModel {
  final int id;
  final String name;
  final String specialization;
  final String phone;
  final String address;
  final String details;
  final String? image;
  final dynamic latitude;
  final dynamic longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? type;

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
    required this.type,
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
      type: json['type'],
    );
  }
}
