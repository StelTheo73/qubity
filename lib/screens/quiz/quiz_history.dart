import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
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
        return BaseScreen(
          title: AppLocalizations.of(context)!.quizHistory,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                if (snapshot.hasData)
                  if (snapshot.data!.isEmpty)
                    Center(
                      child: RobotoText(
                        text: AppLocalizations.of(context)!.quizHistoryEmpty,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
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
                            text:
                                '${quizScore.score}/${quizScore.noOfQuestions}',
                            fontSize: 20,
                            color: Palette.black,
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
