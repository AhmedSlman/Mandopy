import 'package:flutter/material.dart';

class VisitCardModel {
  final String doctorName;
  final String time;
  final String status;
  final Color statusColor;
  final IconData icon; // إضافة حقل للأيقونة

  VisitCardModel({
    required this.doctorName,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.icon,
  });
}
