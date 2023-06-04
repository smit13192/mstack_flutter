import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mstack/core/router/router.dart';
import 'package:mstack/logic/cubit/question_cubit/user_question_cubit.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';
import 'package:mstack/providers/add_question_provider.dart';
import 'package:mstack/providers/auth/login_provider.dart';
import 'package:mstack/providers/auth/register_provider.dart';
import 'package:mstack/providers/user_like_question_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/splash_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => UserQuestionCubit()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LoginProvider(context),
          ),
          ChangeNotifierProvider(
            create: (context) => RegisterProvider(context),
          ),
          ChangeNotifierProvider(
            create: (context) => UserLikeQuestionProvider(context),
          ),
          ChangeNotifierProvider(
            create: (context) => AddQuestionProvider(context),
          )
        ],
        child: MaterialApp(
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SpalshScrren.routeName,
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('change in $bloc: $change');
    super.onChange(bloc, change);
  }
}
