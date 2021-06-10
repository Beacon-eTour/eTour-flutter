import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:flutter/material.dart';

class ETourButton extends StatelessWidget {
  final Function? action;
  final String? titleTranslationKey;
  final bool isEnabled;
  const ETourButton(
      {Key? key, this.action, this.titleTranslationKey, this.isEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      elevation: 0,
      disabledColor: ETourColors.grey,
      color: ETourColors.orange,
      onPressed: isEnabled ? action as void Function()? : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: Center(
          child: Text(
              AppLocalizations.of(context)!
                  .translate(titleTranslationKey)!
                  .toUpperCase(),
              textAlign: TextAlign.center,
              style: ETourTextStyles.mediumItalicTitleWithColor(
                  ETourColors.white)),
        ),
      ),
    );
  }
}
