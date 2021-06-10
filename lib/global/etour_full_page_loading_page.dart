import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/global/etour_loading_indicator.dart';
import 'package:flutter/material.dart';

class FullPageLoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ETourColors.white,
          brightness: Brightness.light,
        ),
        backgroundColor: ETourColors.white,
        body: ETourLoadingIndicator());
  }
}
