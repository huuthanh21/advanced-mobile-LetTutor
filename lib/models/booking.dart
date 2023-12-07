import 'tutor.dart';
import 'user.dart';

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
}

class Booking {
  final User user;
  final Tutor tutor;
  final DateTime dateTime;
  String? request;
  BookingStatus status = BookingStatus.pending;

  Booking({
    required this.user,
    required this.tutor,
    required this.dateTime,
  });
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

  History({required this.booking, this.completed = false});
}
