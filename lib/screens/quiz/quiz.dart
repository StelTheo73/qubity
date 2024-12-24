import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/button/base_button.dart';
import '../../components/form/radio/quiz_radio_group.dart';
import '../../utils/quiz.dart';
import '../base.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<Question>> quizFuture;
  late final QuizController _quizController = QuizController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  void _loadQuiz() {
    setState(() {
      quizFuture = Quiz.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.testYourKnowledge,
      hasBackground: false,
      body: FutureBuilder<List<Question>>(
        future: quizFuture,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Question>> snapshot,
        ) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          for (final Question question in snapshot.data!)
                            QuizRadioGroup(
                              question: question,
                              controller: _quizController,
                            ),
                          const SizedBox(height: 20),
                          BaseButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                              _quizController.onSubmit();
                            },
                            text: AppLocalizations.of(context)!.submit,
                            width: 200,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
