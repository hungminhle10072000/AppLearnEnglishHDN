import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginRepository {
  Future<dynamic> login(String username, String password) async {
    // var res = await http.post(
    //     Uri.parse("http://be-app-learn-english.herokuapp.com/authenticate"),
    //     headers: {},
    //     body: {"username": username, "password": password});
    //final data = json.decode(res.body);
    Map<String,String> headers = {'Content-Type':'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
    final msg = jsonEncode({"grant_type":"password","username":username,"password":password,"scope":"offline_access"});

    var response = await http.post(Uri.parse("https://be-app-learn-english.herokuapp.com/authenticate"),
      headers: headers,
      body: msg,
    );
    //final data = json.decode(response.body);
    // if (data['user']['role'] == "Admin" || data['user']['role'] == "User") {
    //   return data;
    // } else {
    //   return response;
    // }
    return response;
  }
}
