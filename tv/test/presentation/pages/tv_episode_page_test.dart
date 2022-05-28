import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/presentation/pages/tv_episode_page.dart';
import 'package:tv/presentation/provider/tv_episode_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_episode_page_test.mocks.dart';

@GenerateMocks([TVEpisodeNotifier])
void main() {
  late MockTVEpisodeNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTVEpisodeNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVEpisodeNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.Loading);

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TVEpisodePage(idTV: 1, seasonNumber: 0)));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvEpisode).thenReturn(<TVEpisode>[]);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TVEpisodePage(idTV: 1, seasonNumber: 0)));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Error message');

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(TVEpisodePage(idTV: 1, seasonNumber: 0)));

        expect(textFinder, findsOneWidget);
      });
}