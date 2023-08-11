import 'package:astronomy_pictures/views/widgets/search_bar/date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/apod.dart';
import '../viewmodels/apod_viewmodel.dart';
import 'image_detail_screen.dart';
import 'widgets/list/apod_list_item.dart';
import 'widgets/search_bar/search_app_bar.dart';

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
      body: const ApodListView(),
    );
  }
}

class ApodListView extends StatefulWidget {
  const ApodListView({Key? key}) : super(key: key);

  @override
  ApodListViewState createState() => ApodListViewState();
}

class ApodListViewState extends State<ApodListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApodViewModel>(context, listen: false).getAstronomyPictures();
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<ApodViewModel>(context, listen: false)
        .getAstronomyPictures();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApodViewModel>(
      builder: (context, viewModel, child) {
        return RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: _buildContent(context, viewModel),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ApodViewModel viewModel) {
    if (viewModel.hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(viewModel.error),
            duration: const Duration(seconds: 3),
          ),
        );
      });
    }

    if (viewModel.isFetchingData) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.apodList == null || viewModel.apodList!.isEmpty) {
      const data =
          "Failed to fetch images and no local data available. \n Please try again.";

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              data,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _refreshData(context),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: viewModel.apodList!.length,
      itemBuilder: (context, index) {
        final apodData = viewModel.apodList![index];
        return ApodListItem(
          title: apodData.title,
          date: apodData.date,
          imageUrl: apodData.imageUrl,
          onTap: () {
            _navigateToDetailScreen(context, apodData);
          },
        );
      },
    );
  }

  void _navigateToDetailScreen(BuildContext context, Apod apod) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(
          imageUrl: apod.imageUrl,
          title: apod.title,
          date: apod.date,
          description: apod.description,
        ),
      ),
    );
  }
}
