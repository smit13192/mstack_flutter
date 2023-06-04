import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mstack/api/api.dart';
import 'package:mstack/data/model/user_model.dart';

class UserRepository {
  final _api = Api();

  Future<UserModel> createAccount({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    try {
      Response response = await _api.getRequest.post('/users/createUser',
          data: jsonEncode({
            'username': username,
            'email': email,
            'password': password,
            'age': age,
          }));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(data);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> sighIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.getRequest.post('/users/sighIn',
          data: jsonEncode({
            'email': email,
            'password': password,
          }));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      Map<String, dynamic> data = apiResponse.data as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(data);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
