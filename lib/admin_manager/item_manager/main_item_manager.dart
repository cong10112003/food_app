import 'package:flutter/material.dart';
import 'package:food_app/admin_manager/item_manager/post_item.dart';
import 'package:food_app/admin_manager/item_manager/update_item.dart';
import 'package:food_app/api/api_delete.dart';
import 'package:food_app/api/api_get.dart';
import 'package:food_app/api/api_put.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/common_widget/food_item_cell.dart';
import 'package:food_app/food_detail/food_item_detail_view.dart';

class MainItemManager extends StatefulWidget {
  const MainItemManager({super.key});

  @override
  State<MainItemManager> createState() => _MainItemManagerState();
}

class _MainItemManagerState extends State<MainItemManager> {
  late Future<List<dynamic>> _itemsFuture;
  @override
  void initState() {
    super.initState();
    _itemsFuture = getItems();
  }

  Future<void> _refreshItems() async {
    setState(() {
      _itemsFuture = getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Quản lý Sản phẩm'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle menu item selection here
              if (value == 'Thêm') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostItem()),
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
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: media.width * 1.6,
            width: media.width * 0.8,
            child: FutureBuilder<List<dynamic>>(
              future: getItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Không có món ăn nào'));
                } else {
                  final items = snapshot.data!;
                  return RefreshIndicator(
                    color: TColor.primary,
                    onRefresh: _refreshItems,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          var item = items[index] as Map? ?? {};
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FoodItemDetailView(
                                            item: item,
                                          )));
                            },
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    FoodItemCell(
                                      item: item,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () async {
                                              // Navigate to the UpdateItem screen and await the result
                                              final updatedItem =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateItem(item: item),
                                                ),
                                              );
                    
                                              if (updatedItem != null) {
                                                // Update the item with the new data
                                                try {
                                                  await updateItem(
                                                      updatedItem['idSP']
                                                          .toString(),
                                                      updatedItem);
                                                  _refreshItems();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Item updated successfully')),
                                                  );
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Failed to update item: $e')),
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () async {
                                              // Xử lý logic xóa
                                              // Show a confirmation dialog
                                              final shouldDelete =
                                                  await showDialog<bool>(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Confirm Delete', style: TextStyle(color: Colors.black),),
                                                    content: Text(
                                                        'Are you sure you want to delete this item?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              true); // User confirmed deletion
                                                        },
                                                        child: Text('Delete',style: TextStyle(color: TColor.orderColor),),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(
                                                              false); // User cancelled deletion
                                                        },
                                                        child: Text('Cancel',style: TextStyle(color: TColor.alertBackColor),),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                    
                                              if (shouldDelete == true) {
                                                try {
                                                  await deleteItem(
                                                      item['idSP'].toString());
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
                            ),
                          );
                        }),
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
