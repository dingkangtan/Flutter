import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/theme/ThemeManager.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';
import 'package:provider/provider.dart';

class FontStylePage extends StatefulWidget {
  @override
  FontStyleState createState() => FontStyleState();
}

class FontStyleState extends State<FontStylePage> {
  String fontType;
  ThemeManager themeManager;

  @override
  void initState() {
    super.initState();
    themeManager = Provider.of<ThemeManager>(context, listen: false);
    fontType = themeManager.getFontType;
  }

  void updateTheme(String fontType) {
    themeManager.setFontType = fontType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Font'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ConstantUtils.commonPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(ConstantUtils.extraSmallMargin),
              child: Text("Font Type:", style: ConstantUtils.labelStyle),
            ),
            RadioListTile(
              value: ConstantUtils.fontRoboto,
              groupValue: fontType,
              title: Text("Default", style: ConstantUtils.largeTextStyle),
              onChanged: (val) => setState(() {
                var val = ConstantUtils.fontRoboto;
                fontType = val;
                updateTheme(val);
              }),
            ),
            RadioListTile(
              value: ConstantUtils.fontRaleway,
              groupValue: fontType,
              title: Text("Raleway", style: ConstantUtils.largeTextStyle),
              onChanged: (val) => setState(() {
                var val = ConstantUtils.fontRaleway;
                fontType = val;
                updateTheme(val);
              }),
            ),
            RadioListTile(
              value: ConstantUtils.fontDancingScript,
              groupValue: fontType,
              title:
                  new Text("Dancing Script", style: ConstantUtils.largeTextStyle),
              onChanged: (val) => setState(() {
                var val = ConstantUtils.fontDancingScript;
                fontType = val;
                updateTheme(val);
              }),
            ),
            RadioListTile(
              value: ConstantUtils.fontCaveatBrush,
              groupValue: fontType,
              title: new Text("Caveat Brush", style: ConstantUtils.largeTextStyle),
              onChanged: (val) => setState(() {
                var val = ConstantUtils.fontCaveatBrush;
                fontType = val;
                updateTheme(val);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
