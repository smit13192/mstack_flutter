import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';

class LoginProvider extends ChangeNotifier {
  BuildContext context;
  LoginProvider(this.context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final form = GlobalKey<FormState>();

  bool seen = true;

  onChanged() {
    seen = !seen;
    notifyListeners();
  }

  sighIn() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<UserCubit>(context)
        .sighIn(email: email, password: password);
  }
}
