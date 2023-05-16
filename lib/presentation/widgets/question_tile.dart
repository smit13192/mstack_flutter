import 'package:flutter/material.dart';
import 'package:mstack/data/model/question_model.dart';
import 'package:provider/provider.dart';

import '../../providers/user_like_question_provider.dart';

class QuestionTile extends StatelessWidget {
  final QuestionModel question;
  const QuestionTile({required this.question, super.key});

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          Consumer<UserLikeQuestionProvider>(
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
  }
}
