import 'dart:convert';
import 'dart:developer';

import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/common/constant.dart';
import 'package:lettutor/models/booking.dart';

import '../../models/course.dart';
import '../../models/ebook.dart';
import '../../models/tutor.dart';
import '../../models/user.dart';

class ApiService {
  Future<List<Tutor>?> getTutors() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.tutorsEndpoint);
      // add params
      // url = url.replace(queryParameters: {
      //   'perPage': '9',
      //   'page': page.toString(),
      // });
      // make request
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      // check status code
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Tutor> tutors = Tutor.tutorModelsFromJson(response.body);
        return tutors;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<String>?> getFavoriteTutors() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.tutorsEndpoint);
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      if (response.statusCode == 200) {
        List<String> tutors = Tutor.favoriteTutorIdsFromJson(response.body);
        return tutors;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  toggleFavoriteTutor(String tutorId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + TutorEndPoints.toggleFavoriteTutor);
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      }, body: {
        'tutorId': tutorId,
      });
      if (response.statusCode == 200) {
        print('Toggle favorite tutor success');
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  // login and get token
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + AuthenticationEndPoints.login);
      // make request
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      // check status code
      if (response.statusCode != 200) {
        return null;
      }

      Map<String, dynamic> loginData = <String, dynamic>{};

      // parse json
      Map<String, dynamic> json = jsonDecode(response.body);

      Map<String, dynamic> user = json['user'];
      User newUser =
          User(id: user['id'], email: user['email'], name: user['name'], avatar: user['avatar']);
      Map<String, dynamic> tokens = json['tokens'];

      loginData['user'] = newUser;
      loginData['tokens'] = [tokens['access']['token'], tokens['refresh']['token']];

      return loginData;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> register(String email, String password) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + AuthenticationEndPoints.register);
      // make request
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<Tutor?> getTutorById(String id) async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${TutorEndPoints.tutorEndPoint}/$id');
      print(url.toString());
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        Tutor tutor = await Tutor.tutorModelFromJson(response.body);
        return tutor;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<Review>> getReviews(String tutorId) async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${TutorEndPoints.reviewsEndpoint}/$tutorId');
      url = url.replace(queryParameters: {
        'perPage': '12',
        'page': '1',
      });
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      if (response.statusCode == 200) {
        List<Review> reviews = Review.reviewsFromJson(response.body);
        return reviews;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<List<Schedule>> getSchedules(String tutorId) async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${TutorEndPoints.scheduleEndpoint}');
      url = url.replace(queryParameters: {
        'tutorId': tutorId,
        'page': '0',
      });
      print(url.toString());
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Schedule> schedules = Schedule.schedulesFromJson(response.body);
        return schedules;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<List<Booking>> getBookingSchedule() async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${BookingsEndPoints.bookingEndPoint}');

      url = url.replace(queryParameters: {
        'perPage': '20',
        'page': '1',
        "inFuture": '1',
        "orderBy": "meeting",
        "sortBy": "asc",
      });
      print(url.toString());
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Booking> bookings = Booking.bookingsFromJson(response.body);
        return bookings;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<bool> cancelBooking(String id) async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${BookingsEndPoints.cancelBookingEndPoint}');
      print(url.toString());
      var body = {
        'scheduleDetailId': '$id',
        'cancelInfo': {'cancelReasonId': 1}
      };
      var encodedBody = jsonEncode(body);
      var headers = {
        'Authorization': 'Bearer ${Tokens.accessToken}',
        'Content-Type': 'application/json',
      };

      var response = await http.delete(url, headers: headers, body: encodedBody);
      print(encodedBody);

      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  Future<List<History>> getHistorySchedule() async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${BookingsEndPoints.bookingEndPoint}');

      url = url.replace(queryParameters: {
        'perPage': '20',
        'page': '1',
        "inFuture": '0',
        "orderBy": "meeting",
        "sortBy": "desc",
      });
      print(url.toString());
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<History> histories = History.historiesFromJson(response.body);
        return histories;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<List<Course>> getCourses() async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${CoursesEndPoints.coursesEndPoint}');
      url = url.replace(
        queryParameters: {
          'page': '1',
          'size': '100',
        },
      );
      print(url.toString());

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Course> courses = Course.coursesFromJson(response.body);
        return courses;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<List<Ebook>> getEbooks() async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${CoursesEndPoints.ebooksEndPoint}');

      url = url.replace(
        queryParameters: {
          'page': '1',
          'size': '10',
        },
      );
      print(url.toString());
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Ebook> ebooks = Ebook.ebooksFromJson(response.body);
        return ebooks;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<Course> getCourseById(String id) async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${CoursesEndPoints.coursesEndPoint}/$id');
      print(url.toString());
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        Course course = await Course.courseModelFromJson(response.body);
        return course;
      }
    } catch (e) {
      rethrow;
    }
    return Course(
      id: faker.guid.guid(),
      type: "",
      title: "",
      description: "",
      whyDescription: "",
      whatDescription: "",
      level: Level.any,
      topics: [],
      coverUri: Uri.parse(""),
    );
  }

  Future<int> getTotalHours() async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${TutorEndPoints.totalHoursEndPoint}');
      print(url.toString());
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${Tokens.accessToken}',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        return json['total'];
      }
    } catch (e) {
      rethrow;
    }
    return -1;
  }

  Future<bool> bookSchedule(Schedule schedule) async {
    try {
      var url = Uri.parse('${ApiConstants.baseUrl}${BookingsEndPoints.bookingTutorEndPoint}');
      print(url.toString());

      var headers = {
        'Authorization': 'Bearer ${Tokens.accessToken}',
        'Content-Type': 'application/json',
      };
      var body = {
        'scheduleDetailIds': [
          schedule.id,
        ],
        'note': ""
      };
      var encodedBody = jsonEncode(body);
      final response = await http.post(url, headers: headers, body: encodedBody);

      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }
}
