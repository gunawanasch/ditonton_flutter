import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/usecases/get_tv_episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVEpisode usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVEpisode(mockTVRepository);
  });

  final tTVEpisode = <TVEpisode>[];
  final idTV = 1;
  final seasonNumber = 1;

  group('GetTVEpisode Tests', () {
    group('execute', () {
      test(
          'should get list of TV episodes from the repository when execute function is called',
              () async {
            // arrange
            when(mockTVRepository.getTVEpisode(idTV, seasonNumber))
                .thenAnswer((_) async => Right(tTVEpisode));
            // act
            final result = await usecase.execute(idTV, seasonNumber);
            // assert
            expect(result, Right(tTVEpisode));
          });
    });
  });
}