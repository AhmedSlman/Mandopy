class PointsModel {
  final int totalPoints;

  PointsModel({required this.totalPoints});

  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      totalPoints: int.tryParse(json['total_points'].toString()) ?? 0,
    );
  }
}
