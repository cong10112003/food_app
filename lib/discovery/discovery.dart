import 'package:flutter/material.dart';
import 'package:food_app/api/api_urls.dart';
import 'package:food_app/common/color_extension.dart';
import 'package:food_app/discovery/discovery_cell.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

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
                      "Category",
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
          body: FutureBuilder<List<dynamic>>(
            future: getRestaurants(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Lỗi: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Không có nhà hàng nào'));
              } else {
                final items = snapshot.data!;
                return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index] as Map? ?? {};
                      return GestureDetector(
                          onTap: () {},
                          child: DiscoveryCell(
                            item: item,
                          ));
                    });
              }
            },
          )),
    );
  }
}
