import 'package:bloc/bloc.dart';
import 'package:eTour_flutter/constants/etour_config.dart';
import 'package:eTour_flutter/cubit/language_cubit.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_info_page_state.dart';

class CurrentInfoPageCubit extends Cubit<CurrentInfoPageState> {
  CurrentInfoPageCubit()
      : super(
            CurrentInfoPageState('${ETourConfig.baseUrl}/landing/fi', false)) {
    _setInitial();
  }

  void _setInitial() {
    final currentLanguageCode =
        Get.context?.read<LanguageCubit>().state?.languageCode;
    emit(CurrentInfoPageState(
        '${ETourConfig.baseUrl}/landing/$currentLanguageCode', false));
  }

  String? currentBeaconId;

  Future<void> setBasedOnCurrentBeaconId({isExit = false}) async {
    final tourId = await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourId);
    final localization = Get.context?.read<LanguageCubit>().state?.languageCode;
    if (currentBeaconId == null) return;
    emit(CurrentInfoPageState(
        '${ETourConfig.baseUrl}/content/$tourId/$currentBeaconId/$localization',
        isExit));
  }

  Future<void> setCurrentInfoPage(String? beaconId, bool isExit) async {
    if (beaconId == currentBeaconId) {
      return;
    }
    currentBeaconId = beaconId;
    await setBasedOnCurrentBeaconId(isExit: isExit);
  }

  void setIsExit(bool isExit) {
    emit(CurrentInfoPageState(state.currentInfoPage, isExit));
  }
}
