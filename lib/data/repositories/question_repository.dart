import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mstack/api/api.dart';
import 'package:mstack/data/model/question_model.dart';

class QuestionRepository {
  final _api = Api();

  Future<void> addQuestion({
    required String uid,
    required String cid,
    required String question,
    required String description,
  }) async {
    try {
      Response response = await _api.getRequest.post('/questions/add',
          data: jsonEncode({
            'uid': uid,
            'cid': cid,
            'question': question,
            'description': description,
          }));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QuestionModel>> getAllQuestion() async {
    try {
      Response response = await _api.getRequest.get('/questions/');
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      List<dynamic> data = apiResponse.data;
      List<QuestionModel> questions = data
          .map<QuestionModel>((question) => QuestionModel.fromJson(question))
          .toList();
      return questions;
    } catch (e) {
      rethrow;
    }
  }
}
