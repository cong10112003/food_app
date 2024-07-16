import 'package:flutter/material.dart';
import 'package:food_app/login/landing_page.dart';
import 'package:food_app/login/login_page.dart';
import 'package:food_app/login/splash_screen.dart';
import 'package:food_app/navigation_controller/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
