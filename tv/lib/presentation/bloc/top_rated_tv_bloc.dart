import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopRatedTV _getTopRatedTV;

  TopRatedTVBloc(this._getTopRatedTV) : super(const TopRatedTVInitial()) {
    on<TopRatedTVEvent>((event, emit) async {
      emit(const TopRatedTVLoading());
      final result = await _getTopRatedTV.execute();
      result.fold(
            (failure) {
          emit(TopRatedTVError(failure.message));
        },
            (data) {
          emit(TopRatedTVSuccess(data));
        },
      );
    });
  }
}
