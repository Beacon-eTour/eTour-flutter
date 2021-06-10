import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:flutter/material.dart';

class ETourLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: ETourColors.orange,
    ));
  }
}
