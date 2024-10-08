import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_app/admin_manager/item_manager/main_item_manager.dart';
import 'package:food_app/api/api_get.dart';
import 'package:food_app/api/test_view_api.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/common/toast.dart';
import 'package:food_app/home/home_view.dart';
import 'package:food_app/login/forgot_password.dart';
import 'package:food_app/login/signup_view.dart';
import 'package:food_app/navigation_controller/admin_bottom-navigation.dart';
import 'package:food_app/navigation_controller/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    if (txtEmail.text.isEmpty || txtPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(txtEmail.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email không đúng định dạng')),
      );
      return;
    }
    final accounts = await getAccounts();
    final email = txtEmail.text;
    final password = txtPassword.text;

    final account = accounts.firstWhere(
      (account) =>
          account['username'] == email && account['password'] == password,
      orElse: () => null,
    );

    if (account != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setInt('userId', account['idTK']); //Lưu id
      prefs.setString('userName', account['fullname']);
      prefs.setString('phoneNumber', account['SDT']);
      if (account['idTK'] != 0) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => bottom_navigation_controller()),
          (Route<dynamic> route) => false,
        );
      } else if (account['idTK'] == 0) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AdminBottomNavigation()),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      // Handle login failure (e.g., show an error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tên đăng nhập hoặc mật khẩu không đúng')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: SafeArea(
              child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Chào mừng đến\nLunary",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: TColor.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Đăng nhập để tiếp tục",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: TColor.gray,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtEmail,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TColor.primary),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtPassword,
                  obscureText: true,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TColor.primary),
                    ),
                    labelText: 'Mật khẩu',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: Text(
                        "Quên mật khẩu ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TColor.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(TColor.primary),
                    ),
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      handleLogin();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Người mới?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.gray,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpView()));
                      },
                      child: Text(
                        "Đăng ký",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TColor.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
