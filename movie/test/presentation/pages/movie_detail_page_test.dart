import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/save_remove_watchlist_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState> implements MovieDetailBloc {}
class MovieDetailStateFake extends Fake implements MovieDetailState {}
class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MockSaveRemoveWatchlistBloc extends MockBloc<SaveRemoveWatchlistEvent, SaveRemoveWatchlistState> implements SaveRemoveWatchlistBloc {}
class SaveRemoveWatchlistStateFake extends Fake implements SaveRemoveWatchlistState {}
class SaveRemoveWatchlistEventFake extends Fake implements SaveRemoveWatchlistEvent {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockSaveRemoveWatchlistBloc mockSaveRemoveWatchlistBloc;
  late MovieDetailBloc movieDetailBloc;
  late SaveRemoveWatchlistBloc saveRemoveWatchlistBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockSaveRemoveWatchlistBloc = MockSaveRemoveWatchlistBloc();

    final di = GetIt.instance;
    di.registerFactory<MovieDetailBloc>(() => mockMovieDetailBloc);
    di.registerFactory<SaveRemoveWatchlistBloc>(() => mockSaveRemoveWatchlistBloc);

    movieDetailBloc = di<MovieDetailBloc>();
    saveRemoveWatchlistBloc = di<SaveRemoveWatchlistBloc>();
  });

  const tId = 1;
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
  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovieModel];

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockMovieDetailBloc>(
      create: (context) => mockMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailInitial());
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoading());
        when(() => mockMovieDetailBloc.add(const LoadMovieDetail(id: tId))).thenAnswer((_) async => {});
        when(() => mockMovieDetailBloc.state).thenAnswer((_) => MovieDetailSuccess(tMovieDetail, tMovieList, false));
        when(() => mockSaveRemoveWatchlistBloc.state).thenReturn(const SaveRemoveWatchlistInitial());

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
        await tester.pump(Duration.zero);

        expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailInitial());
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoading());
        when(() => mockMovieDetailBloc.add(const LoadMovieDetail(id: tId))).thenAnswer((_) async => {});
        when(() => mockMovieDetailBloc.state).thenAnswer((_) => MovieDetailSuccess(tMovieDetail, tMovieList, true));
        when(() => mockSaveRemoveWatchlistBloc.state).thenReturn(const SaveRemoveWatchlistInitial());

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
        await tester.pump(Duration.zero);

        expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when add to watchlist success',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailInitial());
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoading());
        when(() => mockMovieDetailBloc.add(const LoadMovieDetail(id: tId))).thenAnswer((_) async => {});
        when(() => mockMovieDetailBloc.state).thenAnswer((_) => MovieDetailSuccess(tMovieDetail, tMovieList, false));
        when(() => mockSaveRemoveWatchlistBloc.state).thenReturn(const SaveRemoveWatchlistInitial());
        whenListen(
          mockSaveRemoveWatchlistBloc,
          Stream.fromIterable([
            const SaveRemoveWatchlistLoading(),
            const AddWatchlistSuccess('Added to Watchlist'),
          ]),
          initialState: const SaveRemoveWatchlistInitial(),
        );

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Error message when add to watchlist fail',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailInitial());
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoading());
        when(() => mockMovieDetailBloc.add(const LoadMovieDetail(id: tId))).thenAnswer((_) async => {});
        when(() => mockMovieDetailBloc.state).thenAnswer((_) => MovieDetailSuccess(tMovieDetail, tMovieList, false));
        when(() => mockSaveRemoveWatchlistBloc.state).thenReturn(const SaveRemoveWatchlistInitial());
        whenListen(
          mockSaveRemoveWatchlistBloc,
          Stream.fromIterable([
            const SaveRemoveWatchlistLoading(),
            const SaveRemoveWatchlistError('Database Failure'),
          ]),
          initialState: const SaveRemoveWatchlistInitial(),
        );

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
        await tester.pump();

        expect(find.text('Database Failure'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when remove from watchlist success',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailInitial());
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoading());
        when(() => mockMovieDetailBloc.add(const LoadMovieDetail(id: tId))).thenAnswer((_) async => {});
        when(() => mockMovieDetailBloc.state).thenAnswer((_) => MovieDetailSuccess(tMovieDetail, tMovieList, true));
        when(() => mockSaveRemoveWatchlistBloc.state).thenReturn(const SaveRemoveWatchlistInitial());
        whenListen(
          mockSaveRemoveWatchlistBloc,
          Stream.fromIterable([
            const SaveRemoveWatchlistLoading(),
            const DeleteWatchlistSuccess('Removed from Watchlist'),
          ]),
          initialState: const SaveRemoveWatchlistInitial(),
        );

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Error message when remove from watchlist fail',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailInitial());
        when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoading());
        when(() => mockMovieDetailBloc.add(const LoadMovieDetail(id: tId))).thenAnswer((_) async => {});
        when(() => mockMovieDetailBloc.state).thenAnswer((_) => MovieDetailSuccess(tMovieDetail, tMovieList, true));
        when(() => mockSaveRemoveWatchlistBloc.state).thenReturn(const SaveRemoveWatchlistInitial());
        whenListen(
          mockSaveRemoveWatchlistBloc,
          Stream.fromIterable([
            const SaveRemoveWatchlistLoading(),
            const SaveRemoveWatchlistError('Database Failure'),
          ]),
          initialState: const SaveRemoveWatchlistInitial(),
        );

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
        await tester.pump();

        expect(find.text('Database Failure'), findsOneWidget);
  });

}
