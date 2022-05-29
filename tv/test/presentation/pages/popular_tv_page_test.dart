import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

class MockPopularTVBloc extends MockBloc<PopularTVEvent, PopularTVState> implements PopularTVBloc {}
class PopularTVStateFake extends Fake implements PopularTVState {}
class PopularTVEventFake extends Fake implements PopularTVEvent {}

void main() {
  late MockPopularTVBloc mockPopularTVBloc;
  late PopularTVBloc popularTVBloc;

  setUp(() {
    mockPopularTVBloc = MockPopularTVBloc();
  });

  final tTVModel = TV(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: const [10759, 10765],
    id: 52814,
    name: "Halo",
    originalName: "Halo",
    overview: "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 4720.286,
    posterPath: "/eO0QV5qJaEngP1Ax9w3eV6bJG2f.jpg",
    voteAverage: 8.7,
    voteCount: 645,
  );
  final tTVList = [tTVModel];

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockPopularTVBloc>(
      create: (context) => mockPopularTVBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        final di = GetIt.instance;
        di.registerFactory<PopularTVBloc>(() => mockPopularTVBloc);
        popularTVBloc = di<PopularTVBloc>();

        when(() => mockPopularTVBloc.state).thenReturn(const PopularTVInitial());
        when(() => mockPopularTVBloc.state).thenReturn(const PopularTVLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        final di = GetIt.instance;
        di.unregister<PopularTVBloc>();
        di.registerFactory<PopularTVBloc>(() => mockPopularTVBloc);
        popularTVBloc = di<PopularTVBloc>();

        when(() => mockPopularTVBloc.state).thenReturn(const PopularTVInitial());
        when(() => mockPopularTVBloc.state).thenReturn(const PopularTVLoading());
        when(() => mockPopularTVBloc.add(PopularTV())).thenAnswer((_) async => {});
        when(() => mockPopularTVBloc.state).thenAnswer((_) => PopularTVSuccess(tTVList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        final di = GetIt.instance;
        di.unregister<PopularTVBloc>();
        di.registerFactory<PopularTVBloc>(() => mockPopularTVBloc);
        popularTVBloc = di<PopularTVBloc>();

        when(() => mockPopularTVBloc.state).thenReturn(const PopularTVInitial());
        when(() => mockPopularTVBloc.state).thenReturn(const PopularTVLoading());
        when(() => mockPopularTVBloc.add(PopularTV())).thenAnswer((_) async => {});
        when(() => mockPopularTVBloc.state).thenAnswer((_) => const PopularTVError('error_message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

        expect(textFinder, findsOneWidget);
      });

}