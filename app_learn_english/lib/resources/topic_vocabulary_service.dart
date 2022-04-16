import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/topic_vocabulary_model.dart';

class TopicVocabularyService {

  // static const String _baseUrl = 'http://10.0.2.2:8080/api/user-topic-vocas';

  static const String _baseUrl = 'https://be-app-learn-english.herokuapp.com/api/user-topic-vocas';


  static List<TopicVocabulary> parseTopicList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TopicVocabulary>((json) => TopicVocabulary.fromJson(json))
        .toList();
  }

  static Future<List<TopicVocabulary>> getAllTopicVocabulary() async {
    var response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return parseTopicList(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

}