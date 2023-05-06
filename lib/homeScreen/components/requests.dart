import 'dart:convert';
// import 'package:bookstore_app/components/urls.dart';
// import 'package:http/http.dart' as http;

import '../../models/book_model.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  var s = await rootBundle.loadString('assets/all_books.json');
  return s;
}

Future<List<Book>> getBookList() async {
  // What it should have been if it was an actual API

  // var response = await http.get(Uri.parse(getBookList), headers: header);
  // if (response.statusCode == 200) {
  //   List<Book> bookList = [];
  //   var jsonResponse = jsonDecode(response.body);
  //   for (var d in (jsonResponse as List)) {
  //     bookList.add(d);
  //   }
  //   return bookList;
  // } else {
  //   return [];
  // }

  List<Book> bookList = [];
  String s = await loadAsset();

  var jsonResponse = jsonDecode(s);

  for (var d in (jsonResponse as List)) {
    bookList.add(Book.fromJson(d));
  }

  return bookList;
}
