import 'package:flutter/material.dart';
import 'package:food_app/common/color_extension.dart';

class OtpCheck extends StatefulWidget {
  const OtpCheck({super.key});

  @override
  State<OtpCheck> createState() => _OtpCheckState();
}

class _OtpCheckState extends State<OtpCheck> {
  TextEditingController _txtOTP = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff20D994),
                  ),
                ),
              ),
              Text(
                "Mã OTP",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff173143),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Hãy lấy OTP trong gmail bạn đã đăng ký",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff9D9D9D),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  controller: _txtOTP,
                    obscureText: true,
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
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(TColor.primary),
                      ),
                      child: Text(
                        'Send me',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                      },
                    ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}