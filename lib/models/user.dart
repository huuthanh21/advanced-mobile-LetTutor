import 'package:faker/faker.dart';

class User {
  String email;
  String password;
  double totalLearningHours = 0;

  User({required this.email, required this.password});

  static User getRandomUser() {
    return User(
        email: faker.internet.email(), password: faker.internet.password());
  }
}
