import 'package:flutter/material.dart';
import 'package:mandopy/app.dart';
import 'package:mandopy/core/services/service_locator.dart';

void main() {
  setupLocator();
  runApp(const Mandopy());
}
