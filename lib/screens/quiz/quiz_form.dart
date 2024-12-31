import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/button/base_button.dart';
import '../../components/form/radio/quiz_radio_group.dart';
import '../../components/text/roboto.dart';
import '../../constants/colors.dart';
import '../../models/quiz/quiz.dart';
import '../../store/quiz_submission_notifier.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({
    super.key,
    required this.quiz,
    required this.quizController,
    required this.questions,
  });

  final Quiz quiz;
  final QuizController quizController;
  final List<Question> questions;

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  String? _errorMessage;

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
      if (widget.quizController.isCompleted(widget.quiz.numberOfQuestions)) {
        quizSubmissionNotifier.submit();
        widget.quizController.onSubmit();
        return;
      }
    }

    setState(() {
      _errorMessage = AppLocalizations.of(context)!.selectAllAnswers;
    });
    _scrollToTop();
  }

  @override
  Widget build(BuildContext context) {
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
                    for (final Question question in widget.questions)
                      QuizRadioGroup(
                        question: question,
                        controller: widget.quizController,
                      ),
                    const SizedBox(height: 20),
                    BaseButton(
                      onPressed: _submitForm,
                      text: AppLocalizations.of(context)!.submit,
                      width: 200,
                      icon: Icons.send,
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
}
