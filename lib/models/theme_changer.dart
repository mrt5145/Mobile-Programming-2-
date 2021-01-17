import 'package:flutter/material.dart';
import 'package:hw2/constant.dart';

class ThemeChanger with ChangeNotifier{
  
  ThemeData _themeData = kDarkTheme;
  bool _isDark = true;

  ThemeData get themeData => _themeData;
  bool get isDark => _isDark;


  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }

  toggleTheme() {
    _themeData =  _themeData == kDarkTheme ? kLightTheme : kDarkTheme;
    _isDark = !_isDark;
    notifyListeners();
  }
}