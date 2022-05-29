import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/get_watchlist_movies_bloc.dart';

class MockGetWatchlistMoviesBloc extends MockBloc<GetWatchlistMoviesEvent, GetWatchlistMoviesState> implements GetWatchlistMoviesBloc {}
class GetWatchlistMoviesStateFake extends Fake implements GetWatchlistMoviesState {}
class GetWatchlistMoviesEventFake extends Fake implements GetWatchlistMoviesEvent {}

void main() {
  late MockGetWatchlistMoviesBloc mockGetWatchlistMoviesBloc;
  late GetWatchlistMoviesBloc getWatchlistMoviesBloc;

  setUp(() {
    mockGetWatchlistMoviesBloc = MockGetWatchlistMoviesBloc();

    final di = GetIt.instance;
    di.registerFactory<GetWatchlistMoviesBloc>(() => mockGetWatchlistMoviesBloc);

    getWatchlistMoviesBloc = di<GetWatchlistMoviesBloc>();
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockGetWatchlistMoviesBloc>(
      create: (context) => mockGetWatchlistMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const GetWatchlistMoviesInitial());
        when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const GetWatchlistMoviesLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const GetWatchlistMoviesInitial());
        when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const GetWatchlistMoviesLoading());
        when(() => mockGetWatchlistMoviesBloc.add(LoadWatchlistMovies())).thenAnswer((_) async => {});
        when(() => mockGetWatchlistMoviesBloc.state).thenAnswer((_) => GetWatchlistMoviesSuccess(tMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const GetWatchlistMoviesInitial());
        when(() => mockGetWatchlistMoviesBloc.state).thenReturn(const GetWatchlistMoviesLoading());
        when(() => mockGetWatchlistMoviesBloc.add(LoadWatchlistMovies())).thenAnswer((_) async => {});
        when(() => mockGetWatchlistMoviesBloc.state).thenAnswer((_) => const GetWatchlistMoviesError("error_message"));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

        expect(textFinder, findsOneWidget);
  });

}