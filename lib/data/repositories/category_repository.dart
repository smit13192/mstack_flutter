import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mstack/api/api.dart';
import 'package:mstack/data/model/category_model.dart';

class CategoryRepository {
  final _api = Api();

  Future<List<CategoryModel>> getAllCategory() async {
    try {
      Response response =
          await _api.getRequest.get('/categories/categoryNameId');
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      List<dynamic> data = apiResponse.data;
      List<CategoryModel> categories = data
          .map<CategoryModel>((category) => CategoryModel.fromJson(category))
          .toList();
      return categories;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
