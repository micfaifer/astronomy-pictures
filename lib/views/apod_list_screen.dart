import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/apod_viewmodel.dart';
import 'widgets/list/apod_list_item.dart';

class ApodListView extends StatefulWidget {
  const ApodListView({super.key});

  @override
  _ApodListViewState createState() => _ApodListViewState();
}

class _ApodListViewState extends State<ApodListView> {
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
          child: Center(
            child: viewModel.isFetchingData
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: viewModel.apodList?.length,
                    itemBuilder: (context, index) {
                      final apodData = viewModel.apodList![index];
                      return ApodListItem(apodData: apodData);
                    },
                  ),
          ),
        );
      },
    );
  }
}
