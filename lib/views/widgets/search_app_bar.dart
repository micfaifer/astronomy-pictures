import 'package:flutter/material.dart';
import 'package:astronomy_pictures/views/search_view.dart';
import 'package:provider/provider.dart';
import '../viewmodels/apod_viewmodel.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApodViewModel>(
      builder: (context, viewModel, child) {
        return AppBar(
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: SearchTextField(
              onChanged: (String value) {
                viewModel.searchByTerm(value);
              },
            ),
          ),
          actions: [
            DateRangePickerButton(viewModel: viewModel),
          ],
        );
      },
    );
  }
}

class DateRangePickerButton extends StatelessWidget {
  final ApodViewModel viewModel;

  const DateRangePickerButton({required this.viewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.date_range),
      onPressed: () {
        selectDateRange(context, viewModel);
      },
    );
  }

  void selectDateRange(BuildContext context, ApodViewModel viewModel) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: viewModel.availableDateTimeRange.start,
      lastDate: viewModel.availableDateTimeRange.end,
      currentDate: DateTime.now(),
      initialDateRange: viewModel.selectedDateRange,
      saveText: "Done",
    );
    if (result != null) {
      viewModel.selectedDateRange = result;
    }
  }
}
