import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';
import 'package:tv/domain/entities/season.dart';

class TVDetail extends Equatable {
  const TVDetail({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
    backdropPath,
    firstAirDate,
    genres,
    id,
    name,
    originalName,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
    seasons,
  ];
}