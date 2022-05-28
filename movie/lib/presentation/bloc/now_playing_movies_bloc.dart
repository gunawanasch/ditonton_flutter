import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(const NowPlayingMoviesInitial()) {
    on<NowPlayingMoviesEvent>((event, emit) async {
      emit(const NowPlayingMoviesLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold(
            (failure) {
          emit(NowPlayingMoviesError(failure.message));
        },
            (data) {
          emit(NowPlayingMoviesSuccess(data));
        },
      );
    });
  }

}
