import 'package:flutter/material.dart';

import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/quiz/quiz.dart';
import '../base.dart';

class QuizHistoryScreen extends StatefulWidget {
  const QuizHistoryScreen({super.key});

  @override
  State<QuizHistoryScreen> createState() => _QuizHistoryScreenState();
}

class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
  late Future<List<QuizScore>> quizHistoryFuture;

  @override
  void initState() {
    super.initState();
    _loadQuizHistory();
  }

  void _loadQuizHistory() {
    setState(() {
      quizHistoryFuture = QuizScore.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizScore>>(
      future: quizHistoryFuture,
      builder: (BuildContext context, AsyncSnapshot<List<QuizScore>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return BaseScreen(
            title: AppLocalizations.of(context)!.quizHistory,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: RobotoText(
                    text: AppLocalizations.of(context)!.quizHistoryEmpty,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          return BaseScreen(
            title: AppLocalizations.of(context)!.quizHistory,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                for (final QuizScore quizScore in snapshot.data!.reversed)
                  Card(
                    elevation: 2.0,
                    color: Palette.white,
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          RobotoText(
                            text: AppLocalizations.of(context)!.yourScore,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.black,
                          ),
                          const SizedBox(width: 5),
                          RobotoText(
                            text:
                                '${(quizScore.score / quizScore.noOfQuestions * 100).toStringAsFixed(2)}%',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      subtitle: RobotoText(
                        text: quizScore.formattedDate,
                        fontSize: 16,
                        color: Palette.black,
                      ),
                      trailing: RobotoText(
                        text: '${quizScore.score}/${quizScore.noOfQuestions}',
                        fontSize: 20,
                        color: Palette.black,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      },
    );
  }
}
