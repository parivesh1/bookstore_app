import 'package:bookstore_app/components/size_config.dart';
import 'package:bookstore_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.black.withOpacity(0.15)),
              bottom: BorderSide(color: Colors.black.withOpacity(0.15)))),
      width: double.infinity,
      height: getProportionateScreenHeight(175),
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(9)),
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(24)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(95),
            height: getProportionateScreenHeight(135),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(cartItem.book.coverImageUrl,
                    fit: BoxFit.cover)),
          ),
          SizedBox(width: getProportionateScreenWidth(22)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(237),
                child: Text(cartItem.book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: Colors.black.withOpacity(0.63))),
              ),
              SizedBox(height: getProportionateScreenHeight(12)),
              Text('₹ ${cartItem.book.priceInDollar}',
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 244, 108, 108),
                      fontSize: 32)),
              SizedBox(height: getProportionateScreenHeight(12)),
              SizedBox(
                width: getProportionateScreenWidth(237),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qty: ${cartItem.quantity}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.63))),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(8)),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Color.fromARGB(255, 218, 218, 218),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            provider.delete(cartItem);
                          },
                          child: const Icon(Icons.delete_outline,
                              color: Color.fromARGB(255, 218, 218, 218)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
