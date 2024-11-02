class EndVisitModel {
  final String message;
  final int pointsEarned;

  EndVisitModel({required this.message, required this.pointsEarned});

  factory EndVisitModel.fromJson(Map<String, dynamic> json) {
    return EndVisitModel(
      message: json['message'],
      pointsEarned: json['points_earned'],
    );
  }
}
