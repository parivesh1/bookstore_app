import 'package:bookstore_app/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<List<CartItemModel>> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return CartItemModel.decode(prefs.getString(key) ?? "");
  }

  void save(String key, List<CartItemModel> value) async {
    String endcodedData = CartItemModel.encode(value);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, endcodedData);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
