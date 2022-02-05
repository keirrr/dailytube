import 'package:flutter/material.dart';

import 'screens/nav_screen.dart';
import './bartek_color_palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BartekHub',
      theme: ThemeData(
        // colors
        primarySwatch: BartekColorPalette.bartekGrey,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFFF8F00)),

        // font
        fontFamily: 'Roboto',

        // text style
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
      home: NavScreen(),
    );
  }
}