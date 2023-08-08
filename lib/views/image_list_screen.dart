import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/apod_viewmodel.dart';
import 'image_detail_screen.dart';


class ImageListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApodViewModel(apodService: ApodService()),
      child: Consumer<ApodViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: SearchTextField(
                  onChanged: (String value) {
                    viewModel.searchByTerm(value);
                  },
                ),
              ),
            ),
            body: ApodListView(),
          );
        },
      ),
    );
  }
}

class ApodListView extends StatefulWidget {
  @override
  _ApodListViewState createState() => _ApodListViewState();
}

class _ApodListViewState extends State<ApodListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApodViewModel>(context, listen: false).fetchAstronomyPictureOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ApodViewModel>(context);

    return Center(
      child: viewModel.apodList == null
          ? CircularProgressIndicator()
          : ListView.builder(
        itemCount: viewModel.apodList?.length,
        itemBuilder: (context, index) {
          final apodData = viewModel.apodList![index];

          return ListTile(
            title: Text(apodData.title),
            subtitle: Text(apodData.date),
            leading: Image.network(apodData.imageUrl),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(apodData),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
