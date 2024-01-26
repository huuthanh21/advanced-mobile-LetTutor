import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lettutor/common/constant.dart';

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
      final response = await http.get(url, headers: {
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
      final response = await http.get(url, headers: {
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
}
