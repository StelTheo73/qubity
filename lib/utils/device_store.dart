import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../constants/spaceships.dart';
import '../models/quiz/quiz.dart';
import 'config.dart';

enum DeviceStoreKeys {
  language('language'),
  levelScores('levelScores'),
  onboardingCompleted('onboardingCompleted'),
  quizScore('quizScore'),
  spaceshipId('spaceship'),
  unlockedLevel('unlockedLevel'),
  userId('userId');

  const DeviceStoreKeys(this.key);

  final String key;
}

class DeviceStore {
  static final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  // Public Methods
  // --------------

  static Future<void> init() async {
    await _setupDeviceStore();
  }

  static Future<String> getLanguage() async {
    return await prefs.getString(DeviceStoreKeys.language.key) ??
        Configuration.defaultLanguage;
  }

  static Future<double> getLevelScore(int level) async {
    final Map<String, double> scores = await getLevelScores();
    return scores[level.toString()] ?? 0.0;
  }

  static Future<Map<String, double>> getLevelScores() async {
    final String scoresString =
        await prefs.getString(DeviceStoreKeys.levelScores.key) ?? '{}';
    final Map<String, dynamic> scoresMap =
        jsonDecode(scoresString) as Map<String, dynamic>;
    return scoresMap.map(
      (String key, dynamic value) =>
          MapEntry<String, double>(key, double.parse(value.toString())),
    );
  }

  static Future<bool> getOnboardingCompleted() async {
    return await prefs.getBool(DeviceStoreKeys.onboardingCompleted.key) ??
        false;
  }

  static Future<List<QuizScore>> getQuizScore() async {
    final String quizScoreString =
        await prefs.getString(DeviceStoreKeys.quizScore.key) ?? '[]';
    final List<dynamic> quizScoreList =
        jsonDecode(quizScoreString) as List<dynamic>;

    final List<QuizScore> quizScores = <QuizScore>[];
    for (final dynamic quizScore in quizScoreList) {
      quizScores.add(
        QuizScore(
          score: quizScore['score'] as int,
          noOfQuestions: (quizScore['noOfQuestions'] ?? 0) as int,
          date: DateTime.parse(quizScore['date'] as String),
        ),
      );
    }

    return quizScores;
  }

  static Future<int> getUnlockedLevel() async {
    return (await prefs.getInt(DeviceStoreKeys.unlockedLevel.key)) ?? 1;
  }

  static Future<String> getUserId() async {
    return await prefs.getString(DeviceStoreKeys.userId.key) ?? _createUserId();
  }

  static Future<void> setLanguage(String language) async {
    await prefs.setString(DeviceStoreKeys.language.key, language);
  }

  static Future<void> setLevelScore(int level, double score) async {
    final Map<String, double> scores = await getLevelScores();
    scores[level.toString()] = score;
    await prefs.setString(DeviceStoreKeys.levelScores.key, jsonEncode(scores));
  }

  static Future<void> setOnboardingCompleted() async {
    await prefs.setBool(DeviceStoreKeys.onboardingCompleted.key, true);
  }

  static Future<void> setQuizScore(QuizScore quizScore) async {
    final List<QuizScore> scores = await getQuizScore();
    scores.add(quizScore);

    if (scores.length > Configuration.maxQuizScoreHistory) {
      scores.removeAt(0);
    }

    final String scoresString =
        '[${scores.map((QuizScore score) => score.toJson()).join(',')}]';

    await prefs.setString(DeviceStoreKeys.quizScore.key, scoresString);
  }

  static Future<void> setUnlockedLevel(int level) async {
    await prefs.setInt(DeviceStoreKeys.unlockedLevel.key, level);
  }

  static Future<void> resetDeviceStore() async {
    Future.wait(<Future<void>>[
      prefs.setInt(DeviceStoreKeys.unlockedLevel.key, 1),
      prefs.setString(DeviceStoreKeys.spaceshipId.key, defaultSpaceshipId),
      prefs.setString(DeviceStoreKeys.levelScores.key, '{}'),
      prefs.setString(DeviceStoreKeys.quizScore.key, '[]'),
      prefs.setString(DeviceStoreKeys.userId.key, ''),
    ]);
  }

  // Private Methods
  // ---------------
  static Future<String> _createUserId() async {
    final String userId = const Uuid().v4();
    await prefs.setString(DeviceStoreKeys.userId.key, userId);
    return userId;
  }

  static Future<void> _setupDeviceStore() async {
    final String language =
        await prefs.getString(DeviceStoreKeys.language.key) ?? '';
    if (language.isEmpty) {
      await prefs.setString(
        DeviceStoreKeys.language.key,
        Configuration.defaultLanguage,
      );
    }

    final int level =
        await prefs.getInt(DeviceStoreKeys.unlockedLevel.key) ?? -1;
    if (level == -1) {
      await prefs.setInt(DeviceStoreKeys.unlockedLevel.key, 1);
    }

    final bool onboardingCompleted =
        await prefs.getBool(DeviceStoreKeys.onboardingCompleted.key) ?? false;
    if (!onboardingCompleted) {
      await prefs.setBool(DeviceStoreKeys.onboardingCompleted.key, false);
    }

    final String quizScore =
        await prefs.getString(DeviceStoreKeys.quizScore.key) ?? '';
    if (quizScore.isEmpty) {
      await prefs.setString(DeviceStoreKeys.quizScore.key, '[]');
    }

    final String spaceship =
        await prefs.getString(DeviceStoreKeys.spaceshipId.key) ?? '';
    if (spaceship.isEmpty) {
      await prefs.setString(
        DeviceStoreKeys.spaceshipId.key,
        defaultSpaceshipId,
      );
    }

    final String scoresString =
        await prefs.getString(DeviceStoreKeys.levelScores.key) ?? '{}';
    final Map<String, dynamic> scoresMap =
        jsonDecode(scoresString) as Map<String, dynamic>;
    if (scoresMap.isEmpty) {
      await prefs.setString(DeviceStoreKeys.levelScores.key, '{}');
    }

    final String userId =
        await prefs.getString(DeviceStoreKeys.userId.key) ?? '';
    if (userId.isEmpty) {
      await _createUserId();
    }
  }
}
