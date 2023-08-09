import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/data/data_manager.dart';
import 'package:astronomy_pictures/viewmodels/apod_viewmodel.dart';
import 'package:astronomy_pictures/views/apod_list_screen.dart';
import 'package:astronomy_pictures/views/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ApodViewModel(dataManager: DataManager(ApodService())),
      child: MaterialApp(
        title: 'NASA APOD App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Scaffold(
          appBar: SearchAppBar(),
          body: ApodListView(),
        ),
      ),
    );
  }
}
