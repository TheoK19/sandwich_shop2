import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/main.dart';

void main() {
  testWidgets('OrderScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the initial UI is rendered correctly.
    expect(find.text('Sandwich Counter'), findsOneWidget);
    expect(find.text('No items in your order yet.'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget); // For the logo

    // Tap the 'Add' button and verify the quantity increases.
    await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
    await tester.pump();

    // Verify the order details are displayed
    expect(find.textContaining('1 wheat untoasted footlong veggieDelight(es)'), findsOneWidget);
    expect(find.textContaining('£8.50'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName.contains('veggieDelight_footlong.png')), findsOneWidget);


    // Tap the 'Add' button again and verify the quantity increases.
    await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
    await tester.pump();
    expect(find.textContaining('2 wheat untoasted footlong veggieDelight(es)'), findsOneWidget);
    expect(find.textContaining('£17.00'), findsOneWidget);

    // Tap the 'Remove' button and verify the quantity decreases.
    await tester.tap(find.byIcon(Icons.remove), warnIfMissed: false);
    await tester.pump();
    expect(find.textContaining('1 wheat untoasted footlong veggieDelight(es)'), findsOneWidget);
    expect(find.textContaining('£8.50'), findsOneWidget);

    // Toggle the sandwich type to six-inch.
    await tester.tap(find.byKey(const Key('sandwich_type_switch')), warnIfMissed: false);
    await tester.pump();
    expect(find.textContaining('1 wheat untoasted six-inch veggieDelight(es)'), findsOneWidget);
    expect(find.textContaining('£6.50'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName.contains('veggieDelight_six_inch.png')), findsOneWidget);


    // Toggle the toasted switch.
    await tester.tap(find.byKey(const Key('toasted_switch')), warnIfMissed: false);
    await tester.pump();
    expect(find.textContaining('1 wheat toasted six-inch veggieDelight(es)'), findsOneWidget);


    // Enter a note in the text field.
    await tester.enterText(find.byKey(const Key('notes_textfield')), 'No mayo');
    await tester.pump();
    expect(find.text('Note: No mayo'), findsOneWidget);
  });
}
