import 'package:core/utils/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

void main() {
  // late MockTVDetailNotifier mockNotifier;
  //
  // setUp(() {
  //   mockNotifier = MockTVDetailNotifier();
  // });
  //
  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<TVDetailNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  //
  // testWidgets(
  //     'Watchlist button should display add icon when tv not added to watchlist',
  //         (WidgetTester tester) async {
  //       when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tv).thenReturn(testTVDetail);
  //       when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
  //       when(mockNotifier.isAddedToWatchlistTV).thenReturn(false);
  //
  //       final watchlistButtonIcon = find.byIcon(Icons.add);
  //
  //       await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
  //
  //       expect(watchlistButtonIcon, findsOneWidget);
  //     });
  //
  // testWidgets(
  //     'Watchlist button should dispay check icon when tv is added to wathclist',
  //         (WidgetTester tester) async {
  //       when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tv).thenReturn(testTVDetail);
  //       when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
  //       when(mockNotifier.isAddedToWatchlistTV).thenReturn(true);
  //
  //       final watchlistButtonIcon = find.byIcon(Icons.check);
  //
  //       await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
  //
  //       expect(watchlistButtonIcon, findsOneWidget);
  //     });
  //
  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //         (WidgetTester tester) async {
  //       when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tv).thenReturn(testTVDetail);
  //       when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
  //       when(mockNotifier.isAddedToWatchlistTV).thenReturn(false);
  //       when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
  //
  //       final watchlistButton = find.byType(ElevatedButton);
  //
  //       await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
  //
  //       expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //       await tester.tap(watchlistButton);
  //       await tester.pump();
  //
  //       expect(find.byType(SnackBar), findsOneWidget);
  //       expect(find.text('Added to Watchlist'), findsOneWidget);
  //     });
  //
  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //         (WidgetTester tester) async {
  //       when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tv).thenReturn(testTVDetail);
  //       when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //       when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
  //       when(mockNotifier.isAddedToWatchlistTV).thenReturn(false);
  //       when(mockNotifier.watchlistMessage).thenReturn('Failed');
  //
  //       final watchlistButton = find.byType(ElevatedButton);
  //
  //       await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
  //
  //       expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //       await tester.tap(watchlistButton);
  //       await tester.pump();
  //
  //       expect(find.byType(AlertDialog), findsOneWidget);
  //       expect(find.text('Failed'), findsOneWidget);
  //     });
}