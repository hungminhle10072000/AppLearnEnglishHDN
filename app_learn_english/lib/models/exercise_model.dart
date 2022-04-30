import 'package:app_learn_english/models/question_model.dart';
import 'package:app_learn_english/models/result_model.dart';

class ExerciseModel {
  int id;
  String name;
  String image;
  int type;
  String description;
  List<QuestionModel> questionEntityList;
  List<ResultModel> resultEntityList;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.description,
    required this.questionEntityList,
    required this.resultEntityList
  });
}