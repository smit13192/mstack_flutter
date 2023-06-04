import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUserDetails({
    required String uid,
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString('uid', uid);
    await instance.setString('username', username);
    await instance.setString('email', email);
    await instance.setString('password', password);
    await instance.setInt('age', age);
    log('detail saved');
  }

  static Future<Map<String, dynamic>> fetchUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? uid = instance.getString('uid');
    String? username = instance.getString('username');
    String? email = instance.getString('email');
    String? password = instance.getString('password');
    int? age = instance.getInt('age');

    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'age': age,
    };
  }

  static Future<void> clearData() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.clear();
  }
}
