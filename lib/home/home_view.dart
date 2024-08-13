import 'package:flutter/material.dart';
import 'package:food_app/api/api_get.dart';
import 'package:food_app/cart/cart.dart';
import 'package:food_app/common_widget/food_item_cell.dart';
import 'package:food_app/common_widget/line_textfield.dart';
import 'package:food_app/common_widget/popular_food_item_cell.dart';
import 'package:food_app/common_widget/selection_text_view.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/home/collection_food_item_cell.dart';
import 'package:food_app/home/outlet_list_view.dart';
import 'package:food_app/food_detail/food_item_detail_view.dart';
import 'package:food_app/restaurant_detail/restaurant_detail_view.dart';

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
      "name": "Lombor Pizza",
      "address": "East 46th Streets",
      "category": "Pizza, Italian",
      "image": "assets/img/l1.png",
      "price": "200000"
    },
    {
      "name": "Sushi Bar",
      "address": "210 Salt Pond Rd.",
      "category": "Sushi, Japan",
      "image": "assets/img/l2.png",
      "price": "400000"
    },
    {
      "name": "Steak House",
      "address": "East 46th Street",
      "category": "Steak, American",
      "image": "assets/img/l3.png",
      "price": "300000"
    }
  ];
  List trendingArr = [
    {
      "name": "Seafood Lee",
      "address": "210 Salt Pond Rd.",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png",
      "price": "100000"
    },
    {
      "name": "Egg Tomato",
      "address": "East 46th Street",
      "category": "Egg, Italian",
      "image": "assets/img/t2.png",
      "price": "200000"
    },
    {
      "name": "Burger Hot",
      "address": "East 46th Street",
      "category": "Pizza, Italian",
      "image": "assets/img/t3.png",
      "price": "50000"
    }
  ];
  List collectionsArr = [
    {
      "name": "Legendary food",
      "place": "34",
      "image": "assets/img/c1.png",
      "price": "10000"
    },
    {
      "name": "Seafood",
      "place": "28",
      "image": "assets/img/c2.png",
      "price": "10000"
    },
    {
      "name": "Fizza Meli",
      "place": "56",
      "image": "assets/img/c3.png",
      "price": "10000"
    }
  ];

  List popularArr = [
    {"outlets": "23", "image": "assets/img/logo1.png"},
    {"outlets": "16", "image": "assets/img/logo2.png"},
    {"outlets": "31", "image": "assets/img/logo3.png"},
    {"outlets": "60", "image": "assets/img/logo4.png"}
  ];
  //
  // ItemListViewModel itemListViewModel = ItemListViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // itemListViewModel.fetchFoodList();
  }

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
                          "Thành phố Hồ Chí Minh",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "828 Sư Vạn Hạnh, quận 10",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Cart()));
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
                      hitText: "Tìm kiếm món ăn...",
                      leftIcon: Icon(Icons.search, color: TColor.gray),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO: Trending
                    SelectionTextView(
                      title: "Nổi bật trong tuần này",
                      onSeeAllTap: () {},
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: FutureBuilder<List<dynamic>>(
                        future: getItems(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Lỗi: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('Không có món ăn nào'));
                          } else {
                            final items = snapshot.data!
                                .where((item) =>
                                    item is Map &&
                                    item['Rate'] != null &&
                                    item['Rate'] is double &&
                                    item['Rate'] > 4.5)
                                .toList();
                            if (items.isEmpty) {
                              return Center(
                                  child: Text(
                                      'Không có món ăn nào có Rate > 4.5'));
                            }
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  var item = items[index] as Map? ?? {};
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FoodItemDetailView(
                                                    item: item,
                                                  )));
                                    },
                                    child: FoodItemCell(
                                      item: item,
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                    //TODO: Legendary food
                    SelectionTextView(
                      title: "Thức ăn và nước uống",
                      onSeeAllTap: () {},
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: FutureBuilder<List<dynamic>>(
                        future: getItems(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Lỗi: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('Không có món ăn nào'));
                          } else {
                            final items = snapshot.data!;
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  var item = items[index] as Map? ?? {};
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FoodItemDetailView(
                                                    item: item,
                                                  )));
                                    },
                                    child: FoodItemCell(
                                      item: item,
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                    // //TODO: Collection
                    SelectionTextView(
                      title: "Nhà hàng",
                      onSeeAllTap: () {},
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: FutureBuilder<List<dynamic>>(
                        future: getRestaurants(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Lỗi: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('Không có nhà hàng nào'));
                          } else {
                            final items = snapshot.data!;
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  var item = items[index] as Map? ?? {};
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RestaurantDetailView(
                                                    item: item,
                                                  )));
                                    },
                                    child: CollectionFoodItemCell(
                                      item: item,
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                    //TODO: Popular brands
                    SelectionTextView(
                      title: "Các thương hiệu phổ biến",
                      onSeeAllTap: () {},
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: popularArr.length,
                          itemBuilder: (context, index) {
                            var fObj = popularArr[index] as Map? ?? {};
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OutletListView(fObj: fObj)),
                                );
                              },
                              child: PopularFoodItemCell(
                                fObj: fObj,
                                index: index,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        backgroundColor: TColor.primary,
      ),
      
    );
  }
  
}
