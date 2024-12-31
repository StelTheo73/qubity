import 'package:flutter/material.dart';

import '../../../models/quiz/quiz.dart';
import 'radio_group.dart';

class QuizRadioGroup extends StatelessWidget {
  const QuizRadioGroup({
    super.key,
    required this.question,
    required this.controller,
  });

  final Question question;
  final QuizController controller;

  void _setAnswer(int answer) {
    controller.setAnswer(
      question.id,
      question.correctAnswer,
      answer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      question: question.question,
      answers: question.answers,
      onChanged: _setAnswer,
      id: question.id,
    );
  }
}
