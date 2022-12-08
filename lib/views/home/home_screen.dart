import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mahara_fb/admin/models/category.dart';
import 'package:mahara_fb/helpers/firestore_helper.dart';
import 'package:mahara_fb/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, c) {
        return provider.loggedAppUser == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        provider.updateUserImage();
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey,
                        child: provider.loggedAppUser!.imageUrl == null
                            ? Icon(Icons.camera)
                            : Image.network(
                                provider.loggedAppUser!.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ProfileItem(
                        'FullName:',
                        ((provider.loggedAppUser!.fname!) +
                            " " +
                            (provider.loggedAppUser!.lname!)),
                        provider.profileUserNameController),
                    ProfileItem(
                        'Phone Number:',
                        ((provider.loggedAppUser!.phoneNumber!)),
                        provider.profilePhoneController),
                    ProfileItem('Email:', ((provider.loggedAppUser!.email!)),
                        provider.profileEmailController),
                    ElevatedButton(
                        onPressed: () {
                          bool isValid = formKey.currentState!.validate();
                          if (isValid) {
                            provider.updateUserInfo();
                          }
                        },
                        child: Text('Update UserInfo')),
                    ElevatedButton(
                        onPressed: () async {
                          Category category =
                              Category(image: "image", name: 'name');
                          String id = await FirestoreHelper.firestoreHelper
                              .createNewCategory(category);
                          log(id);
                        },
                        child: Text('Test Add Category'))
                  ],
                ),
              );
      }),
    );
  }
}

class ProfileItem extends StatelessWidget {
  String label;
  String content;
  TextEditingController controller;
  ProfileItem(this.label, this.content, this.controller);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
              validator: (String? x) {
                if (x == null || x.isEmpty) {
                  return "this field is required";
                }
              },
              controller: controller,
              style: TextStyle(fontSize: 18)),
        ),
      ]),
    );
  }
}
