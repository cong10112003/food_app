import 'package:flutter/material.dart';
import 'package:food_app/account/my_level_view.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/common_widget/icon_text_button.dart';
import 'package:food_app/common_widget/menu_row.dart';
import 'package:food_app/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String _userName = "";
  String _phoneNumber = "";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  //Load user information
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? "Guest";
      _phoneNumber = prefs.getString('phoneNumber') ?? "None phone number";
    });
  }

  //Logout
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: TextStyle(
                  color: TColor.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: media.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(media.width * 0.125),
                      child: Container(
                        color: TColor.secondary,
                        child: Image.asset(
                          "assets/img/u1.png",
                          width: media.width * 0.25,
                          height: media.width * 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    Text(
                      _userName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: media.width * 0.025,
                    ),
                    Text(
                      _phoneNumber,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.gray,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconTextButton(
                    icon: "assets/img/network.png",
                    title: "Network",
                    subTitle: "603",
                    onPressed: () {},
                  ),
                  IconTextButton(
                    icon: "assets/img/review.png",
                    title: "My Reviews",
                    subTitle: "953",
                    onPressed: () {},
                  ),
                  IconTextButton(
                    icon: "assets/img/my_level.png",
                    title: "My Level",
                    subTitle: "Sliver",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyLevelView()));
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
              child: Column(
                children: [
                  MenuRow(
                    icon: "assets/img/payment.png",
                    title: "Manage Payment Option",
                    onPressed: () {},
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                  MenuRow(
                    icon: "assets/img/find_friends.png",
                    title: "Find Friends on Capi",
                    onPressed: () {},
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                  MenuRow(
                    icon: "assets/img/settings.png",
                    title: "More Settings",
                    onPressed: () {},
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                  MenuRow(
                    icon: "assets/img/sign_out.png",
                    title: "Sign Out",
                    onPressed: () {
                      _logout();
                    },
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
