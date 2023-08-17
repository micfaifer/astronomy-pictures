import 'package:astronomy_pictures/views/widgets/grid/apod_card_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ApodListItem - Widget Test', (WidgetTester tester) async {
    const title = 'Sample Title';
    const date = '2023-08-10';
    const imageUrl = 'sample_url';

    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ApodCardView(
            title: title,
            date: date,
            imageUrl: imageUrl,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.text(date), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);

    await tester.tap(find.byType(ListTile));
    await tester.pump();
    expect(tapped, true);
  });

  testWidgets('ApodListItem - Navigation Test', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ApodCardView(
            title: 'Title',
            date: '2023-08-10',
            imageUrl: 'url',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ListTile));
    expect(tapped, true);
  });
}
