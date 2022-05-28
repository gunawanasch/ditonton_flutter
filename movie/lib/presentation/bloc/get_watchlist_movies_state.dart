part of 'get_watchlist_movies_bloc.dart';

abstract class GetWatchlistMoviesState extends Equatable {
  const GetWatchlistMoviesState();
}

class GetWatchlistMoviesInitial extends GetWatchlistMoviesState {
  const GetWatchlistMoviesInitial();
  
  @override
  List<Object> get props => [];
}

class GetWatchlistMoviesLoading extends GetWatchlistMoviesState {
  const GetWatchlistMoviesLoading();

  @override
  List<Object> get props => [];
}

class GetWatchlistMoviesSuccess extends GetWatchlistMoviesState {
  final List<Movie> result;
  const GetWatchlistMoviesSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class GetWatchlistMoviesError extends GetWatchlistMoviesState {
  final String message;
  const GetWatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
