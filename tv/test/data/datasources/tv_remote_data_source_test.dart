import 'dart:convert';
import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_episode_response.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TV', () {
    final tTVList = TVResponse.fromJson(
        json.decode(readJson('dummy_data/now_playing_tv.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing_tv.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
                }
              ));
          // act
          final result = await dataSource.getNowPlayingTV();
          // assert
          expect(result, equals(tTVList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getNowPlayingTV();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular TV', () {
    final tTVList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/popular_tv.json')))
            .tvList;

    test('should return list of TV when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
          // act
          final result = await dataSource.getPopularTV();
          // assert
          expect(result, tTVList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularTV();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated TV', () {
    final tTVList = TVResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvList;

    test('should return list of TV when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated_tv.json'),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }
          ));
      // act
      final result = await dataSource.getTopRatedTV();
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTopRatedTV();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get TV detail', () {
    final tId = 1;
    final tTVDetail = TVDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return TV detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTVDetail(tId);
      // assert
      expect(result, equals(tTVDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTVDetail(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get TV recommendations', () {
    final tTVList = TVResponse.fromJson(
        json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of TV Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
                }
          ));
          // act
          final result = await dataSource.getTVRecommendations(tId);
          // assert
          expect(result, equals(tTVList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTVRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search TV', () {
    final tSearchResult = TVResponse.fromJson(
        json.decode(readJson('dummy_data/search_halo_tv.json')))
        .tvList;
    final tQuery = 'halo';

    test('should return list of TV when response code is 200', () async {
      // arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_halo_tv.json'), 200));
      // act
      final result = await dataSource.searchTV(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.searchTV(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });



  group('get TV episodes', () {
    final tTVEpisodeList = TVEpisodeResponse.fromJson(
        json.decode(readJson('dummy_data/tv_episode.json')))
        .tvEpisodeList;
    final idTV = 52814;
    final seasonNumber = 0;

    test('should return list of TV Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$idTV/season/$seasonNumber?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_episode.json'),
                200,
                headers: {
                  HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
                }
          ));
          // act
          final result = await dataSource.getTVEpisode(idTV, seasonNumber);
          // assert
          expect(result, equals(tTVEpisodeList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$idTV/season/$seasonNumber?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTVEpisode(idTV, seasonNumber);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}