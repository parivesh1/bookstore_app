import 'dart:convert';

import 'book_model.dart';

class CartItemModel {
  late Book book;
  late int quantity;

  CartItemModel({required this.book, required this.quantity});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    quantity = json["quantity"];
    book = Book.fromJson(json["book"]);
  }

  static Map<String, dynamic> toJson(CartItemModel cartItem) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["quantity"] = cartItem.quantity;
    data["book"] = cartItem.book;
    return data;
  }

  static String encode(List<CartItemModel> cartItems) => json.encode(
        cartItems
            .map<Map<String, dynamic>>(
                (cartItem) => CartItemModel.toJson(cartItem))
            .toList(),
      );

  static List<CartItemModel> decode(String cartItems) {
    if (cartItems == "") return [];
    return (json.decode(cartItems) as List<dynamic>)
        .map<CartItemModel>((item) => CartItemModel.fromJson(item))
        .toList();
  }
}
