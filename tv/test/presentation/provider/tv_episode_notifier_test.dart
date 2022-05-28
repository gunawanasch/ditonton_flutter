import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/usecases/get_tv_episode.dart';
import 'package:tv/presentation/provider/tv_episode_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_episode_notifier_test.mocks.dart';

@GenerateMocks([GetTVEpisode])
void main() {
  late MockGetTVEpisode mockGetTVEpisode;
  late TVEpisodeNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVEpisode = MockGetTVEpisode();
    notifier = TVEpisodeNotifier(getTVEpisode: mockGetTVEpisode)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final idTV = 1;
  final seasonNumber = 0;

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

  final tTVEpisodeList = <TVEpisode>[tTVEpisode];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTVEpisode.execute(idTV, seasonNumber))
        .thenAnswer((_) async => Right(tTVEpisodeList));
    // act
    notifier.fetchTVEpisode(idTV, seasonNumber);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetTVEpisode.execute(idTV, seasonNumber))
        .thenAnswer((_) async => Right(tTVEpisodeList));
    // act
    await notifier.fetchTVEpisode(idTV, seasonNumber);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvEpisode, tTVEpisodeList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTVEpisode.execute(idTV, seasonNumber))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTVEpisode(idTV, seasonNumber);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}