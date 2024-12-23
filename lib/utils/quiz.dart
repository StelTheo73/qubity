import 'package:yaml/yaml.dart';

import '../constants/assets.dart';
import '../store/locale_notifier.dart';
import 'utils.dart';

class QuizController {
  final Map<int, bool> _answers = <int, bool>{};

  void setAnswer(int questionId, int correctAnswer, int selectedAnswer) {
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

class Quiz {
  static Question _buildQuestion(YamlMap question) {
    final String language = localeNotifier.locale.languageCode;

    return Question(
      id: question['id'] as int,
      question: question['question'][language] as String,
      answers: (question['answers'] as YamlList)
          .value
          .map((dynamic answer) => answer[language] as String)
          .toList(),
      correctAnswer: question['correct'] as int,
    );
  }

  static Future<List<Question>> load() async {
    final YamlMap quiz = await Utils.loadYamlMap(questionsPath);
    final int numberOfQuestions = (quiz['questions'] as YamlList).length;
    final List<Question> questions = <Question>[];

    for (int index = 0; index < numberOfQuestions; index++) {
      final YamlMap question = quiz['questions'][index] as YamlMap;
      questions.add(_buildQuestion(question));
    }
    return questions;
  }
}
