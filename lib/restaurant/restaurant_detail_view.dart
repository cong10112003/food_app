import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/common_widget/collection_food_item_cell.dart';
import 'package:food_app/common_widget/food_item_cell.dart';
import 'package:food_app/common_widget/icon_text_button.dart';
import 'package:food_app/common_widget/img_text_button.dart';
import 'package:food_app/common_widget/selection_text_view.dart';
import 'package:food_app/common_widget/user_review_row.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/color_extension.dart';

class RestaurantDetailView extends StatefulWidget {
  final Map fObj;
  const RestaurantDetailView({super.key, required this.fObj});

  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  List trendingArr = [
    {
      "name": "Seafood Lee",
      "address": "210 Salt Pond Rd.",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png"
    },
    {
      "name": "Egg Tomato",
      "address": "East 46th Street",
      "category": "Egg, Italian",
      "image": "assets/img/t2.png"
    },
    {
      "name": "Burger Hot",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/t3.png"
    }
  ];
  List collectionsArr = [
    {"name": "Legendary food", "place": "34", "image": "assets/img/c1.png"},
    {"name": "Seafood", "place": "28", "image": "assets/img/c2.png"},
    {"name": "Fizza Meli", "place": "56", "image": "assets/img/c3.png"}
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(39.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 14.151926040649414);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: media.width * 0.667,
                floating: false,
                centerTitle: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        width: media.width,
                        height: media.width * 0.667,
                        color: TColor.secondary,
                        child: Image.asset(
                          widget.fObj["image"].toString(),
                          width: media.width,
                          height: media.width * 0.8,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context)
                            .padding
                            .top, // Để đặt nút dưới thanh trạng thái
                        left: 8.0, // Khoảng cách từ mép trái
                        child: IconButton(
                          icon: Image.asset(
                            "assets/img/back.png",
                            width: 24,
                            height: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.fObj["name"].toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: TColor.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: TColor.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "4.8",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconTextButton(
                        title: "Share",
                        subTitle: "603",
                        icon: "assets/img/share.png",
                        onPressed: () {},
                      ),
                      IconTextButton(
                        title: "Review",
                        subTitle: "953",
                        icon: "assets/img/review.png",
                        onPressed: () {},
                      ),
                      IconTextButton(
                        title: "Photo",
                        subTitle: "115",
                        icon: "assets/img/photo.png",
                        onPressed: () {},
                      ),
                      IconTextButton(
                        title: "Bookmark",
                        subTitle: "1478",
                        icon: "assets/img/bookmark_detail.png",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    height: media.width * 0.4,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.fObj["address"].toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: TColor.gray,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      widget.fObj["category"].toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: TColor.gray,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "11:30AM to 11PM",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: TColor.gray,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // const SizedBox(
                //   height: 15,
                // ),
                Container(
                  margin:
                      const EdgeInsets.symmetric( horizontal: 15),
                  child: Divider(
                    height: 20, // Chiều cao của Divider
                    thickness: 4, // Độ dày của Divider
                    color: TColor.primary, // Màu sắc của Divider
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          widget.fObj["image"].toString(),
                          width: media.width,
                          height: media.width * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: media.width,
                        height: media.width * 0.2,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.black54, Colors.transparent]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Order food Online",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),

                SelectionTextView(
                  title: "Photos",
                  actionTitle: "See all",
                  onSeeAllTap: () {},
                ),

                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ImgTextButton(
                            title: "Food",
                            subTitle: "(80)",
                            image: "assets/img/c1.png",
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: ImgTextButton(
                            title: "Ambience",
                            subTitle: "(25)",
                            image: "assets/img/c2.png",
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: ImgTextButton(
                            title: "Menu",
                            subTitle: "(10)",
                            image: "assets/img/c3.png",
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: ImgTextButton(
                            title: "All Photos",
                            subTitle: "(115)",
                            image: "assets/img/l1.png",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Divider(
                  height: 4,
                  color: TColor.gray,
                ),

                SelectionTextView(
                  title: "Details",
                  actionTitle: "Read All",
                  onSeeAllTap: () {},
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Call",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "(212 789-7898)",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cuisines",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Pizza Italian",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Average Cost",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "\$20 - \$40",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),

                //TODO: Trending this week
                SelectionTextView(
                  title: "Same Restaurants",
                  onSeeAllTap: () {},
                ),

                SizedBox(
                  height: media.width * 0.6,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: trendingArr.length,
                      itemBuilder: (context, index) {
                        var fObj = trendingArr[index] as Map? ?? {};

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestaurantDetailView(
                                          fObj: fObj,
                                        )));
                          },
                          child: FoodItemCell(
                            fObj: fObj,
                          ),
                        );
                      }),
                ),

                //TODO: Collections by Capi
                SelectionTextView(
                  title: "Collections by Capi",
                  onSeeAllTap: () {},
                ),

                SizedBox(
                  height: media.width * 0.6,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: collectionsArr.length,
                      itemBuilder: (context, index) {
                        var fObj = collectionsArr[index] as Map? ?? {};

                        return CollectionFoodItemCell(
                          fObj: fObj,
                        );
                      }),
                ),

                const SizedBox(
                  height: 15,
                )
              ],
            ),
          )),
    );
  }
}
