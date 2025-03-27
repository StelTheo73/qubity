import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_el.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('el'),
    Locale('en')
  ];

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'Correct answer: {correctAnswer}'**
  String correctAnswer(Object correctAnswer);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteGameData.
  ///
  /// In en, this message translates to:
  /// **'Delete Data'**
  String get deleteGameData;

  /// No description provided for @deleteGameDataConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all game data?'**
  String get deleteGameDataConfirmation;

  /// No description provided for @deleteGameDataHeader.
  ///
  /// In en, this message translates to:
  /// **'Delete Game Data'**
  String get deleteGameDataHeader;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @gameCompleted.
  ///
  /// In en, this message translates to:
  /// **'You have completed the game!'**
  String get gameCompleted;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @levelCompleted.
  ///
  /// In en, this message translates to:
  /// **'Level Completed!'**
  String get levelCompleted;

  /// No description provided for @levelGatesList.
  ///
  /// In en, this message translates to:
  /// **'Gates: {gates}'**
  String levelGatesList(Object gates);

  /// No description provided for @levelId.
  ///
  /// In en, this message translates to:
  /// **'Level {levelId}'**
  String levelId(Object levelId);

  /// No description provided for @levelNewHighScore.
  ///
  /// In en, this message translates to:
  /// **'New High Score!'**
  String get levelNewHighScore;

  /// No description provided for @levelSelection.
  ///
  /// In en, this message translates to:
  /// **'Level Selection'**
  String get levelSelection;

  /// No description provided for @levels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get levels;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @nextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next Level'**
  String get nextLevel;

  /// No description provided for @questionId.
  ///
  /// In en, this message translates to:
  /// **'Question {questionId}'**
  String questionId(Object questionId);

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @quizHistory.
  ///
  /// In en, this message translates to:
  /// **'Previous Quiz Results'**
  String get quizHistory;

  /// No description provided for @quizHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No previous quiz results'**
  String get quizHistoryEmpty;

  /// No description provided for @quizHistoryView.
  ///
  /// In en, this message translates to:
  /// **'View previous quiz results'**
  String get quizHistoryView;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// No description provided for @restartLevel.
  ///
  /// In en, this message translates to:
  /// **'Restart Level'**
  String get restartLevel;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @selectAllAnswers.
  ///
  /// In en, this message translates to:
  /// **'Please answer all questions before submitting'**
  String get selectAllAnswers;

  /// No description provided for @selectAnAnswer.
  ///
  /// In en, this message translates to:
  /// **'Please select an answer'**
  String get selectAnAnswer;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @spaceships.
  ///
  /// In en, this message translates to:
  /// **'Spaceships'**
  String get spaceships;

  /// No description provided for @spaceshipSelect.
  ///
  /// In en, this message translates to:
  /// **'Select a Spaceship'**
  String get spaceshipSelect;

  /// No description provided for @spaceshipUnlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'New spaceship unlocked!'**
  String get spaceshipUnlockedTitle;

  /// No description provided for @spaceshipUnlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Check it out in the spaceship selection screen'**
  String get spaceshipUnlockedMessage;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey'**
  String get startJourney;

  /// No description provided for @startLevel.
  ///
  /// In en, this message translates to:
  /// **'Start Level'**
  String get startLevel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @takeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Take a quiz to test your knowledge'**
  String get takeQuiz;

  /// No description provided for @testYourKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Test Your Knowledge'**
  String get testYourKnowledge;

  /// No description provided for @tutorial.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// No description provided for @youFound.
  ///
  /// In en, this message translates to:
  /// **'You found {correctAnswers} out of {totalQuestions}'**
  String youFound(Object correctAnswers, Object totalQuestions);

  /// No description provided for @yourScore.
  ///
  /// In en, this message translates to:
  /// **'Your Score:'**
  String get yourScore;

  /// No description provided for @yourScoreIs.
  ///
  /// In en, this message translates to:
  /// **'Your score is: {percentage}%'**
  String yourScoreIs(Object percentage);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['el', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'el': return AppLocalizationsEl();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
