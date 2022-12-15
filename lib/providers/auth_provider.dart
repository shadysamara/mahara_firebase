import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahara_fb/admin/models/category.dart';
import 'package:mahara_fb/admin/views/add_new_category.dart';
import 'package:mahara_fb/admin/views/display_all_categories.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:mahara_fb/customer/views/screens/customer_main_page.dart';
import 'package:mahara_fb/helpers/auth_helper.dart';
import 'package:mahara_fb/helpers/firestore_helper.dart';
import 'package:mahara_fb/helpers/storage_helper.dart';
import 'package:mahara_fb/models/app_user.dart';
import 'package:mahara_fb/views/auth/screens/login_screen.dart';
import 'package:mahara_fb/views/auth/screens/register_screen.dart';
import 'package:mahara_fb/views/home/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    log('provider constructor');
    checkUser();
  }
  TextEditingController loginEmailCOntroller = TextEditingController();
  TextEditingController loginPasswordCOntroller = TextEditingController();
  TextEditingController registerEmailCOntroller = TextEditingController();
  TextEditingController registerPasswordCOntroller = TextEditingController();
  TextEditingController registerfnameCOntroller = TextEditingController();

  TextEditingController registerlnameCOntroller = TextEditingController();

  TextEditingController registerPhoneCOntroller = TextEditingController();
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();

  AppUser? loggedAppUser;
  late User loggedUSer;
  login() async {
    String? userId = await AuthHelper.authHelper
        .login(loginEmailCOntroller.text.trim(), loginPasswordCOntroller.text);
    if (userId != null) {
      getUserFromFirestore(userId);
      AppRouter.navigateAndReplaceScreen(DisplayAllCategoriesScreen());
    }
  }

  getUserFromFirestore(String id) async {
    loggedAppUser =
        await FirestoreHelper.firestoreHelper.getUserFromFirestore(id);
    log(loggedAppUser!.email ?? 'not exist');
    loggedAppUser!.id = id;
    profileUserNameController.text = loggedAppUser!.fname ?? '';
    profilePhoneController.text = loggedAppUser!.phoneNumber ?? '';
    profileEmailController.text = loggedAppUser!.email ?? '';
    notifyListeners();
  }

  register() async {
    bool isSuccess = await AuthHelper.authHelper.register(
        registerEmailCOntroller.text.trim(), registerPasswordCOntroller.text);
    if (isSuccess) {
      getUserFromAuth();
      AppUser appUser = AppUser(
          loggedUSer.uid,
          registerfnameCOntroller.text,
          registerlnameCOntroller.text,
          registerPhoneCOntroller.text,
          loggedUSer.email);
      FirestoreHelper.firestoreHelper.createNewUser(appUser);
    }
  }

  getUserFromAuth() {
    loggedUSer = AuthHelper.authHelper.checkUser()!;
  }

  checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    User? user = AuthHelper.authHelper.checkUser();

    if (user == null) {
      //navigation to auth screen
      AppRouter.navigateAndReplaceScreen(RegisterScreen());
    } else {
      await getUserFromFirestore(user.uid);
      AppRouter.navigateAndReplaceScreen(CustomerMainPage());
    }
  }

  signOut() async {
    AuthHelper.authHelper.signout();
    AppRouter.navigateAndReplaceScreen(LoginScreen());
  }

  updateUserImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage("profile_images", file);
      log(imageUrl);
      loggedAppUser!.imageUrl = imageUrl;
      await FirestoreHelper.firestoreHelper.updateUsernfo(loggedAppUser!);
      loggedAppUser!.imageUrl = imageUrl;
      notifyListeners();
    }
  }

  updateUserInfo() async {
    loggedAppUser!.fname = profileUserNameController.text;
    loggedAppUser!.phoneNumber = profilePhoneController.text;
    FirestoreHelper.firestoreHelper.updateUsernfo(loggedAppUser!);
    getUserFromFirestore(loggedAppUser!.id!);
  }
}
