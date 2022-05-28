import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/save_remove_watchlist_tv_bloc.dart';

import 'save_remove_watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTV, RemoveWatchlistTV])
void main() {
  late SaveRemoveWatchlistTVBloc saveRemoveWatchlistTVBloc;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;

  setUp(() {
    mockSaveWatchlistTV = MockSaveWatchlistTV();
    mockRemoveWatchlistTV = MockRemoveWatchlistTV();
    saveRemoveWatchlistTVBloc = SaveRemoveWatchlistTVBloc(mockSaveWatchlistTV, mockRemoveWatchlistTV);
  });

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

  test('initial state should be empty', () {
    expect(saveRemoveWatchlistTVBloc.state, const SaveRemoveWatchlistTVInitial());
  });

  blocTest<SaveRemoveWatchlistTVBloc, SaveRemoveWatchlistTVState>(
    'Should emit [Loading, Success] when data is saved successfully',
    build: () {
      when(mockSaveWatchlistTV.execute(tTVDetail))
          .thenAnswer((_) async => const Right('saved to watchlist'));
      return saveRemoveWatchlistTVBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistTV(tv: tTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistTVLoading(),
      const AddWatchlistTVSuccess('saved to watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTV.execute(tTVDetail));
    },
  );

  blocTest<SaveRemoveWatchlistTVBloc, SaveRemoveWatchlistTVState>(
    'Should emit [Loading, Error] when save is unsuccessfull',
    build: () {
      when(mockSaveWatchlistTV.execute(tTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return saveRemoveWatchlistTVBloc;
    },
    act: (bloc) => bloc.add(AddWatchlistTV(tv: tTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistTVLoading(),
      const SaveRemoveWatchlistTVError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTV.execute(tTVDetail));
    },
  );

  blocTest<SaveRemoveWatchlistTVBloc, SaveRemoveWatchlistTVState>(
    'Should emit [Loading, Success] when data is removed successfully',
    build: () {
      when(mockRemoveWatchlistTV.execute(tTVDetail))
          .thenAnswer((_) async => const Right('removed from watchlist'));
      return saveRemoveWatchlistTVBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistTV(tv: tTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistTVLoading(),
      const DeleteWatchlistTVSuccess('removed from watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTV.execute(tTVDetail));
    },
  );

  blocTest<SaveRemoveWatchlistTVBloc, SaveRemoveWatchlistTVState>(
    'Should emit [Loading, Error] when save is unsuccessfull',
    build: () {
      when(mockRemoveWatchlistTV.execute(tTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return saveRemoveWatchlistTVBloc;
    },
    act: (bloc) => bloc.add(DeleteWatchlistTV(tv: tTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const SaveRemoveWatchlistTVLoading(),
      const SaveRemoveWatchlistTVError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTV.execute(tTVDetail));
    },
  );
  
}