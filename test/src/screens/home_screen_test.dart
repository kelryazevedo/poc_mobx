import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_mobx/app/environments.dart';
import 'package:poc_mobx/src/screens/home/home_screen.dart';
import 'package:poc_mobx/src/utils/app_config.dart';

void main() {
  Key _listUsers = Key('listUsers');

  setUpAll(() {
    AppConfig.getInstance(config: Environment.dev);
  });

  testWidgets('List Users', (WidgetTester tester) async {
    final key = GlobalKey<ScaffoldState>();
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(key: key, drawer: HomeScreen())));
    key.currentState.openDrawer();
    await tester.pump();
    expect(find.byKey(_listUsers), findsOneWidget);
  });
}
