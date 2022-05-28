import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations, GetWatchListStatus])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations, mockGetWatchListStatus);
  });

  const tId = 1;
  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovieModel];

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, const MovieDetailInitial());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Success] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(tMovieDetail));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetail(id: tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const MovieDetailLoading(),
      MovieDetailSuccess(tMovieDetail, tMovieList, true),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when unsuccessfull',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => false);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetail(id: tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

}