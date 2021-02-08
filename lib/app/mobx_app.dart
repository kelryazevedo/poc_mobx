import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:poc_mobx/app/app_interceptor.dart';
import 'package:poc_mobx/src/screens/home/home_screen.dart';
import 'package:poc_mobx/src/utils/app_config.dart';
import 'package:poc_mobx/src/utils/colors_style.dart';
import 'package:poc_mobx/src/utils/library/alert/alert_controller.dart';
import 'package:poc_mobx/src/utils/library/navigator/navigator_controller.dart';
import 'package:poc_mobx/src/utils/network_service/network_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MobXApp extends StatefulWidget {
  @override
  _MobXAppState createState() => _MobXAppState();
}

class _MobXAppState extends State<MobXApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  void initState() {
    this._registerStores();

    GetIt.I<NavigatorController>().setNavigatorKey(this._navigatorKey);
    GetIt.I<NetworkService>().addInterceptor(AppInterceptor());
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Intl.defaultLocale = 'pt_BR';
    super.initState();
  }

  _registerStores() {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton(NavigatorController());
    getIt.registerSingleton(NetworkService());
    getIt.registerSingleton(AlertController());

  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      locale: Locale("pt", "BR"),
      debugShowCheckedModeBanner:
      AppConfig.getInstance().appEnvironment != AppEnvironment.production,
      title: AppConfig.getInstance().appName,
      navigatorKey: this._navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
        ),
        backgroundColor: ColorsStyle.background,
        canvasColor: Colors.transparent,
      ),
      home: HomeScreen()
    );
  }
}