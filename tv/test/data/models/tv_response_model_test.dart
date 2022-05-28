import 'dart:convert';

import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    originalName: "Halo",
    overview: "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 4263.558,
    posterPath: "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
    voteAverage: 8.7,
    voteCount: 655,
  );
  final tTVResponseModel =
  TVResponse(tvList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/popular_tv.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
            "first_air_date": "2022-03-24",
            "genre_ids": [
              10759,
              10765
            ],
            "id": 52814,
            "name": "Halo",
            "original_name": "Halo",
            "overview": "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
            "popularity": 4263.558,
            "poster_path": "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
            "vote_average": 8.7,
            "vote_count": 655
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}