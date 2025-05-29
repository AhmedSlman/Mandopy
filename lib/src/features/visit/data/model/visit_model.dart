import 'package:equatable/equatable.dart';

class VisitModel extends Equatable {
  final String entityId;
  final bool isDoctor;
  final DateTime startTime;
  final DateTime endTime;
  final int duration; // in minutes
  final String notes;

  const VisitModel({
    required this.entityId,
    required this.isDoctor,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        entityId,
        isDoctor,
        startTime,
        endTime,
        duration,
        notes,
      ];

  Map<String, dynamic> toJson() {
    return {
      'entityId': entityId,
      'isDoctor': isDoctor,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'duration': duration,
      'notes': notes,
    };
  }

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      entityId: json['entityId'] as String,
      isDoctor: json['isDoctor'] as bool,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      duration: json['duration'] as int,
      notes: json['notes'] as String,
    );
  }
}
