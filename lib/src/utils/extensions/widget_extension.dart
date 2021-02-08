import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension WidgetExtension on Widget {
  // set radius(double radius) {}

  addContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      color: Colors.yellow,
      child: this,
    );
  }

  Widget padded(double amount) =>
      Padding(padding: EdgeInsets.all(amount), child: this);
  Widget frame({
    double width,
    double height,
    Alignment alignment: Alignment.center,
  }) =>
      Container(
        width: width,
        height: height,
        alignment: alignment,
        child: this,
      );

  Widget frameConstrained({
    double minWidth,
    double idealWidth,
    double maxWidth,
    double minHeight,
    double idealHeight,
    double maxHeight,
    Alignment alignment,
  }) =>
      Container(
        width: idealWidth,
        height: idealHeight,
        alignment: alignment,
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          maxHeight: maxHeight,
        ),
        child: this,
      );
}
