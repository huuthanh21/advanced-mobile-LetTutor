import 'package:flutter/material.dart';

class FavoriteTutorsProvider extends ChangeNotifier {
  final List<String> _favoriteTutorsId = [];

  List<String> get favoriteTutorsId => _favoriteTutorsId;

  void addFavoriteTutor(String tutorId) {
    _favoriteTutorsId.add(tutorId);
    notifyListeners();
  }

  void removeFavoriteTutor(String tutorId) {
    _favoriteTutorsId.remove(tutorId);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favoriteTutorsId.contains(id);
  }
}
