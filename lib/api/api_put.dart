import 'dart:convert';

import 'package:http/http.dart' as http;
const String FOOD_ITEM = "http://192.168.1.13:3030/api/";
//Sản phẩm
Future<void> updateItem(String itemId, Map<String, dynamic> updatedItem) async {
    final url = Uri.parse('$FOOD_ITEM/SanPhams/Put/$itemId');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedItem),
    );

    if (response.statusCode == 204) {
      print('Item updated successfully');
    } else {
      print('Failed to update item. Status code: ${response.statusCode}, Response body: ${response.body}');
      throw Exception('Failed to update item');
    }
  }
//Nhà hàng
Future<void> updateRestaurant(String restaurantId, Map<String, dynamic> updatedRestaurant) async {
    final url = Uri.parse('$FOOD_ITEM/NhaHangs/Put/$restaurantId');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedRestaurant),
    );

    if (response.statusCode == 204) {
      print('Item updated successfully');
    } else {
      print('Failed to update item. Status code: ${response.statusCode}, Response body: ${response.body}');
      throw Exception('Failed to update item');
    }
  }