import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_learn_english/models/grammar_model.dart';
import 'package:app_learn_english/utils/constants/Cons.dart';

class GrammarService {
  static const String _baseUrlVocabuary = baseUrl + '/api/user-grammars/';

  static List<GrammarModel> parseGrammarList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<GrammarModel>((json) => GrammarModel.fromJson(json))
        .toList();
  }

  static Future<List<GrammarModel>> getAllGrammar() async {
    var response = await http.get(Uri.parse(_baseUrlVocabuary),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return parseGrammarList(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}
