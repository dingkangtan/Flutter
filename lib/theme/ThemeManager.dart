import 'package:flutter/material.dart';
import 'package:flutterapp/models/ThemeModel.dart';
import 'package:flutterapp/theme/ThemeSetting.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  static const KEY_DARK_MODE = "dark_mode";
  static const KEY_THEME_MODEL = "theme_model";
  static const KEY_FONT_TYPE = "font_type";

  String fontType;
  String defaultFontType = ConstantUtils.fontRoboto;
  ThemeMode darkMode;
  ThemeMode defaultThemeMode = ThemeMode.light;
  ThemeModel themeColor;
  ThemeModel defaultThemeColor = ThemeModel('Blue theme', ThemeData.light());

  ThemeManager() {
    getThemeModeFromSharedPrefs();
    getThemeColorFromSharedPrefs();
    getFontTypeFromSharedPrefs();
  }

  set setThemeMode(ThemeMode themeMode) {
    this.darkMode = themeMode;
    saveThemeModeInSharedPrefs(themeMode);
    notifyListeners();
  }

  ThemeMode get getDarkMode {
    return darkMode;
  }

  set setThemeModel(ThemeModel themeColor) {
    this.themeColor = themeColor;
    saveThemeColorInSharedPrefs(themeColor);
    notifyListeners();
  }

  ThemeModel get getThemeColor {
    return themeColor;
  }

  ThemeData get getThemeData {
    if (darkMode == ThemeMode.dark) {
      return ThemeData.dark();
    }

    if (themeColor == null) {
      return ThemeData.light();
    } else if (themeColor.themeData == ThemeData.dark()) {
      return ThemeData.dark();
    } else {
      return themeColor.themeData;
    }
  }

  set setFontType(String fontType) {
    this.fontType = fontType;
    saveFontTypeInSharedPrefs(fontType);
    notifyListeners();
  }

  String get getFontType {
    return fontType;
  }

  void saveThemeModeInSharedPrefs(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_DARK_MODE, themeMode.toString());
  }

  void getThemeModeFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeModeFromSharedPrefs = prefs.getString(KEY_DARK_MODE);

    darkMode = ThemeMode.values.firstWhere(
        (element) => themeModeFromSharedPrefs == element.toString(),
        orElse: () => defaultThemeMode);
    notifyListeners();
  }

  void saveThemeColorInSharedPrefs(ThemeModel themeModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_THEME_MODEL, themeModel.name);
  }

  void getThemeColorFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeColorFromSharedPrefs = prefs.getString(KEY_THEME_MODEL);

    themeColor = defaultThemeColor;
    themeColor = ThemeSettings().findThemeByName(themeColorFromSharedPrefs);
    notifyListeners();
  }

  void saveFontTypeInSharedPrefs(String fontType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_FONT_TYPE, fontType);
  }

  void getFontTypeFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fontTypeFromSharedPrefs = prefs.getString(KEY_FONT_TYPE);

    if (fontTypeFromSharedPrefs != null) {
      fontType = fontTypeFromSharedPrefs;
    } else {
      fontType = defaultFontType;
    }
    notifyListeners();
  }
}
