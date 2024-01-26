import 'package:flutter/material.dart';

import '../../../core/api/api_service.dart';

class FavoriteTutorsProvider extends ChangeNotifier {
  final List<String> _favoriteTutorsId = [];

  List<String> get favoriteTutorsId => _favoriteTutorsId;

  void fetchFavoriteTutors() async {
    _favoriteTutorsId.clear();
    var tutorIds = await ApiService().getFavoriteTutors();
    if (tutorIds != null) {
      _favoriteTutorsId.addAll(tutorIds);
    }
    print(_favoriteTutorsId);
  }

  void addFavoriteTutor(String tutorId) async {
    _favoriteTutorsId.add(tutorId);
    // CALL API TO ADD FAVORITE TUTOR
    await ApiService().toggleFavoriteTutor(tutorId);
    notifyListeners();
  }

  void removeFavoriteTutor(String tutorId) async {
    _favoriteTutorsId.remove(tutorId);
    // CALL API TO REMOVE FAVORITE TUTOR
    await ApiService().toggleFavoriteTutor(tutorId);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favoriteTutorsId.contains(id);
  }
}
