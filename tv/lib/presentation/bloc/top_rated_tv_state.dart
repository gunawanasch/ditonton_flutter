part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTVState extends Equatable {
  const TopRatedTVState();
}

class TopRatedTVInitial extends TopRatedTVState {
  const TopRatedTVInitial();

  @override
  List<Object> get props => [];
}

class TopRatedTVLoading extends TopRatedTVState {
  const TopRatedTVLoading();

  @override
  List<Object> get props => [];
}

class TopRatedTVSuccess extends TopRatedTVState {
  final List<TV> result;
  const TopRatedTVSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTVError extends TopRatedTVState {
  final String message;
  const TopRatedTVError(this.message);

  @override
  List<Object> get props => [message];
}

