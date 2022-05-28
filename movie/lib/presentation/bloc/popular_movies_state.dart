part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();
}

class PopularMoviesInitial extends PopularMoviesState {
  const PopularMoviesInitial();

  @override
  List<Object> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading();

  @override
  List<Object> get props => [];
}

class PopularMoviesSuccess extends PopularMoviesState {
  final List<Movie> result;
  const PopularMoviesSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;
  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
