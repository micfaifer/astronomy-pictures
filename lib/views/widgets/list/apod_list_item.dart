import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ApodListItem extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final VoidCallback onTap;

  const ApodListItem({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(date),
      leading: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
