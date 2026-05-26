import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_hunter/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PatternHunterApp());

    // Verify that the dashboard is loaded.
    expect(find.text('LIVE ASSETS TICKER'), findsOneWidget);
  });
}
