import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/views/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/apod_viewmodel.dart';
import 'list/apod_list_view.dart';

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApodViewModel(apodService: ApodService()),
      child: Scaffold(
        appBar: const SearchAppBar(),
        body: Consumer<ApodViewModel>(
          builder: (context, viewModel, child) {
            return const ApodListView();
          },
        ),
      ),
    );
  }
}
