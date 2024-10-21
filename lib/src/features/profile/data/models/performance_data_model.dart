import 'package:flutter/material.dart';

class PerformanceData {
  final String iconPath;
  final String title;
  final String value;
  final Color? valueColor;

  PerformanceData({
    required this.iconPath,
    required this.title,
    required this.value,
    this.valueColor,
  });
}
