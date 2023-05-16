import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mstack/api/api.dart';

class LikeQuestionRepository {
  final _api = Api();

  Future<void> addLike({required String sId, required String uid}) async {
    try {
      Response response = await _api.getRequest.post('/questions/addLike',
          data: jsonEncode({
            "_id": sId,
            "uid": uid,
          }));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> userQuestionsLikeId({required String uid}) async {
    try {
      Response response = await _api.getRequest.get('/questions/$uid');
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      List<dynamic> data = apiResponse.data;
      return data;
    } catch (e) {
      rethrow;
    }
  }
}