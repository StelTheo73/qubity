import 'package:flutter/material.dart';

import '../../styles/shadow.dart';

class BaseOverlay extends StatelessWidget {
  const BaseOverlay({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: Container(
            decoration: shadow,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: children),
          ),
        ),
      ],
    );
  }
}
