import 'package:flutter/material.dart';
import 'package:food_app/common%20widget/line_textfield.dart';
import 'package:food_app/common%20widget/selection_text_view.dart';
import 'package:food_app/common/color_extension.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSelectCity = false;
  TextEditingController txtSearch = TextEditingController();

  List legendaryArr = [
    {
      "name": "Lombar Pizza",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/l1.png"
    },
    {
      "name": "Sushi Bar",
      "address": "210 Salt Pond Rd.",
      "category": "Sushi, Japan",
      "image": "assets/img/l2.png"
    },
    {
      "name": "Steak House",
      "address": "East 46th Street",
      "category": "Steak, American",
      "image": "assets/img/l3.png"
    }
  ];
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

  List favoriteArr = [
    {"name": "American", "image": "assets/img/f1.png"},
    {"name": "France", "image": "assets/img/f2.png"},
    {"name": "Japan", "image": "assets/img/f3.png"},
    {"name": "health", "image": "assets/img/f4.png"},
    {"name": "American1", "image": "assets/img/f1.png"},
    {"name": "France1", "image": "assets/img/f2.png"},
    {"name": "Japan1", "image": "assets/img/f3.png"},
    {"name": "health1", "image": "assets/img/f4.png"}
  ];

  List popularArr = [
    {"outlets": "23", "image": "assets/img/logo1.png"},
    {"outlets": "16", "image": "assets/img/logo2.png"},
    {"outlets": "31", "image": "assets/img/logo3.png"},
    {"outlets": "60", "image": "assets/img/logo4.png"}
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bg,
        body:
            // isSelectCity
            //     ?
            NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      pinned: true,
                      floating: false,
                      centerTitle: false,
                      // leading: IconButton(
                      //   icon: Image.asset(
                      //     "assets/img/back.png",
                      //     width: 24,
                      //     height: 30,
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       isSelectCity = false;
                      //     });
                      //   },
                      // ),
                      leading: SizedBox(),
                      leadingWidth: 0,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New York City",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.text,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Your location",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      actions: [
                        IconButton(
                          icon: Image.asset(
                            "assets/img/notification.png",
                            width: 24,
                            height: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              isSelectCity = false;
                            });
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                            "assets/img/add.png",
                            width: 24,
                            height: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              isSelectCity = false;
                            });
                          },
                        ),
                      ],
                    ),
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      pinned: false,
                      floating: true,
                      primary: false,
                      leading: SizedBox(),
                      leadingWidth: 0,
                      title: RoundTextField(
                        controller: txtSearch,
                        hitText: "Search for restaurants…",
                        leftIcon: Icon(Icons.search, color: TColor.gray),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TODO: Legendary food
                      SelectionTextView(
                        title: "Legendary food",
                        onSeeAllTap: () {},
                      ),

                      //TODO: Trending this week
                      
                    ],
                  ),
                ))
    );
  }
}
