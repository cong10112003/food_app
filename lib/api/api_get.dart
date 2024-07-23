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
//OTP
Future<List<dynamic>> getOTP() async {
  return await fetchData('TaiKhoans/getOTP');
}


Future<int> fetchMaxIdTk() async {
  final response = await http.get(Uri.parse('$FOOD_ITEM/TaiKhoans/Get'));
  
  if (response.statusCode == 200) {
    final List<dynamic> accounts = json.decode(response.body);
    int maxId = accounts.map((account) => account['idTK']).reduce((a, b) => a > b ? a : b);
    return maxId;
  } else {
    throw Exception('Failed to load accounts');
  }
}

