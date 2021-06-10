part of 'current_info_page_cubit.dart';

class CurrentInfoPageState extends Equatable {
  final String currentInfoPage;
  final bool isExit;
  const CurrentInfoPageState(this.currentInfoPage, this.isExit);

  @override
  List<Object> get props => [currentInfoPage, isExit];
}
