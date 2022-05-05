import 'package:app_learn_english/models/question_model.dart';

class ResultDetailModel {

  int userId;
  int questionId;
  String contentQuestion;
  // QuestionModel questionEntity;
  String userAnswer;
  String correctAnswer;

  ResultDetailModel({
    required this.userId,
    required this.questionId,
    required this.contentQuestion,
    // required this.questionEntity,
    required this.userAnswer,
    required this.correctAnswer
  });

  Map toJson() => {
    'userId': userId,
    'questionId':questionId,
    'q':contentQuestion,
    'userAnswer':userAnswer,
    'correctAnswer':correctAnswer
  };
}