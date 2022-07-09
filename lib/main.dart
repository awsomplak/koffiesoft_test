import 'package:flutter/material.dart';
import 'package:koffiesoft_test/route/main_route.dart';
import 'package:nb_utils/nb_utils.dart';

void main() => init();

void init() async {
  // Initialize WidgetBinding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Flutter
  await initialize();

  runApp(const MainRoute());
}