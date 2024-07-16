import 'package:flutter/material.dart';
import 'package:food_app/login/login_page.dart';
import 'package:food_app/navigation_controller/admin_bottom-navigation.dart';
import 'package:food_app/navigation_controller/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckStatusAccount extends StatefulWidget {
  const CheckStatusAccount({super.key});

  @override
  State<CheckStatusAccount> createState() => _CheckStatusAccountState();
}

class _CheckStatusAccountState extends State<CheckStatusAccount> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    int userId = prefs.getInt('userId') ?? -1;

    if (isLoggedIn) {
      if (userId == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => bottom_navigation_controller()),
        );
      } else if (userId == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminBottomNavigation()),
        );
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff20D994),
    );
  }
}
