import 'package:flutter/material.dart';
import 'package:food_app/admin_manager/restaurant_manager/post_restaurant.dart';
import 'package:food_app/admin_manager/restaurant_manager/update_restaurant.dart';
import 'package:food_app/api/api_delete.dart';
import 'package:food_app/api/api_get.dart';
import 'package:food_app/api/api_put.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/home/collection_food_item_cell.dart';
import 'package:food_app/restaurant_detail/restaurant_detail_view.dart';

class MainRestaurantManager extends StatefulWidget {
  const MainRestaurantManager({super.key});

  @override
  State<MainRestaurantManager> createState() => _MainRestaurantManagerState();
}

class _MainRestaurantManagerState extends State<MainRestaurantManager> {
  late Future<List<dynamic>> _restaurantsFuture;
  @override
  void initState() {
    super.initState();
    _restaurantsFuture = getRestaurants();
  }

  Future<void> _refreshRestaurants() async {
    setState(() {
      _restaurantsFuture = getRestaurants();
    });
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
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
      body: SizedBox(
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
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            CollectionFoodItemCell(
                                                item: item,
                                            ),
                                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () async{
                                    // Xử lý logic sửa
                                    // Navigate to the UpdateItem screen and await the result
                                              final updatedRestaurant =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateRestaurant(item: item),
                                                ),
                                              );
                    
                                              if (updatedRestaurant != null) {
                                                // Update the item with the new data
                                                try {
                                                  await updateRestaurant(
                                                      updatedRestaurant['idNhaHang']
                                                          .toString(),
                                                      updatedRestaurant);
                                                  _refreshRestaurants();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Restaurant updated successfully')),
                                                  );
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Failed to update restaurant: $e')),
                                                  );
                                                }
                                              }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    // Xử lý logic xóa
                                          // Show a confirmation dialog
                                              final shouldDelete =
                                                  await showDialog<bool>(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Xác nhận xóa', style: TextStyle(color: Colors.black),),
                                                    content: Text(
                                                        'bạn có chắc muốn xóa nhà hàng này'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              true); // User confirmed deletion
                                                        },
                                                        child: Text('Xóa',style: TextStyle(color: TColor.orderColor),),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              false); // User cancelled deletion
                                                        },
                                                        child: Text('Hủy',style: TextStyle(color: TColor.alertBackColor),),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                    
                                              if (shouldDelete == true) {
                                                try {
                                                  await deleteRestaurant(
                                                      item['idNhaHang'].toString());
                                                  setState(() {
                                                    items.removeAt(index);
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Xóa thành công')),
                                                  );
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Xóa thất bại: $e')),
                                                  );
                                                }
                                              }
                                  },
                                ),
                                  ],
                                ),
                              )
                                          ],
                                        )
                                      ],
                                    )
                                  );
                                });
                          }
                        },
                      ),
                    ),
    );
  }
}
