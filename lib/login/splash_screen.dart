import 'package:flutter/material.dart';
import 'package:food_app/common/color_extension.dart';
import 'dart:async';
import 'package:food_app/login/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LandingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xff20D994)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Lunary",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
