import 'dart:async';

import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:eTour_flutter/cubit/current_info_page_cubit.dart';
import 'package:eTour_flutter/global/etour_app_bar.dart';
import 'package:eTour_flutter/global/etour_gradient_border.dart';
import 'package:eTour_flutter/global/etour_loading_indicator.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/onBoarding/intro_video_page.dart';
import 'package:eTour_flutter/repository/tours_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:webview_flutter/webview_flutter.dart';

class TourPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  WebViewController? controller;
  late bool isLoading;
  String? url;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    url = context.read<CurrentInfoPageCubit>().state.currentInfoPage;
  }

  Future<void> _showIntroVideoIfNeeded() async {
    final shouldShowIntroVideo = !(await SharedPreferencesHelper.getBoolForKey(
            SharedPreferencesKeys.hasSeenIntroVideo) ??
        false);
    if (shouldShowIntroVideo) {
      SchedulerBinding.instance?.addPostFrameCallback((_) async {
        await SharedPreferencesHelper.setBoolForKey(
            true, SharedPreferencesKeys.hasSeenIntroVideo);
        //Navigator.of(context).push(VideoOverlay());
        final toursRepository = ToursRepository();
        final introVideoUrl =
            await toursRepository.getCurrenTourIntroVideoUrl();
        if (introVideoUrl == null || introVideoUrl.isEmpty) return;
        if (!Get.isDialogOpen!)
          Get.dialog(VideoPage(
            introVideoUrl: introVideoUrl,
          ));
      });
    }
  }

  Future<void> _showExitDialog() async {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      context.read<CurrentInfoPageCubit>().setIsExit(false);
      if (!Get.isDialogOpen!) {
        await Get.dialog(AlertDialog(
          title: Text(
            AppLocalizations.of(context)!
                .translate('tour_not_completed_title')!,
            style: ETourTextStyles.semiboldItalicTitleWithColor(
                ETourColors.brownViolet),
          ),
          content: SingleChildScrollView(
            child: Text(
                AppLocalizations.of(context)!
                    .translate('tour_not_completed_description')!,
                style: ETourTextStyles.regularRalewayBodyWithColor(
                    ETourColors.black)),
          ),
          actions: [
            TextButton(
              child: Text(
                  AppLocalizations.of(context)!.translate('generic_ok')!,
                  style: ETourTextStyles.regularRalewayBodyWithColor(
                      ETourColors.orange)),
              onPressed: () {
                if (Get.isDialogOpen!) Get.close(1);
              },
            ),
          ],
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _showIntroVideoIfNeeded();
    return Scaffold(
        backgroundColor: ETourColors.white,
        appBar: ETourAppBar(
          titleTranslationKey: 'tour_title',
          withSettingsButton: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl: url,
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
              BlocBuilder<CurrentInfoPageCubit, CurrentInfoPageState>(
                  builder: (context, state) {
                if (state != null && controller != null) {
                  if (state.isExit) {
                    _showExitDialog();
                  }
                  return AnimatedOpacity(
                    opacity: state.currentInfoPage != url ? 1 : 0,
                    duration: Duration(milliseconds: 400),
                    child: InkWell(
                      onTap: () {
                        url = state.currentInfoPage;
                        controller?.loadUrl(state.currentInfoPage);
                        isLoading = true;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ETourColors.orange,
                              borderRadius: BorderRadius.circular(2)),
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('tour_new_info_page_available')!,
                                style: ETourTextStyles
                                    .semiboldItalicTitleWithColor(
                                        ETourColors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              }),
              ETourGradientBorder()
            ],
          ),
        ));
  }
}
