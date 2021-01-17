import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw2/models/languages.dart';
import 'package:hw2/models/transactions.dart';
import 'package:hw2/models/theme_changer.dart';
import 'package:hw2/screens/home_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
        ChangeNotifierProvider(create: (_) => Transactions()),
        ChangeNotifierProvider(create: (_) => Languages()),
      ],
      child: HomeScreen(),
    );
    // ChangeNotifierProvider<ThemeChanger>(
    //   create: (_) => ThemeChanger(),
    //   child: HomeScreen(),
    // );
  }
}
