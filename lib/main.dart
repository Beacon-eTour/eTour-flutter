import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/bottom_navigation_root.dart';
import 'package:eTour_flutter/cubit/current_info_page_cubit.dart';
import 'package:eTour_flutter/cubit/language_cubit.dart';
import 'package:eTour_flutter/cubit/tours_cubit.dart';
import 'package:eTour_flutter/helpers/app_localization_helper.dart';
import 'package:eTour_flutter/helpers/native_event_handler.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:eTour_flutter/onBoarding/on_boarding_name_page.dart';
import 'package:eTour_flutter/repository/tours_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'global/etour_full_page_loading_page.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalizationsLoader.loadAndSaveLocalizations();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LanguageCubit()),
      BlocProvider(create: (context) => ToursCubit(ToursRepository())),
      BlocProvider(create: (context) => CurrentInfoPageCubit()),
    ],
    child: ETourBeaconApp(),
  ));
}

class ETourBeaconApp extends StatelessWidget {
  final eventChannel = EventChannel("etour_event_channel");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    NativeEventHandler.instance.currentBeaconInfoId = null;
    eventChannel.receiveBroadcastStream().listen(
        NativeEventHandler.instance.nativeEventHandler,
        onError: NativeEventHandler.instance.nativeEventErrorHandler);
    return BlocBuilder<LanguageCubit, Locale?>(
      builder: (context, state) {
        return GetMaterialApp(
          theme: ThemeData(brightness: Brightness.light),
          locale: state,
          supportedLocales: AppLocalizationsLoader.shared.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          builder: (context, child) {
            final systemTextScaleFactor =
                MediaQuery.of(context).textScaleFactor;
            final textScaleFactor =
                systemTextScaleFactor > 1.25 ? 1.25 : systemTextScaleFactor;
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaleFactor: textScaleFactor),
                child: child!);
          },
          home: state == null
              ? FullPageLoadingPage()
              : FutureBuilder(
                  future: SharedPreferencesHelper.getBoolForKey(
                      SharedPreferencesKeys.hasSeenIntroPages),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? FullPageLoadingPage()
                        : snapshot.data != null
                            ? ETourBeaconHomePage()
                            : OnBoardingNamePage();
                  },
                ),
        );
      },
    );
  }
}

class ETourBeaconHomePage extends StatefulWidget {
  ETourBeaconHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ETourBeaconHomePageState createState() => _ETourBeaconHomePageState();
}

class _ETourBeaconHomePageState extends State<ETourBeaconHomePage> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationRoot();
  }
}
