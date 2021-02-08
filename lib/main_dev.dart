import 'package:flutter/cupertino.dart';
import 'package:poc_mobx/app/mobx_app.dart';
import 'package:poc_mobx/src/utils/app_config.dart';
import 'package:wakelock/wakelock.dart';

import 'app/environments.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  AppConfig.getInstance(config: Environment.dev);
  runApp(MobXApp());
}
