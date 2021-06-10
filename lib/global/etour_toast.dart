import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ETourToast {
  static Future<void> showToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withAlpha(200),
        textColor: ETourColors.white,
        fontSize: 16.0);
  }

  static Future<bool?> cancelToast() {
    return Fluttertoast.cancel();
  }
}
