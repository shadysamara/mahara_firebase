import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahara_fb/admin/models/app_slider.dart';
import 'package:mahara_fb/admin/models/category.dart';
import 'package:mahara_fb/admin/models/product.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:mahara_fb/helpers/firestore_helper.dart';
import 'package:mahara_fb/helpers/storage_helper.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCategories();
    getAllSiders();
  }

  /// admin process
  TextEditingController catNameController = TextEditingController();
  File? pickedImage;
  List<Category>? categories;
  List<Product>? products;
  pickCategoryImage() async {
    //1 - pick image from gallery
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      pickedImage = File(xfile.path);
      notifyListeners();
    }
  }

  createNewCategory() async {
    if (pickedImage != null) {
      AppRouter.showLoaderDialog();
      // 2- upload image to firebase storage and get its url
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("categories_images", pickedImage!);

      // 3- create category object from image url and textfield
      Category category =
          Category(image: imageUrl, name: catNameController.text);
      // 4- create new category document using category object
      String id =
          await FirestoreHelper.firestoreHelper.createNewCategory(category);

      category.id = id;
      categories!.add(category);

      pickedImage = null;
      catNameController.clear();
      notifyListeners();
      AppRouter.hideLoadingDialoug();
      AppRouter.showCustomDiaoug('The category has been successfully added');
    }
  }

  getAllCategories() async {
    categories = await FirestoreHelper.firestoreHelper.getAllCategories();
    notifyListeners();
  }

  deleteCategory(Category category) async {
    AppRouter.showLoaderDialog();
    await FirestoreHelper.firestoreHelper.deleteCategory(category.id!);
    AppRouter.hideLoadingDialoug();
    categories!.remove(category);
    notifyListeners();
  }

  ///// products part
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  addNewProduct(String catId) async {
    if (pickedImage != null) {
      AppRouter.showLoaderDialog();
      // 2- upload image to firebase storage and get its url
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("products_images", pickedImage!);

      // 3- create category object from image url and textfield
      Product product = Product(
          imageUrl: imageUrl,
          name: productNameController.text,
          description: productDescriptionController.text,
          price: productPriceController.text,
          catId: catId);
      // 4- create new category document using category object
      String id = await FirestoreHelper.firestoreHelper.addNewProduct(product);

      product.id = id;
      products?.add(product);

      pickedImage = null;
      productNameController.clear();
      productDescriptionController.clear();
      productPriceController.clear();
      notifyListeners();
      AppRouter.hideLoadingDialoug();
      AppRouter.showCustomDiaoug('The category has been successfully added');
    }
  }

  getAllProducts(String catId) async {
    //  AppRouter.showLoaderDialog();
    products = await FirestoreHelper.firestoreHelper.getAllProducts(catId);
    //  AppRouter.hideLoadingDialoug();
    notifyListeners();
  }

  List<AppSlider>? sliders;
  getAllSiders() async {
    //  AppRouter.showLoaderDialog();
    sliders = await FirestoreHelper.firestoreHelper.getAllSliders();
    //  AppRouter.hideLoadingDialoug();
    notifyListeners();
  }
}
