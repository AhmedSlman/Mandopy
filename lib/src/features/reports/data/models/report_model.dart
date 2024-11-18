class ReportModel {
  final String doctorOrPharmacyName;
  final String address;
  final String date;
  final String time;
  final List<dynamic>? medicationName;
  final String? notes;
  final int? rating;

  ReportModel({
    required this.doctorOrPharmacyName,
    required this.address,
    required this.date,
    required this.time,
    required this.medicationName,
    this.notes,
    this.rating,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      doctorOrPharmacyName: json['doctor or pharmacy name'],
      address: json['address'],
      date: json['date'],
      time: json['time'],
      medicationName: json['medication names'],
      notes: json['notes'],
      rating: json['rating'],
    );
  }
}
