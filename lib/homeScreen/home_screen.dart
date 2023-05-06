import "package:bookstore_app/components/size_config.dart";
import "package:bookstore_app/homeScreen/components/book_item.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";

import "../cartScreen/cart_screen.dart";
import "../models/book_model.dart";
import "../provider/cart_provider.dart";
import "components/requests.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> bookListFuture;
  List<Book> booksToDisplay = [];
  final Color bgColor = const Color.fromARGB(255, 246, 246, 246);
  bool added = false;

  @override
  void initState() {
    super.initState();
    bookListFuture = getBookList();
  }

  @override
  Widget build(BuildContext context) {
    final cartItemProvider = Provider.of<CartProvider>(context, listen: true);
    cartItemProvider.initialize();
    SizeConfig.init(context);
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: bgColor,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: bgColor,
          actions: [
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen())),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                height: getProportionateScreenHeight(36.67),
                width: getProportionateScreenWidth(29.33),
                child: CircleAvatar(
                  backgroundColor: bgColor,
                  child: Image.asset("assets/images/shopping_bag.png",
                      fit: BoxFit.contain),
                ),
              ),
            )
          ],
          title: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(105)),
              elevation: 0,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                cursorColor: Colors.black,
                textCapitalization: TextCapitalization.words,
                onChanged: searchBook,
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 21,
                    color: const Color.fromARGB(255, 213, 182, 182)),
                decoration: InputDecoration(
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenWidth(14.5)),
                  hintText: "Search",
                  hintStyle: GoogleFonts.publicSans(
                      fontSize: 21,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 213, 182, 182)),
                ),
              )),
        ),
        extendBodyBehindAppBar: true,
        // Body set as if actual api was being called
        body: FutureBuilder(
          future: bookListFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // If actual API Was being called
              List<Book> bookList = snapshot.data as List<Book>;
              if (!added) {
                added = true;
                booksToDisplay.clear();
                booksToDisplay.addAll(bookList);
              }
              if (booksToDisplay.isEmpty) {
                return Center(
                  child: Text(
                    "No Books Available!",
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500, fontSize: 32),
                  ),
                );
              } else {
                return Container(
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(40)),
                  child: GridView.builder(
                    itemBuilder: (context, index) {
                      return BookItem(book: booksToDisplay[index]);
                    },
                    itemCount: booksToDisplay.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    scrollDirection: Axis.vertical,
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  void searchBook(String query) {
    final suggestions = booksToDisplay.where((book) {
      final bookName = (book.title).toLowerCase();
      final input = query.toLowerCase();
      return bookName.contains(input);
    }).toList();
    setState(() {
      if (query == "") added = false;
      booksToDisplay = suggestions;
    });
  }
}
