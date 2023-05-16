part of 'user_question_cubit.dart';

abstract class UserQuestionState {}

class UserQuestionInitialState extends UserQuestionState {}

class UserQuestionLoaddedState extends UserQuestionState {
  List<QuestionModel> questions;
  UserQuestionLoaddedState(this.questions);
}

class UserQuestionLoadingState extends UserQuestionState {}

class UserQuestionErrorState extends UserQuestionState {
  String message;
  UserQuestionErrorState(this.message);
}
