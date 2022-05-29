import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTopRatedMoviesBloc extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState> implements TopRatedMoviesBloc {}
class TopRatedMoviesStateFake extends Fake implements TopRatedMoviesState {}
class TopRatedMoviesEventFake extends Fake implements TopRatedMoviesEvent {}

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();

    final di = GetIt.instance;
    di.registerFactory<TopRatedMoviesBloc>(() => mockTopRatedMoviesBloc);

    topRatedMoviesBloc = di<TopRatedMoviesBloc>();
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
    return BlocProvider<MockTopRatedMoviesBloc>(
      create: (context) => mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(const TopRatedMoviesInitial());
    when(() => mockTopRatedMoviesBloc.state).thenReturn(const TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(const TopRatedMoviesInitial());
    when(() => mockTopRatedMoviesBloc.state).thenReturn(const TopRatedMoviesLoading());
    when(() => mockTopRatedMoviesBloc.add(TopRatedMovies())).thenAnswer((_) async => {});
    when(() => mockTopRatedMoviesBloc.state).thenAnswer((_) => TopRatedMoviesSuccess(tMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(const TopRatedMoviesInitial());
    when(() => mockTopRatedMoviesBloc.state).thenReturn(const TopRatedMoviesLoading());
    when(() => mockTopRatedMoviesBloc.add(TopRatedMovies())).thenAnswer((_) async => {});
    when(() => mockTopRatedMoviesBloc.state).thenAnswer((_) => const TopRatedMoviesError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

}
