part of 'save_remove_watchlist_tv_bloc.dart';

abstract class SaveRemoveWatchlistTVEvent extends Equatable {
  const SaveRemoveWatchlistTVEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistTV extends SaveRemoveWatchlistTVEvent {
  final TVDetail tv;

  const AddWatchlistTV({required this.tv});
}

class DeleteWatchlistTV extends SaveRemoveWatchlistTVEvent {
  final TVDetail tv;

  const DeleteWatchlistTV({required this.tv});

}
