import 'package:flutter/material.dart';

import '../../components/button/base_button.dart';
import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
import '../../models/quiz/quiz.dart';
import '../../store/quiz_submission_notifier.dart';
import 'components/answer.dart';

class QuizResults extends StatefulWidget {
  const QuizResults({
    super.key,
    required this.quiz,
    required this.quizController,
    required this.questions,
  });

  final Quiz quiz;
  final QuizController quizController;
  final List<Question> questions;

  @override
  State<QuizResults> createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {
  @override
  Widget build(BuildContext context) {
    final int score = widget.quizController.getScore();
    final int total = widget.questions.length;
    final String percentage = ((score / total) * 100).toStringAsFixed(2);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }

        quizSubmissionNotifier.reset();
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              RobotoText(
                text: 'Your score is: $percentage%',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              RobotoText(
                text: 'You found $score out of $total',
                fontSize: 16,
                color: Palette.black,
              ),
              const SizedBox(height: 10),
              for (final Question question in widget.questions)
                Answer(
                  question: question.question,
                  correctAnswer: question.answers[question.correctAnswer],
                  selectedAnswer: question.answers[
                      widget.quizController.getSelectedAnswer(question.id)!],
                ),
              const SizedBox(height: 20),
              BaseButton(
                text: 'Back',
                onPressed: () {
                  quizSubmissionNotifier.reset();
                  Navigator.pop(context);
                },
                width: 200,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
