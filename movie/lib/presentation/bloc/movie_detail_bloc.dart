import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;

  MovieDetailBloc(
      this._getMovieDetail,
      this._getMovieRecommendations,
      this._getWatchListStatus,
      ) : super(const MovieDetailInitial()) {
    on<LoadMovieDetail>((event, emit) async {
      emit(const MovieDetailLoading());
      final resultDetail = await _getMovieDetail.execute(event.id);
      final listRecommendations = await _getMovieRecommendations.execute(event.id);
      final value = await _getWatchListStatus.execute(event.id);

      late MovieDetail detail;
      late List<Movie> list;

      resultDetail.fold(
            (failure) {
          emit(MovieDetailError(failure.message));
        },
            (dataDetail) {
          detail = dataDetail;

          listRecommendations.fold(
                (failure) {
              emit(MovieDetailError(failure.message));
            },
                (dataRecommendations) {
              list = dataRecommendations;
              emit(MovieDetailSuccess(detail, list, value));
            },
          );
        },
      );
    });
  }

}
