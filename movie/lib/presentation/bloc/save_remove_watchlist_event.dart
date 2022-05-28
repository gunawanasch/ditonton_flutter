part of 'save_remove_watchlist_bloc.dart';

abstract class SaveRemoveWatchlistEvent extends Equatable {
  const SaveRemoveWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlist extends SaveRemoveWatchlistEvent {
  final MovieDetail movie;

  const AddWatchlist({required this.movie});
}

class DeleteWatchlist extends SaveRemoveWatchlistEvent {
  final MovieDetail movie;

  const DeleteWatchlist({required this.movie});

}
