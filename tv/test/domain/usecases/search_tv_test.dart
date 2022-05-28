import 'package:tv/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/search_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTV(mockTVRepository);
  });

  final tTV = <TV>[];
  final tQuery = 'halo';

  test('should get list of TV from the repository', () async {
    // arrange
    when(mockTVRepository.searchTV(tQuery))
        .thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTV));
  });
}
