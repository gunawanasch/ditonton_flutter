part of 'tv_episode_bloc.dart';

abstract class TVEpisodeState extends Equatable {
  const TVEpisodeState();
}

class TVEpisodeInitial extends TVEpisodeState {
  const TVEpisodeInitial();

  @override
  List<Object> get props => [];
}

class TVEpisodeLoading extends TVEpisodeState {
  const TVEpisodeLoading();

  @override
  List<Object> get props => [];
}

class TVEpisodeSuccess extends TVEpisodeState {
  final List<TVEpisode> result;
  const TVEpisodeSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class TVEpisodeError extends TVEpisodeState {
  final String message;
  const TVEpisodeError(this.message);

  @override
  List<Object> get props => [message];
}
