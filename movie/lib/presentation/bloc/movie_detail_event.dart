part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetail extends MovieDetailEvent {
  final int id;

  const LoadMovieDetail({required this.id});

  @override
  List<Object> get props => [id];
}

class SaveWatchlistMovieDetail extends MovieDetailEvent {
  final MovieDetail movie;

  const SaveWatchlistMovieDetail({required this.movie});

}

class RemoveWatchlistMovieDetail extends MovieDetailEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovieDetail({required this.movie});

}
