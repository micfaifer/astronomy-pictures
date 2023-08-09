import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/apod.dart';

class ImageDetailScreen extends StatelessWidget {
  final Apod apodData;

  const ImageDetailScreen(this.apodData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (apodData != null) ...[
              CachedNetworkImage(
                imageUrl: apodData.imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 16),
              Text(
                apodData.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(apodData.date),
              const SizedBox(height: 8),
              Text(apodData.description),
            ] else ...[
              const CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}
