import '../../models/tutor.dart';

class TutorDataProvider {
  Future<List<Tutor>> getTutors() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(10, (index) => Tutor.getRandomTutor());
  }
}