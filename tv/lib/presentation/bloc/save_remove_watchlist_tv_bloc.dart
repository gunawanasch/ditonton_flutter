import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'save_remove_watchlist_tv_event.dart';
part 'save_remove_watchlist_tv_state.dart';

class SaveRemoveWatchlistTVBloc extends Bloc<SaveRemoveWatchlistTVEvent, SaveRemoveWatchlistTVState> {
  final SaveWatchlistTV _saveWatchlistTV;
  final RemoveWatchlistTV _removeWatchlistTV;

  SaveRemoveWatchlistTVBloc(
      this._saveWatchlistTV,
      this._removeWatchlistTV,
      ) : super(const SaveRemoveWatchlistTVInitial()) {
    on<SaveRemoveWatchlistTVEvent>((event, emit) async {
      if (event is AddWatchlistTV) {
        emit(const SaveRemoveWatchlistTVLoading());
        final result = await _saveWatchlistTV.execute(event.tv);
        result.fold(
              (failure) {
            emit(SaveRemoveWatchlistTVError(failure.message));
          },
              (data) {
            emit(AddWatchlistTVSuccess(data));
          },
        );
      } else if (event is DeleteWatchlistTV) {
        emit(const SaveRemoveWatchlistTVLoading());
        final result = await _removeWatchlistTV.execute(event.tv);
        result.fold(
              (failure) {
            emit(SaveRemoveWatchlistTVError(failure.message));
          },
              (data) {
            emit(DeleteWatchlistTVSuccess(data));
          },
        );
      }
    });
  }
}
