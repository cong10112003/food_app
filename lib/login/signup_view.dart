import 'package:flutter/material.dart';
import 'package:food_app/api/api_get.dart';
import 'package:food_app/api/api_post.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/common/toast.dart';
import 'package:food_app/login/otp_check.dart';

import '../../common_widget/line_textfield.dart';
import '../../common_widget/round_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtFullname = TextEditingController();
  void _submitForm() async {
    int maxId = await fetchMaxIdTk();
    if (_formKey.currentState!.validate()){
      final account = {
      'idTK': maxId + 1,
      'username': txtEmail.text,
      'password': txtPassword.text,
      'SDT': int.parse(txtPhone.text),
      'fullname': txtFullname.text,
    };
    try {
      await postAccount(account);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Thêm thành công'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Thêm thất bại'),
      ));
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
              child: SizedBox(
            width: media.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: TColor.primary,
                    ),
                  ),
                ),
                Text(
                  "Welcome to\nLunary",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: TColor.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                Text(
                  "Sign up to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: TColor.gray,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.07,
                ),
                LineTextField(
                  controller: txtEmail,
                  hitText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: media.width * 0.07,
                ),
                LineTextField(
                  controller: txtFullname,
                  hitText: "Tên đầy đủ",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: media.width * 0.07,
                ),
                LineTextField(
                  controller: txtPhone,
                  hitText: "Số điện thoại",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: media.width * 0.07,
                ),
                LineTextField(
                  controller: txtPassword,
                  obscureText: true,
                  hitText: "Password",
                ),
                SizedBox(
                  height: media.width * 0.07,
                ),
                LineTextField(
                  controller: txtConfirmPassword,
                  obscureText: true,
                  hitText: "Nhập lại mật khẩu",
                ),
                SizedBox(
                  height: media.width * 0.1,
                ),
                RoundButton(
                  title: "Đăng ký",
                  onPressed: () async {
                    if (txtEmail.text.isEmpty ||
                        txtPassword.text.isEmpty ||
                        txtConfirmPassword.text.isEmpty) {
                      showToast('Vui lòng điền đầy đủ thông tin');
                      return;
                    }
                    if (txtPassword.text != txtConfirmPassword.text) {
                      showToast('Mật khẩu nhập lại không khớp');
                      return;
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(txtEmail.text)) {
                      showToast('Email không đúng định dạng');
                      return;
                    } else {
                      _submitForm();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OtpCheck()));
                    }
                  },
                  type: RoundButtonType.primary,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
