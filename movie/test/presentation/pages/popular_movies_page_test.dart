import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPopularMoviesBloc extends MockBloc<PopularMoviesEvent, PopularMoviesState> implements PopularMoviesBloc {}
class PopularMoviesStateFake extends Fake implements PopularMoviesState {}
class PopularMoviesEventFake extends Fake implements PopularMoviesEvent {}

void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late PopularMoviesBloc popularMoviesBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();

    final di = GetIt.instance;
    di.registerFactory<PopularMoviesBloc>(() => mockPopularMoviesBloc);

    popularMoviesBloc = di<PopularMoviesBloc>();
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
    return BlocProvider<MockPopularMoviesBloc>(
      create: (context) => mockPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesInitial());
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesInitial());
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesLoading());
    when(() => mockPopularMoviesBloc.add(PopularMovies())).thenAnswer((_) async => {});
    when(() => mockPopularMoviesBloc.state).thenAnswer((_) => PopularMoviesSuccess(tMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesInitial());
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesLoading());
    when(() => mockPopularMoviesBloc.add(PopularMovies())).thenAnswer((_) async => {});
    when(() => mockPopularMoviesBloc.state).thenAnswer((_) => const PopularMoviesError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

}
