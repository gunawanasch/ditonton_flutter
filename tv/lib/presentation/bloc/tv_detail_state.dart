part of 'tv_detail_bloc.dart';

abstract class TVDetailState extends Equatable {
  const TVDetailState();
}

class TVDetailInitial extends TVDetailState {
  const TVDetailInitial();

  @override
  List<Object> get props => [];
}

class TVDetailLoading extends TVDetailState {
  const TVDetailLoading();

  @override
  List<Object> get props => [];
}

class TVDetailSuccess extends TVDetailState {
  final TVDetail detail;
  final List<TV> listRecommendations;
  final bool isAddedToWatchlist;
  const TVDetailSuccess(this.detail, this.listRecommendations, this.isAddedToWatchlist);

  @override
  List<Object> get props => [detail, listRecommendations, isAddedToWatchlist];
}

class TVDetailError extends TVDetailState {
  final String message;
  const TVDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SaveWatchListTVDetailSuccess extends TVDetailState {
  final String result;
  const SaveWatchListTVDetailSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveWatchListTVDetailSuccess extends TVDetailState {
  final String result;
  const RemoveWatchListTVDetailSuccess(this.result);

  @override
  List<Object> get props => [result];
}

