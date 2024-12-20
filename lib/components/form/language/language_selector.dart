import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';

import '../../../constants/colors.dart';
import '../../../store/locale_notifier.dart';
import '../../../utils/utils.dart';
import '../../text/roboto.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  Future<void> _changeLanguage(Language language) async {
    Utils.changeLanguage(language.isoCode);
  }

  Widget _languageOption(Language language) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 8),
        RobotoText(
          text: language.nativeName,
          fontSize: 16,
          color: Palette.black,
        ),
      ],
    );
  }

  Language _getLanguage() {
    return Language.fromIsoCode(localeNotifier.locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 200,
          alignment: Alignment.centerLeft,
          child: RobotoText(
            text: AppLocalizations.of(context)!.selectLanguage,
            color: Palette.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        ListenableBuilder(
          listenable: localeNotifier,
          builder: (BuildContext context, Widget? child) {
            return Container(
              width: 200,
              color: Palette.primary,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LanguagePickerDropdown(
                initialValue: _getLanguage(),
                itemBuilder: _languageOption,
                languages: <Language>[
                  Languages.english,
                  Languages.greekModern1453,
                ],
                onValuePicked: _changeLanguage,
              ),
            );
          },
        ),
      ],
    );
  }
}
