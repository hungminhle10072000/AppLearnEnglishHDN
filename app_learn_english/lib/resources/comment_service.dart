import 'dart:convert';

import 'package:app_learn_english/models/comment_model.dart';
import 'package:http/http.dart' as http;
import '../states/current_user_state.dart';
import '../utils/constants/Cons.dart';


final http.Client httpClient = http.Client();

Future<bool> addComment(CommentModel commentModel) async {
  String url = baseUrl + '/api/comment/add';
  try {
    final response = await httpClient.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(commentModel)
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Cannot load data');
    }
  } catch(exception) {
    throw Exception('Cannot load data');
  }
}
