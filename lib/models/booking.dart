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

class History {
  final Booking booking;
  bool completed = false;

  History({required this.booking});
}
