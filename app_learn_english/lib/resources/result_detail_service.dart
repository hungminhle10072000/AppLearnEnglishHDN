import 'dart:convert';

import 'package:app_learn_english/states/current_user_state.dart';

import '../models/result_detail_model.dart';
import 'package:http/http.dart' as http;
import '../utils/constants/Cons.dart';


final http.Client httpClient = http.Client();

Future<bool> addResultDetail(List<ResultDetailModel> answers) async {
  const String url = baseUrl + '/api/resultdetail/addAnswersMobile';
  try {
    final response = await httpClient.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(answers)
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)) as bool;
      return responseData;
    } else {
    throw Exception('Cannot load data');
    }
    } catch(exception) {
    throw Exception('Cannot load data');
  }
}

Future<List<ResultDetailModel>> findResultDetailsByUserIdAndExerciseId(int userId, int exerciseId) async {
  String url = baseUrl + '/api/resultdetail/findResultDetailsByUserIdAndExerciseId/${userId.toString()}/${exerciseId.toString()}';
  try {
    final response = await httpClient.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)) as List;
      final List<ResultDetailModel> resultDetails =
        responseData.map((resultDetail) => ResultDetailModel(
          userId: resultDetail['userId'],
          questionId: resultDetail['questionId'],
          exerciseId: resultDetail['exerciseId'],
          contentQuestion: resultDetail['q'],
          userAnswer: resultDetail['userAnswer'],
          correctAnswer: resultDetail['correctAnswer']
        )).toList();
      return resultDetails;
    } else {
      throw Exception("Something went wrong!");
    }

  } catch(exception) {
    throw Exception("Cannot load data");
  }
}