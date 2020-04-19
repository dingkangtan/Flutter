import 'package:flutter/material.dart';
import 'package:flutterapp/theme/ThemeManager.dart';
import 'package:provider/provider.dart';

import 'login/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>(
      create: (context) => ThemeManager(),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: themeManager.getThemeData.primaryColor,
        accentColor: themeManager.getThemeData.primaryColor,
        fontFamily: themeManager.getFontType,
      ),
      home: LoginPage(),
    );
  }
}
