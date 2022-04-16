import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_learn_english/models/vocabulary_model.dart';

class VocabularyService {

  // static const String _baseUrlVocabuary = 'http://10.0.2.2:8080/api/user-vocabulary/';

  static const String _baseUrlVocabuary = 'https://be-app-learn-english.herokuapp.com/api/user-vocabulary/';

  static List<VocabularyModel> parseVocabularyList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VocabularyModel>((json) => VocabularyModel.fromJson(json))
        .toList();
  }

  static Future<List<VocabularyModel>> getAllVocabularyTopic(int idTopic) async {
    var response = await http.get(Uri.parse(_baseUrlVocabuary + idTopic.toString()),headers: {'Content-Type': 'application/json'});
    if(response.statusCode == 200) {
      return parseVocabularyList(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

}