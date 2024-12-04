class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'] != null
          ? (json['latitude'] is int
              ? (json['latitude'] as int).toDouble()
              : json['latitude'] as double)
          : 0.0,
      longitude: json['longitude'] != null
          ? (json['longitude'] is int
              ? (json['longitude'] as int).toDouble()
              : json['longitude'] as double)
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
