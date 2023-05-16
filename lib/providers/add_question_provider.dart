import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/data/model/category_model.dart';
import 'package:mstack/data/repositories/category_repository.dart';
import 'package:mstack/logic/cubit/question_cubit/user_question_cubit.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';

class AddQuestionProvider extends ChangeNotifier {
  BuildContext context;
  AddQuestionProvider(this.context);

  TextEditingController questionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _repository = CategoryRepository();

  List<CategoryModel> _listCategory = [];

  String selectedCategory = "";

  fetchCategory() async {
    _listCategory = await _repository.getAllCategory();
    if (_listCategory.isNotEmpty) selectedCategory = _listCategory[0].sId;
    notifyListeners();
  }

  addQuestion() {
    final state =
        BlocProvider.of<UserCubit>(context).state as UserLoggedInState;
    String uid = state.userModel.sId!;
    String question = questionController.text.trim();
    String description = descriptionController.text.trim();
    BlocProvider.of<UserQuestionCubit>(context).addUserQuestion(
      cid: selectedCategory,
      description: description,
      question: question,
      uid: uid,
    );
  }

  onValueChanged(value) {
    selectedCategory = value;
    notifyListeners();
  }

  List<CategoryModel> get category => _listCategory;
}
