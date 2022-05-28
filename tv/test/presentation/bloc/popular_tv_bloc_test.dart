import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late PopularTVBloc popularTVBloc;
  late MockGetPopularTV mockGetPopularTV;

  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    popularTVBloc = PopularTVBloc(mockGetPopularTV);
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
    expect(popularTVBloc.state, const PopularTVInitial());
  });

  blocTest<PopularTVBloc, PopularTVState>(
    'Should emit [Loading, Success] when data is gotten successfully',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      return popularTVBloc;
    },
    act: (bloc) => bloc.add(PopularTV()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const PopularTVLoading(),
      PopularTVSuccess(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );

  blocTest<PopularTVBloc, PopularTVState>(
    'Should emit [Loading, Error] when unsuccessfull',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTVBloc;
    },
    act: (bloc) => bloc.add(PopularTV()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const PopularTVLoading(),
      const PopularTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );

}