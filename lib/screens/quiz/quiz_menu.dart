import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
import '../../constants/routes.dart';
import '../base.dart';

class QuizMenuScreen extends StatefulWidget {
  const QuizMenuScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QuizMenuScreenState();
}

class _QuizMenuScreenState extends State<QuizMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.quiz,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Card(
            elevation: 2.0,
            color: Palette.white,
            child: ListTile(
              title: RobotoText(
                text: AppLocalizations.of(context)!.testYourKnowledge,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              subtitle: RobotoText(
                text: AppLocalizations.of(context)!.takeQuiz,
                fontSize: 16,
                color: Palette.black,
              ),
              trailing: const Icon(Icons.quiz),
              onTap: () {
                Navigator.pushNamed(context, AppRoute.quiz.route);
              },
            ),
          ),
          Card(
            elevation: 2.0,
            color: Palette.white,
            child: ListTile(
              title: RobotoText(
                text: AppLocalizations.of(context)!.quizHistory,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              subtitle: RobotoText(
                text: AppLocalizations.of(context)!.quizHistoryView,
                fontSize: 16,
                color: Palette.black,
              ),
              trailing: const Icon(Icons.history),
              onTap: () {
                Navigator.pushNamed(context, AppRoute.quizHistory.route);
              },
            ),
          ),
        ],
      ),
    );
  }
}
