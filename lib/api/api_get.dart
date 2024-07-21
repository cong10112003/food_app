import 'dart:convert';
import 'package:http/http.dart' as http;

const String FOOD_ITEM = "http://192.168.1.13:3030/api/";
Future<List<dynamic>> fetchData(String endpoint) async {
  final response = await http.get(Uri.parse('$FOOD_ITEM/$endpoint'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
//Item
Future<List<dynamic>> getItems() async {
  return await fetchData('SanPhams/Get');
}
//Restaurant
Future<List<dynamic>> getRestaurants() async {
  return await fetchData('NhaHangs/Get');
}
//Account
Future<List<dynamic>> getAccounts() async {
  return await fetchData('TaiKhoans/Get');
}


