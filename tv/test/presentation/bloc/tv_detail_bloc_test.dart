import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVDetail, GetTVRecommendations, GetWatchListStatusTV])
void main() {
  late TVDetailBloc movieDetailBloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchListStatusTV mockGetWatchListStatusTV;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchListStatusTV = MockGetWatchListStatusTV();
    movieDetailBloc = TVDetailBloc(mockGetTVDetail, mockGetTVRecommendations, mockGetWatchListStatusTV);
  });

  const tId = 1;
  final tTVModel = TV(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: const [10759, 10765],
    id: 52814,
    name: "Halo",
    originalName: "Halo",
    overview: "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 4720.286,
    posterPath: "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
    voteAverage: 8.7,
    voteCount: 645,
  );
  final tTVDetail = TVDetail(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genres: [Genre(id: 10759, name: "Action & Adventure"), Genre(id: 10765, name: "Sci-Fi & Fantasy")],
    id: 52814,
    name: "Halo",
    originalName: "Halo",
    overview: "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 4720.286,
    posterPath: "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
    voteAverage: 8.7,
    voteCount: 650,
    seasons: const [Season(
      airDate: "2022-03-24",
      episodeCount: 8,
      id: 284981,
      name: "Specials",
      overview: "",
      posterPath: null,
      seasonNumber: 0,
    ),
      Season(
        airDate: "2022-03-24",
        episodeCount: 9,
        id: 105701,
        name: "Season 1",
        overview: "",
        posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
        seasonNumber: 1,
      )
    ],
  );
  final tTVList = <TV>[tTVModel];

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, const TVDetailInitial());
  });

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, Success] when data is gotten successfully',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(tTVDetail));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVList));
      when(mockGetWatchListStatusTV.execute(tId))
          .thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const LoadTVDetail(id: tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const TVDetailLoading(),
      TVDetailSuccess(tTVDetail, tTVList, true),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'Should emit [Loading, Error] when unsuccessfull',
    build: () {
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetWatchListStatusTV.execute(tId))
          .thenAnswer((_) async => false);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const LoadTVDetail(id: tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const TVDetailLoading(),
      const TVDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(tId));
    },
  );
  
}