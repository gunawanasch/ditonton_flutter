import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
  GetWatchListStatusTV,
  SaveWatchlistTV,
  RemoveWatchlistTV,
])
void main() {
  late TVDetailNotifier provider;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchListStatusTV mockGetWatchlistStatusTV;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchlistStatusTV = MockGetWatchListStatusTV();
    mockSaveWatchlistTV = MockSaveWatchlistTV();
    mockRemoveWatchlistTV = MockRemoveWatchlistTV();
    provider = TVDetailNotifier(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getWatchListStatusTV: mockGetWatchlistStatusTV,
      saveWatchlistTV: mockSaveWatchlistTV,
      removeWatchlistTV: mockRemoveWatchlistTV,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;

  final tTV = TV(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    originalName: "Halo",
    overview: "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 4720.286,
    posterPath: "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
    voteAverage: 8.7,
    voteCount: 645,
  );
  final tTVs = <TV>[tTV];

  void _arrangeUsecase() {
    when(mockGetTVDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetail));
    when(mockGetTVRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTVs));
  }

  group('Get TV Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTVDetail.execute(tId));
      verify(mockGetTVRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TV when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTVDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation TV when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTVDetail(tId);
          // assert
          expect(provider.tvState, RequestState.Loaded);
          expect(provider.tvRecommendations, tTVs);
        });
  });

  group('Get TV Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTVRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTVs);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTVDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.tvRecommendations, tTVs);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVDetail));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusTV.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatusTV(1);
      // assert
      expect(provider.isAddedToWatchlistTV, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTV(testTVDetail);
      // assert
      verify(mockSaveWatchlistTV.execute(testTVDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTV(testTVDetail);
      // assert
      verify(mockRemoveWatchlistTV.execute(testTVDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTV(testTVDetail);
      // assert
      verify(mockGetWatchlistStatusTV.execute(testTVDetail.id));
      expect(provider.isAddedToWatchlistTV, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTV.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatusTV.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTV(testTVDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVs));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}