class MedicationModel {
  final int id;
  final String name;
  final DateTime? createdAt; // يمكن أن تكون null
  final DateTime? updatedAt; // يمكن أن تكون null

  MedicationModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
