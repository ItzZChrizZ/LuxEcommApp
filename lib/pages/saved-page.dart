// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxappv2/components/widgets/custom-actionbar.dart';
import 'package:luxappv2/constrats.dart';
import 'package:luxappv2/pages/product-page.dart';
import 'package:luxappv2/services/firebase_services.dart';

class SavedPage extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();
  SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.userRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Saved")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error : ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return SafeArea(
                    child: ListView(
                      padding: const EdgeInsets.only(
                        top: 100.0,
                        bottom: 24.0,
                      ),
                      children: snapshot.data!.docs.map((document) {
                        return GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductPage(productId: document.id)));
                          }),
                          child: FutureBuilder(
                            future: _firebaseServices.productRef
                                .doc(document.id)
                                .get(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> productSnap) {
                              if (productSnap.hasError) {
                                return Center(
                                  child: Text("${productSnap.error}"),
                                );
                              }
                              if (productSnap.connectionState ==
                                  ConnectionState.done) {
                                final _productMap = productSnap.data!.data()
                                    as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 90.0,
                                        width: 90.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            "${_productMap["images"][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_productMap["name"]}",
                                              style: Constants.regularHeading,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                              ),
                                              child: Text(
                                                "\$${_productMap["price"]}",
                                                style:
                                                    Constants.regularHeadingRed,
                                              ),
                                            ),
                                            Text(
                                              "Size - ${document.data()}",
                                              style: Constants.regularText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const CustomActionBar(
              title: "",
              hasBackArrow: true,
            )
          ],
        ),
      ),
    );
  }
}
