import 'package:bookstore_app/components/size_config.dart';
import 'package:bookstore_app/homeScreen/home_screen.dart';
import 'package:bookstore_app/models/cart_item.dart';
import 'package:bookstore_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'components/cart_item.dart';

class CartScreen extends StatelessWidget {
  final Color bgColor = const Color.fromARGB(255, 246, 246, 246);

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double checkoutPrice = 0;
    int totalItems = 0;
    bool validOrder = true;
    final cartItemProvider = Provider.of<CartProvider>(context, listen: true);
    List<CartItemModel> cartItems = cartItemProvider.getCartItems;
    for (var element in cartItems) {
      checkoutPrice += element.book.priceInDollar * element.quantity;
      totalItems += 1;
    }
    SizeConfig.init(context);
    if (cartItems.length > 5 || cartItems.isEmpty) validOrder = false;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
          leading: Transform.translate(
            offset: Offset(getProportionateScreenWidth(14), 0),
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
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
          decoration: BoxDecoration(
              color: validOrder
                  ? const Color.fromARGB(255, 244, 108, 108)
                  : Colors.black.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(105))),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(24),
              ),
              GestureDetector(
                  onTap: () {
                    if (validOrder) {
                      cartItemProvider.clear();
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            title: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 244, 108, 108),
                              radius: getProportionateScreenWidth(45),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            content: Text('Order Confirmed!',
                                style: GoogleFonts.workSans(fontSize: 32))),
                      );
                    }
                  },
                  child: Center(
                      child: Text(
                    "Procceed to Checkout",
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.white),
                  )))
            ],
          ),
        ),
        backgroundColor: bgColor,
        extendBody: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(37)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Bag ",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: 48)),
                  Text("($totalItems)",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                          color: Colors.black.withOpacity(0.4)))
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(24)),
            cartItems.isNotEmpty
                ? SizedBox(
                    height: getProportionateScreenHeight(450),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CartItem(
                          cartItem: CartItemModel(
                              book: cartItems[index].book,
                              quantity: cartItems[index].quantity),
                        );
                      },
                      itemCount: cartItems.length,
                    ),
                  )
                : SizedBox(
                    height: getProportionateScreenHeight(450),
                    child: Center(
                      child: Text(
                        "Your Bag is Empty",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 32),
                      ),
                    ),
                  ),
            SizedBox(height: getProportionateScreenHeight(16)),
            RichText(
              text: TextSpan(
                text: 'Subtotal: ',
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 32),
                children: <TextSpan>[
                  TextSpan(
                      text: '₹ ${checkoutPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 244, 108, 108),
                          fontSize: 42))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
