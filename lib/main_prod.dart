import 'package:flutter/cupertino.dart';
import 'package:poc_mobx/src/utils/app_config.dart';
import 'package:wakelock/wakelock.dart';

import 'app/environments.dart';
import 'app/mobx_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  AppConfig.getInstance(config: Environment.prod);
  runApp(MobXApp());
}