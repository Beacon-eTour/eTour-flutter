import 'package:bloc/bloc.dart';
import 'package:eTour_flutter/helpers/shared_preferences_helper.dart';

class TourSelectionCubit extends Cubit<int?> {
  TourSelectionCubit() : super(null) {
    _fetchInitialSelected();
  }

  Future<void> _fetchInitialSelected() async {
    final selectedTourId = (await SharedPreferencesHelper.getIntForKey(
        SharedPreferencesKeys.tourId));
    emit(selectedTourId);
  }

  Future<void> select(int tour) async {
    await SharedPreferencesHelper.setIntForKey(
        tour, SharedPreferencesKeys.tourId);
    emit(tour);
  }
}
