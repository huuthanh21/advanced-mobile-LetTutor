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
