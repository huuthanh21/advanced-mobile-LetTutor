import 'dart:math';

import 'package:faker/faker.dart';
import 'package:lettutor/core/api/api_service.dart';

import '../../models/booking.dart';
import '../../models/course.dart';
import '../../models/ebook.dart';
import '../../models/tutor.dart';
import '../../models/user.dart';

class TutorDataProvider {
  final List<Tutor> _tutors = [];

  List<Tutor> get tutors => _tutors;

  TutorDataProvider() {
    fetchTutors();
  }

  void fetchTutors() async {
    _tutors.clear();
    var gotTutors = await ApiService().getTutors();
    if (gotTutors != null) {
      _tutors.addAll(gotTutors);
    }
  }

  Future<Tutor?> getTutorById(String id) async {
    return await ApiService().getTutorById(id);
  }

  bookTutor(String tutorId, DateTime dateTime) async {
    Tutor? tutor = await getTutorById(tutorId);
    tutor?.schedules.firstWhere((schedule) => schedule.dateTime == dateTime).isBooked = true;
  }

  cancelBooking(String tutorId, DateTime dateTime) async {
    Tutor? tutor = await getTutorById(tutorId);
    tutor?.schedules.firstWhere((schedule) => schedule.dateTime == dateTime).isBooked = false;
  }
}

class BookingDataProvider {
  final List<Booking> _bookings = [];
  final List<History> _histories = [];

  // Development only
  bool _isInitialized = false;

  // sort by date
  List<Booking> get bookings => _bookings;

  void generateRandomData(List<User> users, List<Tutor> tutors) {
    _generateRandomBookings(users, tutors);
    _generateRandomHistories(users, tutors);
    _isInitialized = true;
  }

  void _generateRandomHistories(List<User> users, List<Tutor> tutors) {
    if (_isInitialized) return;

    var random = Random();
    for (User user in users) {
      for (Tutor tutor in tutors) {
        int scheduleIndex = random.nextInt(tutor.schedules.length);
        Schedule schedule = tutor.schedules[scheduleIndex];
        if (random.nextBool()) {
          bool completed = random.nextBool();
          var history = History(
              booking: Booking(
                  user: user,
                  tutor: tutor,
                  dateTime: schedule.dateTime.subtract(const Duration(days: 7))),
              completed: completed);
          if (completed && random.nextBool()) {
            history.booking.request = faker.lorem.sentence();
            history.grading = Grading(
              behaviorRating: random.nextInt(5) + 1,
              behaviorComment: faker.lorem.sentence(),
              listeningRating: random.nextInt(5) + 1,
              listeningComment: faker.lorem.sentence(),
              speakingRating: random.nextInt(5) + 1,
              speakingComment: faker.lorem.sentence(),
              vocabularyRating: random.nextInt(5) + 1,
              vocabularyComment: faker.lorem.sentence(),
              overallComment: faker.lorem.sentence(),
            );
          }
          addHistory(history);
        }
      }
    }
    sortHistoriesByDate();
  }

  void _generateRandomBookings(List<User> users, List<Tutor> tutors) {
    if (_isInitialized) return;

    var random = Random();
    for (User user in users) {
      for (Tutor tutor in tutors) {
        int scheduleIndex = random.nextInt(tutor.schedules.length);
        Schedule schedule = tutor.schedules[scheduleIndex];
        if (random.nextBool()) {
          var booking = Booking(user: user, tutor: tutor, dateTime: schedule.dateTime);
          if (random.nextBool()) {
            booking.request = faker.lorem.sentence();
          }
          addBooking(booking);
        }
      }
    }
    sortBookingsByDate();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    sortBookingsByDate();
  }

  void addHistory(History history) {
    _histories.add(history);
    sortHistoriesByDate();
  }

  void cancelBooking(Booking booking) {
    _bookings.remove(booking);
  }

  List<Booking> getBookingsByUser(User user) {
    return _bookings.where((booking) => booking.user.email == user.email).toList();
  }

  List<History> getHistoriesByUser(User user) {
    return _histories.where((history) => history.booking.user.email == user.email).toList();
  }

  void sortBookingsByDate() {
    _bookings.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void sortHistoriesByDate() {
    _histories.sort((a, b) => a.booking.dateTime.compareTo(b.booking.dateTime));
  }
}

class CourseDataProvider {
  final List<Course> _courses = [];
  final List<Ebook> _ebooks = [];

  List<Course> get courses => _courses;
  List<Ebook> get ebooks => _ebooks;

  CourseDataProvider() {
    List.generate(10, (_) {
      _courses.add(Course.getRandomCourse());
    });
    List.generate(10, (_) {
      _ebooks.add(Ebook.getRandomEbook());
    });
  }

  List<Course> getCoursesByType(int typeIndex) {
    return _courses.where((course) => course.type == courseTypes[typeIndex]).toList();
  }
}
