part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {
  const NowPlayingMoviesInitial();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  const NowPlayingMoviesLoading();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesSuccess extends NowPlayingMoviesState {
  final List<Movie> result;
  const NowPlayingMoviesSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;
  const NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
