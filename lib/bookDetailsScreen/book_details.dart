import 'package:bookstore_app/components/size_config.dart';
import 'package:bookstore_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../cartScreen/cart_screen.dart';
import '../models/book_model.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  final Color bgColor = const Color.fromARGB(255, 246, 246, 246);
  int quantity = 0;
  bool isInserted = false, checked = false;

  @override
  Widget build(BuildContext context) {
    final cartItemProvider = Provider.of<CartProvider>(context, listen: true);
    if (!checked) {
      int a = cartItemProvider.checkIfAlreadyInserted(widget.book);
      if (a != -1) {
        quantity = a;
        isInserted = true;
      }
      checked = true;
    }
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartScreen()));
              },
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
          leading: Transform.translate(
            offset: Offset(getProportionateScreenWidth(14), 0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(getProportionateScreenWidth(10)),
                child: Icon(
                  Icons.chevron_left_outlined,
                  color: const Color.fromARGB(255, 244, 108, 108),
                  size: getProportionateScreenWidth(26),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(18),
                vertical: getProportionateScreenHeight(30)),
            height: getProportionateScreenHeight(78),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 244, 108, 108),
                borderRadius: BorderRadius.all(Radius.circular(105))),
            child: GestureDetector(
                onTap: () {
                  if (!isInserted) {
                    quantity = 1;
                    cartItemProvider.insert(widget.book, quantity);
                  }
                  setState(() {
                    isInserted = true;
                  });
                },
                child: !isInserted
                    ? Center(
                        child: Text(
                          "Add To Bag",
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 40,
                              color: Colors.white),
                        ),
                      )
                    : Center(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (quantity > 0) {
                                  quantity--;
                                }
                                cartItemProvider.updateQuantity(
                                    widget.book, quantity);
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 40,
                                color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                              cartItemProvider.updateQuantity(
                                  widget.book, quantity);
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      )))),
        extendBody: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(50)),
            SizedBox(
              height: getProportionateScreenHeight(278),
              width: getProportionateScreenWidth(178),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.network(widget.book.coverImageUrl,
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: getProportionateScreenHeight(17)),
            SizedBox(
              width: getProportionateScreenWidth(300),
              child: Text(
                widget.book.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.workSans(
                    fontSize: 32, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(28)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(18)),
              child: Text(
                "Available Formats: ${widget.book.availableFormat}\n\n Categories: ${widget.book.categories}",
                style: GoogleFonts.roboto(
                    fontSize: 21, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(8)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(18)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '₹ ${widget.book.priceInDollar.toStringAsFixed(2)}',
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 55,
                        color: const Color.fromARGB(255, 244, 108, 108)),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
