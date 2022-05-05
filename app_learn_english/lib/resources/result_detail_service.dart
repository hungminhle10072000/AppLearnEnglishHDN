import 'dart:convert';

import '../models/result_detail_model.dart';
import 'package:http/http.dart' as http;
import '../utils/constants/Cons.dart';

const String url = baseUrl + '/api/resultdetail/addAnswersMobile';
final http.Client httpClient = http.Client();

Future<bool> addResultDetail(List<ResultDetailModel> answers) async {
  try {
    final response = await httpClient.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJuZ2hpYWFkbWluIiwiZXhwIjoxNjUxNzczNDYyLCJpYXQiOjE2NTE3NTU0NjJ9._1T6t8QimjaFPkxdJQME1Umy8mDO9LN_jigOVZQ8DQW66sfD7lPHB1HHhHdbf6oAza-O3XH9dxQnEK5grQGnhA'},
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