import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/theme/ThemeManager.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';
import 'package:provider/provider.dart';

class AppearancePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppearanceState();
  }
}

class AppearanceState extends State<AppearancePage> {
  ThemeMode themeValue;
  ThemeManager themeManager;

  @override
  void initState() {
    super.initState();
    themeManager = Provider.of<ThemeManager>(context, listen: false);
    themeValue = themeManager.getDarkMode;
  }

  void updateTheme(ThemeMode themeMode) {
    themeManager.setThemeMode = themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Appearance'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RadioListTile(
              value: ThemeMode.system,
              groupValue: themeValue,
              title: Text("System Mode", style: ConstantUtils.largeTextStyle),
              onChanged: (val) => setState(() {
                var val = ThemeMode.system;
                themeValue = val;
                updateTheme(val);
              }),
            ),
            RadioListTile(
              value: ThemeMode.light,
              groupValue: themeValue,
              title: Text("Light Mode", style: ConstantUtils.largeTextStyle),
              onChanged: (val) => setState(() {
                var val = ThemeMode.light;
                themeValue = val;
                updateTheme(val);
              }),
            ),
            RadioListTile(
              value: ThemeMode.dark,
              groupValue: themeValue,
              title: Text("Dark Mode", style: ConstantUtils.largeTextStyle),
              onChanged: (val) => setState(() {
                var val = ThemeMode.dark;
                themeValue = val;
                updateTheme(val);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
