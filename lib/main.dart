import 'package:flutter/material.dart';
import 'package:zentails_wellness/app/app.dart';
import 'package:zentails_wellness/app/di/di.dart';
import 'package:zentails_wellness/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  await initDependencies();

  runApp(const MyApp());
}
