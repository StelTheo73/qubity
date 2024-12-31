import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/quiz/quiz.dart';
import '../../store/quiz_submission_notifier.dart';
import '../base.dart';
import 'quiz_form.dart';
import 'quiz_results.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizController _quizController = QuizController();
  final Quiz _quiz = Quiz();

  late Future<List<Question>> questionsFuture;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  void _loadQuiz() {
    setState(() {
      questionsFuture = _quiz.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: quizSubmissionNotifier,
      builder: (BuildContext context, Widget? child) {
        return BaseScreen(
          title: AppLocalizations.of(context)!.testYourKnowledge,
          hasBackground: false,
          body: FutureBuilder<List<Question>>(
            future: questionsFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              if (snapshot.hasData) {
                return quizSubmissionNotifier.isSubmitted
                    ? QuizResults(
                        quiz: _quiz,
                        quizController: _quizController,
                        questions: snapshot.data!,
                      )
                    : QuizForm(
                        quiz: _quiz,
                        quizController: _quizController,
                        questions: snapshot.data!,
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
