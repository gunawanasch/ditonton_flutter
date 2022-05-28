part of 'tv_episode_bloc.dart';

abstract class TVEpisodeEvent extends Equatable {
  const TVEpisodeEvent();
}

class LoadTVEpisode extends TVEpisodeEvent {
  final int idTV;
  final int seasonNumber;

  const LoadTVEpisode({required this.idTV, required this.seasonNumber});

  @override
  List<Object> get props => [idTV, seasonNumber];
}
