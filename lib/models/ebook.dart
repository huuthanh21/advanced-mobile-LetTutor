import 'package:faker/faker.dart';

import 'course.dart';

class Ebook {
  final id = faker.guid.guid();
  final String title;
  final String description;
  final Level level;
  final Uri coverUri = Uri.parse(
      'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afilewhat_a_world.jpeg');
  final Uri uri;

  Ebook({
    required this.title,
    required this.description,
    required this.level,
    required this.uri,
  });

  static Ebook getRandomEbook() {
    return Ebook(
      title: faker.lorem.sentence(),
      description: faker.lorem.sentences(3).join(' '),
      level: Level.values[faker.randomGenerator.integer(Level.values.length - 1)],
      uri: Uri.parse('https://google.com'),
    );
  }
}
