import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/apod_viewmodel.dart';
import 'apod_list_item.dart';

class ApodListView extends StatelessWidget {
  const ApodListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApodViewModel>(
      builder: (context, viewModel, child) {
        return Center(
          child: viewModel.apodList == null
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: viewModel.apodList?.length,
                  itemBuilder: (context, index) {
                    final apodData = viewModel.apodList![index];
                    return ApodListItem(apodData: apodData);
                  },
                ),
        );
      },
    );
  }
}
