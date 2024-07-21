import 'package:flutter/material.dart';
import 'package:food_app/admin_manager/item_manager/delete_item.dart';
import 'package:food_app/admin_manager/item_manager/post_item.dart';
import 'package:food_app/common/color_extension.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //item 1
        Container(
            height: 50,
            width: 200,
            color: TColor.primary,
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostItem()));
                },
                child: Text('Add'))),
        //item 2
        Container(
          height: 50,
          width: 200,
          color: TColor.alertBackColor,
          child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DeleteItem()));
                },
                child: Text('Delete'))
        ),
        //item 3
        Container(
          height: 50,
          width: 200,
          color: TColor.orderColor,
          child: TextButton(
                onPressed: () {
                  
                },
                child: Text('Update'))
        )
      ],
    );
  }
}
