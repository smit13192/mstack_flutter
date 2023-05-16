import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/logic/cubit/question_cubit/user_question_cubit.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';

class UserLikeQuestionProvider extends ChangeNotifier {
  BuildContext context;
  List<dynamic> _likeQuestionId = [];
  String? _uid;

  UserLikeQuestionProvider(this.context);

  fetchLikeQuestionData() async {
    final state =
        BlocProvider.of<UserCubit>(context).state as UserLoggedInState;
    _uid = state.userModel.sId;
    _likeQuestionId = await BlocProvider.of<UserQuestionCubit>(context)
        .userQuestionsLikeId(uid: uid!);
    notifyListeners();
  }

  addLike({required String sId}) async {
    await BlocProvider.of<UserQuestionCubit>(context).addUserLike(sId: sId, uid: _uid!);
    fetchLikeQuestionData();
  }

  List<dynamic> get likeQuestionsId => _likeQuestionId;
  String? get uid => _uid;
}
