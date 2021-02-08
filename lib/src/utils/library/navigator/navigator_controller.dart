import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavigatorController {
  factory NavigatorController() => _instance;
  static final _instance = NavigatorController.internal();
  NavigatorController.internal();
  static NavigatorController get instance => NavigatorController._instance;

  GlobalKey<NavigatorState> _navigatorKey;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BuildContext get currentContext =>
      this._navigatorKey.currentState.overlay.context;

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    this._navigatorKey = navigatorKey;
  }

  void navigate(dynamic destination,
      {bool modal, bool replace, bool maintainState}) {
    if (replace != null && replace == true) {
      this._navigatorKey.currentState.pushReplacement(
            MaterialPageRoute(
                builder: (context) => destination,
                fullscreenDialog: modal ?? false,
                maintainState: maintainState ?? true),
          );
    } else {
      this._navigatorKey.currentState.push(
            MaterialPageRoute(
                builder: (context) => destination,
                fullscreenDialog: modal ?? false,
                maintainState: maintainState ?? true),
          );
    }
  }

  popNavigate() {
    if (this._navigatorKey.currentState.canPop()) {
      this._navigatorKey.currentState.pop();
    }
  }

  popToRoot() {
    if (this._navigatorKey.currentState.canPop()) {
      this
          ._navigatorKey
          .currentState
          .popUntil((Route<dynamic> route) => route.isFirst);
    }
  }

  showBottomSheet(
    dynamic child, {
    Function closed,
    Color backgroundColor,
    bool isDismissible = true,
  }) {
    var modal = showModalBottomSheet(
      context: this.currentContext,
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      },
    );
    modal.then((value) {
      print("bottomSheetController: $value");
      if (closed != null) {
        closed();
      }
    });
  }
}
