import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/cubit/bottom_navigation_cubit.dart';
import 'package:eTour_flutter/global/etour_toast.dart';
import 'package:eTour_flutter/map/map_page.dart';
import 'package:eTour_flutter/tour_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppFlow {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget basePage;

  AppFlow(this.navigatorKey, this.basePage);
}

class BottomNavigationRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: BottomNavigationView(),
    );
  }
}

class BottomNavigationView extends StatefulWidget {
  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  var _androidAppRetain = MethodChannel("android_app_retain");
  static final List<AppFlow> _widgetOptions = [
    AppFlow(GlobalKey<NavigatorState>(), TourPage()),
    AppFlow(GlobalKey<NavigatorState>(), MapPage()),
  ];
  @override
  Widget build(BuildContext context) {
    final unselectedItemColor = Colors.grey.shade600;
    const selectedItemColor = ETourColors.orange;

    BottomNavigationBarItem getItemWithAssetNameAndTranslationKey(
        String imageAssetName,
        String translationKey,
        int index,
        bool withNotificationBubble) {
      return BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Image.asset(
              imageAssetName,
              height: 24,
              color: (context.read<BottomNavigationCubit>().state == index)
                  ? selectedItemColor
                  : unselectedItemColor,
            ),
          ),
          label: index == 0
              ? AppLocalizations.of(context)!.translate('tour_title')
              : AppLocalizations.of(context)!.translate('btn_map'));
    }

    // Android back button
    var backPressed = false;
    Future<void> _systemBackButtonPressed(NavigatorState currentState) async {
      if (currentState.canPop()) {
        currentState.pop(currentState.context);
      } else {
        if (backPressed) {
          await ETourToast.cancelToast();
          await _androidAppRetain
              .invokeMethod("sendToBackground"); // Retain app, do not kill
        } else {
          await ETourToast.showToast(AppLocalizations.of(context)!
              .translate('exit_confirmation_android')!);
          backPressed = true;
        }

        Future.delayed(Duration(seconds: 3), () {
          ETourToast.cancelToast();
          backPressed = false;
        });
      }
    }

    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        final currentFlow = _widgetOptions[state];
        // WillPopScope needed for Android back button
        return WillPopScope(
            onWillPop: () => _systemBackButtonPressed(
                _widgetOptions[state].navigatorKey.currentState!).then((value) => value as bool),
            child: Scaffold(
              backgroundColor: ETourColors.white,
              body: Navigator(
                  key: _widgetOptions[state].navigatorKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                        settings: settings,
                        builder: (context) => IndexedStack(
                          index: state,
                          children:
                              _widgetOptions.map((e) => e.basePage).toList(),
                        ),
                      )),
              bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    selectedFontSize: 12,
                    backgroundColor: ETourColors.white,
                    elevation: 8,
                    selectedItemColor: selectedItemColor,
                    items: <BottomNavigationBarItem>[
                      getItemWithAssetNameAndTranslationKey(
                          'images/tour.png', 'bottomnav_frontpage', 0, false),
                      getItemWithAssetNameAndTranslationKey(
                          'images/ic_map.png', 'bottomnav_calls', 1, true),
                    ],
                    currentIndex: state,
                    onTap: (page) {
                      if (state == page) {
                        currentFlow.navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                      }
                      context.read<BottomNavigationCubit>().changeTo(page);
                    },
                  )),
            ));
      },
    );
  }
}
