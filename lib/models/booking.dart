import 'dart:convert';

import 'tutor.dart';

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

class Booking {
  final String id;
  final Tutor tutor;
  final DateTime dateTime;
  String? request;
  BookingStatus status = BookingStatus.pending;

  Booking({
    required this.id,
    required this.tutor,
    required this.dateTime,
    this.request,
    required this.status,
  });

  static List<Booking> bookingsFromJson(String json) {
    Map<String, dynamic> apiResponse = jsonDecode(json);
    print("Bookings");

    List<dynamic> bookings = apiResponse["data"]["rows"];
    print(bookings.length);
    // Convert to Booking model
    List<Booking> bookingModels = [];
    for (var booking in bookings) {
      bookingModels.add(Booking(
        id: booking["id"],
        tutor: Tutor(
          id: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["id"],
          name: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["name"],
          profilePictureUrl: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["avatar"],
          description: '',
          countryCode: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["country"],
          education: '',
          hobbies: '',
          experience: '',
          videoUrl: Uri(path: ''),
        ),
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            booking["scheduleDetailInfo"]["startPeriodTimestamp"]),
        status: BookingStatus.confirmed,
        request: booking["studentRequest"],
      ));
    }
    return bookingModels;
  }
}

class Grading {
  final int behaviorRating;
  final String behaviorComment;

  final int listeningRating;
  final String listeningComment;

  final int speakingRating;
  final String speakingComment;

  final int vocabularyRating;
  final String vocabularyComment;

  final String overallComment;

  Grading({
    required this.behaviorRating,
    required this.behaviorComment,
    required this.listeningRating,
    required this.listeningComment,
    required this.speakingRating,
    required this.speakingComment,
    required this.vocabularyRating,
    required this.vocabularyComment,
    required this.overallComment,
  });
}

class History {
  final Booking booking;
  bool completed;
  Grading? grading;

  History({required this.booking, this.completed = false, this.grading});

  static List<History> historiesFromJson(String json) {
    Map<String, dynamic> apiResponse = jsonDecode(json);
    print("Histories");

    List<dynamic> bookings = apiResponse["data"]["rows"];
    print(bookings.length);
    // Convert to Booking model
    List<History> historyModels = [];
    for (var booking in bookings) {
      historyModels.add(History(
        booking: Booking(
          id: booking["id"],
          tutor: Tutor(
            id: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["id"],
            name: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["name"],
            profilePictureUrl: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["avatar"],
            description: '',
            countryCode: booking["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["country"],
            education: '',
            hobbies: '',
            experience: '',
            videoUrl: Uri(path: ''),
          ),
          dateTime: DateTime.fromMillisecondsSinceEpoch(
              booking["scheduleDetailInfo"]["startPeriodTimestamp"]),
          status: BookingStatus.completed,
          request: booking["studentRequest"],
        ),
        grading: (booking["feedbacks"]! as List<dynamic>).isNotEmpty
            ? Grading(
                behaviorRating: booking["feedbacks"][0]["rating"],
                behaviorComment: "",
                listeningRating: booking["feedbacks"][0]["rating"],
                listeningComment: "",
                speakingRating: booking["feedbacks"][0]["rating"],
                speakingComment: "",
                vocabularyRating: booking["feedbacks"][0]["rating"],
                vocabularyComment: "",
                overallComment: booking["feedbacks"][0]["content"],
              )
            : null,
      ));
    }
    return historyModels;
  }
}
