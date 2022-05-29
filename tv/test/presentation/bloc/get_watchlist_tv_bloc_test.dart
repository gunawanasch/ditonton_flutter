import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/get_watchlist_tv_bloc.dart';

import 'get_watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTV])
void main() {
  late GetWatchlistTVBloc getWatchlistTVBloc;
  late MockGetWatchlistTV mockGetWatchlistTV;

  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
    getWatchlistTVBloc = GetWatchlistTVBloc(mockGetWatchlistTV);
  });

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

  final tTVList = [tTVModel];

  test('initial state should be empty', () {
    expect(getWatchlistTVBloc.state, const GetWatchlistTVInitial());
  });

  blocTest<GetWatchlistTVBloc, GetWatchlistTVState>(
    'Should emit [Loading, Success] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      return getWatchlistTVBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistTV()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const GetWatchlistTVLoading(),
      GetWatchlistTVSuccess(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTV.execute());
    },
  );

  blocTest<GetWatchlistTVBloc, GetWatchlistTVState>(
    'Should emit [Loading, Error] when unsuccessfull',
    build: () {
      when(mockGetWatchlistTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return getWatchlistTVBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistTV()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const GetWatchlistTVLoading(),
      const GetWatchlistTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTV.execute());
    },
  );

}