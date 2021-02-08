import 'package:flutter/material.dart';
import 'package:poc_mobx/src/utils/app_config.dart';
import 'package:wakelock/wakelock.dart';
import 'app/environments.dart';
import 'app/mobx_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  AppConfig.getInstance(config: Environment.dev);
  runApp(MobXApp());
}

