import '../../models/tutor.dart';

class TutorDataProvider {
  final List<Tutor> _tutors = [];

  List<Tutor> get tutors => _tutors;

  TutorDataProvider() {
    List.generate(10, (index) {
      _tutors.add(Tutor.getRandomTutor());
    });
  }

  Tutor getTutorById(String id) {
    return _tutors.firstWhere((tutor) => tutor.id == id);
  }
}
