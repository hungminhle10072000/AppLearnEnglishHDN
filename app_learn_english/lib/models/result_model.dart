import 'package:app_learn_english/models/exercise_model.dart';

class ResultModel {
  int id;
  String correctListen;
  String correctRead;
  int totalRight;
  int totalWrong;
  int userId;
  // ExerciseModel exerciseEntity;

  ResultModel({
    required this.id,
    required this.correctListen,
    required this.correctRead,
    required this.totalRight,
    required this.totalWrong,
    required this.userId,
    // required this.exerciseEntity
  });
}