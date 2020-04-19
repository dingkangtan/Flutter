import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutterapp/models/ThemeModel.dart';

class ThemeSettings implements BaseBloc {
  final List<ThemeModel> themes;

  const ThemeSettings._(this.themes);

  factory ThemeSettings() {
    final themes = <ThemeModel>[
      ThemeModel('Dark theme', ThemeData.dark()),
      ThemeModel('Blue theme', ThemeData.light()),
      ThemeModel('Pink theme', ThemeData(primarySwatch: Colors.pink)),
      ThemeModel('Teal theme', ThemeData(primarySwatch: Colors.teal)),
      ThemeModel('Amber theme', ThemeData(primarySwatch: Colors.amber)),
      ThemeModel('Purple theme', ThemeData(primarySwatch: Colors.purple)),
      ThemeModel(
          'Deep orange theme', ThemeData(primarySwatch: Colors.deepOrange)),
      ThemeModel(
          'Deep purple theme', ThemeData(primarySwatch: Colors.deepPurple)),
      ThemeModel('Orange theme', ThemeData(primarySwatch: Colors.orange)),
      ThemeModel(
          'Light green theme', ThemeData(primarySwatch: Colors.lightGreen)),
      ThemeModel(
          'Light blue theme', ThemeData(primarySwatch: Colors.lightBlue)),
    ];
    return ThemeSettings._(themes);
  }

  ThemeModel findThemeByName(String name) =>
      themes.firstWhere((e) => e.name == name,
          orElse: () => ThemeModel('Blue theme', ThemeData.light()));

  @override
  void dispose() => null;
}
