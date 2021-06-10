import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_config.dart';
import 'package:eTour_flutter/cubit/language_cubit.dart';
import 'package:eTour_flutter/global/etour_app_bar.dart';
import 'package:eTour_flutter/global/etour_gradient_border.dart';
import 'package:eTour_flutter/global/etour_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutWebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutWebViewState();
}

class _AboutWebViewState extends State<AboutWebView> {
  WebViewController? controller;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ETourColors.white,
        appBar: ETourAppBar(
          titleTranslationKey: 'settings_about_app',
          withBackButton: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl:
                    '${ETourConfig.baseUrl}/about/${Get.context!.read<LanguageCubit>().state!.languageCode}',
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finished) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onWebViewCreated: (WebViewController webViewController) {
                  controller = webViewController;
                },
              ),
              isLoading
                  ? Center(child: ETourLoadingIndicator())
                  : SizedBox(
                      height: 0,
                    ),
              ETourGradientBorder()
            ],
          ),
        ));
  }
}
