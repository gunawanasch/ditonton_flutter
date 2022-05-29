import 'package:get_it/get_it.dart';
import 'package:tv/presentation/bloc/get_watchlist_tv_bloc.dart';
import 'package:tv/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/save_remove_watchlist_tv_bloc.dart';
import 'package:tv/presentation/bloc/search_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_episode_bloc.dart';
import 'package:tv/presentation/provider/now_playing_tv_notifier.dart';
import 'package:tv/presentation/provider/popular_tv_notifier.dart';
import 'package:tv/presentation/provider/top_rated_tv_notifier.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:tv/presentation/provider/tv_episode_notifier.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';
import 'package:tv/presentation/provider/tv_search_notifier.dart';
import 'package:tv/presentation/provider/watchlist_tv_notifier.dart';

import 'data/datasources/tv_local_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/get_now_playing_tv.dart';
import 'domain/usecases/get_popular_tv.dart';
import 'domain/usecases/get_top_rated_tv.dart';
import 'domain/usecases/get_tv_detail.dart';
import 'domain/usecases/get_tv_episode.dart';
import 'domain/usecases/get_tv_recommendations.dart';
import 'domain/usecases/get_watchlist_status_tv.dart';
import 'domain/usecases/get_watchlist_tv.dart';
import 'domain/usecases/remove_watchlist_tv.dart';
import 'domain/usecases/save_watchlist_tv.dart';
import 'domain/usecases/search_tv.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(() => GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetTVEpisode(locator()));

  // repository
  locator.registerLazySingleton<TVRepository>(
        () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TVRemoteDataSource>(
          () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
          () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // bloc
  locator.registerFactory(() => NowPlayingTVBloc(locator()));
  locator.registerFactory(() => PopularTVBloc(locator()));
  locator.registerFactory(() => TopRatedTVBloc(locator()));
  locator.registerFactory(() => TVDetailBloc(locator(),locator(),locator()));
  locator.registerFactory(() => GetWatchlistTVBloc(locator()));
  locator.registerFactory(() => SaveRemoveWatchlistTVBloc(locator(),locator()));
  locator.registerFactory(() => SearchTVBloc(locator()));
  locator.registerFactory(() => TVEpisodeBloc(locator()));
}