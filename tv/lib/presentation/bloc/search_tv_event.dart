part of 'search_tv_bloc.dart';

abstract class SearchTVEvent extends Equatable {
  const SearchTVEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTV extends SearchTVEvent {
  final String query;

  const OnQueryChangedTV(this.query);

  @override
  List<Object> get props => [query];
}
