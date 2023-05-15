import 'package:flutter/material.dart';
import 'package:mstack/presentation/widgets/primary_button.dart';
import 'package:mstack/providers/add_question_provider.dart';
import 'package:provider/provider.dart';

class AddQuestionScreen extends StatefulWidget {
  static const String routeName = "/AddQuestionScreen";
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  @override
  void initState() {
    context.read<AddQuestionProvider>().fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddQuestionProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Add Question",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: provider.questionController,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Question",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: TextFormField(
                      controller: provider.descriptionController,
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      maxLines: null,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Description",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton(
                    value: provider.selectedCategory,
                    items: provider.category
                        .map<DropdownMenuItem>(
                          (category) => DropdownMenuItem(
                            value: category.sId,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                    onChanged: provider.onValueChanged,
                    itemHeight: 60,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    onTap: () {
                      provider.addQuestion();
                      Navigator.pop(context);
                    },
                    text: "Add Question",
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
