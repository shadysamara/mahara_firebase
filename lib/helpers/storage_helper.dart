import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class StorageHelper {
  StorageHelper._();
  static StorageHelper storageHelper = StorageHelper._();
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadImage(File file) async {
    // 1- define the refrence of the file
    String path = file.path; // downloads/0/dcim/imagename.extension
    String name = path.split('/').last;
    Reference reference = storage.ref('profile_images/$name');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
