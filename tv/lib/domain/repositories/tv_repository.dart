import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_episode.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getNowPlayingTV();
  Future<Either<Failure, List<TV>>> getPopularTV();
  Future<Either<Failure, List<TV>>> getTopRatedTV();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTV(String query);
  Future<Either<Failure, String>> saveWatchlistTV(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlistTV(TVDetail tv);
  Future<bool> isAddedToWatchlistTV(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTV();
  Future<Either<Failure, List<TVEpisode>>> getTVEpisode(int idTV, int seasonNumber);
}