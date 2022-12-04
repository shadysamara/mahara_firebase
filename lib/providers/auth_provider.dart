import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mahara_fb/app_router/app_router.dart';
import 'package:mahara_fb/helpers/auth_helper.dart';
import 'package:mahara_fb/helpers/firestore_helper.dart';
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

  late User loggedUSer;
  login() async {
    String? userId = await AuthHelper.authHelper
        .login(loginEmailCOntroller.text.trim(), loginPasswordCOntroller.text);
    if (userId != null) {
      getUserFromFirestore(userId);
    }
  }

  getUserFromFirestore(String id) {
    FirestoreHelper.firestoreHelper.getUserFromFirestore('GxvoC8G1S7pbUE8sYtX0');
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
      AppRouter.navigateAndReplaceScreen(HomeScreen());
    }
  }

  signOut() async {
    AuthHelper.authHelper.signout();
    AppRouter.navigateAndReplaceScreen(LoginScreen());
  }
}
