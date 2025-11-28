
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/main.dart';

void main() {
  testWidgets('OrderScreen UI Test with SnackBar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the initial UI is rendered correctly.
    expect(find.text('Sandwich Counter'), findsOneWidget);
    expect(find.text('No items in your order yet.'), findsOneWidget);
    // Check for the logo image
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == 'assets/images/logo.png'), findsOneWidget);

    // Tap the 'Add' button to add an item
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the SnackBar is shown with the correct message
    expect(find.text('Added one item to your order.'), findsOneWidget);

    // Verify the first item is displayed correctly
    expect(find.textContaining('1 x'), findsOneWidget);
    expect(find.textContaining('wheat untoasted footlong veggieDelight'), findsOneWidget);
    expect(find.textContaining('£8.50'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName.contains('veggieDelight_footlong.png')), findsOneWidget);

    // Tap the 'Add' button again to increase quantity
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the SnackBar is shown with the correct message
    expect(find.text('Added one item to your order.'), findsOneWidget);

    // Verify the quantity and price are updated
    expect(find.textContaining('2 x'), findsOneWidget);
    expect(find.textContaining('£17.00'), findsOneWidget);

    // Tap the 'Remove' button to decrease quantity
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    // Verify the SnackBar is shown with the correct message
    expect(find.text('Removed one item from your order.'), findsOneWidget);

    // Verify the quantity and price are updated
    expect(find.textContaining('1 x'), findsOneWidget);
    expect(find.textContaining('£8.50'), findsOneWidget);

    // Change sandwich type to six-inch
    await tester.tap(find.byKey(const Key('sandwich_type_switch')));
    await tester.pump();

    // Verify the type, price, and image are updated
    expect(find.textContaining('six-inch'), findsOneWidget);
    expect(find.textContaining('£6.50'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName.contains('veggieDelight_six_inch.png')), findsOneWidget);

    // Toggle the toasted switch
    await tester.tap(find.byKey(const Key('toasted_switch')));
    await tester.pump();

    // Verify the sandwich is now toasted
    expect(find.textContaining('toasted'), findsOneWidget);

    // Add a note
    await tester.enterText(find.byKey(const Key('notes_textfield')), 'No mayo');
    await tester.pump();

    // Verify the note is displayed
    expect(find.text('Note: No mayo'), findsOneWidget);
  });
}
