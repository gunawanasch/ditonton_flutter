import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTVEpisode {
  final TVRepository repository;

  GetTVEpisode(this.repository);

  Future<Either<Failure, List<TVEpisode>>> execute(int idTV, int seasonNumber) {
    return repository.getTVEpisode(idTV, seasonNumber);
  }
}
