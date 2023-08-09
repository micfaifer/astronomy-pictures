class Apod {
  final String title;
  final String date;
  final String description;
  final String imageUrl;

  Apod({
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Apod.fromJson(Map<String, dynamic> json) {
    return Apod(
      title: json['title'],
      date: json['date'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
