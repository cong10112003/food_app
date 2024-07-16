import 'package:flutter/material.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigationState();
}

class _AdminBottomNavigationState extends State<AdminBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("admin page"),),
    );
  }
}
