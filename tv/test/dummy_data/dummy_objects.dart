import 'package:movie/movie.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_episode.dart';

final testTV = TV(
  backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
  firstAirDate: "2022-03-24",
  genreIds: [10759, 10765],
  id: 52814,
  name: "Halo",
  originalName: "Halo",
  overview: "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
  popularity: 4720.286,
  posterPath: "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
  voteAverage: 8.7,
  voteCount: 645,
);

final testTVList = [testTV];

final testTVDetail = TVDetail(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genres: [Genre(id: 10759, name: "Action & Adventure"), Genre(id: 10765, name: "Sci-Fi & Fantasy")],
    id: 52814,
    name: "Halo",
    originalName: "Halo",
    overview: "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 4720.286,
    posterPath: "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
    voteAverage: 8.7,
    voteCount: 650,
    seasons: [Season(
        airDate: "2022-03-24",
        episodeCount: 8,
        id: 284981,
        name: "Specials",
        overview: "",
        posterPath: null,
        seasonNumber: 0,
      ),
      Season(
        airDate: "2022-03-24",
        episodeCount: 9,
        id: 105701,
        name: "Season 1",
        overview: "",
        posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
        seasonNumber: 1,
      )
    ],
);

final testWatchlistTV = TV.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};

final testTVEpisode = TVEpisode(
  airDate: "2022-03-24",
  episodeNumber: 1,
  id: 3620542,
  name: "Pablo Schreiber On Becoming The Master Chief",
  overview: "Sydnee is joined by the Master Chief himself, Pablo Schreiber, Master Chief's highly advanced A.I., Cortana, and AEW professional wrestler Adam Cole.",
  productionCode: "",
  runtime: 22,
  seasonNumber: 0,
  stillPath: "/fomo40bejAKsTBssLCidOqTRsq8.jpg",
  voteAverage: 2.0,
  voteCount: 2,
);

final testTVEpisodeList = [testTVEpisode];
