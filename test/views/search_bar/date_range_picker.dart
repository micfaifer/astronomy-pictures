import 'package:astronomy_pictures/views/widgets/search_bar/date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DateRangePickerButton opens date picker',
      (WidgetTester tester) async {
    DateTimeRange availableDateTimeRange = DateTimeRange(
      start: DateTime(2023, 8, 1),
      end: DateTime(2023, 8, 31),
    );
    DateTimeRange selectedDateRange = DateTimeRange(
      start: DateTime(2023, 8, 15),
      end: DateTime(2023, 8, 20),
    );
    DateTimeRange? selectedResult;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: DateRangePickerButton(
            availableDateTimeRange: availableDateTimeRange,
            selectedDateRange: selectedDateRange,
            onDateRangeSelected: (result) {
              selectedResult = result;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.date_range));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(selectedResult, isNotNull);
  });
}
