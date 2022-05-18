// ignore_for_file: file_names, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxappv2/components/productpage/image-swiper.dart';
import 'package:luxappv2/components/productpage/product-size.dart';
import 'package:luxappv2/components/widgets/custom-actionbar.dart';
import 'package:luxappv2/services/firebase_services.dart';

import '../constrats.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();



  

  String _selectedProductSize = "0";

  Future _addCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }
  Future _addSaved() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar =
      const SnackBar(content: Text("Product Added to Cart"));

  final SnackBar _snackBarSaved =
      const SnackBar(content: Text("Product Added to Saved"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: _firebaseServices.productRef.doc(widget.productId).get(),
              builder: (context, productSnapshot) {
                if (productSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error : ${productSnapshot.error}"),
                    ),
                  );
                }

                if (productSnapshot.connectionState == ConnectionState.done) {
                  var docData = productSnapshot.data as DocumentSnapshot;
                  List imageList = docData['images'];
                  List productSize = docData['size'];

                  _selectedProductSize = productSize[0];

                  return ListView(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                      left: 10.0,
                      right: 10.0,
                    ),
                    children: [
                      ImageSwiper(imagelist: imageList),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "${docData['name']}",
                          style: Constants.regularHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "\$${docData['price']}",
                          style: Constants.regularHeadingRed,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "Select Size",
                          style: Constants.regularText,
                        ),
                      ),
                      ProductSize(
                        productSizes: productSize,
                        onSelected: (size) {
                          _selectedProductSize = size;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "${docData['desc']}",
                          style: Constants.regularText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (() async {
                                  _addSaved();
                                  Scaffold.of(context).showSnackBar(_snackBarSaved);
                                }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                height: 60.0,
                                width: 60.0,
                                child: const Image(
                                  height: 25.0,
                                  image: AssetImage(
                                    "assets/icons/ribbon.png",
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  _addCart();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
                                child: Container(
                                  height: 60.0,
                                  margin: const EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Add To Cart",
                                    style: Constants.addCart,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const CustomActionBar(title: "", hasBackArrow: true),
          ],
        ),
      ),
    );
  }
}
