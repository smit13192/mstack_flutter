import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/data/model/question_model.dart';
import 'package:mstack/data/repositories/question_repository.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitialState());

  final _repository = QuestionRepository();
  Future<void> fetchQuestion() async {
    try {
      emit(QuestionLoadingState());
      List<QuestionModel> questions = await _repository.getAllQuestion();
      emit(QuestionLoaddedState(questions));
    } catch (e) {
      emit(QuestionErrorState(e.toString()));
    }
  }

  Future<void> addLike({required String sId, required String uid}) async {
    try {
      await _repository.addLike(sId: sId, uid: uid);
    } catch (e) {
      emit(QuestionErrorState(e.toString()));
    }
  }

  Future<List<dynamic>> userQuestionsLikeId({required String uid}) async {
    try {
      List<dynamic> likeQuestionsId =
          await _repository.userQuestionsLikeId(uid: uid);
      return likeQuestionsId;
    } catch (e) {
      emit(QuestionErrorState(e.toString()));
      return [];
    }
  }

  void addQustion({
    required String uid,
    required String cid,
    required String question,
    required String description,
  }) async {
    try {
      await _repository.addQuestion(
        uid: uid,
        cid: cid,
        question: question,
        description: description,
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
