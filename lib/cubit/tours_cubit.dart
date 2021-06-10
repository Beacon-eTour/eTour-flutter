import 'package:bloc/bloc.dart';
import 'package:eTour_flutter/helpers/tour_localization_helper.dart';
import 'package:eTour_flutter/repository/tours_repository.dart';
import 'package:eTour_flutter/settings/tour_selection.dart';
import 'package:equatable/equatable.dart';

part 'tours_state.dart';

class ToursCubit extends Cubit<ToursState> {
  final ToursRepository toursRepository;
  ToursCubit(this.toursRepository) : super(ToursInitial()) {
    _loadTours();
  }

  Future<void> _loadTours() async {
    emit(ToursLoading());
    List<TourObject> tourObjects = [];
    try {
      await toursRepository.updateTours();
      final tours = await toursRepository.getTours();
      await Future.forEach(tours, (dynamic tour) async {
        final tourName =
            await TourLocalizationHelper.getLocalizedTourName(tour);
        if (tourName != '') {
          tourObjects.add(TourObject(tourName, tour.id));
        }
      });
    } catch (e) {
      print(e);
      emit(ToursError());
      return;
    }
    emit(ToursLoaded(tourObjects));
  }
}
