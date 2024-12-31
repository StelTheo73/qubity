import 'package:flutter/material.dart';

import '../../components/button/base_button.dart';
import '../../components/text/roboto.dart';
import '../../models/quiz/quiz.dart';
import '../../store/quiz_submission_notifier.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            RobotoText(
              text: 'Your score is: ${widget.quizController.getScore()}',
            ),
            const SizedBox(height: 20),
            for (final Question question in widget.questions)
              Column(
                children: <Widget>[
                  Text(question.question),
                  Text(
                    'Correct answer: ${question.answers[question.correctAnswer]}',
                  ),
                  Text(
                    'Your answer was: ${widget.quizController.isCorrect(question.id)}',
                  ),
                  Text(
                    'You selected: ${question.answers[widget.quizController.getSelectedAnswer(question.id)!]}',
                  ),
                  const SizedBox(height: 20),
                ],
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
          ],
        ),
      ),
    );
  }
}
