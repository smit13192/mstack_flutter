import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mstack/presentation/screens/home_screen.dart';
import 'package:mstack/presentation/widgets/bottom_line.dart';
import 'package:mstack/presentation/widgets/primary_button.dart';
import 'package:mstack/presentation/widgets/primary_field.dart';
import 'package:mstack/providers/auth/login_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/constant.dart';
import '../../../logic/cubit/user_cubit/user_cubit.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onTap;

  const LoginScreen({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Fluttertoast.showToast(msg: 'Sigh in successfully');
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        } else if (state is UserErrorState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Form(
          key: provider.form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  appName,
                  style: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 2,
                    fontSize: 35,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 30),
                PrimaryField(
                  keyboardType: TextInputType.emailAddress,
                  controller: provider.emailController,
                  validator: (value) => !EmailValidator.validate(value!)
                      ? 'Enter valid email'
                      : null,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => provider.emailController.clear(),
                  ),
                  hintText: 'Enter Email',
                ),
                const SizedBox(height: 16),
                PrimaryField(
                  keyboardType: TextInputType.visiblePassword,
                  seen: provider.seen,
                  controller: provider.passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.contains(' ')) {
                      return 'Enter valid password';
                    }
                    if (value.length < 8) {
                      return 'Password length must be more than 7';
                    }
                    return null;
                  },
                  hintText: 'Enter Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      provider.seen ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: provider.onChanged,
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onTap: () {
                    if (provider.form.currentState!.validate()) {
                      provider.sighIn();
                    }
                  },
                  text: 'Sign In',
                ),
                const SizedBox(height: 10),
                BottomLine(
                  text1: "Don't have an account? ",
                  text2: 'Log In',
                  onTap: onTap,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
