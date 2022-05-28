import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/usecases/get_tv_episode.dart';
import 'package:flutter/foundation.dart';

class TVEpisodeNotifier extends ChangeNotifier {
  final GetTVEpisode getTVEpisode;

  TVEpisodeNotifier({required this.getTVEpisode});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVEpisode> _tvEpisode = [];
  List<TVEpisode> get tvEpisode => _tvEpisode;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVEpisode(int idTV, int seasonNumber) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTVEpisode.execute(idTV, seasonNumber);

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (tvEpisodeData) {
        _tvEpisode = tvEpisodeData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}