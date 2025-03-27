// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get continuePrompt => 'Συνέχεια';

  @override
  String correctAnswer(Object correctAnswer) {
    return 'Σωστή απάντηση: $correctAnswer';
  }

  @override
  String get delete => 'Διαγραφή';

  @override
  String get deleteGameData => 'Διαγραφή Δεδομένων';

  @override
  String get deleteGameDataConfirmation => 'Είστε σίγουροι ότι θέλετε να διαγράψετε όλα τα δεδομένα του παιχνιδιού;';

  @override
  String get deleteGameDataHeader => 'Διαγραφή Δεδομένων Παιχνιδιού';

  @override
  String get exit => 'Έξοδος';

  @override
  String get gameCompleted => 'Ολοκληρώσατε το παιχνίδι!';

  @override
  String get help => 'Βοήθεια';

  @override
  String get levelCompleted => 'Ολοκλήρωση επιπέδου!';

  @override
  String levelGatesList(Object gates) {
    return 'Πύλες: $gates';
  }

  @override
  String levelId(Object levelId) {
    return 'Επίπεδο $levelId';
  }

  @override
  String get levelNewHighScore => 'Νέο Ρεκόρ!';

  @override
  String get levelSelection => 'Επίπεδα';

  @override
  String get levels => 'Επίπεδα';

  @override
  String get next => 'Επόμενο';

  @override
  String get nextLevel => 'Επόμενο';

  @override
  String get onboarding => 'Εισαγωγή';

  @override
  String get previous => 'Προηγούμενο';

  @override
  String questionId(Object questionId) {
    return 'Ερώτηση $questionId';
  }

  @override
  String get quiz => 'Κουίζ';

  @override
  String get quizHistory => 'Ιστορικό';

  @override
  String get quizHistoryEmpty => 'Δεν υπάρχουν προηγούμενα αποτελέσματα κουίζ';

  @override
  String get quizHistoryView => 'Προβολή προηγούμενων αποτελεσμάτων';

  @override
  String get quizScoreSavedMessage => 'Το σκορ σας αποθηκεύτηκε με επιτυχία!';

  @override
  String get quizScoreErrorMessage => 'Αποτυχία αποθήκευσης στη βάση δεδομένων:';

  @override
  String get restart => 'Επανεκκίνηση';

  @override
  String get restartLevel => 'Επανεκκίνηση';

  @override
  String get resume => 'Συνέχεια';

  @override
  String get selectAllAnswers => 'Παρακαλώ απαντήστε σε όλες τις ερωτήσεις πριν υποβάλετε';

  @override
  String get selectAnAnswer => 'Παρακαλώ επιλέξτε μια απάντηση';

  @override
  String get selectLanguage => 'Επιλογή Γλώσσας';

  @override
  String get settings => 'Ρυθμίσεις';

  @override
  String get spaceships => 'Διαστημόπλοια';

  @override
  String get spaceshipSelect => 'Επιλογή Διαστημοπλοίου';

  @override
  String get spaceshipUnlockedTitle => 'Νέο διαστημόπλοιο διαθέσιμο!';

  @override
  String get spaceshipUnlockedMessage => 'Θα το βρείτε στην οθόνη επιλογής διαστημοπλοίων';

  @override
  String get startGame => 'Ξεκινήστε';

  @override
  String get startLevel => 'Έναρξη';

  @override
  String get submit => 'Υποβολή';

  @override
  String get takeQuiz => 'Κάντε ένα κουίζ για να ελέγξετε τις γνώσεις σας';

  @override
  String get testYourKnowledge => 'Ελέγξτε τις γνώσεις σας';

  @override
  String get tutorial => 'Επίδειξη';

  @override
  String get welcome => 'Καλώς ήρθατε στο Qubity!';

  @override
  String get welcomeSelectLanguage => 'Παρακαλώ επιλέξτε την προτιμώμενη γλώσσα';

  @override
  String get welcomeChangeLater => 'Μπορείτε να την αλλάξετε αργότερα στις ρυθμίσεις';

  @override
  String youFound(Object correctAnswers, Object totalQuestions) {
    return 'Βρήκατε $correctAnswers από $totalQuestions';
  }

  @override
  String get yourScore => 'Το σκορ σας:';

  @override
  String yourScoreIs(Object percentage) {
    return 'Το σκορ σας είναι: $percentage%';
  }
}
