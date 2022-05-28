import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetNowPlayingTV {
  final TVRepository repository;

  GetNowPlayingTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTV();
  }
}