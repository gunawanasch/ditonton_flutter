import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchListStatusTV(mockTVRepository);
  });

  test('should get watchlist status TV from repository', () async {
    // arrange
    when(mockTVRepository.isAddedToWatchlistTV(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
