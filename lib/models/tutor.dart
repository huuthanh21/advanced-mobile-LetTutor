import 'user.dart';

class Tutor {
  final String name;
  final String profilePictureUrl = "https://picsum.photos/200";
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
  });

  static Tutor getRandomTutor() {
    return Tutor(
      name: "Nguyen Van A",
      description: "I am a teacher",
      countryCode: "vn",
      education: "Bachelor",
      hobbies: "Reading",
      experience: "5 years",
    );
  }
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

  Review(
      {required this.author,
      required this.content,
      required this.rating,
      required this.date});
}
