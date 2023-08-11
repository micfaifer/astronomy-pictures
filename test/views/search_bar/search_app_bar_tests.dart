import 'package:astronomy_pictures/views/widgets/search_bar/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SearchAppBar calls onSearchTextChanged when search text changes',
      (WidgetTester tester) async {
    bool onSearchTextChangedCalled = false;
    String searchText = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SearchAppBar(
            actions: const [],
            onSearchTextChanged: (text) {
              onSearchTextChangedCalled = true;
              searchText = text;
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Sample text');
    await tester.pump();

    expect(onSearchTextChangedCalled, isTrue);
    expect(searchText, 'Sample text');
  });

  testWidgets('SearchAppBar displays actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SearchAppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.filter),
                onPressed: () {},
              ),
            ],
            onSearchTextChanged: (text) {},
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.filter), findsOneWidget);
  });
}
