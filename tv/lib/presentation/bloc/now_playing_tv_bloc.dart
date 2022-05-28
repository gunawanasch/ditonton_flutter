import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTVBloc extends Bloc<NowPlayingTVEvent, NowPlayingTVState> {
  final GetNowPlayingTV _getNowPlayingTV;

  NowPlayingTVBloc(this._getNowPlayingTV) : super(const NowPlayingTVInitial()) {
    on<NowPlayingTVEvent>((event, emit) async {
      emit(const NowPlayingTVLoading());
      final result = await _getNowPlayingTV.execute();
      result.fold(
            (failure) {
          emit(NowPlayingTVError(failure.message));
        },
            (data) {
          emit(NowPlayingTVSuccess(data));
        },
      );
    });
  }

}
