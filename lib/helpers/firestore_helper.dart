import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahara_fb/models/app_user.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  createNewUser(AppUser appUser) async {
    firestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection('users').doc(id).get();
        
    Map<String, dynamic>? data = document.data();
    log(data.toString());
  }
}
