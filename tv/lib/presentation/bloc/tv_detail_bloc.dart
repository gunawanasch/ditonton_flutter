import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTVDetail _getTVDetail;
  final GetTVRecommendations _getTVRecommendations;
  final GetWatchListStatusTV _getWatchListStatusTV;

  TVDetailBloc(
      this._getTVDetail,
      this._getTVRecommendations,
      this._getWatchListStatusTV,
      ) : super(const TVDetailInitial()) {
    on<LoadTVDetail>((event, emit) async {
      emit(const TVDetailLoading());
      final resultDetail = await _getTVDetail.execute(event.id);
      final listRecommendations = await _getTVRecommendations.execute(event.id);
      final value = await _getWatchListStatusTV.execute(event.id);

      late TVDetail detail;
      late List<TV> list;

      resultDetail.fold(
            (failure) {
          emit(TVDetailError(failure.message));
        },
            (dataDetail) {
          detail = dataDetail;

          listRecommendations.fold(
                (failure) {
              emit(TVDetailError(failure.message));
            },
                (dataRecommendations) {
              list = dataRecommendations;
              emit(TVDetailSuccess(detail, list, value));
            },
          );
        },
      );
    });
  }

}
