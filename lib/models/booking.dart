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
  BookingStatus status = BookingStatus.pending;

  Booking({
    required this.user,
    required this.tutor,
    required this.dateTime,
  });
}

class Grading {
  final int behaviorRating;
  final int listeningRating;
  final int speakingRating;
  final int vocabularyRating;
  final String comment;

  Grading(this.behaviorRating, this.listeningRating, this.speakingRating,
      this.vocabularyRating, this.comment);
}

class History {
  final Booking booking;
  bool completed;
  Grading? grading;

  History({required this.booking, this.completed = false});
}
