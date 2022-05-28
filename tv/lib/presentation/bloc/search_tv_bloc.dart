import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTVBloc extends Bloc<SearchTVEvent, SearchTVState> {
  final SearchTV _searchTV;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchTVBloc(this._searchTV) : super(SearchTVEmpty()) {
    on<OnQueryChangedTV>((event, emit) async {
      final query = event.query;


      emit(SearchTVLoading());
      final result = await _searchTV.execute(query);


      result.fold(
            (failure) {
          emit(SearchTVError(failure.message));
        },
            (data) {
          emit(SearchTVHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

}
