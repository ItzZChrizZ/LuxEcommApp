// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxappv2/constrats.dart';

class CustomActionBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow;
    bool? _hasTitle = hasTittle ?? true;

    final CollectionReference _userRef =
        FirebaseFirestore.instance.collection("Users");

    User? _user = FirebaseAuth.instance.currentUser;

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
                title,
                style: Constants.boldHeading,
              ),
            Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: StreamBuilder(
                  stream:
                      _userRef.doc(_user?.uid).collection("Cart").snapshots(),
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
          ],
        ),
      ),
    );
  }
}
