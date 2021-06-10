import 'package:bloc/bloc.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';

class LanguageSelectionCubit extends Cubit<int?> {
  LanguageSelectionCubit() : super(null) {
    _fetchInitialSelected();
  }

  Future<void> _fetchInitialSelected() async {
    final selectedIndex = (await SharedPreferencesHelper.getIntForKey(
            SharedPreferencesKeys.languageIndex)) ??
        0;
    emit(selectedIndex);
  }

  void select(int index) => emit(index);
}
