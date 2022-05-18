// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxappv2/constrats.dart';
import 'package:luxappv2/pages/cart-page.dart';
import 'package:luxappv2/services/firebase_services.dart';

class CustomActionBar extends StatefulWidget {
  final String title;
  final bool hasBackArrow;
  final bool? hasTittle;
  const CustomActionBar(
      {Key? key,
      required this.title,
      required this.hasBackArrow,
      this.hasTittle})
      : super(key: key);

  @override
  State<CustomActionBar> createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("Users");

  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = widget.hasBackArrow;
    bool? _hasTitle = widget.hasTittle ?? true;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_hasBackArrow)
              Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (_hasTitle)
              Text(
                widget.title,
                style: Constants.boldHeading,
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: StreamBuilder(
                    stream: _userRef
                        .doc(_firebaseServices.getUserId())
                        .collection("Cart")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      int _totalItems = 0;

                      if (snapshot.connectionState == ConnectionState.active) {
                        List? _documents = snapshot.data!.docs;
                        _totalItems = _documents!.length;
                      }

                      return Text(
                        "$_totalItems",
                        style: Constants.boxNumbers,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
