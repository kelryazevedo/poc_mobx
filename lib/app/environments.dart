

import 'package:poc_mobx/src/utils/app_config.dart';

mixin Environment {
  static final dev = AppConfig(
      appName: 'PocMobX',
      appEnvironment: AppEnvironment.development,
      apiBaseUrl: 'https://api.github.com/search/',
      ditoKey: '',
      ditoSecret: '');

  static final prod = AppConfig(
      appName: 'PocMobX',
      appEnvironment: AppEnvironment.development,
      apiBaseUrl: 'https://api.github.com/search/',
      ditoKey: '',
      ditoSecret: '');
}
