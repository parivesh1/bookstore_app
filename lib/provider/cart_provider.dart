import 'package:bookstore_app/components/shared_prefs.dart';
import 'package:bookstore_app/models/book_model.dart';
import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItemModel> _cartItems = List.empty(growable: true);
  List<CartItemModel> get getCartItems => _cartItems;
  SharedPref sharedPref = SharedPref();
  bool init = false;

  int checkIfAlreadyInserted(Book book) {
    int qty = -1;

    for (var element in _cartItems) {
      if (element.book.coverImageUrl == book.coverImageUrl) {
        qty = element.quantity;
      }
    }
    return qty;
  }

  void initialize() async {
    if (!init) {
      List<CartItemModel> list = await sharedPref.read("cartItems");
      _cartItems.addAll(list);
      init = true;
    }
  }

  void clear() {
    sharedPref.remove("cartItems");
    _cartItems.clear();
    notifyListeners();
  }

  void updateQuantity(Book book, int quantity) {
    sharedPref.remove("cartIems");
    CartItemModel cartItem = _cartItems.firstWhere(
        (element) => (element.book.coverImageUrl == book.coverImageUrl));
    cartItem.quantity = quantity;
    sharedPref.save("cartItems", _cartItems);
    notifyListeners();
  }

  void insert(Book book, int quantity) {
    sharedPref.remove("cartIems");
    _cartItems.add(CartItemModel(book: book, quantity: quantity));
    sharedPref.save("cartItems", _cartItems);
    notifyListeners();
  }

  void delete(CartItemModel cartItem) {
    sharedPref.remove("cartIems");
    _cartItems.removeWhere((element) =>
        (element.book.coverImageUrl == cartItem.book.coverImageUrl));
    sharedPref.save("cartItems", _cartItems);
    notifyListeners();
  }
}
