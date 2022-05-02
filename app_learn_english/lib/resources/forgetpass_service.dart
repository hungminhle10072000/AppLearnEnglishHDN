import 'package:app_learn_english/utils/constants/Cons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ForgetPassRepository {
  Future<dynamic> ForgetPassUser(String username,String email) async {

    Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
    final msg = jsonEncode({"grant_type":"password","username":username,"email":email,"scope":"offline_access"});
    var response = await http.post(Uri.parse(baseUrl+"/api/users/check-username-email"),
      headers: headers,
      body: msg,
    );
    return response;
  }
}
