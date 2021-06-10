import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:eTour_flutter/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ETourAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBackButton;
  final String titleTranslationKey;
  final bool withSettingsButton;

  const ETourAppBar(
      {Key? key,
      this.withBackButton = false,
      required this.titleTranslationKey,
      this.withSettingsButton = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        child: AppBar(
          centerTitle: true,
          leading: withBackButton
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: ETourColors.orange,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : null,
          actions: [
            withSettingsButton
                ? IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: ETourColors.black,
                    ),
                    onPressed: () {
                      Get.to(() => SettingsPage());
                    },
                  )
                : SizedBox(
                    width: 0,
                  )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.translate(titleTranslationKey)!,
                textAlign: TextAlign.center,
                style: ETourTextStyles.semiboldItalicTitleWithColor(
                    ETourColors.brownViolet),
              ),
            ],
          ),
          brightness: Brightness.light,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
