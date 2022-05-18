import 'package:flutter/material.dart';
import 'package:luxappv2/constrats.dart';
import 'package:luxappv2/pages/product-page.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  const ProductCard(
      {Key? key,
      required this.onPressed,
      required this.imageUrl,
      required this.title,
      required this.price,
      required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(productId: productId)));
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Constants.regularHeading,
                    ),
                    Text(
                      price,
                      style: Constants.regularHeadingRed,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
