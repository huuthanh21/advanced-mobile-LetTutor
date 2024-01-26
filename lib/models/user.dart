class User {
  String id;
  String email;
  String name;
  String? avatarUrl;
  double totalLearningHours = 0;

  User({required this.id, required this.name, required this.email, avatar}) {
    avatarUrl = avatar;
  }
}
