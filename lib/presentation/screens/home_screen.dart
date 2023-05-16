import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/data/model/question_model.dart';
import 'package:mstack/logic/cubit/question_cubit/user_question_cubit.dart';
import 'package:mstack/presentation/screens/add_question_screen.dart';
import 'package:mstack/presentation/widgets/question_tile.dart';
import 'package:mstack/providers/user_like_question_provider.dart';

import '../../core/constant/constant.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserLikeQuestionProvider>().fetchLikeQuestionData();
    BlocProvider.of<UserQuestionCubit>(context).fetchQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          appName,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
        ),
      ),
      drawer: const Drawer(),
      body: BlocBuilder<UserQuestionCubit, UserQuestionState>(
        builder: (context, state) {
          if (state is UserQuestionErrorState) {
            return Center(child: Text(state.message.toString()));
          } else if (state is UserQuestionLoaddedState) {
            return buildQuestions(state.questions);
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black87));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AddQuestionScreen.routeName),
        backgroundColor: Colors.black87,
        tooltip: "Add Question",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildQuestions(List<QuestionModel> questions) {
    return RefreshIndicator(
      onRefresh: () async { 
        BlocProvider.of<UserQuestionCubit>(context).fetchQuestion();
       },
      child: ListView.separated(
        physics:
            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          final question = questions[index];
          return QuestionTile(question: question);
        },
        separatorBuilder: (context, index) {
          return const Divider(thickness: 2);
        },
        itemCount: questions.length,
      ),
    );
  }
}
