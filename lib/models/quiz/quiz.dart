import 'dart:convert';

import 'package:yaml/yaml.dart';

import '../../api/db_client.dart';
import '../../components/toast/score_save_toast.dart';
import '../../constants/assets.dart';
import '../../store/locale_notifier.dart';
import '../../utils/device_store.dart';
import '../../utils/utils.dart';
import '../schemas/quiz.dart';

class QuizController {
  final Map<int, bool> _answers = <int, bool>{};
  final Map<int, int> _selectedAnswers = <int, int>{};

  // The index of the selected answer in quiz question's answers list
  int? getSelectedAnswer(int questionId) {
    return _selectedAnswers[questionId];
  }

  void setAnswer(int questionId, int correctAnswer, int selectedAnswer) {
    _selectedAnswers[questionId] = selectedAnswer;
    _answers[questionId] = correctAnswer == selectedAnswer;
  }

  bool isAnswered(int questionId) {
    return _answers.containsKey(questionId);
  }

  bool isCorrect(int questionId) {
    return _answers[questionId]!;
  }

  bool isCompleted(int numberOfQuestions) {
    return _answers.length == numberOfQuestions;
  }

  Map<int, bool> get answers => _answers;

  int getScore() {
    return _answers.values.where((bool answer) => answer).length;
  }

  Future<DbClientResponse> saveScore(
    int correct,
    int total,
    DateTime date,
  ) async {
    final String userId = await DeviceStore.getUserId();
    final QuizSchema quizSchema = QuizSchema(
      userId: userId,
      correct: correct,
      total: total,
      date: date,
    );

    final DbClientResponse res = await DatabaseClient.insertScore(quizSchema);
    return res;
  }

  Future<void> onSubmit() async {
    final int score = getScore();
    final QuizScore quizScore = QuizScore(
      score: score,
      noOfQuestions: _answers.length,
      date: Utils.getUtcTime(),
    );
    // Save locally
    await quizScore.save();
    // Save to database
    final DbClientResponse res = await saveScore(
      score,
      _answers.length,
      quizScore.date,
    );

    final ScoreSaveToast toast = ScoreSaveToast(
      success: res.success,
      message: res.message,
    );
    await toast.show();
  }
}

class Question {
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  final int id;
  final String question;
  final List<String> answers;
  final int correctAnswer;
}

class QuizScore {
  QuizScore({
    required this.score,
    required this.noOfQuestions,
    required this.date,
  });

  final int score;
  final int noOfQuestions;
  final DateTime date;

  static Future<List<QuizScore>> load() async {
    return DeviceStore.getQuizScore();
  }

  String get formattedDate {
    final DateTime localDate = date.toLocal();
    return Utils.getFormattedDate(localDate);
  }

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'score': score,
      'date': date.toIso8601String(),
      'noOfQuestions': noOfQuestions,
    };
    return jsonEncode(data);
  }

  Future<void> save() async {
    await DeviceStore.setQuizScore(this);
  }
}

class Quiz {
  int numberOfQuestions = -1;

  static Question _buildQuestion(YamlMap question) {
    final String language = localeNotifier.locale.languageCode;

    return Question(
      id: question['id'] as int,
      question: question['question'][language] as String,
      answers:
          (question['answers'] as YamlList).value
              .map((dynamic answer) => answer[language] as String)
              .toList(),
      correctAnswer: question['correct'] as int,
    );
  }

  Future<List<Question>> load() async {
    final YamlMap quiz = await Utils.loadYamlMap(questionsPath);
    numberOfQuestions = (quiz['questions'] as YamlList).length;
    final List<Question> questions = <Question>[];

    for (int index = 0; index < numberOfQuestions; index++) {
      final YamlMap question = quiz['questions'][index] as YamlMap;
      questions.add(_buildQuestion(question));
    }

    return questions;
  }
}
