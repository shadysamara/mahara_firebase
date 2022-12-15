import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahara_fb/admin/models/app_slider.dart';
import 'package:mahara_fb/admin/models/category.dart';
import 'package:mahara_fb/admin/models/product.dart';
import 'package:mahara_fb/models/app_user.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  createNewUser(AppUser appUser) async {
    firestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection('users').doc(id).get();

    Map<String, dynamic>? data = document.data();
    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  updateUsernfo(AppUser appUser) async {
    await firestore.collection('users').doc(appUser.id).update(appUser.toMap());
  }

  ///// admin functions
  Future<String> createNewCategory(Category category) async {
    DocumentReference<Map<String, dynamic>> document =
        await firestore.collection('categories').add(category.toMap());
    return document.id;
  }

  Future<List<Category>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('categories').get();
    List<Category> categories = querySnapshot.docs.map((doc) {
      Category cat = Category.fromMap(doc.data());
      cat.id = doc.id;
      return cat;
    }).toList();
    return categories;
  }

  deleteCategory(String id) async {
    await firestore.collection('categories').doc(id).delete();
  }

  updateCategory(Category newCategory) async {}

  //// products functions
  Future<String> addNewProduct(Product product) async {
    DocumentReference<Map<String, dynamic>> documentReference = await firestore
        .collection('categories')
        .doc(product.catId)
        .collection('products')
        .add(product.toMap());

    return documentReference.id;
  }

  Future<List<Product>?> getAllProducts(String catId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('categories')
          .doc(catId)
          .collection('products')
          .get();
      return querySnapshot.docs.map((e) {
        Product product = Product.fromMap(e.data());
        product.id = e.id;
        return product;
      }).toList();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  getCollections() async {
    firestore.collection('categories').doc('').get();
  }
   Future<List<AppSlider>?> getAllSliders() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('sliders')
          .get();
      return querySnapshot.docs.map((e) {
        AppSlider product = AppSlider.fromMap(e.data());

        return product;
      }).toList();
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
