// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../models/user.dart';

// Future<void> createUser(String displayName, BuildContext context) async {
//   final userCollection = FirebaseFirestore.instance.collection('users');
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String uid = auth.currentUser!.uid;
//   MUser user = MUser(displayName: displayName, uid: uid, id: 'okkk');

//   userCollection.add(user.toMap());
//   return; // since it's a future void type
// }
