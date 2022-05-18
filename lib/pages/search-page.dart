// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxappv2/components/homepage/product_card.dart';
import 'package:luxappv2/components/widgets/custom-input.dart';
import 'package:luxappv2/constrats.dart';
import 'package:luxappv2/services/firebase_services.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              const Center(
                child: Text(
                  "Search Results",
                  style: Constants.regularHeading,
                ),
              )
            else
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productRef.orderBy("search").startAt(
                    [_searchString]).endAt(["$_searchString\uf8ff"]).get(),
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
                          top: 125.0,
                          bottom: 24.0,
                        ),
                        children: snapshot.data!.docs.map((document) {
                          return ProductCard(
                            imageUrl: document['images'][0],
                            onPressed: () {},
                            price: "\$${document["price"]}",
                            productId: document.id,
                            title: document["name"],
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
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
              ),
              child: CustomInput(
                onPressed: () {},
                text: "Search here...",
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _searchString = value.toLowerCase();
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
