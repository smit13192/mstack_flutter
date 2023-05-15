import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstack/data/model/question_model.dart';
import 'package:mstack/logic/cubit/question_cubit/question_cubit.dart';
import 'package:mstack/presentation/screens/add_question_screen.dart';
import 'package:mstack/providers/question_provider.dart';
import 'package:provider/provider.dart';

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
    context.read<QuestionProvider>().fetchLikeQuestionData();
    BlocProvider.of<QuestionCubit>(context).fetchQuestion();
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
      body: BlocBuilder<QuestionCubit, QuestionState>(
        builder: (context, state) {
          if (state is QuestionErrorState) {
            return Center(child: Text(state.message.toString()));
          } else if (state is QuestionLoaddedState) {
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
        BlocProvider.of<QuestionCubit>(context).fetchQuestion();
       },
      child: ListView.separated(
        physics:
            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          final question = questions[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  question.question,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  question.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<QuestionProvider>(
                  builder: (context, provider, child) {
                    int like = question.likes;
                    if (!question.userLikes.contains(provider.uid) &&
                        provider.likeQuestionsId.contains(question.sId)) {
                      like += 1;
                    } else if (question.userLikes.contains(provider.uid) &&
                        !provider.likeQuestionsId.contains(question.sId)) {
                      like -= 1;
                    }
                    return Row(
                      children: [
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            provider.addLike(sId: question.sId!);
                          },
                          child: Icon(
                            provider.likeQuestionsId.contains(question.sId)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("$like likes"),
                        const Spacer(),
                        Text(
                          question.cname,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(width: 10),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(thickness: 2);
        },
        itemCount: questions.length,
      ),
    );
  }
}
