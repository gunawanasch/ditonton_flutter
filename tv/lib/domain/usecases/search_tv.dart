import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SearchTV {
  final TVRepository repository;

  SearchTV(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTV(query);
  }
}