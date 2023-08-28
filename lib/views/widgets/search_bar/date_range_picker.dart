import 'package:flutter/material.dart';

class DateRangePickerButton extends StatelessWidget {
  final DateTimeRange availableDateTimeRange;
  final DateTimeRange selectedDateRange;
  final void Function(DateTimeRange) onDateRangeSelected;

  const DateRangePickerButton({
    required this.availableDateTimeRange,
    required this.selectedDateRange,
    required this.onDateRangeSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.date_range),
      onPressed: () {
        _selectDateRange(context);
      },
    );
  }

  void _selectDateRange(BuildContext context) async {
    final DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: availableDateTimeRange.start,
        lastDate: availableDateTimeRange.end,
        currentDate: DateTime.now(),
        initialDateRange: selectedDateRange,
        saveText: "Done");
    if (result != null) {
      onDateRangeSelected(result);
    }
  }
}
