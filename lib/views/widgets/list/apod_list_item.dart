import 'package:flutter/material.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'details/image_detail_screen.dart';

class ApodListItem extends StatelessWidget {
  final Apod apodData;

  const ApodListItem({required this.apodData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
