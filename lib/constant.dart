import 'package:flutter/material.dart';

const kSpacingUnit = 50;

const kTextColor = Color(0xFF151C2A);
const kDarkPrimaryColor = Color(0xFF3E2723);
const kCanvasColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);


final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kDarkPrimaryColor,
  canvasColor: kCanvasColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);