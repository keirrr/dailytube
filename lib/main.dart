import 'package:flutter/material.dart';

// FlutterFire
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'screens/nav_screen.dart';
import './bartek_color_palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
