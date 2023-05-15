import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';

class RegisterProvider extends ChangeNotifier {
  BuildContext context;
  RegisterProvider(this.context);

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final form = GlobalKey<FormState>();

  bool seen = true;
  bool confirmSeen = true;

  onChanged() {
    seen = !seen;
    notifyListeners();
  }

  onChangedConfirm() {
    confirmSeen = !confirmSeen;
    notifyListeners();
  }

  createAccount() {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    int age = int.parse(ageController.text.trim());
    BlocProvider.of<UserCubit>(context).createAccount(
        username: username, email: email, password: password, age: age);
  }
}
