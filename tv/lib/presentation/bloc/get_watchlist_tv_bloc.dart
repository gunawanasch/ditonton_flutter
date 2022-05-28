import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

part 'get_watchlist_tv_event.dart';
part 'get_watchlist_tv_state.dart';

class GetWatchlistTVBloc extends Bloc<GetWatchlistTVEvent, GetWatchlistTVState> {
  final GetWatchlistTV _getWatchlistTV;

  GetWatchlistTVBloc(this._getWatchlistTV) : super(const GetWatchlistTVInitial()) {
    on<LoadWatchlistTV>((event, emit) async {
      emit(const GetWatchlistTVLoading());
      final result = await _getWatchlistTV.execute();
      result.fold(
            (failure) {
          emit(GetWatchlistTVError(failure.message));
        },
            (data) {
          emit(GetWatchlistTVSuccess(data));
        },
      );
    });
  }

}
