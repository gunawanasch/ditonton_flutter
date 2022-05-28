part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();
  
  @override
  List<Object> get props => [];
}

class LoadTVDetail extends TVDetailEvent {
  final int id;

  const LoadTVDetail({required this.id});

  @override
  List<Object> get props => [id];
}

class SaveWatchlistTVDetail extends TVDetailEvent {
  final TVDetail tv;

  const SaveWatchlistTVDetail({required this.tv});

}

class RemoveWatchlistTVDetail extends TVDetailEvent {
  final TVDetail tv;

  const RemoveWatchlistTVDetail({required this.tv});

}
