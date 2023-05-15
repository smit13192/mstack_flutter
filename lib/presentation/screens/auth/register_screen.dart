import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/constant.dart';
import '../../../logic/cubit/user_cubit/user_cubit.dart';
import '../../../providers/auth/register_provider.dart';
import '../../widgets/bottom_line.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_field.dart';
import '../home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback onTap;

  const RegisterScreen({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    RegisterProvider provider = Provider.of<RegisterProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Fluttertoast.showToast(msg: "Log in successfully");
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        } else if (state is UserErrorState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: provider.form,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
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
                        keyboardType: TextInputType.name,
                        controller: provider.usernameController,
                        validator: (value) =>
                            (value!.isEmpty || value.contains(" "))
                                ? "Enter valid username"
                                : null,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => provider.usernameController.clear(),
                        ),
                        hintText: "Enter username",
                      ),
                      const SizedBox(height: 16),
                      PrimaryField(
                        keyboardType: TextInputType.emailAddress,
                        controller: provider.emailController,
                        validator: (value) => !EmailValidator.validate(value!)
                            ? "Enter valid email"
                            : null,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => provider.emailController.clear(),
                        ),
                        hintText: "Enter Email",
                      ),
                      const SizedBox(height: 16),
                      PrimaryField(
                        keyboardType: TextInputType.visiblePassword,
                        seen: provider.seen,
                        controller: provider.passwordController,
                        validator: (value) {
                          if (value!.isEmpty || value.contains(" ")) {
                            return "Enter valid password";
                          }
                          if (value.length < 8) {
                            return "Password length must be more than 7";
                          }
                          if (value != provider.confirmPasswordController.text) {
                            return "Password and confirm password different";
                          }
                          return null;
                        },
                        hintText: 'Enter Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            provider.seen
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: provider.onChanged,
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryField(
                        keyboardType: TextInputType.visiblePassword,
                        seen: provider.confirmSeen,
                        controller: provider.confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty || value.contains(" ")) {
                            return "Enter valid password";
                          }
                          if (value.length < 8) {
                            return "Password length must be more than 7";
                          }
                          if (value != provider.passwordController.text) {
                            return "Password and confirm password different";
                          }
                          return null;
                        },
                        hintText: 'Enter confirm password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            provider.confirmSeen
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: provider.onChangedConfirm,
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryField(
                        keyboardType: TextInputType.number,
                        controller: provider.ageController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter valid age";
                          }
                          if (int.parse(value) <= 0) {
                            return "age is not minimun than zero";
                          }
                          if (int.parse(value) > 100) {
                            return "Enter valid age";
                          }
                          return null;
                        },
                        hintText: 'Enter age',
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        onTap: () {
                          if (provider.form.currentState!.validate()) {
                            provider.createAccount();
                          }
                        },
                        text: "Log In",
                      ),
                      const SizedBox(height: 10),
                      BottomLine(
                        text1: "You have an account ",
                        text2: "Sigh In",
                        onTap: onTap,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
