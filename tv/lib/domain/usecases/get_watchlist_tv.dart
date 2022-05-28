import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetWatchlistTV {
  final TVRepository _repository;

  GetWatchlistTV(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTV();
  }
}
