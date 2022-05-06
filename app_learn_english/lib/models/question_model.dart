import 'package:app_learn_english/models/exercise_model.dart';
import 'package:app_learn_english/models/lesson_model.dart';
import 'package:app_learn_english/models/result_detail_model.dart';

class QuestionModel {
  int id;
  int exerciseId;
  String correctAnswer;
  String option_1;
  String option_2;
  String option_3;
  String option_4;
  String contentQuestion;
  String audio;
  String imageDescription;
  String paragraph;
  int ordinalNumber;
  int type;
  List<ResultDetailModel> resultDetailModelList;

  QuestionModel({
    required this.id,
    required this.exerciseId,
    required this.correctAnswer,
    required this.option_1,
    required this.option_2,
    required this.option_3,
    required this.option_4,
    required this.contentQuestion,
    required this.audio,
    required this.imageDescription,
    required this.paragraph,
    required this.ordinalNumber,
    required this.type,
    required this. resultDetailModelList
  });
}