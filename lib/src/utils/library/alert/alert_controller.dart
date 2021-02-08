import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poc_mobx/src/utils/library/navigator/navigator_controller.dart';

import '../../colors_style.dart';

enum AlertType { OK, YES_NO }

class AlertController {
  void showAlert({
    String title,
    BuildContext context,
    Colors titleColor,
    @required String message,
    Colors messageColor,
    TextAlign textAlign,
    AlertType alertType,
    Function() dialogCallback,
    bool barrierDismissible,
  }) {
    try {
      FocusScope.of(context ?? NavigatorController.instance.currentContext)
          .unfocus();
      showDialog(
        context: context ?? NavigatorController.instance.currentContext,
        builder: (x) =>
            CustomAlert(
              message: message,
              textAlign: textAlign,
              title: title,
              alertType: alertType,
              titleColor: titleColor,
              messageColor: messageColor,
              dialogCallback: dialogCallback,
            ),
        barrierDismissible: barrierDismissible ?? true,
      );
    } catch (e) {
      print('showAlert => invalid context');
    }
  }
}

class CustomAlert extends StatelessWidget {
  final AlertType alertType;

  final Function() dialogCallback;

  final String title;
  final Colors titleColor;

  final String message;
  final Colors messageColor;

  final TextAlign textAlign;

  const CustomAlert({Key key,
    this.title,
    this.titleColor,
    this.message,
    this.messageColor,
    this.alertType,
    this.dialogCallback,
    this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              this.title ?? 'Projeto MobX',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorsStyle.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              this.message ?? '',
              textAlign: this.textAlign ?? TextAlign.center,
              style: TextStyle(
                  color: ColorsStyle.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 16,
            ),
            (alertType == null || alertType == AlertType.OK)
                ? _buildSimpleButton(context)
                : _buildDecisionButton(context)
          ],
        ),
        )
    );
  }

  Widget _buildSimpleButton(BuildContext context) {
    return Container(
      height: 40,
      child: FlatButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          Navigator.of(context).pop();
          if (dialogCallback != null) dialogCallback();
        },
        highlightColor: ColorsStyle.blue,
        splashColor: ColorsStyle.blue,
        color: Colors.transparent,
        child: Text(
          'OK',
          style: TextStyle(
              color: ColorsStyle.blue,
              fontSize: 17,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildDecisionButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 40,
          child: FlatButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pop();
              if (dialogCallback != null) dialogCallback();
            },
            highlightColor: ColorsStyle.blue,
            splashColor: ColorsStyle.blue,
            color: Colors.transparent,
            child: Text(
              'Sim',
              style: TextStyle(
                  color: ColorsStyle.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Divider(
          height: 1,
          color: ColorsStyle.blue,
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          height: 40,
          child: FlatButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            highlightColor: ColorsStyle.blue,
            splashColor: ColorsStyle.blue,
            color: Colors.transparent,
            child: Text(
              'Não',
              style: TextStyle(
                  color: ColorsStyle.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}
