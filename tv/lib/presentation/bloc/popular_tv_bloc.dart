import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTV _getPopularTV;

  PopularTVBloc(this._getPopularTV) : super(const PopularTVInitial()) {
    on<PopularTVEvent>((event, emit) async {
      emit(const PopularTVLoading());
      final result = await _getPopularTV.execute();
      result.fold(
            (failure) {
          emit(PopularTVError(failure.message));
        },
            (data) {
          emit(PopularTVSuccess(data));
        },
      );
    });
  }
  
}
