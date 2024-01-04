import 'package:faker/faker.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

enum Level {
  any,
  beginner,
  upperBeginner,
  preIntermediate,
  intermediate,
  upperIntermediate,
  preAdvanced,
  advanced,
  veryAdvanced,
}

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.any:
        return 'Any Level';
      case Level.beginner:
        return 'Beginner';
      case Level.upperBeginner:
        return 'Upper-Beginner';
      case Level.preIntermediate:
        return 'Pre-Intermediate';
      case Level.intermediate:
        return 'Intermediate';
      case Level.upperIntermediate:
        return 'Upper-Intermediate';
      case Level.preAdvanced:
        return 'Pre-Advanced';
      case Level.advanced:
        return 'Advanced';
      case Level.veryAdvanced:
        return 'Very Advanced';
    }
  }
}

const List<String> courseTypes = [
  'English for Traveling',
  'English for Beginners',
  'Business English',
  'English for Kids',
];

class Course {
  final String id = faker.guid.guid();
  final String type;
  final Uri coverUri = Uri.parse(
      'https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e');
  final String title;
  final String description;
  final String whyDescription;
  final String whatDescription;
  final Level level;
  final List<CourseTopic> topics;

  Course({
    required this.type,
    required this.title,
    required this.description,
    required this.whyDescription,
    required this.whatDescription,
    required this.level,
    required this.topics,
  });

  static Course getRandomCourse() {
    return Course(
      type: courseTypes[faker.randomGenerator.integer(courseTypes.length - 1)],
      title: toBeginningOfSentenceCase(faker.lorem.words(3).join(' '))!,
      description: toBeginningOfSentenceCase(faker.lorem.words(10).join(' '))!,
      whyDescription: toBeginningOfSentenceCase(faker.lorem.sentences(2).join(' '))!,
      whatDescription: toBeginningOfSentenceCase(faker.lorem.sentences(2).join(' '))!,
      level: Level.values[faker.randomGenerator.integer(2)],
      topics: List.generate(
        faker.randomGenerator.integer(10, min: 4),
        (index) => CourseTopic(name: faker.lorem.words(2).join(' ')),
      ),
    );
  }
}

class CourseTopic {
  final String name;
  Uri? contentUri;

  CourseTopic({
    required this.name,
    this.contentUri,
  });
}
