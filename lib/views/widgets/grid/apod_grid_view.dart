import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/apod.dart';
import '../../../viewmodels/apod_viewmodel.dart';
import '../../image_detail_screen.dart';
import 'apod_card_view.dart';

class ApodGridView extends StatefulWidget {
  const ApodGridView({Key? key}) : super(key: key);

  @override
  ApodGridViewState createState() => ApodGridViewState();
}

class ApodGridViewState extends State<ApodGridView> {
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

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: viewModel.apodList!.length,
      itemBuilder: (context, index) {
        final apodData = viewModel.apodList![index];
        return GestureDetector(
          onTap: () {
            _navigateToDetailScreen(context, apodData);
          },
          child: ApodCardView(
            title: apodData.title,
            date: apodData.date,
            imageUrl: apodData.imageUrl,
            onTap: () {
              _navigateToDetailScreen(context, apodData);
            },
          ),
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
