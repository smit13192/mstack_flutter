import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/data/model/question_model.dart';
import 'package:mstack/data/repositories/like_question_repository.dart';
import 'package:mstack/data/repositories/question_repository.dart';

part 'user_question_state.dart';

class UserQuestionCubit extends Cubit<UserQuestionState> {
  UserQuestionCubit() : super(UserQuestionInitialState());

  final _repository = QuestionRepository();
  final _likeRepository = LikeQuestionRepository();

   void addUserQuestion({
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

  Future<void> fetchQuestion() async {
    try {
      emit(UserQuestionLoadingState());
      List<QuestionModel> questions = await _repository.getAllQuestion();
      emit(UserQuestionLoaddedState(questions));
    } catch (e) {
      emit(UserQuestionErrorState(e.toString()));
    }
  }

  Future<void> addUserLike({required String sId, required String uid}) async {
    try {
      await _likeRepository.addLike(sId: sId, uid: uid);
    } catch (e) {
      emit(UserQuestionErrorState(e.toString()));
    }
  }

  Future<List<dynamic>> userQuestionsLikeId({required String uid}) async {
    try {
      List<dynamic> likeQuestionsId =
          await _likeRepository.userQuestionsLikeId(uid: uid);
      return likeQuestionsId;
    } catch (e) {
      emit(UserQuestionErrorState(e.toString()));
      return [];
    }
  }

}
