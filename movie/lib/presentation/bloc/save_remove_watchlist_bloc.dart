import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'save_remove_watchlist_event.dart';
part 'save_remove_watchlist_state.dart';

class SaveRemoveWatchlistBloc extends Bloc<SaveRemoveWatchlistEvent, SaveRemoveWatchlistState> {
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  SaveRemoveWatchlistBloc(
      this._saveWatchlist,
      this._removeWatchlist,
      ) : super(const SaveRemoveWatchlistInitial()) {
    on<SaveRemoveWatchlistEvent>((event, emit) async {
      if (event is AddWatchlist) {
        emit(const SaveRemoveWatchlistLoading());
        final result = await _saveWatchlist.execute(event.movie);
        result.fold(
              (failure) {
            emit(SaveRemoveWatchlistError(failure.message));
          },
              (data) {
            emit(AddWatchlistSuccess(data));
          },
        );
      } else if (event is DeleteWatchlist) {
        emit(const SaveRemoveWatchlistLoading());
        final result = await _removeWatchlist.execute(event.movie);
        result.fold(
              (failure) {
            emit(SaveRemoveWatchlistError(failure.message));
          },
              (data) {
            emit(DeleteWatchlistSuccess(data));
          },
        );
      }
    });
  }

}
