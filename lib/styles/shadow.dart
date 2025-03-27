import 'package:flutter/material.dart';

import '../constants/colors.dart';

final BoxDecoration shadow = BoxDecoration(
  color: Palette.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Palette.black.withOpacity(0.2),
      blurRadius: 10,
      spreadRadius: 5,
    ),
  ],
);
