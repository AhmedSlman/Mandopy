class MontlyTargetModel {
  int? monthlyTarget;
  int? completedVisits;
  String? percentage;

  MontlyTargetModel(
      {this.monthlyTarget, this.completedVisits, this.percentage});

  MontlyTargetModel.fromJson(Map<String, dynamic> json) {
    monthlyTarget = json['monthly_target'];
    completedVisits = json['completed_visits'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthly_target'] = this.monthlyTarget;
    data['completed_visits'] = this.completedVisits;
    data['percentage'] = this.percentage;
    return data;
  }
}
