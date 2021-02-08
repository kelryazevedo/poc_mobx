
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:poc_mobx/src/utils/library/navigator/navigator_controller.dart';

import '../../colors_style.dart';

class SemConexaoScreen extends StatelessWidget {
  final Function(bool) semConexaoCallback;

  const SemConexaoScreen({@required this.semConexaoCallback});

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
                Icons.signal_wifi_off,
                color: ColorsStyle.blue.withOpacity(0.5),
                size: 140,
              ),
              SizedBox(
                height: 48,
              ),
              Text(
                'Parece que não há internet!',
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
                'Verifique a sua conexão para continuar navegando.',
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
                    var connectivityResult =
                        await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.none) {
                      this.semConexaoCallback(false);
                      NavigatorController.instance.popNavigate();
                    }
                  },
                  child: Text(
                    'Tentar novamente',
                    style: TextStyle(
                        color: ColorsStyle.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  // borderSide: BorderSide(color: ColorsStyle.azulClaro),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
