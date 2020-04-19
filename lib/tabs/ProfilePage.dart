import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/login/LoginPage.dart';
import 'package:flutterapp/models/ThemeModel.dart';
import 'package:flutterapp/theme/AppearancePage.dart';
import 'package:flutterapp/theme/FontStyleFragment.dart';
import 'package:flutterapp/theme/ThemeManager.dart';
import 'package:flutterapp/theme/ThemeSetting.dart';
import 'package:flutterapp/utils/AppNavigator.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  ThemeModel themeColor;
  ThemeManager themeManager;
  List<ThemeModel> themeModel = ThemeSettings().themes;

  @override
  void initState() {
    super.initState();
    themeManager = Provider.of<ThemeManager>(context, listen: false);
    themeColor = themeManager.getThemeColor;
  }

  void updateTheme(ThemeModel themeColor) {
    themeManager.setThemeModel = themeColor;
  }

  @override
  Widget build(BuildContext context) {
    var themeDialog = new SimpleDialog(
      title: Text("Theme"),
      children: ThemeSettings().themes.map((theme) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                theme.themeData.primaryColorLight,
                theme.themeData.primaryColor,
                theme.themeData.primaryColorDark,
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context, theme);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: ConstantUtils.commonPadding,
                ),
                child: Center(
                  child: Text(
                    theme.name,
                    textAlign: TextAlign.center,
                    style: theme.themeData.textTheme.subhead,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: ConstantUtils.commonPadding,
            right: ConstantUtils.commonPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(ConstantUtils.commonPadding),
                child: new Column(
                  children: <Widget>[
                    ProfileImage(),
                    Center(
                      child:
                          Text("Ding Kang", style: ConstantUtils.nameTextStyle),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.all(ConstantUtils.smallMargin),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.text_fields),
                    title: Text("Font Style"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      AppNavigator.push(context, FontStylePage());
                    },
                  ),
                  ConstantUtils.buildDividerContainer(),
                  ListTile(
                    leading: Icon(Icons.color_lens),
                    title: Text("Change Theme"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () async {
                      final themeModel = await showDialog<ThemeModel>(
                        context: context,
                        builder: (context) {
                          return themeDialog;
                        },
                      );

                      if (themeModel != null) {
                        updateTheme(themeModel);
                        // settingBloc.changeTheme(themeModel);
                      }
                    },
                  ),
                  ConstantUtils.buildDividerContainer(),
                  ListTile(
                    leading: Icon(Icons.colorize),
                    title: Text("Appearance"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      AppNavigator.push(context, AppearancePage());
                    },
                  ),
                ],
              ),
            ),
            new Container(
              width: double.infinity,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ConstantUtils.extraLargePadding),
                      child: SizedBox(
                        width: 200.0,
                        height: 45.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          padding: EdgeInsets.all(ConstantUtils.smallPadding),
                          color: Theme.of(context).primaryColor,
                          elevation: 5.0,
                          child: Text(
                            "Logout",
                            style: ConstantUtils.buttonStyle,
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.0,
                          ),
                          onPressed: () {
                            AppNavigator.pushReplacement(context, LoginPage());
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/profile_avatar.png');
    Image image = Image(image: assetImage, width: 150.0, height: 150.0);

    return Padding(
      padding: EdgeInsets.all(ConstantUtils.extraLargePadding),
      child: Container(
        child: image,
      ),
    );
  }
}
