import 'package:flutter/material.dart';

enum AppEnvironment {
  production,
  development,
}

class AppConfig {
  final String appName;
  final AppEnvironment appEnvironment;
  final String apiBaseUrl;
  final String ditoSecret;
  final String ditoKey;
  final String termosUsoUrl;
  final String termosUsoVendedorUrl;
  final String politicasPrivacidadeUrl;
  final String acomparPedidoFirebaseCollection;
  final String clientId;
  final String accessToken;
  final String braspagBaseUrl;
  final String braspagToken;
  final num timeout;
  final String sentryClient;

  AppConfig({
    @required this.ditoSecret,
    @required this.ditoKey,
    @required this.appName,
    @required this.appEnvironment,
    @required this.apiBaseUrl,
    @required this.termosUsoUrl,
    @required this.acomparPedidoFirebaseCollection,
    this.politicasPrivacidadeUrl,
    this.clientId,
    this.accessToken,
    this.timeout,
    this.braspagBaseUrl,
    this.braspagToken,
    this.sentryClient,
    this.termosUsoVendedorUrl,
  });

  static AppConfig _instance;

  static AppConfig getInstance({AppConfig config}) {
    if (_instance == null) {
      _instance = config;
      print('APP CONFIGURED FOR: ${config.appName}');
      return _instance;
    }
    return _instance;
  }

  bool get isProd {
    if (_instance.appEnvironment == AppEnvironment.production)
      return true;
    else
      return false;
  }
}
