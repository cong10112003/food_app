import 'package:flutter/material.dart';
import 'package:food_app/admin_manager/restaurant_manager/post_restaurant.dart';

class MainRestaurantManager extends StatefulWidget {
  const MainRestaurantManager({super.key});

  @override
  State<MainRestaurantManager> createState() => _MainRestaurantManagerState();
}

class _MainRestaurantManagerState extends State<MainRestaurantManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Quản lý nhà hàng'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle menu item selection here
              if(value == 'Thêm') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostRestaurant()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Thêm'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
