import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/button/base_button.dart';
import '../../components/form/radio/quiz_radio_group.dart';
import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
import '../../utils/quiz.dart';
import '../base.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<Question>> questionsFuture;
  late final QuizController _quizController = QuizController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Quiz _quiz = Quiz();
  final ScrollController _scrollController = ScrollController();

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  void _loadQuiz() {
    setState(() {
      questionsFuture = _quiz.load();
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _submitForm() {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_quizController.isCompleted(_quiz.numberOfQuestions)) {
        _quizController.onSubmit();
      } else {
        setState(() {
          _errorMessage = 'Please answer all questions before submitting.';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Please answer all questions before submitting.';
      });
    }
    _scrollToTop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.of(context)!.testYourKnowledge,
      hasBackground: false,
      body: FutureBuilder<List<Question>>(
        future: questionsFuture,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Question>> snapshot,
        ) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RobotoText(
                          text: _errorMessage!,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Palette.danger,
                        ),
                      ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 40,
                        ),
                        child: Column(
                          children: <Widget>[
                            for (final Question question in snapshot.data!)
                              QuizRadioGroup(
                                question: question,
                                controller: _quizController,
                              ),
                            const SizedBox(height: 20),
                            BaseButton(
                              onPressed: _submitForm,
                              text: AppLocalizations.of(context)!.submit,
                              width: 200,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
