import 'dart:ui' show ImageFilter;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../store/locale_notifier.dart';
import '../tutorial_game.dart' show TutorialState;

class _TutorialText {
  static final Map<String, Map<TutorialState, String>> _tutorialMap =
      <String, Map<TutorialState, String>>{
    'en': <TutorialState, String>{
      TutorialState.gate: '1. Select a gate',
      TutorialState.register:
          "2. Tap on a '+' icon to apply the gate to a qubit",
      TutorialState.shoot: '3. Tap on the shoot button to fire the missiles',
      TutorialState.completed:
          'Tap on the pause button on the top right corner to exit tutorial',
    },
    'el': <TutorialState, String>{
      TutorialState.gate: '1. Επιλέξτε μια πύλη',
      TutorialState.register:
          '2. Πατήστε στο "+" για να εφαρμόσετε την πύλη σε ένα qubit',
      TutorialState.shoot:
          '3. Πατήστε το κουμπί εκτόξευσης για να εκτοξεύσετε πυραύλους',
      TutorialState.completed:
          'Πατήστε το κουμπί παύσης στην πάνω δεξιά γωνία για να τερματίσετε την επίδειξη',
    },
  };

  static String getTutorialText(TutorialState state) {
    final String language = localeNotifier.locale.languageCode;
    return _tutorialMap[language]![state]!;
  }
}

final Paint _paint = Paint()
  ..color = Palette.primary
  ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
  ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5)
  ..colorFilter =
      ColorFilter.mode(Palette.white.withOpacity(0.5), BlendMode.srcOver);

class TutorialBoxComponent extends RectangleComponent {
  TutorialBoxComponent({
    required Vector2 position,
    required TutorialState state,
    required Vector2 size,
  }) : super(
          anchor: Anchor.center,
          position: position,
          size: size,
          paint: _paint,
          children: <Component>[
            TextBoxComponent<TextPaint>(
              text: _TutorialText.getTutorialText(state),
              align: Anchor.center,
              textRenderer: TextPaint(
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Palette.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              size: size,
              anchor: Anchor.topLeft,
            ),
          ],
        );
}
