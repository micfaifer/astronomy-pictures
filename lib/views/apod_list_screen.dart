import 'package:astronomy_pictures/views/widgets/grid/apod_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/apod_viewmodel.dart';
import 'widgets/search_bar/search_app_bar.dart';
import 'widgets/search_bar/date_range_picker.dart';

class ApodListScreen extends StatelessWidget {
  const ApodListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ApodViewModel>(context, listen: false);

    return Scaffold(
      appBar: SearchAppBar(
        actions: [
          DateRangePickerButton(
            availableDateTimeRange: viewModel.availableDateTimeRange,
            selectedDateRange: viewModel.selectedDateRange,
            onDateRangeSelected: (selectedDateRange) {
              viewModel.selectedDateRange = selectedDateRange;
            },
          ),
        ],
        onSearchTextChanged: (String value) {
          viewModel.searchByTerm(value);
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ApodGridView(),
      ),
    );
  }
}
