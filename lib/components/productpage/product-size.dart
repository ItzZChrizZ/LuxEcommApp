// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:luxappv2/constrats.dart';

class ProductSize extends StatefulWidget {
  final List productSizes;
  final Function(String)? onSelected;
  const ProductSize({Key? key, required this.productSizes, this.onSelected})
      : super(key: key);

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selectedSize = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes.length; i++)
            GestureDetector(
              onTap: (() {
                setState(() {
                  _selectedSize = i;
                });

                widget.onSelected!("$_selectedSize[i]");
              }),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selectedSize == i ? Colors.orange : Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${widget.productSizes[i]}",
                  style: Constants.sizeNumbers,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
