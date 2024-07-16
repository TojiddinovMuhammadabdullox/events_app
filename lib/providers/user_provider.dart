import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class UserProvider with ChangeNotifier {
  String _email = 'No Email';
  String _name = 'No Name';
  String _imageUrl = '';

  String get email => _email;
  String get name => _name;
  String get imageUrl => _imageUrl;

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('userEmail') ?? 'No Email';
    _name = prefs.getString('userName') ?? 'No Name';
    _imageUrl = prefs.getString('userImageUrl') ?? '';
    notifyListeners();
  }

  Future<void> updateUserData(
      String newEmail, String newName, File? newImageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', newEmail);
    await prefs.setString('userName', newName);

    String imageUrl = _imageUrl;
    if (newImageFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('$newEmail.jpg');
      await storageRef.putFile(newImageFile);
      imageUrl = await storageRef.getDownloadURL();
      await prefs.setString('userImageUrl', imageUrl);
    }

    _email = newEmail;
    _name = newName;
    _imageUrl = imageUrl;
    notifyListeners();

    await FirebaseFirestore.instance.collection('users').doc(newEmail).set({
      'email': newEmail,
      'name': newName,
      'imageUrl': imageUrl,
    });
  }
}
