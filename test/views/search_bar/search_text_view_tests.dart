import 'package:astronomy_pictures/views/widgets/search_bar/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SearchTextField - Widget Test', (WidgetTester tester) async {
    String searchText = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchTextField(
            onChanged: (value) {
              searchText = value;
            },
          ),
        ),
      ),
    );

    expect(find.text('Search title. Eg: Moon'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    var testString = "filled text string test";
    await tester.enterText(find.byType(TextField), testString);
    await tester.pump();

    expect(find.text(testString), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(find.text(testString), findsNothing);
    expect(searchText, '');
  });
}
