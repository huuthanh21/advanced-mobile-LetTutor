class ApiConstants {
  static String baseUrl = 'https://sandbox.api.lettutor.com';
  static String tutorsEndpoint = '/tutor/search';
}

class AuthenticationEndPoints {
  static String login = '/auth/login';
  static String register = '/auth/register';
  static String logout = '/auth/logout';
}

class TutorEndpoints {
  static String getTutors = '/tutor/more';
  static String toggleFavoriteTutor = '/user/manageFavoriteTutor';
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
