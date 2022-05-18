// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  String? getUserId (){

    return _firebaseAuth.currentUser?.uid;
  }


  final CollectionReference productRef =
      FirebaseFirestore.instance.collection("products");

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("Users");

}
