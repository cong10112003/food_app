import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class FoodItemCell extends StatelessWidget {
  final Map item;
  const FoodItemCell({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    String imageUrl =
        item['image'] ?? ""; // Lấy URL hình ảnh hoặc chuỗi rỗng nếu không có
    bool isValidImageUrl = Uri.tryParse(imageUrl ?? "")?.isAbsolute ?? false;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: media.width * 0.4,
      height: media.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Container(
                color: TColor.secondary,
                width: media.width * 0.4,
                height: media.width * 0.3,
                child: isValidImageUrl
                    ? Image.network(
                        item['image'] ?? "",
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.image,
                        color: Colors.grey[600],
                        size: media.width * 0.3,
                      )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                item["tenSP"].toString() ?? "",
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: TColor.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                item["ChiTiet"].toString() ?? "",
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: TColor.gray,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                item["category"] ?? "error",
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: TColor.gray,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
