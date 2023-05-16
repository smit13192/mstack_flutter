import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/data/repositories/user_repository.dart';
import 'package:mstack/logic/service/local_service.dart';
import '../../../data/model/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _initialize();
  }
  final UserRepository _repository = UserRepository();

  _initialize() async {
    Map<String, dynamic> userdetails = await LocalStorage.fetchUserDetails();
    String? email = userdetails['email'];
    String? password = userdetails['password'];
    if (email == null || password == null) {
      emit(UserLoggedOutState());
    } else {
      sighIn(email: email, password: password);
    }
  }

  void _emitUserLoggedInState(
      {required UserModel userModel, required String password}) async {
    await LocalStorage.saveUserDetails(
        uid: userModel.sId!,
        username: userModel.username!,
        email: userModel.email!,
        password: password,
        age: userModel.age!);
    emit(UserLoggedInState(userModel));
  }

  void sighIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(UserLoadingState());
      UserModel userModel =
          await _repository.sighIn(email: email, password: password);
      _emitUserLoggedInState(userModel: userModel, password: password);
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  void createAccount({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    try {
      emit(UserLoadingState());
      UserModel userModel = await _repository.createAccount(
        email: email,
        password: password,
        age: age,
        username: username,
      );
      _emitUserLoggedInState(userModel: userModel, password: password);
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  void logOut() async {
    await LocalStorage.clearData();
    emit(UserLoggedOutState());
  }
}
