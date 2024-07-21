import 'package:flutter/material.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/common_widget/direct_button.dart';
import 'package:food_app/payment/cart_payment.dart';
import 'package:food_app/payment/option_payment.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
  static List<Map<String, dynamic>> cartItems = [];
}

class _CartState extends State<Cart> {
  void checkout() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OptionPayment()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Container(
          child: Text("Danh sách cart"), // Thay text bằng dánh sách cart
        )),
        Container(
          color: TColor.orderColor,
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    "2.000.000 VNĐ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DirectButton(text: "Checkout", onTap: checkout)
            ],
          ),
        )
      ],
    ));
  }
}
