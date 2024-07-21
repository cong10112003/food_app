import 'package:flutter/material.dart';

class PostAccount extends StatefulWidget {
  const PostAccount({super.key});

  @override
  State<PostAccount> createState() => _PostAccountState();
}

class _PostAccountState extends State<PostAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("this is post account"),
    );
  }
}