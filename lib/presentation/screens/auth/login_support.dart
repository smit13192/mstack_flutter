import 'package:flutter/material.dart';

import 'login_page.dart';
import 'register_screen.dart';

class LoginSupport extends StatefulWidget {
  static const String routeName = '/LoginSupport';
  const LoginSupport({super.key});

  @override
  State<LoginSupport> createState() => _LoginSupportState();
}

class _LoginSupportState extends State<LoginSupport> {
  bool isLogin = true;

  onTap() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(onTap: onTap);
    } else {
      return RegisterScreen(onTap: onTap);
    }
  }
}
