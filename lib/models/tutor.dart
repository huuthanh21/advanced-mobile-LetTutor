import 'dart:convert';

import 'user.dart';

class Tutor {
  final String id;
  final String name;
  final String description;
  final String countryCode;
  final String education;
  final String hobbies;
  final String experience;
  final String profilePictureUrl;
  Uri videoUrl;
  final List<String> specializations = [];
  final List<String> languages = [];
  final List<String> courses = [];
  final List<Review> reviews = [];
  final List<Schedule> schedules = [];

  Tutor({
    required this.id,
    required this.name,
    required this.description,
    required this.countryCode,
    required this.education,
    required this.hobbies,
    required this.experience,
    required this.profilePictureUrl,
    required this.videoUrl,
    specializations,
    languages,
    courses,
    reviews,
    schedules,
  }) {
    if (specializations != null) {
      this.specializations.addAll(specializations as List<String>);
    }
    if (languages != null) {
      this.languages.addAll(languages as List<String>);
    }
    if (courses != null) {
      this.courses.addAll(courses);
    }
    if (reviews != null) {
      this.reviews.addAll(reviews);
    }
    if (schedules != null) {
      this.schedules.addAll(schedules);
    }
  }

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

  static List<Tutor> tutorModelsFromJson(String json) {
    // Parse json to Dart object
    Map<String, dynamic> apiResponse = jsonDecode(json);
    List<dynamic> tutors = apiResponse["rows"];
    // Convert to Tutor model
    List<Tutor> tutorModels = [];
    for (var tutor in tutors) {
      tutorModels.add(Tutor(
        id: tutor["id"],
        name: tutor["name"],
        profilePictureUrl: tutor["avatar"] ?? "https://i.pravatar.cc/300?u=${tutor["id"]}",
        description: tutor["bio"] ?? "Không có mô tả",
        countryCode: tutor["country"] ?? "VN",
        education: tutor["education"] ?? "Không có thông tin",
        hobbies: tutor["interests"] ?? "Không có thông tin",
        experience: tutor["experience"] ?? "Không có thông tin",
        videoUrl: tutor["video"] ?? Uri.parse("https://www.w3schools.com/tags/mov_bbb.mp4"),
        specializations: tutor['specialties'] != null
            ? (tutor['specialties'] as String).split(',')
            : List<String>.empty(),
        languages: tutor['languages'] != null
            ? (tutor['languages'] as String).split(',')
            : List<String>.empty(),
        courses: null,
        reviews: null,
        schedules: null,
      ));
    }
    return tutorModels;
  }

  static List<String> favoriteTutorIdsFromJson(String json) {
    // Parse json to Dart object
    Map<String, dynamic> apiResponse = jsonDecode(json);
    List<dynamic> tutors = apiResponse["rows"];
    List<String> tutorIds = [];
    for (var tutor in tutors) {
      if (tutor["isFavoriteTutor"] == true) {
        tutorIds.add(tutor["id"]);
      }
    }
    return tutorIds;
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

  @override
  String toString() {
    return "Schedule: $dateTime - ${isBooked ? "Booked" : "Available"}}";
  }
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
