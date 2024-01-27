import 'dart:convert';

import 'package:faker/faker.dart';

import 'course.dart';

class Ebook {
  final id = faker.guid.guid();
  final String title;
  final String description;
  final Level level;
  final Uri coverUri;
  final Uri uri;

  Ebook({
    required this.title,
    required this.description,
    required this.coverUri,
    required this.level,
    required this.uri,
  });

  static Ebook getRandomEbook() {
    return Ebook(
      title: faker.lorem.sentence(),
      description: faker.lorem.sentences(3).join(' '),
      level: Level.values[faker.randomGenerator.integer(Level.values.length - 1)],
      uri: Uri.parse('https://google.com'),
      coverUri: Uri.parse("google.com"),
    );
  }

  static List<Ebook> ebooksFromJson(String json) {
    Map<String, dynamic> apiResponse = jsonDecode(json);
    List<dynamic> ebooks = apiResponse["data"]["rows"];
    // Convert to Tutor model
    List<Ebook> ebookModels = [];
    for (var ebook in ebooks) {
      ebookModels.add(Ebook(
          title: ebook["name"],
          description: ebook["description"],
          level: Level.values[int.parse(ebook["level"].toString())],
          uri: Uri.parse(ebook["fileUrl"]),
          coverUri: Uri.parse(ebook["imageUrl"])));
    }
    return ebookModels;
  }
}
