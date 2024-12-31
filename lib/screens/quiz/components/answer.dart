import 'package:flutter/material.dart';

import '../../../components/text/roboto.dart';
import '../../../constants/colors.dart';

class Answer extends StatelessWidget {
  const Answer({
    super.key,
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
  });

  final String question;
  final String correctAnswer;
  final String selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = correctAnswer == selectedAnswer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: RobotoText(
            text: question,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          subtitle: RobotoText(
            text: selectedAnswer,
            color: Palette.black,
            fontSize: 12,
          ),
          trailing: Icon(
            isCorrect ? Icons.check : Icons.close,
            color: isCorrect ? Palette.success : Palette.danger,
          ),
        ),
        if (!isCorrect)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: RobotoText(
              text: 'Correct answer: $correctAnswer',
              color: Palette.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        const Divider(
          color: Palette.black,
          thickness: 1,
        ),
      ],
    );
  }
}
