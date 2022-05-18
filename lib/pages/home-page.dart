// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxappv2/components/homepage/product_card.dart';

import 'package:luxappv2/services/firebase_services.dart';

import '../components/widgets/custom-actionbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productRef.get(),
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
          const CustomActionBar(
            hasBackArrow: false,
            title: 'Lux',
          ),
        ],
      ),
    );
  }
}
