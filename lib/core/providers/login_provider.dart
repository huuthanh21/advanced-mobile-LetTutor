import '../../models/user.dart';

class LoginProvider {
  User? _user;
  final List<User> _users = [
    User(email: "teacher@lettutor.com", password: "123456"),
    User(email: "student@lettutor.com", password: "123456"),
    User(email: "admin", password: "123456")
  ];

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login(String email, String password) {
    if (_isLoggedIn) return;
    for (var user in _users) {
      if (user.email == email && user.password == password) {
        _user = user;
        _isLoggedIn = true;
        return;
      }
    }
  }

  bool register(User newUser) {
    if (_isLoggedIn) return false;
    // Check if email is already registered
    for (var user in _users) {
      if (user.email == newUser.email) {
        return false;
      }
    }
    _users.add(newUser);
    return true;
  }
}
