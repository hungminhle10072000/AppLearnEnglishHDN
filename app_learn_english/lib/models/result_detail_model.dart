import 'package:app_learn_english/models/question_model.dart';

class ResultDetailModel {

  int userId;
  int questionId;
  // QuestionModel questionEntity;
  String userAnswer;
  String correctAnswer;

  ResultDetailModel({
    required this.userId,
    required this.questionId,
    // required this.questionEntity,
    required this.userAnswer,
    required this.correctAnswer
  });
}