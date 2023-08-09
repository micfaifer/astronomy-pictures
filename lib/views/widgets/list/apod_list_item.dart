import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:astronomy_pictures/models/apod.dart';
import '../../image_detail_screen.dart';

class ApodListItem extends StatelessWidget {
  final Apod apodData;

  const ApodListItem({required this.apodData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(apodData.title),
      subtitle: Text(apodData.date),
      leading: CachedNetworkImage(
        imageUrl: apodData.imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
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
