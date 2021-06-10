part of 'tours_cubit.dart';

abstract class ToursState extends Equatable {
  const ToursState();

  @override
  List<Object> get props => [];
}

class ToursInitial extends ToursState {
  const ToursInitial();
}

class ToursLoading extends ToursState {
  const ToursLoading();
}

class ToursLoaded extends ToursState {
  final List<TourObject> tourObjects;
  const ToursLoaded(this.tourObjects);
}

class ToursError extends ToursState {
  const ToursError();
}
