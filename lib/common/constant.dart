class ApiConstants {
  static String baseUrl = 'https://sandbox.api.lettutor.com';
  static String tutorsEndpoint = '/tutor/search';
}

class AuthenticationEndPoints {
  static String login = '/auth/login';
  static String register = '/auth/register';
  static String logout = '/auth/logout';
}

class TutorEndPoints {
  static String tutorEndPoint = '/tutor';
  static String getTutors = '/tutor/more';
  static String toggleFavoriteTutor = '/user/manageFavoriteTutor';
  static String reviewsEndpoint = '/feedback/v2';
  static String scheduleEndpoint = '/schedule';
  static String totalHoursEndPoint = '/call/total';
}

class BookingsEndPoints {
  static String bookingEndPoint = '/booking/list/student';
  static String cancelBookingEndPoint = '/booking/schedule-detail';
  static String bookingTutorEndPoint = '/booking';
  static String bookingNextEndPoint = '/booking/next';
}

class CoursesEndPoints {
  static String coursesEndPoint = '/course';
  static String ebooksEndPoint = '/e-book';
}

class Tokens {
  static final Tokens _instance = Tokens._internal();

  static String? accessToken;
  static String? refreshToken;

  factory Tokens() {
    return _instance;
  }

  Tokens._internal();

  static void setTokens(String accessToken, String refreshToken) {
    Tokens.accessToken = accessToken;
    Tokens.refreshToken = refreshToken;
  }
}
