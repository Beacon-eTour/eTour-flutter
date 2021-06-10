import 'dart:ui';

import 'package:flutter/material.dart';

class ETourTextStyles {
  static TextStyle regularRalewayCaptionWithColor(Color color) {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        fontFamily: 'Raleway',
        fontFeatures: [
          FontFeature.tabularFigures(),
          FontFeature.enable('lnum')
        ]);
  }

  static TextStyle regularRalewayBodyWithColor(Color color) {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        fontFamily: 'Raleway',
        fontFeatures: [
          FontFeature.tabularFigures(),
          FontFeature.enable('lnum')
        ]);
  }

  static TextStyle semiboldItalicTitleWithColor(Color color) {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
        fontStyle: FontStyle.italic,
        fontFamily: 'Raleway',
        fontFeatures: [
          FontFeature.tabularFigures(),
          FontFeature.enable('lnum')
        ]);
  }

  static TextStyle mediumItalicTitleWithColor(Color color) {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
        fontStyle: FontStyle.italic,
        fontFamily: 'Raleway',
        fontFeatures: [
          FontFeature.tabularFigures(),
          FontFeature.enable('lnum')
        ]);
  }
}
