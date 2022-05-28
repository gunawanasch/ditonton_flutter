import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

part 'get_watchlist_movies_event.dart';
part 'get_watchlist_movies_state.dart';

class GetWatchlistMoviesBloc extends Bloc<GetWatchlistMoviesEvent, GetWatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;

  GetWatchlistMoviesBloc(this._getWatchlistMovies) : super(const GetWatchlistMoviesInitial()) {
    on<LoadWatchlistMovies>((event, emit) async {
      emit(const GetWatchlistMoviesLoading());
      final result = await _getWatchlistMovies.execute();
      result.fold(
            (failure) {
          emit(GetWatchlistMoviesError(failure.message));
        },
            (data) {
          emit(GetWatchlistMoviesSuccess(data));
        },
      );
    });
  }

}
