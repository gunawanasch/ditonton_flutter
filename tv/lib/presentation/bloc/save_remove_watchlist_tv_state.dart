part of 'save_remove_watchlist_tv_bloc.dart';

abstract class SaveRemoveWatchlistTVState extends Equatable {
  const SaveRemoveWatchlistTVState();
}

class SaveRemoveWatchlistTVInitial extends SaveRemoveWatchlistTVState {
  const SaveRemoveWatchlistTVInitial();

  @override
  List<Object> get props => [];
}

class SaveRemoveWatchlistTVLoading extends SaveRemoveWatchlistTVState {
  const SaveRemoveWatchlistTVLoading();

  @override
  List<Object> get props => [];
}

class AddWatchlistTVSuccess extends SaveRemoveWatchlistTVState {
  final String result;
  const AddWatchlistTVSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class DeleteWatchlistTVSuccess extends SaveRemoveWatchlistTVState {
  final String result;
  const DeleteWatchlistTVSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class SaveRemoveWatchlistTVError extends SaveRemoveWatchlistTVState {
  final String message;
  const SaveRemoveWatchlistTVError(this.message);

  @override
  List<Object> get props => [message];
}
