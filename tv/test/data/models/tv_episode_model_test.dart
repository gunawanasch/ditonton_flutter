import 'package:tv/data/models/tv_episode_model.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_episode_model.dart';

void main() {
  final tTVEpisodeModel = TVEpisodeModel(
    airDate: "2022-03-24",
    episodeNumber: 1,
    id: 3620542,
    name: "Pablo Schreiber On Becoming The Master Chief",
    overview: "Sydnee is joined by the Master Chief himself, Pablo Schreiber, Master Chief's highly advanced A.I., Cortana, and AEW professional wrestler Adam Cole.",
    productionCode: "",
    runtime: 22,
    seasonNumber: 0,
    stillPath: "/fomo40bejAKsTBssLCidOqTRsq8.jpg",
    voteAverage: 2.0,
    voteCount: 2,
  );

  final tTVEpisode = TVEpisode(
    airDate: "2022-03-24",
    episodeNumber: 1,
    id: 3620542,
    name: "Pablo Schreiber On Becoming The Master Chief",
    overview: "Sydnee is joined by the Master Chief himself, Pablo Schreiber, Master Chief's highly advanced A.I., Cortana, and AEW professional wrestler Adam Cole.",
    productionCode: "",
    runtime: 22,
    seasonNumber: 0,
    stillPath: "/fomo40bejAKsTBssLCidOqTRsq8.jpg",
    voteAverage: 2.0,
    voteCount: 2,
  );

  test('should be a subclass of TV ep entity', () async {
    final result = tTVEpisodeModel.toEntity();
    expect(result, tTVEpisode);
  });
}