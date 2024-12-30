import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/colors.dart';
import '../../text/roboto.dart';

class RadioGroup extends StatefulWidget {
  const RadioGroup({
    super.key,
    required this.question,
    required this.onChanged,
    required this.answers,
    this.showDivider = true,
    this.initialAnswer,
    this.id,
  });

  final String question;
  final List<String> answers;
  final bool showDivider;
  final void Function(int) onChanged;
  final int? initialAnswer;
  final int? id;

  @override
  State<StatefulWidget> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  late int? _answer;

  @override
  void initState() {
    super.initState();
    _answer = widget.initialAnswer;
  }

  void _setAnswer(int answer) {
    widget.onChanged(answer);
    setState(() {
      _answer = answer;
    });
  }

  String? _validate() {
    if (_answer == null) {
      return 'Please select an answer';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      validator: (_) => _validate(),
      builder: (FormFieldState<int> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.id != null)
              RobotoText(
                text: AppLocalizations.of(context)!.questionId(widget.id!),
                textAlign: TextAlign.start,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            if (widget.id != null) const SizedBox(height: 10),
            RobotoText(
              text: widget.question,
              textAlign: TextAlign.start,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Palette.black,
            ),
            for (int i = 0; i < widget.answers.length; i++)
              RadioListTile<int>(
                title: RobotoText(
                  text: widget.answers[i],
                  fontSize: 16,
                  color: Palette.black,
                ),
                activeColor: Palette.primary,
                value: i,
                groupValue: _answer,
                onChanged: (int? i) {
                  if (i != null) {
                    _setAnswer(i);
                  }
                },
              ),
            if (state.hasError)
              RobotoText(
                text: state.errorText!,
                fontSize: 16,
                color: Palette.danger,
              ),
            if (widget.showDivider)
              const Divider(
                color: Palette.black,
                thickness: 1,
              ),
          ],
        );
      },
    );
  }
}
