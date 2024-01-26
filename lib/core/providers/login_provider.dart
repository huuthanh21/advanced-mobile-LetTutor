import 'package:lettutor/core/api/api_service.dart';

import '../../common/constant.dart';
import '../../models/user.dart';

class LoginProvider {
  // ignore: unused_field
  User? _user;

  User get user => _user!;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  String? accessToken;
  String? refreshToken;

  Future<bool> login(String email, String password) async {
    if (_isLoggedIn) return false;
    // call API to login
    await ApiService().login(email, password).then((data) {
      if (data != null) {
        _user = data['user'];
        var tokens = data['tokens'];
        accessToken = tokens[0];
        Tokens.accessToken = accessToken;
        refreshToken = tokens[1];
        Tokens.refreshToken = refreshToken;
        _isLoggedIn = true;
      }
    });
    return _isLoggedIn;
  }

  Future<bool> register(String email, String password) async {
    if (_isLoggedIn) return false;

    return await ApiService().register(email, password);
  }
}
