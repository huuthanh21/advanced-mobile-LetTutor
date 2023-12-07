import 'dart:math';

import '../../models/booking.dart';
import '../../models/tutor.dart';
import '../../models/user.dart';

class TutorDataProvider {
  final List<Tutor> _tutors = [];

  List<Tutor> get tutors => _tutors;

  TutorDataProvider() {
    List.generate(10, (index) {
      _tutors.add(Tutor.getRandomTutor());
    });
  }

  Tutor getTutorById(String id) {
    return _tutors.firstWhere((tutor) => tutor.id == id);
  }
}

class BookingDataProvider {
  final List<Booking> _bookings = [];

  // Development only
  bool _isInitialized = false;

  // sort by date
  List<Booking> get bookings => _bookings;

  void generateRandomBookings(List<User> users, List<Tutor> tutors) {
    if (_isInitialized) return;

    var random = Random();
    for (User user in users) {
      for (Tutor tutor in tutors) {
        int scheduleIndex = random.nextInt(tutor.schedules.length);
        Schedule schedule = tutor.schedules[scheduleIndex];
        if (random.nextBool()) {
          addBooking(user, tutor, schedule.dateTime);
        }
      }
    }
    _isInitialized = true;
    sortBookingsByDate();
  }

  void addBooking(User user, Tutor tutor, DateTime dateTime) {
    _bookings.add(Booking(
      user: user,
      tutor: tutor,
      dateTime: dateTime,
    ));
    sortBookingsByDate();
  }

  List<Booking> getBookingsByUser(User user) {
    return _bookings
        .where((booking) => booking.user.email == user.email)
        .toList();
  }

  void sortBookingsByDate() {
    _bookings.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }
}
