import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/outlet_list_row.dart';
import '../../common_widget/popup_layout.dart';

class OutletListView extends StatefulWidget {
  final Map fObj;
  const OutletListView({super.key, required this.fObj});

  @override
  State<OutletListView> createState() => _OutletListViewState();
}

class _OutletListViewState extends State<OutletListView> {

  List outletArr = [
    {
      "name": "Pizza",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/l1.png",
      "time": "11:30AM to 11:00PM",
      "rate": 4.8
    },
    {
      "name": "Sushi miếng",
      "address": "210 Salt Pond Rd.",
      "category": "Sushi, Japan",
      "image": "assets/img/l2.png",
      "time": "11:30AM to 11:00PM",
      "rate": 3.8
    },
    {
      "name": "Ngôi nhà thịt nướng",
      "address": "East 46th Street",
      "category": "Steak, American",
      "image": "assets/img/l3.png",
      "time": "11:30AM to 11:00PM",
      "rate": 2.8
    },
    {
      "name": "Hải sản Lee",
      "address": "210 Salt Pond Rd.",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png",
      "time": "11:30AM to 11:00PM",
      "rate": 5.0
    },
    {
      "name": "Trứng Tomato",
      "address": "East 46th Street",
      "category": "Egg, Italian",
      "image": "assets/img/t2.png",
      "time": "11:30AM to 11:00PM",
      "rate": 4.8
    },
    {
      "name": "Burger nóng hổi",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/t3.png",
      "time": "11:30AM to 11:00PM",
      "rate": 4.8
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.bg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: TColor.list[0],
              elevation: 0,
              expandedHeight: media.width * 0.667,
              floating: false,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  width: media.width,
                  height: media.width * 0.667,
                  color: TColor.list[0],
                  child: Container(
                    padding:  EdgeInsets.only(top: media.width * 0.25),
                    height: media.width * 0.8,
                    alignment: Alignment.center,
                    child: Image.asset(
                      widget.fObj["image"].toString(),
                      width: media.width * 0.25,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                icon: Image.asset(
                  "assets/img/back.png",
                  width: 24,
                  height: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Chia sẻ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          ];
        },
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            
              ListView.builder(
                  itemCount: outletArr.length,
                  itemBuilder: (context, index) {
                    var fObj = outletArr[index] as Map? ?? {};
                    return OutletListRow(
                      fObj: fObj,
                    );
                  }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      "${ widget.fObj["Thương hiệu"] } Outlets",
                      style: TextStyle(
                          color: TColor.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextButton(
                    onPressed: () {
                      
                    },
                    child: Text(
                      "Lọc",
                      style: TextStyle(
                          color: TColor.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
