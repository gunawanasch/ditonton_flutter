part of 'get_watchlist_tv_bloc.dart';

abstract class GetWatchlistTVState extends Equatable {
  const GetWatchlistTVState();
}

class GetWatchlistTVInitial extends GetWatchlistTVState {
  const GetWatchlistTVInitial();

  @override
  List<Object> get props => [];
}

class GetWatchlistTVLoading extends GetWatchlistTVState {
  const GetWatchlistTVLoading();

  @override
  List<Object> get props => [];
}

class GetWatchlistTVSuccess extends GetWatchlistTVState {
  final List<TV> result;
  const GetWatchlistTVSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class GetWatchlistTVError extends GetWatchlistTVState {
  final String message;
  const GetWatchlistTVError(this.message);

  @override
  List<Object> get props => [message];
}

