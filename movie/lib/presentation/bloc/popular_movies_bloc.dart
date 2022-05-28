import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(const PopularMoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {
      emit(const PopularMoviesLoading());
      final result = await _getPopularMovies.execute();
      result.fold(
            (failure) {
          emit(PopularMoviesError(failure.message));
        },
            (data) {
          emit(PopularMoviesSuccess(data));
        },
      );
    });
  }

}
