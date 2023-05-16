import 'package:flutter/cupertino.dart';
import 'package:mstack/presentation/screens/add_question_screen.dart';
import 'package:mstack/presentation/screens/auth/login_support.dart';
import 'package:mstack/presentation/screens/home_screen.dart';
import 'package:mstack/presentation/screens/splash_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    String name = settings.name!;
    switch (name) {
      case LoginSupport.routeName:
        return CupertinoPageRoute(
          builder: (context) => const LoginSupport(),
        );
      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SpalshScrren.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SpalshScrren(),
        );
      case AddQuestionScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const AddQuestionScreen(),
        );
      default:
        return null;
    }
  }
}
