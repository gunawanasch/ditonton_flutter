import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_episode_model.dart';

class TVEpisodeResponse extends Equatable {
  final List<TVEpisodeModel> tvEpisodeList;

  const TVEpisodeResponse({required this.tvEpisodeList});

  factory TVEpisodeResponse.fromJson(Map<String, dynamic> json) => TVEpisodeResponse(
    tvEpisodeList: List<TVEpisodeModel>.from((json["episodes"] as List)
        .map((x) => TVEpisodeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "episodes": List<dynamic>.from(tvEpisodeList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvEpisodeList];
}