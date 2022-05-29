import 'package:about/about.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:movie/movie_injection.dart' as movie_di;
import 'package:tv/tv_injection.dart' as tv_di;
import 'package:tv/tv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  movie_di.init();
  tv_di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => movie_di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => movie_di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => movie_di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => movie_di.locator<TopRatedMoviesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case HomeTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeTVPage());
            case NowPlayingTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingTVPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SearchTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case WatchlistTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
