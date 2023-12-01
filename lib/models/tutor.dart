import 'package:faker/faker.dart';

import 'user.dart';

class Tutor {
  final String name;
  final String profilePictureUrl;
  // final String videoUrl = "https://www.youtube.com/watch?v=7oKjW1OIjuw";
  final String description;
  final String countryCode;
  final String education;
  final List<String> specializations = [];
  final List<String> languages = [];
  final List<String> courses = [];
  final String hobbies;
  final String experience;
  final List<Review> reviews = [];
  final List<Schedule> schedules = [];

  Tutor({
    required this.name,
    required this.description,
    required this.countryCode,
    required this.education,
    required this.hobbies,
    required this.experience,
    this.profilePictureUrl = "https://picsum.photos/seed/20120582/200",
  });

  static List<String> specializationList = [
    'Tiếng Anh cho trẻ em',
    'Tiếng Anh cho công việc',
    'Giao tiếp',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC'
  ];

  static Tutor getRandomTutor() {
    Tutor tutor = Tutor(
      name: faker.person.name(),
      profilePictureUrl:
          "https://picsum.photos/seed/${faker.randomGenerator.integer(100)}/200",
      description: faker.lorem.sentences(5).join(" "),
      countryCode: faker.randomGenerator.element([
        "VN",
        "US",
        "CN",
        "IN",
        "ID",
        "PK",
        "BR",
        "NG",
        "BD",
        "RU",
        "JP",
        "MX",
        "PH",
        "ET",
        "EG",
        "DE",
        "IR",
        "TR",
        "CD",
        "FR"
      ]),
      education: faker.lorem.words(3).join(" "),
      hobbies: faker.lorem.sentence(),
      experience: faker.lorem.sentence(),
    );
    // Add random languages
    for (var i = 0; i < faker.randomGenerator.integer(3, min: 1); i++) {
      String randomLanguage = faker.randomGenerator.element([
        "English",
        "Vietnamese",
        "Japanese",
        "Korean",
        "Mandarin",
        "French",
        "German",
        "Spanish"
      ]);
      if (!tutor.languages.contains(randomLanguage)) {
        tutor.languages.add(randomLanguage);
      }
    }
    // Add random specializations
    for (var i = 0; i < faker.randomGenerator.integer(6, min: 1); i++) {
      String randomSpecialization = faker.randomGenerator.element(
          specializationList
              .where((element) => !tutor.specializations.contains(element))
              .toList());
      tutor.specializations.add(randomSpecialization);
    }
    // Add random courses
    for (var i = 0; i < faker.randomGenerator.integer(6, min: 1); i++) {
      String randomCourse = faker.lorem.words(3).join(" ");
      tutor.courses.add(randomCourse);
    }
    // Add random reviews
    for (var i = 0; i < faker.randomGenerator.integer(6, min: 0); i++) {
      Review randomReview = Review(
          author: User.getRandomUser(),
          content: faker.lorem.sentences(2).join(" "),
          rating: faker.randomGenerator.integer(5, min: 1),
          date: faker.date.dateTime());
      tutor.reviews.add(randomReview);
    }
    return tutor;
  }

  int get rating {
    if (reviews.isEmpty) {
      return 0;
    }
    int sum = 0;
    for (var review in reviews) {
      sum += review.rating;
    }
    return sum ~/ reviews.length;
  }

  bool get isForeigner => countryCode != "VN";

  bool get isNativeEnglishSpeaker => [
        "AG",
        "AU",
        "BS",
        "BB",
        "BZ",
        "CA",
        "DM",
        "GD",
        "GY",
        "IE",
        "JM",
        "MT",
        "NZ",
        "KN",
        "LC",
        "VC",
        "TT",
        "GB",
        "US"
      ].contains(countryCode);
}

class Schedule {
  final DateTime dateTime;
  bool isBooked = false;

  Schedule(this.dateTime);
}

class Review {
  final User author;
  final String content;
  final int rating;
  final DateTime date;

  Review({
    required this.author,
    required this.content,
    required this.rating,
    required this.date,
  });
}
