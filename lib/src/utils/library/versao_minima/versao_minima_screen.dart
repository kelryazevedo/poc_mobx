import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors_style.dart';

class VersaoMinimaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          color: ColorsStyle.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.sync_problem,
                color: ColorsStyle.grey.withOpacity(0.5),
                size: 140,
              ),
              SizedBox(
                height: 48,
              ),
              Text(
                'Seu aplicativo está desatualizado!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsStyle.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Instale a nova versão para continuar navegando.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsStyle.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 48,
              ),
              Container(
                height: 50,
                child: FlatButton(
                  onPressed: () async {
                    String url;

                    if (Platform.isAndroid)
                      url =
                          'https://play.google.com/store/apps/details?id=com.araujo.araujoapp';
                    else
                      url =
                          'https://apps.apple.com/br/app/drogaria-araujo/id1258317711';

                    if (url != null && await canLaunch(url)) {
                      launch(url);
                    } else {
                      throw 'Problemas ao encontrar url :$url';
                    }
                  },
                  child: Text(
                    'Ir para loja',
                    style: TextStyle(
                        color: ColorsStyle.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
