import 'package:flutter/material.dart';
import '../models/apod.dart';

class ImageDetailScreen extends StatelessWidget {
  final Apod apodData;

  ImageDetailScreen(this.apodData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (apodData != null) ...[
              Image.network(apodData.imageUrl),
              SizedBox(height: 16),
              Text(
                apodData.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(apodData.date),
              SizedBox(height: 8),
              Text(apodData.description),
            ] else ...[
              CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}
