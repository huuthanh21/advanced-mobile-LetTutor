import 'dart:convert';

import 'package:faker/faker.dart';

import '../core/api/api_service.dart';
import 'course.dart';

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
  final List<Course> courses = [];
  final List<Review> reviews = [];
  final List<Schedule> schedules = [];
  double calculatedRating = 0;
  bool? isFavorite;
  int? totalReviews;

  Tutor(
      {required this.id,
      required this.name,
      required this.description,
      required this.countryCode,
      required this.education,
      required this.hobbies,
      required this.experience,
      required this.profilePictureUrl,
      required this.videoUrl,
      List<String>? specializations,
      List<String>? languages,
      List<Course>? courses,
      List<Review>? reviews,
      List<Schedule>? schedules,
      double? calculatedRating,
      bool? isFavorite,
      int? totalReviews}) {
    if (specializations != null) {
      this.specializations.addAll(specializations);
    }
    if (languages != null) {
      this.languages.addAll(languages);
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
    if (calculatedRating != null) {
      this.calculatedRating = calculatedRating;
    }
    if (isFavorite != null) {
      this.isFavorite = isFavorite;
    }
    if (totalReviews != null) {
      this.totalReviews = totalReviews;
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
            ? specializationMapper((tutor['specialties'] as String).split(','))
            : List<String>.empty(),
        languages: tutor['languages'] != null
            ? (tutor['languages'] as String).split(',')
            : List<String>.empty(),
        courses: null,
        reviews: null,
        schedules: null,
        calculatedRating: tutor["rating"] ?? 0,
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

  static Future<Tutor> tutorModelFromJson(String json) async {
    try {
// Parse json to Dart object
      Map<String, dynamic> tutor = jsonDecode(json);
      // Convert to Tutor model
      return Tutor(
          id: tutor["User"]["id"],
          name: tutor["User"]["name"],
          profilePictureUrl:
              tutor["User"]["avatar"] ?? "https://i.pravatar.cc/300?u=${tutor["id"]}",
          description: tutor["bio"] ?? "Không có mô tả",
          countryCode: tutor["User"]["country"] ?? "VN",
          education: tutor["education"] ?? "Không có thông tin",
          hobbies: tutor["interests"] ?? "Không có thông tin",
          experience: tutor["experience"] ?? "Không có thông tin",
          videoUrl: tutor["video"] != null
              ? Uri.parse(tutor["video"])
              : Uri.parse("https://www.w3schools.com/tags/mov_bbb.mp4"),
          specializations: tutor['specialties'] != null
              ? (tutor['specialties'] as String).split(',')
              : List<String>.empty(),
          languages: tutor['languages'] != null
              ? (tutor['languages'] as String).split(',')
              : List<String>.empty(),
          courses: Course.tutorCoursesFromJson(tutor["User"]["courses"]),
          reviews: await Tutor.getReviews(tutor["User"]["id"]),
          schedules: await Tutor.getSchedules(tutor["User"]["id"]),
          calculatedRating: tutor["avgRating"],
          isFavorite: tutor["isFavorite"],
          totalReviews: tutor["totalFeedback"] ?? 0);
    } catch (e) {
      print("error in tutor");
      rethrow;
    }
    return Tutor(
        id: "",
        name: "",
        profilePictureUrl: "",
        description: "",
        countryCode: "",
        education: "",
        hobbies: "",
        experience: "",
        videoUrl: Uri.parse("https://www.w3schools.com/tags/mov_bbb.mp4"),
        specializations: [],
        languages: [],
        courses: [],
        reviews: [],
        schedules: [],
        calculatedRating: 0);
  }

  static Future<List<Review>> getReviews(String tutorId) async {
    return await ApiService().getReviews(tutorId);
  }

  static Future<List<Schedule>> getSchedules(String tutorId) {
    return ApiService().getSchedules(tutorId);
  }

  static List<String> specializationMapper(List<String> abreviations) {
    for (int i = 0; i < abreviations.length; i++) {
      switch (abreviations[i]) {
        case "business-english":
          abreviations[i] = "Tiếng Anh cho công việc";
          break;
        case "ielts":
          abreviations[i] = "IELTS";
          break;
        case "toeic":
          abreviations[i] = "TOEIC";
          break;
        case "toefl":
          abreviations[i] = "TOEFL";
          break;
        //pet, ket
        case "pet":
          abreviations[i] = "PET";
          break;
        case "ket":
          abreviations[i] = "KET";
          break;
        //starters, movers, flyers
        case "starters":
          abreviations[i] = "STARTERS";
          break;
        case "movers":
          abreviations[i] = "MOVERS";
          break;
        case "flyers":
          abreviations[i] = "FLYERS";
          break;
        // conversational english
        case "conversational-english":
          abreviations[i] = "Giao tiếp";
          break;
        // english for kids
        case "english-for-kids":
          abreviations[i] = "Tiếng Anh cho trẻ em";
          break;
        default:
          abreviations[i] = "";
      }
    }
    return abreviations;
  }
}

class Schedule {
  final String id;
  final DateTime dateTime;
  bool isBooked = false;

  Schedule({required this.id, required this.dateTime, required this.isBooked});

  @override
  String toString() {
    return "Schedule: $dateTime - ${isBooked ? "Booked" : "Available"}}";
  }

  static List<Schedule> schedulesFromJson(String json) {
    Map<String, dynamic> apiResponse = jsonDecode(json);
    List<dynamic> schedules = apiResponse["scheduleOfTutor"];
    // Convert to Tutor model
    List<Schedule> scheduleModels = [];
    for (var schedule in schedules) {
      scheduleModels.add(Schedule(
        id: schedule["id"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(schedule["startTimestamp"]),
        isBooked: schedule["isBooked"],
      ));
    }
    return scheduleModels;
  }
}

class Review {
  final String id;
  final String authorName;
  Uri authorAvatar = Uri.parse("https://i.pravatar.cc/300?u=${faker.guid.guid()}");
  final String content;
  final int rating;
  final DateTime date;

  Review(
      {required this.id,
      required this.authorName,
      required this.content,
      required this.rating,
      required this.date,
      Uri? authorAvatar}) {
    if (authorAvatar != null) {
      this.authorAvatar = authorAvatar;
    }
  }

  static List<Review> reviewsFromJson(String json) {
    Map<String, dynamic> apiResponse = jsonDecode(json);
    List<dynamic> reviews = apiResponse["data"]["rows"];
    // Convert to Tutor model
    List<Review> reviewModels = [];
    for (var review in reviews) {
      reviewModels.add(Review(
        id: review["id"],
        content: review["content"],
        authorName: review["firstInfo"]["name"],
        authorAvatar: review["firstInfo"]["avatar"] != null
            ? Uri.parse(review["firstInfo"]["avatar"])
            : Uri.parse("https://i.pravatar.cc/300?u=${faker.guid.guid()}"),
        rating: review["rating"],
        date: DateTime.parse(review["createdAt"]),
      ));
    }
    return reviewModels;
  }
}
