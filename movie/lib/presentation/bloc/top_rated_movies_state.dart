part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();
}

class TopRatedMoviesInitial extends TopRatedMoviesState {
  const TopRatedMoviesInitial();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {
  const TopRatedMoviesLoading();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesSuccess extends TopRatedMoviesState {
  final List<Movie> result;
  const TopRatedMoviesSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;
  const TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
