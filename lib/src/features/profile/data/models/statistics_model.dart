class StatisticsModel {
  String? message;
  int? allVisits;
  int? completedVisits;
  int? pendingVisits;
  String? mostSoldMedication;
  int? totalSold;

  StatisticsModel(
      {this.message,
      this.allVisits,
      this.completedVisits,
      this.pendingVisits,
      this.mostSoldMedication,
      this.totalSold});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    allVisits = json['All Visits'];
    completedVisits = json['Completed Visits'];
    pendingVisits = json['Pending Visits'];
    mostSoldMedication = json['Most Sold Medication'];
    totalSold = json['Total Sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['All Visits'] = allVisits;
    data['Completed Visits'] = completedVisits;
    data['Pending Visits'] = pendingVisits;
    data['Most Sold Medication'] = mostSoldMedication;
    data['Total Sold'] = totalSold;
    return data;
  }
}
