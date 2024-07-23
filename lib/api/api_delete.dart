
import 'package:http/http.dart' as http;

const String FOOD_ITEM = "http://192.168.1.13:3030/api/";

Future<void> deleteItem(String itemId) async {
  final url = Uri.parse('$FOOD_ITEM/SanPhams/Delete/$itemId');
  
  // Gửi yêu cầu DELETE đến API
  final response = await http.delete(
    url,
    headers: {'Content-Type': 'application/json'}, // Thiết lập tiêu đề nếu cần
  );

  if (response.statusCode == 200) {
    print('Item deleted successfully');
  } else {
    // In ra chi tiết lỗi nếu xóa thất bại
    print('Failed to delete item. Status code: ${response.statusCode}, Response body: ${response.body}');
    throw Exception('Failed to delete item');
  }
}
//nhà hàng
Future<void> deleteRestaurant(String restaurantId) async {
  final url = Uri.parse('$FOOD_ITEM/NhaHangs/Delete/$restaurantId');
  
  // Gửi yêu cầu DELETE đến API
  final response = await http.delete(
    url,
    headers: {'Content-Type': 'application/json'}, // Thiết lập tiêu đề nếu cần
  );

  if (response.statusCode == 200) {
    print('Item deleted successfully');
  } else {
    // In ra chi tiết lỗi nếu xóa thất bại
    print('Failed to delete item. Status code: ${response.statusCode}, Response body: ${response.body}');
    throw Exception('Failed to delete item');
  }
}