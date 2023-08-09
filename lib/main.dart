import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/data/data_manager.dart';
import 'package:astronomy_pictures/viewmodels/apod_viewmodel.dart';
import 'package:astronomy_pictures/views/apod_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const Center(child: CircularProgressIndicator()),
          );
        }

        final sharedPreferences = snapshot.data!;
        final dataManager = DataManager(ApodService(), sharedPreferences);

        return ChangeNotifierProvider(
          create: (context) => ApodViewModel(dataManager: dataManager),
          child: MaterialApp(
            title: 'NASA APOD App',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const ApodListScreen(),
          ),
        );
      },
    );
  }
}
