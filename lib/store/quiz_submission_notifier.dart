import 'package:flutter/material.dart';

class QuizSubmissionNotifier extends ChangeNotifier {
  bool isSubmitted = false;

  void submit() {
    isSubmitted = true;
    notifyListeners();
  }

  void reset() {
    isSubmitted = false;
    notifyListeners();
  }
}

final QuizSubmissionNotifier quizSubmissionNotifier = QuizSubmissionNotifier();
