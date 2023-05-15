import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mstack/core/router/router.dart';
import 'package:mstack/logic/cubit/question_cubit/question_cubit.dart';
import 'package:mstack/logic/cubit/user_cubit/user_cubit.dart';
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
        BlocProvider(create: (context) => QuestionCubit()),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SpalshScrren.routeName,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log("change in $bloc: $change");
    super.onChange(bloc, change);
  }
}
