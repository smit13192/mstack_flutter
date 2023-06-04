import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';
import 'package:mstack/presentation/screens/auth/login_support.dart';
import 'package:mstack/presentation/screens/home_screen.dart';

import '../../core/constant/constant.dart';

class SpalshScrren extends StatelessWidget {
  static const String routeName = '/SplashScreen';
  const SpalshScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Timer(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
        } else if (state is UserLoggedOutState) {
          Timer(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginSupport.routeName, (route) => false);
          });
        } else if (state is UserErrorState) {
          Timer(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginSupport.routeName, (route) => false);
          });
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            appName,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
