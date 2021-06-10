import 'package:flutter/material.dart';

class ETourGradientBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, 0.2),
              colors: [
            Colors.white,
            Colors.white.withAlpha(0),
          ])),
    );
  }
}
