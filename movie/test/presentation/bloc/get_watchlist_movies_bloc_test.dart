import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/get_watchlist_movies_bloc.dart';

import 'get_watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late GetWatchlistMoviesBloc getWatchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    getWatchlistMoviesBloc = GetWatchlistMoviesBloc(mockGetWatchlistMovies);
  });

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
  final tMovieList = <Movie>[tMovieModel];

  test('initial state should be empty', () {
    expect(getWatchlistMoviesBloc.state, const GetWatchlistMoviesInitial());
  });

  blocTest<GetWatchlistMoviesBloc, GetWatchlistMoviesState>(
    'Should emit [Loading, Success] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return getWatchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const GetWatchlistMoviesLoading(),
      GetWatchlistMoviesSuccess(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<GetWatchlistMoviesBloc, GetWatchlistMoviesState>(
    'Should emit [Loading, Error] when unsuccessfull',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return getWatchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistMovies()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const GetWatchlistMoviesLoading(),
      const GetWatchlistMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

}