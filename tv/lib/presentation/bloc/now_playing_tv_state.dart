part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTVState extends Equatable {
  const NowPlayingTVState();
}

class NowPlayingTVInitial extends NowPlayingTVState {
  const NowPlayingTVInitial();

  @override
  List<Object> get props => [];
}

class NowPlayingTVLoading extends NowPlayingTVState {
  const NowPlayingTVLoading();

  @override
  List<Object> get props => [];
}

class NowPlayingTVSuccess extends NowPlayingTVState {
  final List<TV> result;
  const NowPlayingTVSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class NowPlayingTVError extends NowPlayingTVState {
  final String message;
  const NowPlayingTVError(this.message);

  @override
  List<Object> get props => [message];
}
