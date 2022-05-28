import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/usecases/get_tv_episode.dart';

part 'tv_episode_event.dart';
part 'tv_episode_state.dart';

class TVEpisodeBloc extends Bloc<TVEpisodeEvent, TVEpisodeState> {
  final GetTVEpisode _getTVEpisode;

  TVEpisodeBloc(this._getTVEpisode) : super(const TVEpisodeInitial()) {
    on<LoadTVEpisode>((event, emit) async {
      emit(const TVEpisodeLoading());
      final result = await _getTVEpisode.execute(event.idTV, event.seasonNumber);
      result.fold(
            (failure) {
          emit(TVEpisodeError(failure.message));
        },
            (data) {
          emit(TVEpisodeSuccess(data));
        },
      );
    });
  }

}
