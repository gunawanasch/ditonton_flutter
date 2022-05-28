import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/save_remove_watchlist_bloc.dart';

import 'save_remove_watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist])
void main() {
  late SaveRemoveWatchlistBloc saveRemoveWatchlistBloc;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    saveRemoveWatchlistBloc = SaveRemoveWatchlistBloc(mockSaveWatchlist, mockRemoveWatchlist);
  });

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

  test('initial state should be empty', () {
    expect(saveRemoveWatchlistBloc.state, const SaveRemoveWatchlistInitial());
  });

  blocTest<SaveRemoveWatchlistBloc, SaveRemoveWatchlistState>(
    'Should emit [Loading, Success] when data is saved successfully',
    build: () {
      when(mockSaveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('saved to watchlist'));
      return saveRemoveWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(movie: tMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistLoading(),
      const AddWatchlistSuccess('saved to watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tMovieDetail));
    },
  );

  blocTest<SaveRemoveWatchlistBloc, SaveRemoveWatchlistState>(
    'Should emit [Loading, Error] when save is unsuccessfull',
    build: () {
      when(mockSaveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return saveRemoveWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddWatchlist(movie: tMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistLoading(),
      const SaveRemoveWatchlistError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tMovieDetail));
    },
  );

  blocTest<SaveRemoveWatchlistBloc, SaveRemoveWatchlistState>(
    'Should emit [Loading, Success] when data is removed successfully',
    build: () {
      when(mockRemoveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('removed from watchlist'));
      return saveRemoveWatchlistBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlist(movie: tMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistLoading(),
      const DeleteWatchlistSuccess('removed from watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tMovieDetail));
    },
  );

  blocTest<SaveRemoveWatchlistBloc, SaveRemoveWatchlistState>(
    'Should emit [Loading, Error] when save is unsuccessfull',
    build: () {
      when(mockRemoveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return saveRemoveWatchlistBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlist(movie: tMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistLoading(),
      const SaveRemoveWatchlistError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tMovieDetail));
    },
  );

}