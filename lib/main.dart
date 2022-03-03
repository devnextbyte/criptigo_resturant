import 'package:criptigo/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Criptigo',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFFF6300,
          <int, Color>{
            50: Color(0xFFFFB180),
            100: Color(0xFFFFA166),
            200: Color(0xFFFF924D),
            300: Color(0xFFFF8233),
            400: Color(0xFFFF731A),
            500: Color(0xFFFF6300),
            600: Color(0xFFE65900),
            700: Color(0xFFCC4F00),
            800: Color(0xFFB34500),
            900: Color(0xFF993B00),
          },
        ),
        fontFamily: "montserrat",
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          contentPadding: EdgeInsets.fromLTRB(24, 8, 8, 24),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
      home: Splash(),
    );
  }
}
