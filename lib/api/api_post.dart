
import 'package:http/http.dart' as http;
import 'dart:convert';
const String FOOD_ITEM = "http://192.168.1.13:3030/api/";

//item
Future<void> postItem(Map<String, dynamic> product) async {
  final response = await http.post(
    Uri.parse('$FOOD_ITEM/SanPhams/Post'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(product),
  );

  if (response.statusCode == 201) {
    print('Product posted successfully');
  } else {
    throw Exception('Failed to post product');
  }
}
//restaurant
Future<void> postRestaurant(Map<String, dynamic> product) async {
  final response = await http.post(
    Uri.parse('$FOOD_ITEM/NhaHangs/Post'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(product),
  );

  if (response.statusCode == 201) {
    print('Product posted successfully');
  } else {
    throw Exception('Failed to post product');
  }
}
//account
Future<void> postAccount(Map<String, dynamic> account) async {
  final response = await http.post(
    Uri.parse('$FOOD_ITEM/TaiKhoans/PostTaiKhoan'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(account),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Product posted successfully');
  } else {
    throw Exception('Failed to post product');
  }
}
Future<Map<String, dynamic>> postOtp(String email) async {
  final response = await http.post(
    Uri.parse('$FOOD_ITEM/TaiKhoans/postOTP').replace(queryParameters: {'email': email}),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Successful response
    return json.decode(response.body);
  } else {
    // Error response
    throw Exception('Failed to send OTP');
  }
}
