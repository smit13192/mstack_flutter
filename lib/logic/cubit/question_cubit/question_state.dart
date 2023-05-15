part of 'question_cubit.dart';

abstract class QuestionState {}

class QuestionInitialState extends QuestionState {}

class QuestionLoaddedState extends QuestionState {
  List<QuestionModel> questions;
  QuestionLoaddedState(this.questions);
}

class QuestionLoadingState extends QuestionState {}

class QuestionErrorState extends QuestionState {
  String message;
  QuestionErrorState(this.message);
}
