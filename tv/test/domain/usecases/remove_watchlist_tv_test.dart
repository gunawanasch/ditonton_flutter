import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = RemoveWatchlistTV(mockTVRepository);
  });

  test('should remove watchlist TV from repository', () async {
    // arrange
    when(mockTVRepository.removeWatchlistTV(testTVDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.removeWatchlistTV(testTVDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
