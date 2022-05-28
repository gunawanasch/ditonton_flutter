part of 'get_watchlist_movies_bloc.dart';

abstract class GetWatchlistMoviesEvent extends Equatable {
  const GetWatchlistMoviesEvent();
}

class LoadWatchlistMovies extends GetWatchlistMoviesEvent {

  @override
  List<Object> get props => [];

}
