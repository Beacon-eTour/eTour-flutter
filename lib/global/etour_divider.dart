import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:flutter/material.dart';

class ETourDivider extends StatelessWidget {
  final withPadding;

  const ETourDivider({Key? key, this.withPadding = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: withPadding ? 16 : 0),
      child: Container(
        color: ETourColors.orange,
        height: 0.5,
        width: double.infinity,
      ),
    );
  }
}
