import 'package:movie/movie.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVDetailResponse extends Equatable {
  const TVDetailResponse({
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
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final List<SeasonModel> seasons;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) => TVDetailResponse(
    backdropPath: json["backdrop_path"],
    firstAirDate: json['first_air_date'],
    genres: List<GenreModel>.from(
        json["genres"].map((x) => GenreModel.fromJson(x))),
    id: json["id"],
    name: json["name"],
    originalName: json['original_name'],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
    seasons: List<SeasonModel>.from(
        json["seasons"].map((x) => SeasonModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": firstAirDate,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "id": id,
    "name": name,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
  };

  TVDetail toEntity() {
    return TVDetail(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      name: name,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      seasons: seasons.map((season) => season.toEntity()).toList(),
    );
  }

  @override
  // TODO: implement props
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