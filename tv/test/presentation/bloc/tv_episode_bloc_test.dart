import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/usecases/get_tv_episode.dart';
import 'package:tv/presentation/bloc/tv_episode_bloc.dart';

import 'tv_episode_bloc_test.mocks.dart';

@GenerateMocks([GetTVEpisode])
void main() {
  late TVEpisodeBloc tvEpisodeBloc;
  late MockGetTVEpisode mockGetTVEpisode;

  setUp(() {
    mockGetTVEpisode = MockGetTVEpisode();
    tvEpisodeBloc = TVEpisodeBloc(mockGetTVEpisode);
  });

  const tIdTV = 1;
  const tSeasonNumber = 1;
  final tTVEpisodeModel = TVEpisode(
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
  final tTVEpisodeList = [tTVEpisodeModel];

  test('initial state should be empty', () {
    expect(tvEpisodeBloc.state, const TVEpisodeInitial());
  });

  blocTest<TVEpisodeBloc, TVEpisodeState>(
    'Should emit [Loading, Success] when data is gotten successfully',
    build: () {
      when(mockGetTVEpisode.execute(tIdTV, tSeasonNumber))
          .thenAnswer((_) async => Right(tTVEpisodeList));
      return tvEpisodeBloc;
    },
    act: (bloc) => bloc.add(LoadTVEpisode(idTV: tIdTV, seasonNumber: tSeasonNumber)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const TVEpisodeLoading(),
      TVEpisodeSuccess(tTVEpisodeList),
    ],
    verify: (bloc) {
      verify(mockGetTVEpisode.execute(tIdTV, tSeasonNumber));
    },
  );

  blocTest<TVEpisodeBloc, TVEpisodeState>(
    'Should emit [Loading, Error] when unsuccessfull',
    build: () {
      when(mockGetTVEpisode.execute(tIdTV, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvEpisodeBloc;
    },
    act: (bloc) => bloc.add(LoadTVEpisode(idTV: tIdTV, seasonNumber: tSeasonNumber)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const TVEpisodeLoading(),
      const TVEpisodeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVEpisode.execute(tIdTV, tSeasonNumber));
    },
  );

}