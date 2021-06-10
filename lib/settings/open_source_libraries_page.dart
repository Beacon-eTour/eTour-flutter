import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:eTour_flutter/global/etour_app_bar.dart';
import 'package:eTour_flutter/global/etour_gradient_border.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceLibrary {
  final String title;
  final String linkUrl;

  OpenSourceLibrary(this.title, this.linkUrl);
}

class OpenSourceLibrariesPage extends StatelessWidget {
  final List<OpenSourceLibrary> libraries = [
    OpenSourceLibrary('retrofit', 'https://pub.dev/packages/retrofit'),
    OpenSourceLibrary('dio', 'https://pub.dev/packages/dio'),
    OpenSourceLibrary('get_it', 'https://pub.dev/packages/get_it'),
    OpenSourceLibrary('flutter_bloc', 'https://pub.dev/packages/flutter_bloc'),
    OpenSourceLibrary('bloc', 'https://pub.dev/packages/bloc'),
    OpenSourceLibrary('equatable', 'https://pub.dev/packages/equatable'),
    OpenSourceLibrary(
        'json_annotation', 'https://pub.dev/packages/json_annotation'),
    OpenSourceLibrary('package_info', 'https://pub.dev/packages/package_info'),
    OpenSourceLibrary(
        'shared_preferences', 'https://pub.dev/packages/shared_preferences'),
    OpenSourceLibrary('url_launcher', 'https://pub.dev/packages/url_launcher'),
    OpenSourceLibrary('device_info', 'https://pub.dev/packages/device_info'),
    OpenSourceLibrary('fluttertoast', 'https://pub.dev/packages/fluttertoast'),
    OpenSourceLibrary('get', 'https://pub.dev/packages/get'),
    OpenSourceLibrary('sqflite', 'https://pub.dev/packages/sqflite'),
    OpenSourceLibrary('floor', 'https://pub.dev/packages/floor'),
    OpenSourceLibrary(
        'retrofit_generator', 'https://pub.dev/packages/retrofit_generator'),
    OpenSourceLibrary('build_runner', 'https://pub.dev/packages/build_runner'),
    OpenSourceLibrary(
        'json_serializable', 'https://pub.dev/packages/json_serializable'),
    OpenSourceLibrary(
        'floor_generator', 'https://pub.dev/packages/floor_generator'),
    OpenSourceLibrary('pedantic', 'https://pub.dev/packages/pedantic'),
    OpenSourceLibrary('flutter_local_notifications',
        'https://pub.dev/packages/flutter_local_notifications'),
    OpenSourceLibrary(
        'webview_flutter', 'https://pub.dev/packages/webview_flutter'),
    OpenSourceLibrary(
        'path_provider', 'https://pub.dev/packages/path_provider'),
    OpenSourceLibrary(
        'youtube_plyr_iframe', 'https://pub.dev/packages/youtube_plyr_iframe'),
    OpenSourceLibrary('app_settings', 'https://pub.dev/packages/app_settings/'),
    OpenSourceLibrary('notification_permissions',
        'https://pub.dev/packages/notification_permissions'),
  ];
  @override
  Widget build(BuildContext context) {
    libraries.sort((a, b) => a.title.compareTo(b.title));
    return Scaffold(
        backgroundColor: ETourColors.white,
        appBar: ETourAppBar(
          titleTranslationKey: 'settings_open_source_libraries',
          withBackButton: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                ListView.builder(
                    itemCount: libraries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OpenSourceListTile(
                        titleText: libraries[index].title,
                        linkUrl: libraries[index].linkUrl,
                      );
                    }),
                ETourGradientBorder()
              ],
            ),
          ),
        ));
  }
}

class OpenSourceListTile extends StatelessWidget {
  final String? titleText;
  final String? linkUrl;

  const OpenSourceListTile({Key? key, this.titleText, this.linkUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleText!,
                style: ETourTextStyles.regularRalewayBodyWithColor(
                    ETourColors.black)),
            IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: Icon(Icons.exit_to_app_rounded,
                  color: ETourColors.orange, size: 24),
              onPressed: () {
                launch(linkUrl!);
              },
            ),
          ],
        ),
      ),
    ]);
  }
}
