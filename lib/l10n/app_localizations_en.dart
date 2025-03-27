// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get continuePrompt => 'Continue';

  @override
  String correctAnswer(Object correctAnswer) {
    return 'Correct answer: $correctAnswer';
  }

  @override
  String get delete => 'Delete';

  @override
  String get deleteGameData => 'Delete Data';

  @override
  String get deleteGameDataConfirmation => 'Are you sure you want to delete all game data?';

  @override
  String get deleteGameDataHeader => 'Delete Game Data';

  @override
  String get exit => 'Exit';

  @override
  String get gameCompleted => 'You have completed the game!';

  @override
  String get help => 'Help';

  @override
  String get levelCompleted => 'Level Completed!';

  @override
  String levelGatesList(Object gates) {
    return 'Gates: $gates';
  }

  @override
  String levelId(Object levelId) {
    return 'Level $levelId';
  }

  @override
  String get levelNewHighScore => 'New High Score!';

  @override
  String get levelSelection => 'Level Selection';

  @override
  String get levels => 'Levels';

  @override
  String get next => 'Next';

  @override
  String get nextLevel => 'Next Level';

  @override
  String get onboarding => 'Onboarding';

  @override
  String get previous => 'Previous';

  @override
  String questionId(Object questionId) {
    return 'Question $questionId';
  }

  @override
  String get quiz => 'Quiz';

  @override
  String get quizHistory => 'Previous Quiz Results';

  @override
  String get quizHistoryEmpty => 'No previous quiz results';

  @override
  String get quizHistoryView => 'View previous quiz results';

  @override
  String get quizScoreSavedMessage => 'Your score has been saved successfully!';

  @override
  String get quizScoreErrorMessage => 'Failed to save to database:';

  @override
  String get restart => 'Restart';

  @override
  String get restartLevel => 'Restart Level';

  @override
  String get resume => 'Resume';

  @override
  String get selectAllAnswers => 'Please answer all questions before submitting';

  @override
  String get selectAnAnswer => 'Please select an answer';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get settings => 'Settings';

  @override
  String get spaceships => 'Spaceships';

  @override
  String get spaceshipSelect => 'Select a Spaceship';

  @override
  String get spaceshipUnlockedTitle => 'New spaceship unlocked!';

  @override
  String get spaceshipUnlockedMessage => 'Check it out in the spaceship selection screen';

  @override
  String get startGame => 'Start';

  @override
  String get startLevel => 'Start Level';

  @override
  String get submit => 'Submit';

  @override
  String get takeQuiz => 'Take a quiz to test your knowledge';

  @override
  String get testYourKnowledge => 'Test Your Knowledge';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get welcome => 'Welcome to Qubity!';

  @override
  String get welcomeSelectLanguage => 'Please select your preferred language';

  @override
  String get welcomeChangeLater => 'You can change this later in the settings';

  @override
  String youFound(Object correctAnswers, Object totalQuestions) {
    return 'You found $correctAnswers out of $totalQuestions';
  }

  @override
  String get yourScore => 'Your Score:';

  @override
  String yourScoreIs(Object percentage) {
    return 'Your score is: $percentage%';
  }
}
