import 'dart:convert';

import 'package:tv/data/models/tv_episode_model.dart';
import 'package:tv/data/models/tv_episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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
  final tTVEpisodeResponseModel =
  TVEpisodeResponse(tvEpisodeList: <TVEpisodeModel>[tTVEpisodeModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/tv_episode.json'));
      // act
      final result = TVEpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVEpisodeResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVEpisodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "air_date": "2022-03-24",
            "episode_number": 1,
            "id": 3620542,
            "name": "Pablo Schreiber On Becoming The Master Chief",
            "overview": "Sydnee is joined by the Master Chief himself, Pablo Schreiber, Master Chief's highly advanced A.I., Cortana, and AEW professional wrestler Adam Cole.",
            "production_code": "",
            "runtime": 22,
            "season_number": 0,
            "still_path": "/fomo40bejAKsTBssLCidOqTRsq8.jpg",
            "vote_average": 2.0,
            "vote_count": 2
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}