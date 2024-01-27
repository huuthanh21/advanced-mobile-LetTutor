import 'dart:convert';

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
  final String id;
  final String type;
  final Uri coverUri;
  final String title;
  final String description;
  final String whyDescription;
  final String whatDescription;
  final Level level;
  final List<CourseTopic> topics;

  Course({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.whyDescription,
    required this.whatDescription,
    required this.level,
    required this.topics,
    required this.coverUri,
  });

  static Course getRandomCourse() {
    return Course(
      id: faker.guid.guid(),
      type: courseTypes[faker.randomGenerator.integer(courseTypes.length - 1)],
      title: toBeginningOfSentenceCase(faker.lorem.words(3).join(' '))!,
      description: toBeginningOfSentenceCase(faker.lorem.words(10).join(' '))!,
      whyDescription: toBeginningOfSentenceCase(faker.lorem.sentences(2).join(' '))!,
      whatDescription: toBeginningOfSentenceCase(faker.lorem.sentences(2).join(' '))!,
      level: Level.values[faker.randomGenerator.integer(2)],
      coverUri: Uri.parse("google.com"),
      topics: List.generate(
        faker.randomGenerator.integer(10, min: 4),
        (index) => CourseTopic(name: faker.lorem.words(2).join(' ')),
      ),
    );
  }

  static List<Course> tutorCoursesFromJson(tutorCourses) {
    List<Course> courses = [];
    for (var course in tutorCourses) {
      courses.add(Course(
        id: course['id'],
        type: '',
        title: course['name'],
        description: '',
        whyDescription: '',
        whatDescription: '',
        level: Level.any,
        topics: [],
        coverUri: Uri.parse("google.com"),
      ));
    }
    return courses;
  }

  static List<Course> coursesFromJson(String json) {
    Map<String, dynamic> apiResponse = jsonDecode(json);
    List<dynamic> courses = apiResponse["data"]["rows"];
    // Convert to Tutor model
    List<Course> courseModels = [];
    for (var course in courses) {
      courseModels.add(Course(
          id: course["id"],
          type: course["categories"][0]["title"],
          title: course["name"],
          description: course["description"],
          whyDescription: course["reason"],
          whatDescription: course["purpose"],
          level: Level.values[int.parse(course["level"].toString())],
          topics: dynamicTopicsFromJson(course["topics"]),
          coverUri: Uri.parse(course["imageUrl"])));
    }
    return courseModels;
  }

  static dynamicTopicsFromJson(topics) {
    List<CourseTopic> courseTopics = [];
    for (var topic in topics) {
      courseTopics.add(CourseTopic(name: topic["name"], contentUri: Uri.parse(topic["nameFile"])));
    }
    return courseTopics;
  }

  static Future<Course> courseModelFromJson(String json) async {
    try {
// Parse json to Dart object
      Map<String, dynamic> course = jsonDecode(json)["data"];
      // Convert to Tutor model
      return Course(
        id: course["id"],
        type: "",
        title: course["name"],
        description: course["description"],
        whyDescription: course["reason"],
        whatDescription: course["purpose"],
        level: Level.values[int.parse(course["level"].toString())],
        topics: dynamicTopicsFromJson(course["topics"]),
        coverUri: Uri.parse(course["imageUrl"]),
      );
    } catch (e) {
      print("error in tutor");
      rethrow;
    }
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
