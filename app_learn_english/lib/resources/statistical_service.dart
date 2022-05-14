import 'package:app_learn_english/models/statistical_model.dart';
import '../states/current_user_state.dart';
import '../utils/constants/Cons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_learn_english/utils/constants/Cons.dart';

Future<List<StatisticalModel>> getStatisticalOfWeek(int userId) async {
  String url = baseUrl + '/api/statistical/getStatisticalOfWeekByUserId/'+userId.toString();
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': CurrentUserState.token} );
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)) as List;
      final List<StatisticalModel> statisticals = responseData.map((statistical) {
          return StatisticalModel(
              userId: statistical['userId'],
              dateCreateDate: DateTime.parse(statistical['dateCreateDate']),
              score: statistical['score']);
        }).toList();
      return statisticals;
    } else {
      throw Exception('Cannot load data');
    }
  } catch(exception) {
    throw Exception('Cannot load data');
  }
}