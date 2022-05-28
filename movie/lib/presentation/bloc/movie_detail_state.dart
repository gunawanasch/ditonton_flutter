part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  const MovieDetailInitial();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {
  const MovieDetailLoading();

  @override
  List<Object> get props => [];
}

class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail detail;
  final List<Movie> listRecommendations;
  final bool isAddedToWatchlist;
  const MovieDetailSuccess(this.detail, this.listRecommendations, this.isAddedToWatchlist);

  @override
  List<Object> get props => [detail, listRecommendations, isAddedToWatchlist];
}

class MovieDetailError extends MovieDetailState {
  final String message;
  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SaveWatchListMovieDetailSuccess extends MovieDetailState {
  final String result;
  const SaveWatchListMovieDetailSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveWatchListMovieDetailSuccess extends MovieDetailState {
  final String result;
  const RemoveWatchListMovieDetailSuccess(this.result);

  @override
  List<Object> get props => [result];
}
