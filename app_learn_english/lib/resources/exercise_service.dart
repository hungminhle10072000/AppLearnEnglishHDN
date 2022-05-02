import 'dart:convert';

import 'package:app_learn_english/models/exercise_model.dart';
import 'package:app_learn_english/models/question_model.dart';
import 'package:app_learn_english/models/result_detail_model.dart';
import 'package:app_learn_english/models/result_model.dart';
import 'package:http/http.dart' as http;
import '../utils/constants/Cons.dart';

Future<List<ExerciseModel>> getAllExercises() async {
  const String url = baseUrl + '/api/exercise';
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url), headers: {'Content-Type': 'application/json'} );
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)) as List;
      final List<ExerciseModel> exercises =
      responseData.map((exercise) {
        List<dynamic> questionsDynamic = exercise['questionEntityList'] ?? [];
        List<QuestionModel> questionsModel = questionsDynamic.map((question) {
          List<dynamic> resultDetailDynamic = question['resultDetailEntityList'];
          List<ResultDetailModel> resultDetailsModel = resultDetailDynamic.map((resultDetail) {
            dynamic key = resultDetail['id'];
            int userId = key['userId'] ?? -1;
            int questionId = key['questionId'] ?? -1;
            String userAnswer = resultDetail['user_answer'] ?? '';
            String correctAnswer = resultDetail['correct_answer'] ?? '';
            return ResultDetailModel(
                userId: userId,
                questionId: questionId,
                userAnswer: userAnswer,
                correctAnswer: correctAnswer);
          }).toList();
          return QuestionModel(
              id: question['id'] ?? -1,
              correctAnswer: question['correctAnswer'] ?? '',
              option_1: question['option_1'] ?? '',
              option_2: question['option_2'] ?? '',
              option_3: question['option_3'] ?? '',
              option_4: question['option_4'] ?? '',
              contentQuestion: question['contentQuestion'] ?? '',
              audio: question['audio'] ?? '',
              paragraph: question['paragraph'] ?? '',
              ordinalNumber: question['ordinalNumber'] ?? 0,
              type: question['type'],
              resultDetailModelList: resultDetailsModel ?? []
          );
        }).toList();

        List<dynamic> resultsDynamic = exercise['resultEntityList'] ?? [];
        List<ResultModel> resultModel = resultsDynamic.map((result) {
          dynamic userEntity = result['userEntity'];
          int userId = userEntity['id'] ?? -1;
          return ResultModel(
              id: result['id'] ?? -1,
              correctListen: result['correct_listen'] ?? '',
              correctRead: result['correct_read'] ?? '',
              totalRight: result['total_right'] ?? '',
              totalWrong: result['total_wrong'] ?? '',
              userId: userId);
        }).toList();
        return ExerciseModel(
            id: exercise['id'] ?? -1,
            name: exercise['name'] ?? '',
            image: exercise['image'] ?? '',
            type: exercise['type'],
            description: exercise['description'] ?? '',
            questionEntityList: questionsModel ?? [],
            resultEntityList: resultModel ?? []);
      }).toList();

      return exercises;
    } else {
      throw Exception('Cannot load data');
    }
  } catch(exception) {
    throw Exception('Cannot load data');
  }
}