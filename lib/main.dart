import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/viewmodels/apod_viewmodel.dart';
import 'package:astronomy_pictures/views/image_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApodViewModel(apodService: ApodService()),
      child: MaterialApp(
        title: 'NASA APOD App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImageListScreen(),
      ),
    );
  }
}
