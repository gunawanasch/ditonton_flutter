part of 'save_remove_watchlist_bloc.dart';

abstract class SaveRemoveWatchlistState extends Equatable {
  const SaveRemoveWatchlistState();
}

class SaveRemoveWatchlistInitial extends SaveRemoveWatchlistState {
  const SaveRemoveWatchlistInitial();

  @override
  List<Object> get props => [];
}

class SaveRemoveWatchlistLoading extends SaveRemoveWatchlistState {
  const SaveRemoveWatchlistLoading();

  @override
  List<Object> get props => [];
}

class AddWatchlistSuccess extends SaveRemoveWatchlistState {
  final String result;
  const AddWatchlistSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class DeleteWatchlistSuccess extends SaveRemoveWatchlistState {
  final String result;
  const DeleteWatchlistSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class SaveRemoveWatchlistError extends SaveRemoveWatchlistState {
  final String message;
  const SaveRemoveWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}
