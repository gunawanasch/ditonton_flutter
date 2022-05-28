import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/search_tv_bloc.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late SearchTVBloc searchTVBloc;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
    searchTVBloc = SearchTVBloc(mockSearchTV);
  });

  test('initial state should be empty', () {
    expect(searchTVBloc.state, SearchTVEmpty());
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
  final tTVList = <TV>[tTVModel];
  final tQuery = 'Halo';

  blocTest<SearchTVBloc, SearchTVState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      return searchTVBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTV(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      SearchTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );

  blocTest<SearchTVBloc, SearchTVState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTVBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTV(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      const SearchTVError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );

}