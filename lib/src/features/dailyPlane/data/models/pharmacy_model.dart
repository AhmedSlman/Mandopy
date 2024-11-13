class PharmacyModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String details;
  final String? image;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? type;

  PharmacyModel({
    required this.id,
    required this.name,
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

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'],
      name: json['name'],
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
