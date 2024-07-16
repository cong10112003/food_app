import 'package:flutter/material.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/discovery/discovery_cell.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

  List listArr = [
    {
      "name":"Nearby",
      "place":"34",
      "image":"assets/img/nearby_dis.png",
    },
    {
      "name": "Desserts & Bakes",
      "place": "28",
      "image": "assets/img/desserts_bakes_disc.png",
    },
    {
      "name": "Dining Out",
      "place": "28",
      "image": "assets/img/dining_out_dis.png",
    },
    {
      "name":"Drinks & Nigtlife",
      "place":"42",
      "image":"assets/img/drink_dis.png",
    },
    {
      "name": "Cafes & More",
      "place": "29",
      "image": "assets/img/coff_dis.png",
    },
    {
      "name": "Take-Away",
      "place": "21",
      "image": "assets/img/take_away_dis.png",
    },
  ];

class _DiscoveryState extends State<Discovery> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: false,
              centerTitle: false,
              leadingWidth: 0,
              title: Row(
                children: [
                  Image.asset(
                    "assets/img/discovery_icon.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Discovery",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: TColor.text,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ];
        },
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1),
            itemCount: listArr.length,
            itemBuilder: (context, index) {
              var fObj = listArr[index] as Map? ?? {};
              return  GestureDetector(
                onTap: (){
                },
                child: DiscoveryCell(fObj: fObj,)) ;
            }),
      ),
    );
  }
}
