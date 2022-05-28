import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class TVDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchListStatusTV getWatchListStatusTV;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;

  TVDetailNotifier({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatusTV,
    required this.saveWatchlistTV,
    required this.removeWatchlistTV,
  });

  late TVDetail _tv;
  TVDetail get tv => _tv;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<TV> _tvRecommendations = [];
  List<TV> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTV = false;
  bool get isAddedToWatchlistTV => _isAddedtoWatchlistTV;

  Future<void> fetchTVDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVDetail.execute(id);
    final recommendationResult = await getTVRecommendations.execute(id);
    detailResult.fold(
          (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tv) {
        _recommendationState = RequestState.Loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
              (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
              (tv) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tv;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlistTV(TVDetail tv) async {
    final result = await saveWatchlistTV.execute(tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusTV(tv.id);
  }

  Future<void> removeFromWatchlistTV(TVDetail tv) async {
    final result = await removeWatchlistTV.execute(tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusTV(tv.id);
  }

  Future<void> loadWatchlistStatusTV(int id) async {
    final result = await getWatchListStatusTV.execute(id);
    _isAddedtoWatchlistTV = result;
    notifyListeners();
  }
}