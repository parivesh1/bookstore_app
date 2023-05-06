import 'package:bookstore_app/bookDetailsScreen/book_details.dart';
import 'package:bookstore_app/components/size_config.dart';
import 'package:bookstore_app/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetailsScreen(book: book)));
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(12.5),
            horizontal: getProportionateScreenWidth(19)),
        borderOnForeground: true,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(width: 0.6, color: Colors.black.withOpacity(0.4))),
        child: Container(
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(169),
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14),
              vertical: getProportionateScreenHeight(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: getProportionateScreenHeight(110),
                  width: getProportionateScreenWidth(142),
                  child: Image.network(book.coverImageUrl)),
              SizedBox(
                height: getProportionateScreenHeight(4),
              ),
              SizedBox(
                height: getProportionateScreenHeight(24),
                width: getProportionateScreenWidth(100),
                child: Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: const Color.fromARGB(255, 224, 108, 108)),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(4),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
                width: getProportionateScreenWidth(100),
                child: FittedBox(
                  child: Text(
                    book.priceInDollar.toStringAsFixed(2),
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.63)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
