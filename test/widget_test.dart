// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:netflix/main.dart';

void main() {
  testWidgets('Netflix app starts correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const NetflixApp());

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Games'), findsOneWidget);
    expect(find.text('New & Hot'), findsOneWidget);
    expect(find.text('Downloads'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });

  testWidgets('Hero banner displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const NetflixApp());

    expect(find.text('Stranger Things'), findsOneWidget);
    expect(find.text('Thriller • Sci-Fi • Horror'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);
    expect(find.text('My List'), findsOneWidget);
    expect(find.text('Info'), findsOneWidget);
  });

  testWidgets('Movie sections are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const NetflixApp());

    expect(find.text('Trending Now'), findsOneWidget);
    expect(find.text('Netflix Originals'), findsOneWidget);
    expect(find.text('Continue Watching'), findsOneWidget);
    expect(find.text('Recommended for You'), findsOneWidget);
    expect(find.text('Action & Adventure'), findsOneWidget);
    expect(find.text('Comedy Movies'), findsOneWidget);
  });

  testWidgets('Bottom navigation works', (WidgetTester tester) async {
    await tester.pumpWidget(const NetflixApp());

    await tester.tap(find.text('Games'));
    await tester.pump();

    expect(find.text('Games'), findsWidgets);

    await tester.tap(find.text('Downloads'));
    await tester.pump();

    expect(find.text('Downloads'), findsWidgets);
  });
}
