import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/main.dart';

void main() {
  testWidgets('OrderScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the initial UI is rendered correctly.
    expect(find.text('Sandwich Counter'), findsOneWidget);
    expect(find.text('1 white untoasted footlong sandwich(es): 🥪 (£5.00)'), findsOneWidget);

    // Tap the 'Add' button and verify the quantity increases.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2 white untoasted footlong sandwich(es): 🥪🥪 (£10.00)'), findsOneWidget);

    // Tap the 'Remove' button and verify the quantity decreases.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('1 white untoasted footlong sandwich(es): 🥪 (£5.00)'), findsOneWidget);

    // Toggle the sandwich type to six-inch.
    await tester.tap(find.byKey(const Key('sandwich_type_switch')));
    await tester.pump();
    expect(find.text('1 white untoasted six-inch sandwich(es): 🥪 (£3.50)'), findsOneWidget);

    // Toggle the toasted switch.
    await tester.tap(find.byKey(const Key('toasted_switch')));
    await tester.pump();
    expect(find.text('1 white toasted six-inch sandwich(es): 🥪 (£3.50)'), findsOneWidget);

    // Enter a note in the text field.
    await tester.enterText(find.byKey(const Key('notes_textfield')), 'No mayo');
    await tester.pump();
    expect(find.text('Note: No mayo'), findsOneWidget);
  });
}
